/* Table: deals */
{{
    config(
        materialized='table'
    )
}}

-- depends_on: {{ ref('hubspot_dlt_active_load_ids') }}

SELECT
/* select which columns will be available for table 'deals' */
    "closedate",
    "createdate",
    "days_to_close",
    "dealname",
    "dealstage",
    "hs_closed_amount",
    "hs_closed_amount_in_home_currency",
    "hs_lastmodifieddate",
    "hs_num_of_associated_line_items",
    "hs_object_id",
    "hubspot_owner_assigneddate",
    "hubspot_owner_id",
    "num_associated_contacts",
    "pipeline",
    "id",
    "_dlt_load_id",
    "_dlt_id",
FROM {{ source('raw_data', 'deals') }}

/* we only load table items of the currently active load ids into the staging table */
WHERE "_dlt_load_id" IN ( SELECT "load_id" FROM  {{ ref('hubspot_dlt_active_load_ids') }} )