/* Table: contacts__tickets */
/* Parent: { parent }} */
{{
    config(
        materialized='table'
    )
}}

-- depends_on: {{ ref('dlt_active_load_ids') }}
-- depends_on: {{ ref('stg_contacts') }}

SELECT
/* select which columns will be available for table 'contacts__tickets' */
    value,
    tickets_id,
    _dlt_parent_id,
    _dlt_list_idx,
    _dlt_id,
FROM {{ source('raw_data', 'contacts__tickets') }}

/* we only load table items if the parent table has the parent item */
WHERE _dlt_parent_id IN ( SELECT _dlt_id FROM {{ ref('stg_contacts') }} )
