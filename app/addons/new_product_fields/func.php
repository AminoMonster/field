<?php

function fn_new_product_fields_get_product_data_post()
{
    db_query("UPDATE `?:product_tabs_descriptions` SET name = 'Comment' WHERE name = '';");
}