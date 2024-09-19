/* Table: companies */
{{
    config(
        materialized='incremental'
    )
}}
SELECT
    t."createdate",
    t."hs_lastmodifieddate",
    t."hs_object_id",
    t."hubspot_owner_assigneddate",
    t."hubspot_owner_id",
    t."lifecyclestage",
    t."name",
    t."num_associated_contacts",
    t."id",
    t."_dlt_load_id",
    t."_dlt_id",
FROM  {{ ref('stg_hubspot__companies') }} as t