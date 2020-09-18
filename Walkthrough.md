# Contents

- [Building Docker image](https://github.com/marcscho/AML-PL-with-custom-Docker/blob/master/Walkthrough.md#building-docker-image)
- [Pushing Docker image to Azure Container Registry](https://github.com/marcscho/AML-PL-with-custom-Docker/blob/master/Walkthrough.md#pushing-docker-image-to-azure-container-registry)
- [Creating Azure ML pipeline](https://github.com/marcscho/AML-PL-with-custom-Docker/blob/master/Walkthrough.md#creating-azure-ml-pipeline)
- [Submitting Azure ML pipeline](https://github.com/marcscho/AML-PL-with-custom-Docker/blob/master/Walkthrough.md#submitting-azure-ml-pipeline)


# Building Docker image

The first thing we will need to do is create our own Docker image that includes all the required libraries & packages for python and R that our pipeline needs. For the purpose of this walkthrough, let us assume that we need the following R packages as part of the R script that we want to run in our ML pipeline: <code>remotes, reticulate, optparse, dplyr, caret, gbm </code>. If you want to learn more about these packages, please refer to their respective project pages on CRAN.

## Dockerfile

The basis for every Docker image is the Dockerfile which contains the instructions passed to the Docker engine when building the Docker image. Whilst it would be possible to start with a green field, our aim is to extend one of the Docker base images provided by Azure ML. Hence, we will use these as a starting point and just add the packages mentioned above.

As you can see when inspecting the Dockerfile, we are also adding the full azureml-sdk via pip-install (line 5) alongside the R packages listed above in the last line.

## Building a Docker image

--> WE ARE HERE

# Pushing Docker image to Azure Container Registry

# Creating Azure ML pipeline

# Submitting Azure ML pipeline
