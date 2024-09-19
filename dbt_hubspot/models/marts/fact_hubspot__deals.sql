/* Fact Table: deals */
{{
    config(
        materialized='incremental'
    )
}}

SELECT

    -- select columns for deals
    ---- main table
    deals."closedate" as closedate,
    deals."createdate" as createdate,
    deals."days_to_close" as days_to_close,
    deals."dealname" as dealname,
    deals."dealstage" as dealstage,
    deals."hs_closed_amount" as hs_closed_amount,
    deals."hs_closed_amount_in_home_currency" as hs_closed_amount_in_home_currency,
    deals."hs_lastmodifieddate" as hs_lastmodifieddate,
    deals."hs_num_of_associated_line_items" as hs_num_of_associated_line_items,
    deals."hs_object_id" as hs_object_id,
    deals."hubspot_owner_assigneddate" as hubspot_owner_assigneddate,
    deals."hubspot_owner_id" as hubspot_owner_id,
    deals."num_associated_contacts" as num_associated_contacts,
    deals."pipeline" as pipeline,
    deals."id" as id,

    -- select columns for contacts__deals_id
    ---- joined via deals.id
    -- contacts__deals_id."_dlt_id" as contacts__deals_id__dlt_id,
    contacts__deals_id."value" as contacts_deals_value,
    contacts__deals_id."deals_id" as contacts_deals_deals_id,

    -- select columns for contacts__dlt_parent_id_id
    ---- joined via contacts__deals_id._dlt_parent_id
    contacts__dlt_parent_id_id."id" as contacts__dlt_parent_id_id_id,
    -- contacts__dlt_parent_id_id."deals_id" as contacts__dlt_parent_id_id_deals_id,
    -- contacts__dlt_parent_id_id."city" as contacts__dlt_parent_id_id_city,
    -- contacts__dlt_parent_id_id."company" as contacts__dlt_parent_id_id_company,
    -- contacts__dlt_parent_id_id."createdate" as contacts__dlt_parent_id_id_createdate,
    -- contacts__dlt_parent_id_id."email" as contacts__dlt_parent_id_id_email,
    -- contacts__dlt_parent_id_id."firstname" as contacts__dlt_parent_id_id_firstname,
    -- contacts__dlt_parent_id_id."hs_object_id" as contacts__dlt_parent_id_id_hs_object_id,
    -- contacts__dlt_parent_id_id."jobtitle" as contacts__dlt_parent_id_id_jobtitle,
    -- contacts__dlt_parent_id_id."lastmodifieddate" as contacts__dlt_parent_id_id_lastmodifieddate,
    -- contacts__dlt_parent_id_id."lastname" as contacts__dlt_parent_id_id_lastname,
    -- contacts__dlt_parent_id_id."lifecyclestage" as contacts__dlt_parent_id_id_lifecyclestage,
    -- contacts__dlt_parent_id_id."num_conversion_events" as contacts__dlt_parent_id_id_num_conversion_events,
    -- contacts__dlt_parent_id_id."num_unique_conversion_events" as contacts__dlt_parent_id_id_num_unique_conversion_events,
    -- contacts__dlt_parent_id_id."state" as contacts__dlt_parent_id_id_state,
    -- contacts__dlt_parent_id_id."website" as contacts__dlt_parent_id_id_website,
    -- contacts__dlt_parent_id_id."twitterhandle" as contacts__dlt_parent_id_id_twitterhandle,
    -- contacts__dlt_parent_id_id."twitterprofilephoto" as contacts__dlt_parent_id_id_twitterprofilephoto,
    -- contacts__dlt_parent_id_id."first_deal_created_date" as contacts__dlt_parent_id_id_first_deal_created_date,
    -- contacts__dlt_parent_id_id."hs_lead_status" as contacts__dlt_parent_id_id_hs_lead_status,
    -- contacts__dlt_parent_id_id."hubspot_owner_assigneddate" as contacts__dlt_parent_id_id_hubspot_owner_assigneddate,
    -- contacts__dlt_parent_id_id."hubspot_owner_id" as contacts__dlt_parent_id_id_hubspot_owner_id,
    -- contacts__dlt_parent_id_id."num_associated_deals" as contacts__dlt_parent_id_id_num_associated_deals,
    -- contacts__dlt_parent_id_id."phone" as contacts__dlt_parent_id_id_phone,
    -- contacts__dlt_parent_id_id."notes_last_contacted" as contacts__dlt_parent_id_id_notes_last_contacted,
    -- contacts__dlt_parent_id_id."notes_last_updated" as contacts__dlt_parent_id_id_notes_last_updated,
    -- contacts__dlt_parent_id_id."num_contacted_notes" as contacts__dlt_parent_id_id_num_contacted_notes,
    -- contacts__dlt_parent_id_id."num_notes" as contacts__dlt_parent_id_id_num_notes,
    -- contacts__dlt_parent_id_id."address" as contacts__dlt_parent_id_id_address,
    -- contacts__dlt_parent_id_id."zip" as contacts__dlt_parent_id_id_zip,

FROM  {{ ref('stg_hubspot__deals') }} as deals
LEFT JOIN {{ ref('dim_hubspot__contacts__deals') }} as contacts__deals_id ON contacts__deals_id."deals_id" = deals."id"
LEFT JOIN {{ ref('dim_hubspot__contacts') }} as contacts__dlt_parent_id_id ON contacts__dlt_parent_id_id."_dlt_id" = contacts__deals_id."_dlt_parent_id"