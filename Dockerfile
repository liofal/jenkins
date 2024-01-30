# Specify base image
FROM jenkins/jenkins:latest

# Switch to root to install additional tools
USER root

# Update packages and install dependencies
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    apt-transport-https \
    lsb-release

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker-ce-cli

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Add Helm repository key
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor -o /usr/share/keyrings/helm-archive-keyring.gpg

# Add Helm repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm-archive-keyring.gpg] https://baltocdn.com/helm/stable/debian all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

# Install Helm
RUN apt-get update && \
    apt-get install helm
