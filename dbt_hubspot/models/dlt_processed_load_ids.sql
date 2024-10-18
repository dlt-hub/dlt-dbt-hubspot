{{
    config(
        materialized='incremental'
    )
}}
-- depends_on: {{ ref('dim__dlt_loads') }}
-- depends_on: {{ ref('dim_companies') }}
-- depends_on: {{ ref('dim_contacts') }}
-- depends_on: {{ ref('dim_deals') }}
-- depends_on: {{ ref('dim_tickets') }}
-- depends_on: {{ ref('dim_contacts__tickets') }}
-- depends_on: {{ ref('dim_contacts__deals') }}
/* we save all currently active load ids into the processed ids table */
select load_id, {{ current_timestamp() }} as inserted_at FROM {{ ref('dlt_active_load_ids') }}