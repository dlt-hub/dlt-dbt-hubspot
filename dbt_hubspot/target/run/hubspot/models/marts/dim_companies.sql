
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_companies`
      
    
    

    OPTIONS()
    as (
      /* Table: companies */

SELECT
    t.createdate,
    t.hs_lastmodifieddate,
    t.hs_object_id,
    t.hubspot_owner_assigneddate,
    t.hubspot_owner_id,
    t.lifecyclestage,
    t.name,
    t.num_associated_contacts,
    t.id,
    t._dlt_load_id,
    t._dlt_id,
FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_companies` as t
    );
  