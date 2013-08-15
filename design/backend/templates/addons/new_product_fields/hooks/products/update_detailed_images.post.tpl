
<div class="control-group {$no_hide_input_if_shared_product}">
    <label for="product_author" class="control-label">{__("author")}</label>
    <div class="controls">
        <input class="input-large" form="form" type="text" name="product_data[author]" id="author" size="55" value="{$product_data.author}" />
    </div>     
</div>

<div class="control-group">
    <label class="control-label" for="elm_product_type">{__("product_type")}:</label>
        <div class="controls">
            <select class="span3" name="product_data[story_type]" id="elm_product_type">
                <option value="" {if $product_data.story_type == ""}selected="selected"{/if}>{__("please_select")}</option>                
                <option value="novel" {if $product_data.story_type == "novel"}selected="selected"{/if}>{__("novel")}</option>
                <option value="story" {if $product_data.story_type == "story"}selected="selected"{/if}>{__("story")}</option>
                <option value="stories" {if $product_data.story_type == "stories"}selected="selected"{/if}>{__("stories")}</option>
                <option value="poetry" {if $product_data.story_type == "poetry"}selected="selected"{/if}>{__("poetry")}</option>
            </select>
        </div>
</div>

<div class="control-group cm-no-hide-input">
    <label class="control-label" for="elm_product_comment">{__("comment")}:</label>
        <div class="controls">
            {include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id='comment' name="update_all_vendors[comment]"}
                <textarea id="elm_product_comment" name="product_data[comment]" cols="55" rows="8" class="cm-wysiwyg input-large">{$product_data.comment}</textarea>
        </div>
</div>