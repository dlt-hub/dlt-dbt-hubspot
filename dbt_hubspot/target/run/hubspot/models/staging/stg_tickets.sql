
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_tickets`
      
    
    

    OPTIONS()
    as (
      /* Table: tickets */


-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids`

SELECT
/* select which columns will be available for table 'tickets' */
    createdate,
    hs_lastmodifieddate,
    hs_object_id,
    hs_pipeline,
    hs_pipeline_stage,
    subject,
    id,
    _dlt_load_id,
    _dlt_id,
FROM `dlthub-sandbox`.`hubspot_dataset_test_2`.`tickets`

/* we only load table items of the currently active load ids into the staging table */
WHERE _dlt_load_id IN ( SELECT load_id FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids` )
    );
  