{scripts}

{script src="js/lib/jquery/jquery.min.js"}
{script src="js/tygh/core.js"}
{script src="js/tygh/history.js"}

{script src="js/lib/twitterbootstrap/bootstrap.min.js"}
{script src="js/lib/jqueryui/jquery-ui.custom.min.js"}
{script src="js/lib/autonumeric/autoNumeric.js"}
{script src="js/lib/appear/jquery.appear-1.1.1.js"}
{script src="js/lib/tools/tooltip.min.js"}

{script src="js/tygh/editors/`$settings.Appearance.default_wysiwyg_editor`.editor.js"}

{script src="js/tygh/ajax.js"}

{if $settings.General.feedback_type == "auto"}
    {include file="common/analytics.tpl"}
{/if}

{capture name="promo_data"}
    <div class="commercial-promotion-text">
        <p>{__("text_forbidden_functionality")}</p>
    <div>
{/capture}

<script type="text/javascript">
//<![CDATA[
(function(_, $) {
    _.tr({
        cannot_buy: '{__("cannot_buy")|escape:"javascript"}',
        no_products_selected: '{__("no_products_selected")|escape:"javascript"}',
        error_no_items_selected: '{__("error_no_items_selected")|escape:"javascript"}',
        delete_confirmation: '{__("delete_confirmation")|escape:"javascript"}',
        text_out_of_stock: '{__("text_out_of_stock")|escape:"javascript"}',
        items: '{__("items")|escape:"javascript"}',
        text_required_group_product: '{__("text_required_group_product")|escape:"javascript"}',
        save: '{__("save")|escape:"javascript"}',
        close: '{__("close")|escape:"javascript"}',
        loading: '{__("loading")|escape:"javascript"}',
        notice: '{__("notice")|escape:"javascript"}',
        warning: '{__("warning")|escape:"javascript"}',
        error: '{__("error")|escape:"javascript"}',
        text_are_you_sure_to_proceed: '{__("text_are_you_sure_to_proceed")|escape:"javascript"}',
        text_invalid_url: '{__("text_invalid_url")|escape:"javascript"}',
        error_validator_email: '{__("error_validator_email")|escape:"javascript"}',
        error_validator_phone: '{__("error_validator_phone")|escape:"javascript"}',
        error_validator_integer: '{__("error_validator_integer")|escape:"javascript"}',
        error_validator_multiple: '{__("error_validator_multiple")|escape:"javascript"}',
        error_validator_password: '{__("error_validator_password")|escape:"javascript"}',
        error_validator_required: '{__("error_validator_required")|escape:"javascript"}',
        error_validator_zipcode: '{__("error_validator_zipcode")|escape:"javascript"}',
        error_validator_message: '{__("error_validator_message")|escape:"javascript"}',
        error_validator_color: '{__("error_validator_color")|escape:"javascript"}',
        text_page_loading: '{__("text_page_loading")|escape:"javascript"}',
        error_ajax: '{__("error_ajax")|escape:"javascript"}',
        text_changes_not_saved: '{__("text_changes_not_saved")|escape:"javascript"}',
        text_data_changed: '{__("text_data_changed")|escape:"javascript"}',
        trial_notice: '{__("text_block_trial_notice")|escape:"javascript"}',
        expired_license: '{__("text_expired_license")|escape:"javascript"}',
        file_browser: '{__("file_browser")|escape:"javascript"}',
        editing_block: '{__("editing_block")|escape:"javascript"}',
        editing_grid: '{__("editing_grid")|escape:"javascript"}',
        editing_container: '{__("editing_container")|escape:"javascript"}',
        adding_grid: '{__("adding_grid")|escape:"javascript"}',
        adding_block_to_grid: '{__("adding_block_to_grid")|escape:"javascript"}',
        manage_blocks: '{__("manage_blocks")|escape:"javascript"}',
        editing_block: '{__("editing_block")|escape:"javascript"}',
        add_block: '{__("add_block")|escape:"javascript"}',
        text_position_updating: '{__("text_position_updating")|escape:"javascript"}',
        more: '{__("more")|escape:"javascript"}',
        text_full_mode_required: '{__("text_full_mode_required")|escape:javascript}',
        browse: '{__("browse")|escape:javascript}'
    });

    $.extend(_, {
        index_script: '{if $user_info.user_type == 'V'}{$config.vendor_index|escape:javascript nofilter}{else}{$config.admin_index|escape:javascript nofilter}{/if}',
        changes_warning: '{$settings.Appearance.changes_warning|escape:javascript nofilter}',
        currencies: {
            'primary': {
                'decimals_separator': '{$currencies.$primary_currency.decimals_separator|escape:javascript nofilter}',
                'thousands_separator': '{$currencies.$primary_currency.thousands_separator|escape:javascript nofilter}',
                'decimals': '{$currencies.$primary_currency.decimals|escape:javascript nofilter}'
            },
            'secondary': {
                'decimals_separator': '{$currencies.$secondary_currency.decimals_separator|escape:javascript nofilter}',
                'thousands_separator': '{$currencies.$secondary_currency.thousands_separator|escape:javascript nofilter}',
                'decimals': '{$currencies.$secondary_currency.decimals|escape:javascript nofilter}',
                'coefficient': '{$currencies.$secondary_currency.coefficient}'
            }
        },
        default_editor: '{$settings.Appearance.default_wysiwyg_editor}',
        frontend_css: '{""|fn_get_frontend_css}',
        default_previewer: '{$settings.Appearance.default_image_previewer}',    
        current_path: '{$config.current_path|escape:javascript nofilter}',
        current_location: '{$config.current_location|escape:javascript nofilter}',
        current_url: '{$config.current_url|escape:javascript nofilter}',
        images_dir: '{$images_dir}',
        notice_displaying_time: {if $settings.Appearance.notice_displaying_time}{$settings.Appearance.notice_displaying_time}{else}0{/if},
        cart_language: '{$smarty.const.CART_LANGUAGE}',
        default_language: '{$smarty.const.DEFAULT_LANGUAGE}',
        cart_prices_w_taxes: {if ($settings.Appearance.cart_prices_w_taxes == 'Y')}true{else}false{/if},
        translate_mode: {if $runtime.customization_mode.translation}true{else}false{/if},
        theme_name: '{$settings.theme_name|escape:javascript nofilter}',
        regexp: [],
        current_url: '{$config.current_url|escape:javascript nofilter}',
        {if $config.tweaks.anti_csrf}
        security_hash: '{""|fn_generate_security_hash}', // CSRF form protection key
        {/if}
        promo_data: '{$smarty.capture.promo_data|escape:javascript nofilter}'
    });

    $(document).ready(function(){
        $.runCart('A');
    });
}(Tygh, Tygh.$));
//]]>
</script>

{hook name="index:scripts"}
{/hook}

{/scripts}
