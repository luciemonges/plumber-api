library(plumber)
library(randomForest)

# Load the saved model
model <- readRDS("model.rds")

#* @post /predict
#* @serializer json
function(req, res) {
  input <- jsonlite::fromJSON(req$postBody)
  
  # Debug logging — shows in Render logs
  print("---- Incoming data ----")
  print(input)

  # Mappings
  likert_map <- c("Strongly disagree" = 1, "Somewhat disagree" = 2, "Somewhat agree" = 3,
                  "Strongly agree" = 4)
  yesno_map <- c("No" = 1, "Yes" = 2)

  # Convert inputs
  q1 <- as.numeric(likert_map[input$Q1])
  q2 <- as.numeric(yesno_map[input$Q2])
  q3 <- as.numeric(input$Q3)

  # Create dataframe
  newdata <- data.frame(
    Q1 = q1,
    Q2 = q2,
    Q3 = q3
  )

  #pred <- predict(model, newdata)
  pred = apply(newdata,1,sum)

  list(segment = as.character(pred))
}
