# HubSpot dbt Package

### Overview
The HubSpot dbt package provides a comprehensive set of data models to transform and analyze your HubSpot data. This package is designed to work seamlessly with the open-source dlt HubSpot pipeline,
which extracts and loads data from HubSpot into your data warehouse.

### Who is this for?
This package is ideal for dbt users who want to integrate HubSpot data into their analytics workflows. If you're looking to use pre-built models for HubSpot and streamline your data pipeline, this package is for you.

### Key Features

- **Staging Models:** Clean and prepare raw HubSpot data for downstream analysis.
- **Mart Models:** Pre-built dimension and fact tables for key HubSpot entities like contacts, deals, companies, and tickets.
- **Incremental Loading:** Supports incremental data processing to optimize performance.
- **Easy Integration:** Designed to work out-of-the-box with the dlt HubSpot pipeline.

### How it works?
This package was generated using the dlt-dbt-generator, a tool that automatically inspects the dlt pipeline schema and generates a 
baseline dbt project. The generator creates staging and mart layers based on the schema 
of the data loaded by the dlt pipeline.

### Installation and setup

#### Prerequisites
- dbt Core installed in your environment.
- Access to a supported data warehouse: BigQuery, Snowflake, Redshift, Athena, or PostgreSQL.
- The dlt HubSpot pipeline is set up and running.

### Step 1: Set up the dlt Hubspot pipeline

1. **Install dlt:**
   
   ```sh
   pip install dlt
   ```
2. **Configure the Pipeline:**

   Follow the dlt HubSpot pipeline [documentation](https://dlthub.com/docs/dlt-ecosystem/verified-sources/hubspot) to set up your pipeline. 
   Ensure you have your HubSpot API key and destination credentials configured.

3. **Run the Pipeline:**

   Execute the pipeline to extract and load data from HubSpot into your data warehouse.

### Step 2: Install the dlt-dbt-generator package

Install the latest version on dlt-dbt-generator using the following command:

```sh
pip install https://dlt-packages.fra1.digitaloceanspaces.com/dlt-plus/dlt_plus-0.2.0-py3-none-any.whl
```

To install the latest nightly build with Poetry, first uninstall any existing version you have installed, then run:

```sh
poetry add https://dlt-packages.fra1.digitaloceanspaces.com/dlt-plus/dlt_plus-0.2.0-py3-none-any.whl
```

### Step 3: Licensing
To use the dlt+ tools, you need to obtain a valid license from dltHub. Once you have received your license, you can make it available to dlt+ by adding it to your environment:

```sh
export RUNTIME__LICENSE="eyJhbGciOiJSUz...vKSjbEc==="
```
Or by adding it to your global or local "secrets.toml" file:

```toml
[runtime]
license="eyJhbGciOiJSUz...vKSjbEc==="
```
You can verify that the license was installed correctly and is valid by running:
```sh
$ dlt-license
```
The full guide to read for generating fact and dimension tables using dlt-dbt-generator: here.


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

Enter credentials for your chosen destination as per the [docs.](https://dlthub.com/docs/dlt-ecosystem/destinations/)


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
This command generates a new folder named `dbt_`, which contains the project with the following structure:

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

Additionally, in the directory where you ran the generator, you will find a new Python file named run_<pipeline-name>_dbt.py, which you can execute to run the project.

### Step 3: Configure your dbt project
In this case, you don't need to configure your `dbt_project.yml`, as it will be automatically generated with the following 
pre-configured settings when you run the generator:

```yaml
name: 'hubspot'

config-version: 2
version: '0.1'

profile: 'hubspot'

model-paths: ["models"]
test-paths: ["tests"]
analysis-paths: ["analysis"]
macro-paths: ["macros"]

target-path: "target"
clean-targets:
    - "target"
    - "dbt_modules"
    - "logs"

require-dbt-version: [">=1.0.0", "<2.0.0"]

models:
  hubspot:
    materialized: table
    staging:
      materialized: view
      +docs:
        node_color: 'silver'
    +docs:
      node_color: 'gold'
```

### Step 4: Run your dbt project
You can run your dbt project with the previously mentioned script that was generated by dlt-dbt-generator <pipeline-name>:
```sh
python run_<pipeline_name>_dbt.py
```
This script executes your dbt transformations, loads the results into a new dataset named <original-dataset>_transformed and
runs the dbt tests. If needed, you can adjust the dataset name directly in the script.

If you want to see dbt run command output, increase the logging level. For example
```sh
RUNTIME__LOG_LEVEL=INFO python run_<pipeline_name>_dbt.py
```
or by setting config.toml:
```toml
[runtime]
log_level="INFO"
```

### Step 5: Running dbt package directly
If you'd like to run your dbt package without a pipeline instance, please refer to our [dbt runner docs.](https://dlthub.com/docs/dlt-ecosystem/transformations/dbt/#how-to-run-dbt-runner-without-pipeline)

## Customization
While the package provides a solid foundation, you may want to customize it to suit your specific needs:

- **Modify Models:** Adjust the SQL in the models to align with your business logic.
- **Add Relationships:** Define custom relationships between tables by modifying the schema in the dlt pipeline.
- **Extend Functionality:** Create new models or macros as needed.

### Support for multiple destinations
This package supports the following data warehouses:

- BigQuery
- Snowflake
- Redshift
- Athena
- PostgreSQL

### Defining primary keys
To generate fact tables, you will first need to add additional relationship hints to your pipeline. This requires ensuring that each 
table has a primary key defined, as relationships are based on these keys:

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

### Create fact tables
To create a fact table, you can use the primary key relationships created above or you could define custom relationships using the relationship adapter as:

```py
import dlt
from dlt_plus.dbt_generator.utils import table_reference_adapter

#configure and run your pipeline
p = dlt.pipeline(pipeline_name="hubspot", destination="bigquery", dataset="hubspot_data")
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
>Please note that the aforementioned relationships are provided for demonstration purposes. You should 
>define these relationships based on your specific use case and the design of your dimensional model, 
>tailoring them to meet the unique requirements of your project.

To create the fact tables:

```sh
dlt-dbt-generator <pipeline-name> --fact deals


dlt-dbt-generator <pipeline-name> --fact tickets
```

The new model you generated looks like:

```text
dbt_<pipeline-name>/
├── analysis/
├── macros/
├── models/
│   ├── marts/
│   │   ├── dim_<pipeline-name>__<other_tables>.sql
|   |   └── fact_<pipeline-name>__deals.sql
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

1. The schema of data modelled above using dlt-dbt-generator:
    
   ![picture1](https://storage.googleapis.com/dlt-blog-images/hubspot_schema_new%20(1).png)

> Please note that this is a starting template for your data model and is not the final product. It is advised to customize the
> data model as per your needs.

Here's the link to the DB diagram: [link](https://dbdiagram.io/d/hubspot_normal-66d161a0eef7e08f0e338a98).
