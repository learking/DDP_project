library(shiny)

shinyUI(navbarPage("Develop Data Product Course Project",
tabsetPanel(id="allTabs",                 
    tabPanel("Explore",
             
             h4(a("The data set comes from UCI Machine Learning Repository", href="https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)")),
             h4("When a bank receives a loan application, based on the applicant’s profile the bank has to make a decision regarding whether to go ahead with the loan approval or not."),
             h4("There are two types of customers: Good (pay on time and do not charge off) VS Bad (do not pay on time and/or charge off)."),
             h4("Mosaic plot is a way to visualize relationships between different variables. Here we can investigate the relationship between 'Good/Bad label' variable and other categorical variables:"),
             
             selectInput("numVarSelected", 
                         label = "Choose a variable to generate Mosaic plot",
                         choices = c(
                           "InstallmentRatePercentage"              ,"ResidenceDuration"                      ,"NumberExistingCredits"                 
                           ,"NumberPeopleMaintenance"                ,"Telephone"                              ,"ForeignWorker"                         
                           ,"CheckingAccountStatus.lt.0"             ,"CheckingAccountStatus.0.to.200"         ,"CheckingAccountStatus.gt.200"          
                           ,"CheckingAccountStatus.none"             ,"CreditHistory.NoCredit.AllPaid"         ,"CreditHistory.ThisBank.AllPaid"        
                           ,"CreditHistory.PaidDuly"                 ,"CreditHistory.Delay"                    ,"CreditHistory.Critical"                
                           ,"Purpose.NewCar"                         ,"Purpose.UsedCar"                        ,"Purpose.Furniture.Equipment"  
                           ),
                         selected = "InstallmentRatePercentage"),
             plotOutput("histPlot")
    ),

    tabPanel("Solution",                   
             
             h4("Logistic regression is built upon training data. The probabilities are computed for testing data. The modeling part of code is shown below:"),
             
             h4(code("Train50 <- GermanCredit[indexes,] # Training data contains created indices")),
             h4(code("Test50 <- GermanCredit[-indexes,] # Test data contains the rest")),             
             h4(code("cvFit = cv.glmnet(data.matrix(Train50[!excludeVar]), Train50$Class, alpha=1, standardize=FALSE, family='binomial',nfolds =5)")), 
             h4(code("Y_prob = predict(cvFit, newx = data.matrix(Test50[!excludeVar]), type = 'response',s=cvFit$lambda.min)")),

             h4("If you accept all applicants, the acceptance rate is 100%. If you reject all applicants, the acceptance rate is 0%. Anywhere in between, you can play with the widget below:"),
             
             sidebarLayout(
               sidebarPanel( 
                 radioButtons("checkGroup", label = h3("Please choose acceptance percentage to compare confusion matrix"), 
                                c(
                                  "10 %" = "0.1", 
                                  "20 %" = "0.2", 
                                  "30 %" = "0.3",
                                  
                                  "40 %" = "0.4", 
                                  "50 %" = "0.5", 
                                  "60 %" = "0.6",
                                  
                                  "70 %" = "0.7", 
                                  "80 %" = "0.8", 
                                  "90 %" = "0.9"
                                  ), selected="0.9")
             ),
             
             mainPanel(
               tabPanel("Plot", plotOutput("cmPlot"))             
               )
             
             )
    )
)
))