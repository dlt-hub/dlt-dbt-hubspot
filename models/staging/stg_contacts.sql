/* Table: contacts */
{{
    config(
        materialized='table'
    )
}}

-- depends_on: {{ ref('dlt_active_load_ids') }}

SELECT
/* select which columns will be available for table 'contacts' */
    city,
    company,
    createdate,
    email,
    firstname,
    hs_object_id,
    jobtitle,
    lastmodifieddate,
    lastname,
    lifecyclestage,
    num_conversion_events,
    num_unique_conversion_events,
    state,
    website,
    id,
    _dlt_load_id,
    _dlt_id,
    twitterhandle,
    twitterprofilephoto,
    first_deal_created_date,
    hubspot_owner_assigneddate,
    hubspot_owner_id,
    num_associated_deals,
    phone,
    notes_last_contacted,
    notes_last_updated,
    num_contacted_notes,
    num_notes,
    address,
    zip,
FROM {{ source('raw_data', 'contacts') }}

/* we only load table items of the currently active load ids into the staging table */
WHERE _dlt_load_id IN ( SELECT load_id FROM  {{ ref('dlt_active_load_ids') }} )