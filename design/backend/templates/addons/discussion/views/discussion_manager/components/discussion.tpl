{if $discussion && !$discussion.is_empty}

{$allow_save = false}

{if ($discussion.object_type != "M" || !$runtime.company_id) && "discussion.update"|fn_check_view_permissions}
{$allow_save = true}
{/if}
<div class="{if $allow_save}cm-no-hide-input{else}cm-hide-inputs{/if}" id="content_discussion">
<div class="clearfix">
    <div class="buttons-container buttons-bg pull-right">
    {if $allow_save}
            {if "discussion_manager"|fn_check_view_permissions}
                {if $discussion.object_type == "E"}
                    {capture name="adv_buttons"}
                        {include file="common/popupbox.tpl" id="add_new_post" title=__("add_post") icon="icon-plus" act="general" link_class="cm-dialog-switch-avail"}
                    {/capture}
                {else}
                    {include file="common/popupbox.tpl" id="add_new_post" link_text=__("add_post") act="general" link_class="cm-dialog-switch-avail"}
                {/if}
            {/if}
            {if $discussion.posts}
                {$show_save_btn = true scope = root}
                {if $discussion.object_type == "E"}
                    {capture name="buttons_insert"}
                {/if}
                {if "discussion.m_delete"|fn_check_view_permissions}
                    {capture name="tools_list"}
                        <li>{btn type="delete_selected" dispatch="dispatch[discussion.m_delete]" form="update_posts_form"}</li>
                    {/capture}
                    {dropdown content=$smarty.capture.tools_list}
                {/if}
                {if $discussion.object_type == "E"}
                    {/capture}
                {/if}
            {/if}
    {/if}
    </div>
</div><br>

{if $discussion.posts}

{script src="js/addons/discussion/discussion.js"}

{include file="common/pagination.tpl" save_current_page=true id="pagination_discussion" search=$discussion.search}

<div class="posts-container">

{foreach from=$discussion.posts item="post"}
<div class="post-item {if $discussion.object_type == "O"}{if $post.user_id == $user_id}incoming{else}outgoing{/if}{/if}">
    {hook name="discussion:items_list_row"}
        {include file="addons/discussion/views/discussion_manager/components/post.tpl" post=$post type=$discussion.type}
    {/hook}
</div>
{/foreach}
</div>
{include file="common/pagination.tpl" id="pagination_discussion" search=$discussion.search}

{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{if "discussion_manager"|fn_check_view_permissions}
    {capture name="add_new_picker"}
    <div class="tabs cm-j-tabs">
        <ul class="nav nav-tabs">
            <li id="tab_add_post" class="cm-js cm-active active"><a>{__("general")}</a></li>
        </ul>
    </div>

    <div class="cm-tabs-content" id="content_tab_add_post">
    <input type ="hidden" name="post_data[thread_id]" value="{$discussion.thread_id}" />
    <input type ="hidden" name="redirect_url" value="{$config.current_url}&amp;selected_section=discussion" />

    <div class="control-group">
        <label for="post_data_name" class="cm-required control-label">{__("name")}:</label>
        <div class="controls">
            <input type="text" name="post_data[name]" id="post_data_name" value="{if $auth.user_id}{$user_info.firstname} {$user_info.lastname}{/if}" disabled="disabled">
        </div>
    </div>

    {if $discussion.type == "R" || $discussion.type == "B"}
    <div class="control-group">
        <label for="rating_value" class="control-label cm-required cm-multiple-radios">{__("your_rating")}</label>
        <div class="controls clearfix">
            {include file="addons/discussion/views/discussion_manager/components/rate.tpl" rate_id="rating_value" rate_name="post_data[rating_value]" disabled=true}
        </div>
    </div>
    {/if}

    {hook name="discussion:add_post"}
    {if $discussion.type == "C" || $discussion.type == "B"}
    <div class="control-group">
        <label for="message" class="control-label">{__("your_message")}:</label>
        <div class="controls">
            <textarea name="post_data[message]" id="message" class="input-textarea-long" cols="70" rows="8" disabled="disabled"></textarea>
        </div>
    </div>
    {/if}
    {/hook}
    </div>

    <div class="buttons-container">
        {include file="buttons/save_cancel.tpl" but_text=__("add") but_name="dispatch[discussion.add]" cancel_action="close" hide_first_button=false}
    </div>
    {/capture}
    {include file="common/popupbox.tpl" id="add_new_post" text=__("new_post") content=$smarty.capture.add_new_picker act="fake"}
{/if}

</div>

{elseif $discussion.is_empty}

{__("text_enabled_testimonials_notice", ["[link]" => "addons.manage#groupdiscussion"|fn_url])}

{/if}