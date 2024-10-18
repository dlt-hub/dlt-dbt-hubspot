/* Table: _dlt_loads */
/* Description: Created by DLT. Tracks completed loads */


-- depends_on: `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`dlt_active_load_ids`

SELECT
/* select which columns will be available for table '_dlt_loads' */
    load_id,
    schema_name,
    status,
    inserted_at,
    schema_version_hash,
FROM `dlthub-sandbox`.`hubspot_dataset_test_2`.`_dlt_loads`