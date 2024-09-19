{{
    config(
        materialized='incremental'
    )
}}
-- depends_on: {{ ref('dim_hubspot___dlt_loads') }}
-- depends_on: {{ ref('dim_hubspot__companies') }}
-- depends_on: {{ ref('dim_hubspot__contacts') }}
-- depends_on: {{ ref('dim_hubspot__deals') }}
-- depends_on: {{ ref('dim_hubspot__tickets') }}
-- depends_on: {{ ref('dim_hubspot__contacts__tickets') }}
-- depends_on: {{ ref('dim_hubspot__contacts__deals') }}
/* we save all currently active load ids into the processed ids table */
select load_id, {{ current_timestamp() }} as inserted_at FROM {{ ref('hubspot_dlt_active_load_ids') }}