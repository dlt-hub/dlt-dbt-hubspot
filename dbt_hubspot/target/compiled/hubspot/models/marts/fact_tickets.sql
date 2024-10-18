/* Fact Table: tickets */


SELECT
    ---- main table tickets
    tickets._dlt_id,
    tickets.createdate,
    tickets.hs_lastmodifieddate,
    tickets.hs_object_id,
    tickets.hs_pipeline,
    tickets.hs_pipeline_stage,
    tickets.subject,
    tickets.id,

    
    ---- dim table contacts__tickets via contacts__tickets__id
    contacts__tickets__id.tickets_id as contacts__tickets__id__tickets_id,
    -- contacts__tickets__id.value as contacts__tickets__id__value,
    
    ---- dim table contacts via contacts__contacts__tickets__id
    contacts__contacts__tickets__id._dlt_id as contacts__contacts__tickets__id___dlt_id,
    -- contacts__contacts__tickets__id.city as contacts__contacts__tickets__id__city,
    -- contacts__contacts__tickets__id.company as contacts__contacts__tickets__id__company,
    -- contacts__contacts__tickets__id.createdate as contacts__contacts__tickets__id__createdate,
    -- contacts__contacts__tickets__id.email as contacts__contacts__tickets__id__email,
    -- contacts__contacts__tickets__id.firstname as contacts__contacts__tickets__id__firstname,
    -- contacts__contacts__tickets__id.hs_object_id as contacts__contacts__tickets__id__hs_object_id,
    -- contacts__contacts__tickets__id.jobtitle as contacts__contacts__tickets__id__jobtitle,
    -- contacts__contacts__tickets__id.lastmodifieddate as contacts__contacts__tickets__id__lastmodifieddate,
    -- contacts__contacts__tickets__id.lastname as contacts__contacts__tickets__id__lastname,
    -- contacts__contacts__tickets__id.lifecyclestage as contacts__contacts__tickets__id__lifecyclestage,
    -- contacts__contacts__tickets__id.num_conversion_events as contacts__contacts__tickets__id__num_conversion_events,
    -- contacts__contacts__tickets__id.num_unique_conversion_events as contacts__contacts__tickets__id__num_unique_conversion_events,
    -- contacts__contacts__tickets__id.state as contacts__contacts__tickets__id__state,
    -- contacts__contacts__tickets__id.website as contacts__contacts__tickets__id__website,
    -- contacts__contacts__tickets__id.id as contacts__contacts__tickets__id__id,
    -- contacts__contacts__tickets__id.twitterhandle as contacts__contacts__tickets__id__twitterhandle,
    -- contacts__contacts__tickets__id.twitterprofilephoto as contacts__contacts__tickets__id__twitterprofilephoto,
    -- contacts__contacts__tickets__id.first_deal_created_date as contacts__contacts__tickets__id__first_deal_created_date,
    -- contacts__contacts__tickets__id.hubspot_owner_assigneddate as contacts__contacts__tickets__id__hubspot_owner_assigneddate,
    -- contacts__contacts__tickets__id.hubspot_owner_id as contacts__contacts__tickets__id__hubspot_owner_id,
    -- contacts__contacts__tickets__id.num_associated_deals as contacts__contacts__tickets__id__num_associated_deals,
    -- contacts__contacts__tickets__id.phone as contacts__contacts__tickets__id__phone,
    -- contacts__contacts__tickets__id.notes_last_contacted as contacts__contacts__tickets__id__notes_last_contacted,
    -- contacts__contacts__tickets__id.notes_last_updated as contacts__contacts__tickets__id__notes_last_updated,
    -- contacts__contacts__tickets__id.num_contacted_notes as contacts__contacts__tickets__id__num_contacted_notes,
    -- contacts__contacts__tickets__id.num_notes as contacts__contacts__tickets__id__num_notes,
    -- contacts__contacts__tickets__id.address as contacts__contacts__tickets__id__address,
    -- contacts__contacts__tickets__id.zip as contacts__contacts__tickets__id__zip,
    

FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_tickets` as tickets
LEFT JOIN `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts__tickets` as contacts__tickets__id ON
        contacts__tickets__id.tickets_id = tickets.id

LEFT JOIN `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts` as contacts__contacts__tickets__id ON
        contacts__contacts__tickets__id._dlt_id = contacts__tickets__id._dlt_parent_id