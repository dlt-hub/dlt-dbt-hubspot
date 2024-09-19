# Hubspot dlt-dbt-generator package
This package uses a dlt-dbt-generator to model data that is loaded from your dlt pipeline.

## In a nutshell

- It automatically inspects the pipeline schema and generates a baseline dbt project, complete with staging and mart layers. The generator is able to create staging, dimensional, and fact models.

- Additionally, the dlt-dbt-generator lets you define relationships between the schema tables, which can be used to create fact tables automatically.

The resulting project can be executed using the credentials already provided to the pipeline and is capable of processing incoming data incrementally.

## How it works?
1. Setup and run your dlt-hubspot pipeline.
2. Install and execute the dlt-dbt-generator to automatically create the initial set of mart and staging tables.
3. Before running the generator, make sure the primary keys are defined. These keys are essential for accurately linking data across tables.
4. Execute the generator and examine the baseline dbt project created.
5. To add customized fact tables, define how different tables relate to each other based on your specific data needs. This involves setting up custom relationships that reflect your data model.
6. After defining all necessary relationships, re-run the pipeline to apply the changes. This step processes the data with the updated configurations.
7. Use the dlt-dbt-generator again to create dimension and fact tables. This finalizes the structure of your data model, allowing for comprehensive analysis and insights.

## Install `dlt-dbt-generator`
Install the latest version on `dlt-dbt-generator` using the following command:

```sh
pip install https://dlt-packages.fra1.digitaloceanspaces.com/dlt-plus/dlt_plus-0.1.0-py3-none-any.whl
```

To install the latest nightly build with Poetry, first uninstall any existing version you have installed, then run:

```sh
poetry add https://dlt-packages.fra1.digitaloceanspaces.com/dlt-plus/dlt_plus-0.1.0-py3-none-any.whl
```
### Licensing
To use the dlt+ tools, you need to obtain a valid license from dltHub. Once you have received your license, you can make it available to dlt+ by adding it to your environment:

```sh
export RUNTIME__LICENSE="eyJhbGciOiJSUz...vKSjbEc==="
```
Or by adding it to your global or local `secrets.toml` file:

```toml
[runtime]
license="eyJhbGciOiJSUz...vKSjbEc==="
```

You can verify that the license was installed correctly and is valid by running:

```sh
$ dlt-license
```

The full guide to read for generating fact and dimension tables using `dlt-dbt-generator`: [here](https://dlt-plus.netlify.app/docs/plus/dlt_dbt_generator/).


## Database support
We support 
- Redshift, 
- BigQuery,
- Snowflake, 
- Athena, 
- Postgres.

## How to use this package

We recommend that you add this package as a dependency to your own `dbt` package.


### How to run the `dlt` pipeline

To deploy dlt Hubspot pipeline, please read the full documentation [here](https://dlthub.com/docs/dlt-ecosystem/verified-sources/hubspot). 

### Install `dlt`
Install dlt with destination dependencies, e.g. [BigQuery](https://dlthub.com/docs/dlt-ecosystem/destinations/bigquery):

```shell
pip install dlt[bigquery]
```
or
```shell
pip install -r requirements.txt
```

> If you use [Redshift](https://dlthub.com/docs/dlt-ecosystem/destinations/redshift) as a destination, then run `pip install dlt[redshift]`. 
> 
> If you use [Snowflake](https://dlthub.com/docs/dlt-ecosystem/destinations/snowflake) as a destination, then run `pip install dlt[snowflake]`. 
> 
> If you use [Athena](https://dlthub.com/docs/dlt-ecosystem/destinations/athena) as a destination, then run `pip install dlt[athena]`. 
> 
> If you use [Postgres](https://dlthub.com/docs/dlt-ecosystem/destinations/postgres) as a destination, then run `pip install dlt[postgres]`. 

More about installing dlt: [Installation](https://dlthub.com/docs/reference/installation).

### Configuration

In `.dlt` folder add your credentials to `secrets.toml`.  
It's where you store sensitive information securely, like access tokens, private keys, etc. 
Keep this file safe, do not commit it.

**Credentials for source data**

Add the Hubspot credentials for a database where you want to get your data from:
```toml
# Hubspot source configuration

[sources.hubspot]
api_key= "Please set me up!"
```

**Credentials for destination**

Add the destination credentials for a database where you want to upload your data:
```toml
# BigQuery destination configuration

[destination.bigquery]
location = "US"
[destination.bigquery.credentials]
project_id = "please set me up!"
private_key = "please set me up!"
client_email = "please set me up!"
```

Read more about configuration: [Secrets and Configs](https://dlthub.com/docs/general-usage/credentials/configuration). 
### Define primary keys
To generate fact tables, you will first need to add additional relationship hints to your pipeline. This requires ensuring that each table has a primary key defined, as relationships are based on these keys:

```py
import dlt 

@dlt.resource(name="deals", primary_key="id")
def deals():
    ...
```
or 

```py
source = hubspot()
source.deals.apply_hints(primary_key="id")
```

### Run the pipeline

Run the CLI script with defaults by executing the following command:
```bash
python bigquery_pipeline.py
```
Options:
- `--pipeline_name` (required): Name of the pipeline. Defaults to "ga4_event_export_pipeline".
- `--tables`: List of tables to process. Defaults to "events".
- `--month`: Month for data processing. Defaults to last month.
- `--year`: Year for data processing. Defaults to current year.
- `--destination`: Destination for the pipeline. Defaults to "bigquery".
- `--dataset`: Name of the dataset. Defaults to "ga4_event_export_dataset".
- `--dbt_run_params`: Additional run parameters for dbt. Defaults to "--fail-fast --full-refresh".
- `--dbt_additional_vars`: Additional variables for dbt. Defaults to None.
- `--write_disposition`: dlt mode. The "replace" mode completely replaces the existing data in the destination with the new data, 
  while the "append" mode adds the new data to the existing data in the destination. Defaults to "replace".

### 2. Generating your baseline project
Ensure that your `dlt` pipeline has been run at least once locally or restored from the destination. Then, navigate to the directory where your pipeline is located and, using its name, execute the following command to create a baseline dbt project with dimensional tables for all existing pipeline tables:

```sh
dlt-dbt-generator <pipeline-name>
```

This command generates a new folder named dbt_<pipeline-name>, which contains the project with the following structure:

```
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
|   |   └── dim_<pipeline-name>__deals.sql
|   |   └── dim_<pipeline-name>__owners.sql
|   |   └── dim_<pipeline-name>__pipelines_deals__stages.sql
|   |   └── dim_<pipeline-name>__pipelines_deals.sql
|   |   └── dim_<pipeline-name>__stages_timing_deals.sql
|   |   └── dim_<pipeline-name>__tickets.sql
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

### 3. Create fact tables 

To create a fact table, you can use the primary critical relationships created earlier or you could define custom relationships using the relationship adapter as :

```py
import dlt
from dlt_plus.dbt_generator.utils import table_reference_adapter

#configure and run your pipeline
p = dlt.pipeline(pipeline_name="example_shop", destination="duckdb")
p.run([deals(), contacts(), tickets()])

# Define relationships in your schema
table_reference_adapter(
    p,
    "deals",
    references=[
        {
            "referenced_table": "contacts__deals",
            "columns": ["id"],
            "referenced_columns": ["deals_id"],
        }
    ],
    )

    table_reference_adapter(
    p,
    "tickets",
    references=[
        {
            "referenced_table": "contacts__tickets",
            "columns": ["id"],
            "referenced_columns": ["tickets_id"],
        }
    ],
    )
  
```

> Please note that the abovementioned relationships are for demonstration purposes only. You should define these relationships based on your specific use case and the design of your dimensional model. Tailor them to meet the unique requirements of your project.

```
dlt-dbt-generator <pipeline-name> --fact deals


dlt-dbt-generator <pipeline-name> --fact tickets
```

The new model you generated looks like:
```
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
│   │   ...
│   ├── <pipeline-name>_dlt_active_load_ids.sql # Used for incremental processing of data
│   └── <pipeline-name>_dlt_processed_load.sql # Used for incremental processing of data
├── tests/
├── dbt_project.yml
└── requirements.txt
```

## Customize as you need
The dbt model above can be further customized according to the requirements. Using this package you'll get a basic template
for data model which can be further modified as required.

1. The schema of data exported from GA4 to BigQuery:
    
   ![picture1](https://storage.googleapis.com/dlt-blog-images/hubspot_schema_new%20(1).png)

   Here's the link to the DB diagram: [link](https://dbdiagram.io/d/hubspot_normal-66d161a0eef7e08f0e338a98).




