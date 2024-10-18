
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_tickets`
      
    
    

    OPTIONS()
    as (
      /* Table: tickets */

SELECT
    t.createdate,
    t.hs_lastmodifieddate,
    t.hs_object_id,
    t.hs_pipeline,
    t.hs_pipeline_stage,
    t.subject,
    t.id,
    t._dlt_load_id,
    t._dlt_id,
FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_tickets` as t
    );
  