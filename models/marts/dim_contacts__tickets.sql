/* Table: contacts__tickets */
/* Parent: contacts */
{{
    config(
        materialized='incremental'
    )
}}
SELECT
    t.value,
    t.tickets_id,
    t._dlt_parent_id,
    t._dlt_list_idx,
    t._dlt_id,
FROM  {{ ref('stg_contacts__tickets') }} as t
/* this join to the parent table is not necessarily needed for this template to work */
JOIN {{ ref('stg_contacts') }} as pt
ON (t._dlt_parent_id = pt._dlt_id)