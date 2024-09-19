/* Fact Table: tickets */
{{
    config(
        materialized='incremental'
    )
}}

SELECT

    -- select columns for tickets
    ---- main table
    tickets."createdate" as tickets_createdate,
    tickets."hs_lastmodifieddate" as tickets_hs_lastmodifieddate,
    tickets."hs_object_id" as tickets_hs_object_id,
    tickets."hs_pipeline" as tickets_hs_pipeline,
    tickets."hs_pipeline_stage" as tickets_hs_pipeline_stage,
    tickets."subject" as tickets_subject,
    tickets."id" as tickets_id,

    -- select columns for contacts__tickets_id
    ---- joined via tickets.id
    contacts__tickets_id."_dlt_id" as contacts__tickets_id__dlt_id,
    -- contacts__tickets_id."value" as contacts__tickets_id_value,
    -- contacts__tickets_id."tickets_id" as contacts__tickets_id_tickets_id,

    -- select columns for contacts__dlt_parent_id_id
    ---- joined via contacts__tickets_id._dlt_parent_id
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

FROM  {{ ref('stg_hubspot__tickets') }} as tickets
LEFT JOIN {{ ref('dim_hubspot__contacts__tickets') }} as contacts__tickets_id ON contacts__tickets_id."tickets_id" = tickets."id"
LEFT JOIN {{ ref('dim_hubspot__contacts') }} as contacts__dlt_parent_id_id ON contacts__dlt_parent_id_id."_dlt_id" = contacts__tickets_id."_dlt_parent_id"