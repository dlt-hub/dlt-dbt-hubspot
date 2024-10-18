/* Table: contacts__deals */
/* Parent: { parent }} */


-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids`
-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_contacts`

SELECT
/* select which columns will be available for table 'contacts__deals' */
    value,
    deals_id,
    _dlt_parent_id,
    _dlt_list_idx,
    _dlt_id,
FROM `dlthub-sandbox`.`hubspot_dataset_test_2`.`contacts__deals`

/* we only load table items if the parent table has the parent item */
WHERE _dlt_parent_id IN ( SELECT _dlt_id FROM `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg_contacts` )