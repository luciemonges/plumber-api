FROM rocker/plumber

# Copy all project files into the /app directory inside the container
COPY . /app
WORKDIR /app

# Optionally install extra R packages here
# RUN R -e "install.packages(c('randomForest', 'jsonlite','plumber'))"

# Expose the port the API will run on
EXPOSE 8000

# Start the API
CMD ["Rscript", "run.R"]
