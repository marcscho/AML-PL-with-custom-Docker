# Azure ML pipelines with custom Docker images

In this repository we walk through all steps required to run ML pipelines in Azure Machine Learning using a custom Docker image. This is of particular importance if you intend to run a pipeline including a script (python or R) which relies on libraries/packages of its respective eco-system at runtime as downloading and installing these dependencies add significant overhead to the your pipeline's execution time. 

## About ML pipelines in Azure

[Azure ML pipelines](https://docs.microsoft.com/en-us/azure/machine-learning/concept-ml-pipelines) essentially allow data scientists to build, run and maintain ML workflows. In most cases, these pipelines are used to train a machine learning model from some training data. Whilst technically, ML pipelines could also be used to use data as input, apply some transformation and then output yet another dataset, other technologies such as [Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/concepts-pipelines-activities) are more suitable for these kinds of pipelines.

## The anatomy of ML pipelines

In the following we will briefly introduce the most important ingredients of ML pipelines.

### Steps

Every ML pipeline consists of at least one step which is being executed. If a pipeline consists of more than one steps, these steps can be executed sequentially or in parallel. Steps define **what** happens as part of the pipeline.

Steps themselves can be of [different kinds](https://docs.microsoft.com/en-us/python/api/azureml-pipeline-steps/azureml.pipeline.steps?view=azure-ml-py). In the most basic case, on which we are focusing for the sake of this scenario, our step will execute a python script. Hence, it will use the [PythonScriptStep](https://docs.microsoft.com/en-us/python/api/azureml-pipeline-steps/azureml.pipeline.steps.python_script_step.pythonscriptstep?view=azure-ml-py) class of the [Azure ML python SDK](https://docs.microsoft.com/en-us/python/api/overview/azure/ml/?view=azure-ml-py). Please note that whilst it is possible for an ML pipeline to run an R script as one of its step, the actual pipeline itself currently cannot be written in R. 

### Triggers

There are various events that can potentially trigger an ML pipeline, depending on your project's use case and requirements. Common scenarios include [scheduling ML pipelines](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-schedule-pipelines) to run at fixed time intervalls. When an ML pipeline is [published](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-deploy-pipelines) it is exposed as a REST endpoint and can be interacted with from other systems, [Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/transform-data-machine-learning-service). 

### Execution environment

[Compute targets](https://docs.microsoft.com/en-us/azure/machine-learning/concept-compute-target#train) in Azure ML define **where** the ML pipeline is being executed. In most cases we ultimately want to be able to run the pipeline in an unattended and repeatable manner. While Azure ML's [Compute Instances](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-create-attach-compute-sdk#instance) are a great place to do your experimental data science work, [Azure ML compute clusters](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-create-attach-compute-sdk#amlcompute) should be considered your go-to compute target for ML pipelines as they can be spun up by the ML pipeline and shut down after its execution. 

Another common pattern when wrangling with big data volumes is to use [Azure Databricks](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-create-attach-compute-sdk#databricks) as the compute targets for an intial data preparation and aggregation step, leveraging Spark's powerful distributed architecture in the process. The resulting training dataset often times is orders of magnitude smaller than the raw data, prompting data scientist's to rely on python's [sklearn library](https://scikit-learn.org/stable/)  (or others) for machine learning tasks. Here's where the flexibility of ML pipelines come in handy, allowing the data preparation step to run on a different compute target (Azure Databricks) than the step to train a model (Azure ML compute cluster). 
