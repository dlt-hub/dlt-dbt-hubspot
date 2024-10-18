
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_deals`
      
    
    

    OPTIONS()
    as (
      /* Table: deals */

SELECT
    t.closedate,
    t.createdate,
    t.days_to_close,
    t.dealname,
    t.dealstage,
    t.hs_lastmodifieddate,
    t.hs_object_id,
    t.hubspot_owner_assigneddate,
    t.hubspot_owner_id,
    t.num_associated_contacts,
    t.pipeline,
    t.id,
    t._dlt_load_id,
    t._dlt_id,
FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_deals` as t
    );
  