/* Fact Table: deals */
{{
    config(
        materialized='incremental'
    )
}}

SELECT
    ---- main table deals
    deals._dlt_id,
    deals.closedate,
    deals.createdate,
    deals.days_to_close,
    deals.dealname,
    deals.dealstage,
    deals.hs_lastmodifieddate,
    deals.hs_object_id,
    deals.hubspot_owner_assigneddate,
    deals.hubspot_owner_id,
    deals.num_associated_contacts,
    deals.pipeline,
    deals.id,

    
    ---- dim table contacts__deals via contacts__deals__id
    contacts__deals__id.deals_id as contacts__deals__id__deals_id,
    -- contacts__deals__id.value as contacts__deals__id__value,
    
    ---- dim table contacts via contacts__contacts__deals__id
    contacts__contacts__deals__id._dlt_id as contacts__contacts__deals__id___dlt_id,
    -- contacts__contacts__deals__id.city as contacts__contacts__deals__id__city,
    -- contacts__contacts__deals__id.company as contacts__contacts__deals__id__company,
    -- contacts__contacts__deals__id.createdate as contacts__contacts__deals__id__createdate,
    -- contacts__contacts__deals__id.email as contacts__contacts__deals__id__email,
    -- contacts__contacts__deals__id.firstname as contacts__contacts__deals__id__firstname,
    -- contacts__contacts__deals__id.hs_object_id as contacts__contacts__deals__id__hs_object_id,
    -- contacts__contacts__deals__id.jobtitle as contacts__contacts__deals__id__jobtitle,
    -- contacts__contacts__deals__id.lastmodifieddate as contacts__contacts__deals__id__lastmodifieddate,
    -- contacts__contacts__deals__id.lastname as contacts__contacts__deals__id__lastname,
    -- contacts__contacts__deals__id.lifecyclestage as contacts__contacts__deals__id__lifecyclestage,
    -- contacts__contacts__deals__id.num_conversion_events as contacts__contacts__deals__id__num_conversion_events,
    -- contacts__contacts__deals__id.num_unique_conversion_events as contacts__contacts__deals__id__num_unique_conversion_events,
    -- contacts__contacts__deals__id.state as contacts__contacts__deals__id__state,
    -- contacts__contacts__deals__id.website as contacts__contacts__deals__id__website,
    -- contacts__contacts__deals__id.id as contacts__contacts__deals__id__id,
    -- contacts__contacts__deals__id.twitterhandle as contacts__contacts__deals__id__twitterhandle,
    -- contacts__contacts__deals__id.twitterprofilephoto as contacts__contacts__deals__id__twitterprofilephoto,
    -- contacts__contacts__deals__id.first_deal_created_date as contacts__contacts__deals__id__first_deal_created_date,
    -- contacts__contacts__deals__id.hubspot_owner_assigneddate as contacts__contacts__deals__id__hubspot_owner_assigneddate,
    -- contacts__contacts__deals__id.hubspot_owner_id as contacts__contacts__deals__id__hubspot_owner_id,
    -- contacts__contacts__deals__id.num_associated_deals as contacts__contacts__deals__id__num_associated_deals,
    -- contacts__contacts__deals__id.phone as contacts__contacts__deals__id__phone,
    -- contacts__contacts__deals__id.notes_last_contacted as contacts__contacts__deals__id__notes_last_contacted,
    -- contacts__contacts__deals__id.notes_last_updated as contacts__contacts__deals__id__notes_last_updated,
    -- contacts__contacts__deals__id.num_contacted_notes as contacts__contacts__deals__id__num_contacted_notes,
    -- contacts__contacts__deals__id.num_notes as contacts__contacts__deals__id__num_notes,
    -- contacts__contacts__deals__id.address as contacts__contacts__deals__id__address,
    -- contacts__contacts__deals__id.zip as contacts__contacts__deals__id__zip,
    

FROM  {{ ref('stg_deals') }} as deals
LEFT JOIN {{ ref('dim_contacts__deals') }} as contacts__deals__id ON
        contacts__deals__id.deals_id = deals.id

LEFT JOIN {{ ref('dim_contacts') }} as contacts__contacts__deals__id ON
        contacts__contacts__deals__id._dlt_id = contacts__deals__id._dlt_parent_id
