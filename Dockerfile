FROM rocker/r-base:4.3.1

# Install system libraries required for common R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libpq-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libmariadb-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Plumber and other required R packages
RUN R -e "install.packages(c('plumber', 'randomForest', 'jsonlite'), repos = 'https://cloud.r-project.org')"

# Debug: print installed packages during image build
RUN R -e "print(installed.packages()[, c('Package', 'Version')])"

# Copy your API files into the container
COPY . /app
WORKDIR /app

# Expose the port that Plumber will run on
EXPOSE 8000

# Start the API when the container launches
CMD [ "Rscript", "run.R" ]
