{{
  config(
      enabled = false,
  )
}}
with view_item_list_with_params as (
  select *
  , {{ ga4.unnest_key('event_params', 'item_list_id') }}
  , {{ ga4.unnest_key('event_params', 'item_list_name') }}
  {% if var("default_custom_parameters", "none") != "none" %}
    {{ ga4.stage_custom_parameters( var("default_custom_parameters") )}}
  {% endif %}
  {% if var("view_item_list_custom_parameters", "none") != "none" %}
    {{ ga4.stage_custom_parameters( var("view_item_list_custom_parameters") )}}
  {% endif %}
 from {{ref('stg_ga4__events')}}    
 where event_name = 'view_item_list'
)

select * from view_item_list_with_params