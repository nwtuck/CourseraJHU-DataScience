#Quiz 4

##Question 1
The American Community Survey distributes downloadable data about United States communities. 
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. 
The code book, describing the variable names is here:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
What is the value of the 123 element of the resulting list?

```
url <- https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
f <- file.path(getwd(), "ss06hid.csv")
download.file(url, f)
data <- data.table(read.csv(f))
data.names <- names(data)
data.splitnames <- strsplit(data.names, "wgtp")
data.splitnames[[123]]
```
```
## [1] ""   "15"
```

##Question 2
Load the Gross Domestic Product data for the 190 ranked countries in this data set:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

```
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
GDP.data <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
GDP.data <- GDP.data[X != ""]
GDP.data <- GDP.data[, list(X, X.1, X.3, X.4)]
setnames(GDP.data, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", GDP.data$gdp))
```
```
## Warning: NAs introduced by coercion
```
```
mean(gdp, na.rm = TRUE)
```
```
## [1] 377652.4
```


#Question 3
In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? 
Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

```
isUnited <- grepl("^United", GDP.data$Long.Name)
sum(isUnited)
```
```
## [1] 3
```


#Question 4
Load the Gross Domestic Product data for the 190 ranked countries in this data set:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table http://data.worldbank.org/data-catalog/ed-stats

```
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
Ed.data <- data.table(read.csv(f))

data <- merge(GDP.data, Ed.data, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(data$Special.Notes))
isJune <- grepl("june", tolower(data$Special.Notes))
table(isFiscalYearEnd, isJune)
```
```
##                isJune
## isFiscalYearEnd FALSE TRUE
##           FALSE   203    3
##           TRUE     19   13
```

##Question 5
You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. 
Use the following code to download data on Amazons stock price and get the times the data was sampled.
```
library(quantmod) 
amzn = getSymbols("AMZN",auto.assign=FALSE) 
sampleTimes = index(amzn)
```
How many values were collected in 2012? How many values were collected on Mondays in 2012?

```
library(quantmod) 
amzn = getSymbols("AMZN",auto.assign=FALSE) 
sampleTimes = index(amzn)

addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
```
```
##        Friday Monday Thursday Tuesday Wednesday  Sum
##   2007     51     48       51      50        51  251
##   2008     50     48       50      52        53  253
##   2009     49     48       51      52        52  252
##   2010     50     47       51      52        52  252
##   2011     51     46       51      52        52  252
##   2012     51     47       51      50        51  250
##   2013     51     48       50      52        51  252
##   2014     15     14       16      16        16   77
##   Sum     368    346      371     376       378 1839
```

