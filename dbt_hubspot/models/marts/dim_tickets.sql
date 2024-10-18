/* Table: tickets */
{{
    config(
        materialized='incremental'
    )
}}
SELECT
    t.createdate,
    t.hs_lastmodifieddate,
    t.hs_object_id,
    t.hs_pipeline,
    t.hs_pipeline_stage,
    t.subject,
    t.id,
    t._dlt_load_id,
    t._dlt_id,
FROM  {{ ref('stg_tickets') }} as t