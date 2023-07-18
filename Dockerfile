FROM python:3.9

# Install necessary dependencies
RUN apt-get update \
    && apt-get install -y apt-transport-https curl pip \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl \
    && pip install flask \
    && pip install kubernetes 

# Make scripts directory
RUN mkdir /scripts

# Set the working directory
WORKDIR /scripts

#Additional modules can be added in a initPythonModules
RUN if [ -f initPythonModules ]; then \
        for pyModule in $(cat ./initPythonModules); do \
	    echo "Installing python module $pyModule"\
            pip install "$pyModule"; \
        done \
    fi

#keepS the container running for troubleshooting
CMD ["tail", "-f", "/dev/null"] 
