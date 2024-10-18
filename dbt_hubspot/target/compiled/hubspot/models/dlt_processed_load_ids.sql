
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim__dlt_loads`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_companies`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`fact_deals`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`fact_tickets`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts__tickets`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dim_contacts__deals`
/* we save all currently active load ids into the processed ids table */
select load_id, current_timestamp() as inserted_at FROM `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids`