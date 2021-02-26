<?php

class ControllerExtensionPaymentLiqPay extends Controller
{
    const VERSION = '3';
    const TYPE = 'buy';
    const ACTION = 'https://www.liqpay.ua/api/3/checkout';
    const STATUS_PROCESSING = 1;

    /**
     * Index action
     *
     * @return void
     */
    public function index()
    {
        $this->load->model('checkout/order');

        $result_url = $this->url->link('extension/payment/liqpay/callback', '', 'SSL');
        $server_url = $this->url->link('extension/payment/liqpay/callback', '', 'SSL');

        $private_key = $this->config->get('payment_liqpay_signature');
        $public_key = $this->config->get('payment_liqpay_merchant');

        $order_id = $this->session->data['order_id'];
        $order_info = $this->model_checkout_order->getOrder($order_id);

        $currency = $order_info['currency_code'];
        if ($currency == 'RUR') {
            $currency = 'RUB';
        }

        $amount = $this->currency->format(
            $order_info['total'],
            $order_info['currency_code'],
            $order_info['currency_value'],
            false
        );

        $send_data = ['version' => self::VERSION,
            //'sandbox'    => '1',
            'action' => 'pay',
            'public_key' => $public_key,
            'amount' => $amount,
            'currency' => $currency,
            'description' => $this->config->get('config_name'),
            'order_id' => $order_id,
            'type' => self::TYPE,
            'language' => $this->getLanguage(),
            'server_url' => $server_url,
            'result_url' => $result_url,
            'paytypes' => $this->config->get('payment_liqpay_type')];

        $data_final = base64_encode(json_encode($send_data));

        $signature = base64_encode(sha1($private_key . $data_final . $private_key, 1));

        $data['action'] = self::ACTION;
        $data['signature'] = $signature;
        $data['data'] = $data_final;
        $data['button_confirm'] = $this->language->get('button_confirm');

        return $this->load->view('extension/payment/liqpay_payment', $data);
    }

    public function callback()
    {
        $data = $_POST['data'];
        $signature = $_POST['signature'];

        $private_key = $this->config->get('payment_liqpay_signature');
        $public_key = $this->config->get('payment_liqpay_merchant');

        $generated_signature = base64_encode(sha1($private_key . $data . $private_key, 1));

        if ($signature != $generated_signature) {
            die("Signature secure fail");
        }

        $parsed_data = json_decode(base64_decode($data), true);

        $received_public_key = (isset($parsed_data['public_key'])) ? $parsed_data['public_key'] : '';
        $order_id = (isset($parsed_data['order_id'])) ? $parsed_data['order_id'] : '';
        $status = (isset($parsed_data['status'])) ? $parsed_data['status'] : '';
        $error = (isset($parsed_data['err_code'])) ? $parsed_data['err_code'] : '';

        if ($public_key != $received_public_key) {
            die("public_key secure fail");
        }

        $this->load->model('checkout/order');
        if (!$this->model_checkout_order->getOrder($order_id)) {
            die("Order_id fail");
        }

        if ($status == 'success' || $status == 'sandbox') {
            $this->model_checkout_order->addOrderHistory($order_id, $this->config->get('payment_liqpay_order_status_id'));
            $this->response->redirect($this->url->link('checkout/success', '', 'SSL'));
        } elseif (preg_match('/wait|hold|processing/', $status)) {
            $this->model_checkout_order->addOrderHistory($order_id, self::STATUS_PROCESSING);
            //TODO redirect to wait page
            $this->response->redirect($this->url->link('checkout/success', '', 'SSL'));
        } elseif (($status === 'failure') && ($error === 'cancel')) {
            $this->response->redirect($this->url->link('checkout/checkout', '', 'SSL'));
        } else {
            $this->response->redirect($this->url->link('checkout/failure', '', 'SSL'));
        }
    }

    private function getLanguage()
    {
        switch ($this->language->get('code')) {
            case 'ua-uk':
            case 'uk-ua':
            case 'ua':
            case 'uk':
            case 'ukrainian':
                $language = 'uk';
                break;
            case 'en-gb':
            case 'en-us':
            case 'en':
            case 'english':
                $language = 'en';
                break;
            case 'ru-ru':
            case 'ru':
            case 'russian':
                $language = 'ru';
                break;
            default:
                $language = 'ru';
        }

        return $language;
    }
}