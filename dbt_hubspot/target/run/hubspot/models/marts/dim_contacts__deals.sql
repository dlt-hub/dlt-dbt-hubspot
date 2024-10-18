
  
    

    create or replace table `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts__deals`
      
    
    

    OPTIONS()
    as (
      /* Table: contacts__deals */
/* Parent: contacts */

SELECT
    t.value,
    t.deals_id,
    t._dlt_parent_id,
    t._dlt_list_idx,
    t._dlt_id,
FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_contacts__deals` as t
/* this join to the parent table is not necessarily needed for this template to work */
JOIN `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_contacts` as pt
ON (t._dlt_parent_id = pt._dlt_id)
    );
  