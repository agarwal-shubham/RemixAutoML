% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AutoCatBoostClassifier.R
\name{AutoCatBoostClassifier}
\alias{AutoCatBoostClassifier}
\title{AutoCatBoostClassifier is an automated catboost model grid-tuning classifier and evaluation system}
\usage{
AutoCatBoostClassifier(data, ValidationData = NULL, TestData = NULL,
  TargetColumnName = NULL, FeatureColNames = NULL,
  PrimaryDateColumn = NULL, ClassWeights = NULL, IDcols = NULL,
  task_type = "GPU", eval_metric = "AUC", Trees = 50,
  GridTune = FALSE, grid_eval_metric = "f", MaxModelsInGrid = 10,
  model_path = NULL, metadata_path = NULL, ModelID = "FirstModel",
  NumOfParDepPlots = 3, ReturnModelObjects = TRUE,
  SaveModelObjects = FALSE, PassInGrid = NULL)
}
\arguments{
\item{data}{This is your data set for training and testing your model}

\item{ValidationData}{This is your holdout data set used in modeling either refine your hyperparameters. Catboost using both training and validation data in the training process so you should evaluate out of sample performance with this data set.}

\item{TestData}{This is your holdout data set. Catboost using both training and validation data in the training process so you should evaluate out of sample performance with this data set.}

\item{TargetColumnName}{Either supply the target column name OR the column number where the target is located, but not mixed types. Note that the target column needs to be a 0 | 1 numeric variable.}

\item{FeatureColNames}{Either supply the feature column names OR the column number where the target is located, but not mixed types. Also, not zero-indexed.}

\item{PrimaryDateColumn}{Supply a date or datetime column for catboost to utilize time as its basis for handling categorical features, instead of random shuffling}

\item{ClassWeights}{Supply a vector of weights for your target classes. E.g. c(0.25, 1) to weight your 0 class by 0.25 and your 1 class by 1.}

\item{IDcols}{A vector of column names or column numbers to keep in your data but not include in the modeling.}

\item{task_type}{Set to "GPU" to utilize your GPU for training. Default is "CPU".}

\item{eval_metric}{This is the metric used inside catboost to measure performance on validation data during a grid-tune. "AUC" is the default, but other options include "Logloss", "CrossEntropy", "Precision", "Recall", "F1", "BalancedAccuracy", "BalancedErrorRate", "MCC", "Accuracy", "CtrFactor", "AUC", "BrierScore", "HingeLoss", "HammingLoss", "ZeroOneLoss", "Kappa", "WKappa", "LogLikelihoodOfPrediction"}

\item{Trees}{The maximum number of trees you want in your models}

\item{GridTune}{Set to TRUE to run a grid tuning procedure. Set a number in MaxModelsInGrid to tell the procedure how many models you want to test.}

\item{grid_eval_metric}{This is the metric used to find the threshold "f", "auc", "tpr", "fnr", "fpr", "tnr", "prbe", "f", "odds"}

\item{MaxModelsInGrid}{Number of models to test from grid options.}

\item{model_path}{A character string of your path file to where you want your output saved}

\item{metadata_path}{A character string of your path file to where you want your model evaluation output saved. If left NULL, all output will be saved to model_path.}

\item{ModelID}{A character string to name your model and output}

\item{NumOfParDepPlots}{Tell the function the number of partial dependence calibration plots you want to create. Calibration boxplots will only be created for numerical features (not dummy variables)}

\item{ReturnModelObjects}{Set to TRUE to output all modeling objects. E.g. plots and evaluation metrics}

\item{SaveModelObjects}{Set to TRUE to return all modeling objects to your environment}

\item{PassInGrid}{Defaults to NULL. Pass in a single row of grid from a previous output as a data.table (they are collected as data.tables)}
}
\value{
Saves to file and returned in list: VariableImportance.csv, Model (the model), ValidationData.csv, ROC_Plot.png, EvalutionPlot.png, EvaluationMetrics.csv, ParDepPlots.R a named list of features with partial dependence calibration plots, GridCollect, and GridList
}
\description{
AutoCatBoostClassifier is an automated modeling function that runs a variety of steps. First, a stratified sampling (by the target variable) is done to create train, validation, and test sets (if not supplied). Then, the function will run a random grid tune over N number of models and find which model is the best (a default model is always included in that set). Once the model is identified and built, several other outputs are generated: validation data with predictions (on test data), an ROC plot, evaluation plot, evaluation metrics, variable importance, partial dependence calibration plots, partial dependence calibration box plots, and column names used in model fitting. You can download the catboost package using devtools, via: devtools::install_github('catboost/catboost', subdir = 'catboost/R-package')
}
\examples{
\donttest{
Correl <- 0.85
N <- 1000
data <- data.table::data.table(Target = runif(N))
data[, x1 := qnorm(Target)]
data[, x2 := runif(N)]
data[, Independent_Variable1 := log(pnorm(Correl * x1 +
                                            sqrt(1-Correl^2) * qnorm(x2)))]
data[, Independent_Variable2 := (pnorm(Correl * x1 +
                                         sqrt(1-Correl^2) * qnorm(x2)))]
data[, Independent_Variable3 := exp(pnorm(Correl * x1 +
                                            sqrt(1-Correl^2) * qnorm(x2)))]
data[, Independent_Variable4 := exp(exp(pnorm(Correl * x1 +
                                                sqrt(1-Correl^2) * qnorm(x2))))]
data[, Independent_Variable5 := sqrt(pnorm(Correl * x1 +
                                             sqrt(1-Correl^2) * qnorm(x2)))]
data[, Independent_Variable6 := (pnorm(Correl * x1 +
                                         sqrt(1-Correl^2) * qnorm(x2)))^0.10]
data[, Independent_Variable7 := (pnorm(Correl * x1 +
                                         sqrt(1-Correl^2) * qnorm(x2)))^0.25]
data[, Independent_Variable8 := (pnorm(Correl * x1 +
                                         sqrt(1-Correl^2) * qnorm(x2)))^0.75]
data[, Independent_Variable9 := (pnorm(Correl * x1 +
                                         sqrt(1-Correl^2) * qnorm(x2)))^2]
data[, Independent_Variable10 := (pnorm(Correl * x1 +
                                          sqrt(1-Correl^2) * qnorm(x2)))^4]
data[, Independent_Variable11 := as.factor(
  ifelse(Independent_Variable2 < 0.20, "A",
         ifelse(Independent_Variable2 < 0.40, "B",
                ifelse(Independent_Variable2 < 0.6,  "C",
                       ifelse(Independent_Variable2 < 0.8,  "D", "E")))))]
data[, ':=' (x1 = NULL, x2 = NULL)]
data[, Target := ifelse(Target < 0.5, 1, 0)]
TestModel <- AutoCatBoostClassifier(data,
                                    ValidationData = NULL,
                                    TestData = NULL,
                                    TargetColumnName = "Target",
                                    FeatureColNames = c(2:12),
                                    PrimaryDateColumn = NULL,
                                    ClassWeights = NULL,
                                    IDcols = NULL,
                                    MaxModelsInGrid = 3,
                                    task_type = "GPU",
                                    eval_metric = "AUC",
                                    grid_eval_metric = "auc",
                                    Trees = 50,
                                    GridTune = FALSE,
                                    model_path = NULL,
                                    metadata_path = NULL,
                                    ModelID = "ModelTest",
                                    NumOfParDepPlots = 15,
                                    ReturnModelObjects = TRUE,
                                    SaveModelObjects = FALSE,
                                    PassInGrid = NULL)
}
}
\seealso{
Other Automated Binary Classification: \code{\link{AutoH2oDRFClassifier}},
  \code{\link{AutoH2oGBMClassifier}},
  \code{\link{AutoXGBoostClassifier}}
}
\author{
Adrian Antico
}
\concept{Automated Binary Classification}
