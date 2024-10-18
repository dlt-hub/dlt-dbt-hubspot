/* Table: deals */
{{
    config(
        materialized='incremental'
    )
}}
SELECT
    t.closedate,
    t.createdate,
    t.days_to_close,
    t.dealname,
    t.dealstage,
    t.hs_lastmodifieddate,
    t.hs_object_id,
    t.hubspot_owner_assigneddate,
    t.hubspot_owner_id,
    t.num_associated_contacts,
    t.pipeline,
    t.id,
    t._dlt_load_id,
    t._dlt_id,
FROM  {{ ref('stg_deals') }} as t