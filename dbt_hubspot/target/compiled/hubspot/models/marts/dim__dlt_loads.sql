/* Table: _dlt_loads */

/* Description: Created by DLT. Tracks completed loads */
SELECT
    t.load_id,
    t.schema_name,
    t.status,
    t.inserted_at,
    t.schema_version_hash,
FROM  `dlthub-sandbox`.`hubspot_dataset_test_2_transformed`.`stg__dlt_loads` as t