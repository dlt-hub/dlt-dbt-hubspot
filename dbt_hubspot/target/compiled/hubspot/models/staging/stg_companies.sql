/* Table: companies */


-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids`

SELECT
/* select which columns will be available for table 'companies' */
    createdate,
    hs_lastmodifieddate,
    hs_object_id,
    hubspot_owner_assigneddate,
    hubspot_owner_id,
    lifecyclestage,
    name,
    num_associated_contacts,
    id,
    _dlt_load_id,
    _dlt_id,
FROM `dlthub-sandbox`.`hubspot_dataset_test_2`.`companies`

/* we only load table items of the currently active load ids into the staging table */
WHERE _dlt_load_id IN ( SELECT load_id FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids` )