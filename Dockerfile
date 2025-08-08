FROM rocker/r-ver:4.3.1

# Install system dependencies for R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages
RUN R -e "install.packages(c('plumber', 'randomForest', 'jsonlite'), repos='https://cloud.r-project.org')"

# Set working directory and copy code
COPY . /app
WORKDIR /app

# Expose port used by Plumber
EXPOSE 8000

# Start the API
CMD ["Rscript", "run.R"]
