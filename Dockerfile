FROM python:3.9

#make scripts directory
RUN mkdir /scripts

# Install necessary dependencies
RUN apt-get update \
    && apt-get install -y apt-transport-https curl pip \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl \
    && /scripts/initPythonModules.sh

# Set the working directory
WORKDIR /scripts
