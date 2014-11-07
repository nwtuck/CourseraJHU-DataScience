#Quiz 2

## Question 1

Register an application with the Github API here https://github.com/settings/applications. 
Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
Use this data to find the time that the datasharing repo was created. 
What time was it created? 
This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
You may also need to run the code in the base R package and not R studio.

```
library(httr)
require(httpuv)
require(jsonlite)

# 1. Find OAuth settings for github: http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
# Insert your values below - if secret is omitted, it will look it up in the
# GITHUB_CONSUMER_SECRET environmental variable.  Use http://localhost:1410
# as the callback url
myapp <- oauth_app("quiz2", "ddb0d599de51ccd02f4b", secret = "6af1109f6ecf442d292425087d49bb13d9bbe9c8")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)
list(output[[4]]$name, output[[4]]$created_at)
```
```
[[1]]
[1] "datascientist"

[[2]]
[1] "2012-06-24T14:36:20Z"
```

##Question 2
The sqldf package allows for execution of SQL commands on R data frames. 
We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. 
Download the American Community Survey data and load it into an R object called
```
acs
```
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
1. sqldf("select * from acs where AGEP < 50")
2. sqldf("select pwgtp1 from acs where AGEP < 50")
3. sqldf("select * from acs")
4. sqldf("select * from acs where AGEP < 50 and pwgtp1")
```
library(data.table)
library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
acs <- data.table(read.csv(f))
query1 <- sqldf("select * from acs where AGEP < 50") ## selects all columns with age less than 50 
```
```
## Loading required package: tcltk
```
query2 <- sqldf("select pwgtp1 from acs where AGEP < 50")  ## correct syntax
query3 <- sqldf("select * from acs")  ## selects everything
query4 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")  ## selects everything with age less than 50, "and pwgtp1" does not do anything
```

##Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

1. sqldf("select distinct pwgtp1 from acs")
2. sqldf("select distinct AGEP from acs")
3. sqldf("select AGEP where unique from acs")
4. sqldf("select unique AGEP from acs")

```
x <- unique(acs$AGEP)

x1 <- sqldf("select distinct pwgtp1 from acs")
x2 <- sqldf("select distinct AGEP from acs")
x3 <- sqldf("select AGEP where unique from acs")
```
## Error in sqliteSendQuery(con, statement, bind.data) : 
##   error in statement: near "unique": syntax error
```
```
x4 <- sqldf("select unique AGEP from acs")
```
```
## Error in sqliteSendQuery(con, statement, bind.data) : 
##   error in statement: near "unique": syntax error
```
```
x <- data.frame(x)
summary(x)
```
```
## Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 0.00   22.50   45.00   45.03   67.50   93.00 
```
```
summary(x1)
```
```
## pwgtp1     
## Min.   :  1.0  
## 1st Qu.:139.0  
## Median :277.0  
## Mean   :297.5  
## 3rd Qu.:424.0  
## Max.   :930.0 
```
```
summary(x2)
```
```
## AGEP      
## Min.   : 0.00  
## 1st Qu.:22.50  
## Median :45.00  
## Mean   :45.03  
## 3rd Qu.:67.50  
## Max.   :93.00  
```
```
identical(dim(x), dim(x2))
```
```
## [1] TRUE
```

##Question 4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
  
  http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)

```
connection = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(connection)
close(connection)
nchar(htmlCode[c(10,20,30,100)])
```
```
## [1] 45 31  7 25
```

##Question 5
Read this data set into R and report the sum of the numbers in the fourth column.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)

```
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
width <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3) # width of each column
data <- read.fwf(url, width, header = FALSE, skip = 4)

sum(data$V8) # column 4 = V8 (col1=V2, col2=V4 etc)
```
```
## [1] 32426.7
```
