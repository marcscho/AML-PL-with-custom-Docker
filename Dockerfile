FROM mcr.microsoft.com/azureml/base:intelmpi2018.3-ubuntu16.04

RUN conda install -c r -y conda=4.8.4 r-essentials openssl=1.1.1g ruamel.yaml && \
	conda clean -ay && \
	pip install --no-cache-dir azureml-sdk \
	pip install --no-cache-dir azureml-dataprep[pandas]

ENV TAR="/bin/tar"
RUN R -e "install.packages(c('remotes', 'reticulate', 'optparse', 'dplyr', 'caret', 'gbm', 'tictoc', 'optparse'), repos = 'https://cloud.r-project.org/')" 