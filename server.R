#source("helper.R")

library(shiny)
#library(glmnet)
#library(caret)
#data(GermanCredit)

load("german.rda")
load("cmList.rda")

# numVarVec = colnames(GermanCredit)[sapply(GermanCredit, is.numeric)]
# numVarVec = numVarVec[sapply(numVarVec, function(x) ifelse(length(unique(GermanCredit[,x])) < 10,TRUE,FALSE))]
# 
# indexes = sample(1:nrow(GermanCredit), size=0.5*nrow(GermanCredit)) # Random sample of 50% of row numbers created
# Train50 <- GermanCredit[indexes,] # Training data contains created indices
# Test50 <- GermanCredit[-indexes,] # Test data contains the rest
# 
# excludeVar <- names(GermanCredit) %in% c("Class")  
# cvFit = cv.glmnet(data.matrix(Train50[!excludeVar]), Train50$Class, alpha=1, standardize=FALSE, family='binomial',nfolds =5)
# Y_prob = predict(cvFit, newx = data.matrix(Test50[!excludeVar]), type = "response",s=cvFit$lambda.min)
# 
# percentVec = seq(0.1,0.9,0.1)
# 
# getCM <- function(probVec, percentCutoff, trueL){
#   cutOffV = quantile(probVec, percentCutoff)
#   predL = ifelse(probVec > cutOffV, "Bad", "Good")
#   return(confusionMatrix(predL, trueL)$table)
# }
# 
# cmList = lapply(percentVec, function(x) getCM(Y_prob, x, Test50$Class))
# names(cmList) = percentVec



shinyServer(function(input, output, session) {

  output$histPlot = renderPlot({
    mosaicplot(table(GermanCredit[,input$numVarSelected], GermanCredit$Class), main = "Mosaic plot: categorical variable VS good/bad class label", xlab = input$numVarSelected, ylab = "Class")
  })
  
  output$mytable = renderDataTable({
    GermanCredit
  }, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  
  output$cmPlot = renderPlot({
      fourfoldplot(cmList[[input$checkGroup]], color = c("#CC6666", "#99CC99"),
                   conf.level = 0, margin = 1, main = "Confusion Matrix")  
  })
  
})