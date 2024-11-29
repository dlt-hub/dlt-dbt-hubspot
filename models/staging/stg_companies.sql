/* Table: companies */
{{
    config(
        materialized='table'
    )
}}

-- depends_on: {{ ref('dlt_active_load_ids') }}

SELECT
/* select which columns will be available for table 'companies' */
    createdate,
    hs_lastmodifieddate,
    hs_object_id,
    hubspot_owner_assigneddate,
    hubspot_owner_id,
    lifecyclestage,
    name,
    num_associated_contacts,
    id,
    _dlt_load_id,
    _dlt_id,
FROM {{ source('raw_data', 'companies') }}

/* we only load table items of the currently active load ids into the staging table */
WHERE _dlt_load_id IN ( SELECT load_id FROM  {{ ref('dlt_active_load_ids') }} )