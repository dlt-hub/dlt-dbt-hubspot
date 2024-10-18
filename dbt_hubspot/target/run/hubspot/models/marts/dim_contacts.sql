
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts`
      
    
    

    OPTIONS()
    as (
      /* Table: contacts */

SELECT
    t.city,
    t.company,
    t.createdate,
    t.email,
    t.firstname,
    t.hs_object_id,
    t.jobtitle,
    t.lastmodifieddate,
    t.lastname,
    t.lifecyclestage,
    t.num_conversion_events,
    t.num_unique_conversion_events,
    t.state,
    t.website,
    t.id,
    t._dlt_load_id,
    t._dlt_id,
    t.twitterhandle,
    t.twitterprofilephoto,
    t.first_deal_created_date,
    t.hubspot_owner_assigneddate,
    t.hubspot_owner_id,
    t.num_associated_deals,
    t.phone,
    t.notes_last_contacted,
    t.notes_last_updated,
    t.num_contacted_notes,
    t.num_notes,
    t.address,
    t.zip,
FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_contacts` as t
    );
  