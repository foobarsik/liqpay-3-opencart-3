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

<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>"
                        class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>


    <div class="container-fluid">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-pay2pay"
                      class="form-horizontal">

                    <div class="form-group required">
                        <label class="col-sm-2 control-label"
                               for="input-liqpay_public_key"><?php echo $entry_public_key; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="liqpay_public_key" value="<?php echo $liqpay_public_key; ?>"
                                   placeholder="<?php echo $entry_public_key; ?>" id="input-liqpay_public_key"
                                   class="form-control"/>
                        </div>
                        <?php if ($error_public_key) { ?>
                        <div class="text-danger"><?php echo $error_public_key; ?></div>
                        <?php } ?>
                    </div>

                    <div class="form-group required">
                        <label class="col-sm-2 control-label"
                               for="input-liqpay_private_key"><?php echo $entry_private_key; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="liqpay_private_key" value="<?php echo $liqpay_private_key; ?>"
                                   placeholder="<?php echo $entry_private_key; ?>" id="input-liqpay_private_key"
                                   class="form-control"/>
                        </div>
                        <?php if ($error_private_key) { ?>
                        <div class="text-danger"><?php echo $error_private_key; ?></div>
                        <?php } ?>
                    </div>

                    <div class="form-group required">
                        <label class="col-sm-2 control-label"
                               for="input-liqpay_action"><?php echo $entry_action; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="liqpay_action" value="<?php echo $liqpay_action; ?>"
                                   placeholder="<?php echo $entry_action; ?>" id="input-liqpay_action"
                                   class="form-control"/>
                        </div>
                        <?php if ($error_action) { ?>
                        <div class="text-danger"><?php echo $error_action; ?></div>
                        <?php } ?>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_pay_way; ?></label>
                        <div class="col-sm-10">

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="card"
                                                                                   name="card" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "card") !== false):?>checked="checked"<?php endif?>
                                /> Карта</label>


                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="liqpay"
                                                                                   name="liqpay" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "liqpay") !== false):?>checked="checked"<?php endif?>
                                /> Liqpay</label>

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="privat24"
                                                                                   name="privat24" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "privat24") !== false):?>
                                checked="checked"<?php endif?>
                                /> Privat24</label>

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="invoice"
                                                                                   name="invoice" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "invoice") !== false):?>checked="checked"<?php endif?>
                                /> Invoice</label>

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="cache"
                                                                                   name="cache" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "cache") !== false):?>checked="checked"<?php endif?>
                                /> Наличными</label>

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="masterpass"
                                                                                   name="masterpass" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "masterpass") !== false):?>
                                checked="checked"<?php endif?>
                                />Masterpass</label>

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="moment_part"
                                                                                   name="moment_part" class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "moment_part") !== false):?>
                                checked="checked"<?php endif?>
                                />Рассрочка</label>

                            <label class="control-label" onclick="payWay()"><input type="checkbox" value="qr" name="qr"
                                                                                   class="pay_way"
                                <?php if (strpos($liqpay_pay_way, "qr") !== false):?>checked="checked"<?php endif?>
                                />QR-код</label>


                            <input type="text" id="pay_way" name="liqpay_pay_way"
                                   value="<?=$liqpay_pay_way?>" hidden/>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="input-liqpay_total"><?php echo $entry_total; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="liqpay_total" value="<?php echo $liqpay_total; ?>"
                                   placeholder="<?php echo $entry_total; ?>" id="input-liqpay_total"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_order_status; ?></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="liqpay_order_status_id">
                                <?php
                                    foreach ($order_statuses as $order_status):
                                        $order_status_id = $order_status['order_status_id'];
                                        $sel = ($order_status_id == $liqpay_order_status_id);
                                ?>
                                <option
                                <?php if ($sel):?>selected="selected"<?php endif?> value="<?=$order_status_id?>">
                                <?=$order_status['name']?>
                                </option>
                                <?php endforeach?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_geo_zone; ?></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="liqpay_geo_zone_id">
                                <option value="0"><?=$text_all_zones?></option>
                                <?php
                                    foreach ($geo_zones as $geo_zone):
                                        $geo_zone_id = $geo_zone['geo_zone_id'];
                                        $sel = ($geo_zone_id == $liqpay_geo_zone_id);
                                ?>
                                <option
                                <?php if ($sel):?>selected="selected"<?php endif?> value="<?=$geo_zone_id?>">
                                <?=$geo_zone['name']?>
                                </option>
                                <?php endforeach?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="liqpay_status">
                                <option
                                <?php if ($liqpay_status): ?>selected="selected"<?php endif?> value="1">
                                <?=$text_enabled?>
                                </option>
                                <option
                                <?php if (!$liqpay_status): ?>selected="selected"<?php endif?> value="0">
                                <?=$text_disabled?>
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_language; ?></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="liqpay_language">
                                <option
                                <?php if ($liqpay_language == 'ru'): ?>selected="selected"<?php endif?> value="ru">
                                ru
                                </option>
                                <option
                                <?php if ($liqpay_language == 'en'): ?>selected="selected"<?php endif?> value="en">
                                en
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                        <div class="col-sm-10">
                            <input class="form-control" type="text" name="liqpay_sort_order"
                                   value="<?=$liqpay_sort_order?>" size="1"/>
                        </div>
                        </tr>

                </form>
            </div>
        </div>
        <script>
            function payWay() {

                var elems = $(".pay_way:checked");
                var str = '';
                elems.each(function () {
                    str += $(this).prop("name") + ',';
                })
                $("#pay_way").val(str);

            }
        </script>
        <?php echo $footer; ?>