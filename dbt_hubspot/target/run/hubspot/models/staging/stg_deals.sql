
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_deals`
      
    
    

    OPTIONS()
    as (
      /* Table: deals */


-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids`

SELECT
/* select which columns will be available for table 'deals' */
    closedate,
    createdate,
    days_to_close,
    dealname,
    dealstage,
    hs_lastmodifieddate,
    hs_object_id,
    hubspot_owner_assigneddate,
    hubspot_owner_id,
    num_associated_contacts,
    pipeline,
    id,
    _dlt_load_id,
    _dlt_id,
FROM `dlthub-sandbox`.`hubspot_dataset_test_2`.`deals`

/* we only load table items of the currently active load ids into the staging table */
WHERE _dlt_load_id IN ( SELECT load_id FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids` )
    );
  