% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AutoCatBoostCARMA.R
\name{AutoCatBoostCARMA}
\alias{AutoCatBoostCARMA}
\title{AutoCatBoostCARMA Automated CatBoost Calendar, Holiday, ARMA, and Trend Variables Forecasting}
\usage{
AutoCatBoostCARMA(data, TargetColumnName = "Target",
  DateColumnName = "DateTime", GroupVariables = NULL,
  FC_Periods = 30, TimeUnit = "week", TargetTransformation = FALSE,
  Lags = c(1:5), MA_Periods = c(1:5), CalendarVariables = FALSE,
  HolidayVariable = TRUE, TimeTrendVariable = FALSE,
  ZeroPadSeries = NULL, DataTruncate = FALSE, SplitRatios = c(0.7,
  0.2, 0.1), TaskType = "GPU", EvalMetric = "RMSE", GridTune = FALSE,
  GridEvalMetric = "mae", ModelCount = 1, NTrees = 1000,
  PartitionType = "timeseries", Timer = TRUE)
}
\arguments{
\item{data}{Supply your full series data set here}

\item{TargetColumnName}{List the column name of your target variables column. E.g. "Target"}

\item{DateColumnName}{List the column name of your date column. E.g. "DateTime"}

\item{GroupVariables}{Defaults to NULL. Use NULL when you have a single series. Add in GroupVariables when you have a series for every level of a group or multiple groups.}

\item{FC_Periods}{Set the number of periods you want to have forecasts for. E.g. 52 for weekly data to forecast a year ahead}

\item{TimeUnit}{List the time unit your data is aggregated by. E.g. "1min", "5min", "10min", "15min", "30min", "hour", "day", "week", "month", "quarter", "year"}

\item{TargetTransformation}{Run AutoTransformationCreate() to find best transformation for the target variable. Tests YeoJohnson, BoxCox, and Asigh (also Asin and Logit for proportion target variables).}

\item{Lags}{Select the periods for all lag variables you want to create. E.g. c(1:5,52)}

\item{MA_Periods}{Select the periods for all moving average variables you want to create. E.g. c(1:5,52)}

\item{CalendarVariables}{Set to TRUE to have calendar variables created. The calendar variables are numeric representations of second, minute, hour, week day, month day, year day, week, isoweek, quarter, and year}

\item{HolidayVariable}{Set to TRUE to have a holiday counter variable created.}

\item{TimeTrendVariable}{Set to TRUE to have a time trend variable added to the model. Time trend is numeric variable indicating the numeric value of each record in the time series (by group). Time trend starts at 1 for the earliest point in time and increments by one for each success time point.}

\item{ZeroPadSeries}{Set to "all", "inner", or NULL. See TimeSeriesFill for explanation}

\item{DataTruncate}{Set to TRUE to remove records with missing values from the lags and moving average features created}

\item{SplitRatios}{E.g c(0.7,0.2,0.1) for train, validation, and test sets}

\item{TaskType}{Default is "GPU" but you can also set it to "CPU"}

\item{EvalMetric}{Select from "RMSE", "MAE", "MAPE", "Poisson", "Quantile", "LogLinQuantile", "Lq", "NumErrors", "SMAPE", "R2", "MSLE", "MedianAbsoluteError"}

\item{GridTune}{Set to TRUE to run a grid tune}

\item{GridEvalMetric}{This is the metric used to find the threshold 'poisson', 'mae', 'mape', 'mse', 'msle', 'kl', 'cs', 'r2'}

\item{ModelCount}{Set the number of models to try in the grid tune}

\item{NTrees}{Select the number of trees you want to have built to train the model}

\item{PartitionType}{Select "random" for random data partitioning "time" for partitioning by time frames}

\item{Timer}{Set to FALSE to turn off the updating print statements for progress}
}
\value{
Returns a data.table of original series and forecasts, the catboost model objects (everything returned from AutoCatBoostRegression()), a time series forecast plot, and transformation info if you set TargetTransformation to TRUE. The time series forecast plot will plot your single series or aggregate your data to a single series and create a plot from that.
}
\description{
AutoCatBoostCARMA Automated CatBoost Calendar, Holiday, ARMA, and Trend Variables Forecasting. Create hundreds of thousands of time series forecasts using this function.
}
\examples{
\donttest{
Results <- AutoCatBoostCARMA(data,
                             TargetColumnName = "Target",
                             DateColumnName = "Date",
                             GroupVariables = c("Store","Dept"),
                             FC_Periods = 52,
                             TimeUnit = "week",
                             TargetTransformation = FALSE,
                             Lags = c(1:5,52),
                             MA_Periods = c(1:5,52),
                             CalendarVariables = TRUE,
                             HolidayVariable = TRUE, 
                             TimeTrendVariable = TRUE,
                             DataTruncate = FALSE,
                             ZeroPadSeries = "all",
                             SplitRatios = c(1-2*30/143,30/143,30/143),
                             TaskType = "GPU",
                             EvalMetric = "MAE",
                             GridTune = FALSE,
                             GridEvalMetric = "mae",
                             ModelCount = 1,
                             NTrees = 1000,
                             PartitionType = "timeseries",
                             Timer = TRUE)
Results$TimeSeriesPlot
Results$Forecast
Results$ModelInformation$...
}
}
\seealso{
Other Automated Time Series: \code{\link{AutoCatBoostFreqSizeScoring}},
  \code{\link{AutoCatBoostSizeFreqDist}},
  \code{\link{AutoH2oDRFCARMA}},
  \code{\link{AutoH2oGBMCARMA}},
  \code{\link{AutoH2oGBMFreqSizeScoring}},
  \code{\link{AutoH2oGBMSizeFreqDist}},
  \code{\link{AutoTS}}, \code{\link{AutoXGBoostCARMA}},
  \code{\link{ID_Forecast}},
  \code{\link{ID_SingleLevelGibbsSampler}},
  \code{\link{IntermittentDemandScoringDataGenerator}}
}
\author{
Adrian Antico
}
\concept{Automated Time Series}
