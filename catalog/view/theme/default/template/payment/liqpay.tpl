<?php
/**
 * Liqpay Payment Module
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 *
 * @category        Liqpay
 * @package         Payment
 * @version         3.0
 * @author          Liqpay
 * @copyright       Copyright (c) 2014 Liqpay
 * @license         http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *
 * EXTENSION INFORMATION
 *
 * OpenCart         1.5.6
 * LiqPay API       https://www.liqpay.com/ru/doc
 *
 */
?>

<form action="<?php echo $action ?>" method="post" id="liqpay">
    <input type="hidden" name="data" value="<?=$data?>"/>
    <input type="hidden" name="signature" value="<?=$signature?>"/>

    <div class="buttons">
        <div class="pull-right">
            <input type="submit" value="<?php echo $button_confirm; ?>" id="button-confirm"
                   data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"/>
        </div>
    </div>
</form>
<script type="text/javascript">
    $(document).ready(function () {
        $("#payment").click(function (event) {
            $.ajax({
                type: 'get',
                url: '<?php echo $url_confirm; ?>',
                success: function () {
                    $("form#liqpay").submit();
                }
            });
            return false;
        });
    });
</script>
