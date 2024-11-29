import dlt

if __name__ == "__main__":
    """
    Execute this file to run your transformations, you can also just copy this code
    into your main dlt runner file and execute the transformation right after your
    pipeline.run(...) command
    """
    p = dlt.pipeline(pipeline_name="hubspot", destination="bigquery")
    venv = dlt.dbt.get_venv(p)
    dbt = dlt.dbt.package(p, "dbt_hubspot", venv=venv)

    # run transformations
    models = dbt.run_all(
        # add any additional vars you need in dbt here
        additional_vars={},
        # change this to save your transformation results into another dataset
        destination_dataset_name=p.dataset_name + "_transformed",
    )

    # run tests
    dbt.test(destination_dataset_name=p.dataset_name + "_transformed")