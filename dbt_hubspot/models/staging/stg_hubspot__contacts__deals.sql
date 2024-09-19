/* Table: contacts__deals */
/* Parent: { parent }} */
{{
    config(
        materialized='table'
    )
}}

-- depends_on: {{ ref('hubspot_dlt_active_load_ids') }}
-- depends_on: {{ ref('stg_hubspot__contacts') }}

SELECT
/* select which columns will be available for table 'contacts__deals' */
    "value",
    "deals_id",
    "_dlt_parent_id",
    "_dlt_list_idx",
    "_dlt_id",
FROM {{ source('raw_data', 'contacts__deals') }}

/* we only load table items if the parent table has the parent item */
WHERE "_dlt_parent_id" IN ( SELECT "_dlt_id" FROM {{ ref('stg_hubspot__contacts') }} )
