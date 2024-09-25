# HubSpot dlt-dbt Package

### Overview
The HubSpot dbt package offers data models to help you transform and analyze HubSpot data. It's designed to integrate seamlessly with the dlt HubSpot pipeline, which extracts and loads HubSpot data into your data warehouse.

### Who is this for?
This package is perfect for dbt users who want to integrate HubSpot data into their analytics workflows without building models from scratch.

### Key Features
- **Staging Models:** Clean and prepare raw HubSpot data for downstream analysis.
- **Mart Models:** Pre-built dimension and fact tables for key HubSpot entities like contacts, deals, companies, and tickets.
- **Incremental Loading:** Supports incremental data processing to optimize performance.
- **Easy Integration:** Designed to work out-of-the-box with the dlt HubSpot pipeline.

### Setup Instructions

#### Prerequisites
- dbt Core installed in your environment.
- Access to a supported data warehouse: BigQuery, Snowflake, Redshift, Athena, or PostgreSQL.
- The dlt HubSpot pipeline is set up and running.

### Step 1: Set Up the dlt HubSpot Pipeline
1. **Install dlt:**
   ``` 
   pip install dlt
   ```
2. **Configure the Pipeline:**
   Follow the dlt HubSpot pipeline documentation to set up your pipeline. Ensure you have your HubSpot API key and destination credentials configured.

3. **Run the Pipeline:**
   Extract and load data from HubSpot into your data warehouse by running the pipeline.

### Step 2: Install and Configure the dbt Project

1. Install the HubSpot dbt package into your dbt environment.
2. Configure your 'dbt_project.yml' file with the appropriate connection details for your data warehouse.
3. Ensure the data from your dlt HubSpot pipeline is available in your warehouse.

This is how the tables in dbt package look like:
```text
dbt_<pipeline-name>/
├── analysis/
├── macros/
├── models/
│   ├── marts/
│   │   ├── dim_<pipeline-name>__dlt_loads.sql
│   │   ├── dim_<pipeline-name>__companies.sql
│   │   └── dim_<pipeline-name>__contacts__deals.sql
│   │   └── dim_<pipeline-name>__contacts__tickets.sql
│   │   └── dim_<pipeline-name>__contacts.sql
|   |   └── fact_<pipeline-name>__deals.sql
|   |   └── dim_<pipeline-name>__owners.sql
|   |   └── dim_<pipeline-name>__pipelines_deals__stages.sql
|   |   └── dim_<pipeline-name>__pipelines_deals.sql
|   |   └── dim_<pipeline-name>__stages_timing_deals.sql
|   |   └── fact_<pipeline-name>__tickets.sql
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── stg_<pipeline-name>__dlt_loads.sql
│   │   ├── stg_<pipeline-name>__companies.sql
│   │   └── stg_<pipeline-name>__contacts__deals.sql
│   │   └── stg_<pipeline-name>__contacts__tickets.sql
│   │   └── stg_<pipeline-name>__contacts.sql
|   |   └── stg_<pipeline-name>__deals.sql
|   |   └── stg_<pipeline-name>__owners.sql
|   |   └── stg_<pipeline-name>__pipelines_deals__stages.sql
|   |   └── stg_<pipeline-name>__pipelines_deals.sql
|   |   └── stg_<pipeline-name>__stages_timing_deals.sql
|   |   └── stg_<pipeline-name>__tickets.sql
│   ├── <pipeline-name>_dlt_active_load_ids.sql # Used for incremental processing of data
│   └── <pipeline-name>_dlt_processed_load.sql # Used for incremental processing of data
├── tests/
├── dbt_project.yml
└── requirements.txt
```
### Step 3: Run dbt
Execute the dbt models to transform the raw HubSpot data into useful tables:

```sh
dbt run
```

>You can use the 'run_hubspot_dbt.py' script to execute your dbt transformations and load the results into a 
>new dataset named `<original-dataset>_transformed` and runs the dbt tests.To use, please ensure you configure 
>your dlt pipeline name and destination correctly.

To check for issues, run the dbt tests:

```sh
dbt test
```

### Customization
While this package provides a solid foundation, you can customize it to suit your specific needs:

- Modify the models to align with your business logic.
- Add relationships between tables by modifying your dlt pipeline schema.

#### Optional: Advanced Usage (Generator and Licensing)

This package was created using the dlt-dbt-generator by dlt-plus. For more information about dlt-plus, refer to the 
[dlt-plus documentation.](https://dlt-plus.netlify.app/docs/plus/intro/).To learn more about the dlt-dbt-generator, 
consult the [dlt-dbt-generator](https://dlt-plus.netlify.app/docs/plus/dlt_dbt_generator/#5-running-dbt-package-directly) documentation.

### Schema diagram
The dbt model above can be further customized according to the requirements. Using this package you'll get a basic template
for data model which can be further modified as required.

1. The schema of data modelled above using dlt-dbt-generator:
    
   ![picture1](https://storage.googleapis.com/dlt-blog-images/hubspot_schema_new%20(1).png)

> Please note that this is a starting template for your data model and is not the final product. It is advised to customize the
> data model as per your needs.

Here's the link to the DB diagram: [link](https://dbdiagram.io/d/hubspot_schema_new-66e1604a6dde7f4149be5c2a).


