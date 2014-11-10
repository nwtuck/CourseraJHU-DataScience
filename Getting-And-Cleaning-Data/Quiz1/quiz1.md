#Quiz1 

##Question 1
 
The American Community Survey distributes downloadable data about United States communities. 
Download the 2006 microdata survey about housing for the state of Idaho using download.file() 
from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
and load the data into R. 
The code book, describing the variable names is here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
How many housing units in this survey were worth more than $1,000,000?

```
library(data.table)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "ss06hid.csv")
download.file(url, f)
data <- data.table(read.csv(f))

nrow(subset(data, data$VAL == 24)) #VAL = 24, property value = $1000,000+
```
```
## [1] 53
```
```
data[, .N, "VAL"] #summarize data by length of each VAL
```
```
## VAL    N
## 1:  17  357
## 2:  NA 2076
## 3:  18  502
## 4:  19  232
## 5:  20  312
## 6:  15  483
## 7:  13  233
## 8:   1   75
## 9:  12  199
## 10:  11  152
## 11:   8   70
## 12:  16  486
## 13:  22  159
## 14:  14  495
## 15:  10  119
## 16:   6   29
## 17:  21  164
## 18:   9   99
## 19:   3   33
## 20:  24   53
## 21:   4   30
## 22:  23   47
## 23:   2   42
## 24:   5   26
## 25:   7   23
## VAL    N
```

##Question 3

Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
Read rows 18-23 and columns 7-15 into R and assign the result to a variable called dat 
What is the value of:
sum(dat$Zip*dat$Ext,na.rm=T) 
(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)
```
library(xlsx)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
f <- file.path(getwd(), "DATA.gov_NGAP.xlsx")
download.file(url, f)

# Reading specific rows and columns
colIndex <- 7:15
rowIndex <- 18:23
data <- read.xlsx(f, sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)

sum(data$Zip*dat$Ext,na.rm=T) 
```
```
## [1] 36534720
```

##Question 4

Read the XML data on Baltimore restaurants from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
How many restaurants have zipcode 21231?
```
library(xml)

url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data <- xmlInternalTreeParse(url)
rootNode <- xmlRoot(data)

names(rootNode[[1]][[1]])

zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zipcode == 21231)
```
```
## [1] 127
```
```
table(zipcode == 21231)
```
```
## FALSE  TRUE 
## 1200   127 
```

##Question 5

The American Community Survey distributes downloadable data about United States communities. 
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
using the fread() command load the data into an R object DT 
Which of the following is the fastest way to calculate the average value of the variable pwgtp15 broken down by sex using the data.table package?
1. mean(DT$pwgtp15,by=DT$SEX)
2. sapply(split(DT$pwgtp15,DT$SEX),mean)
3. DT[,mean(pwgtp15),by=SEX]
4. mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
5. rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
6. tapply(DT$pwgtp15,DT$SEX,mean)
```
library(data.table)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
DT <- fread(f)
```
```
#1.
mean(DT$pwgtp15,by=DT$SEX)
system.time(mean(DT$pwgtp15,by=DT$SEX))
```
```
## [1] 98.21613
##    user  system elapsed 
##       0       0       0 
```
```
##2.
sapply(split(DT$pwgtp15,DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
```
```
##        1        2 
## 99.80667 96.66534 
## user  system elapsed 
##    0       0       0 
```
```
##3. :: correct methods with all values required produced
DT[,mean(pwgtp15),by=SEX]
system.time(DT[,mean(pwgtp15),by=SEX])
```
```
##    SEX       V1
## 1:   1 99.80667
## 2:   2 96.66534
## user  system elapsed 
##    0       0       0 
```
```
##4.
mean(DT[DT$SEX==1,]$pwgtp15)
mean(DT[DT$SEX==2,]$pwgtp15)
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
```
```
## [1] 99.80667
## [1] 96.66534
## user  system elapsed 
## 0.04    0.00    0.04 
```
```
##5.
rowMeans(DT)[DT$SEX==1]
rowMeans(DT)[DT$SEX==2]
system.time(rowMeans(DT)[DT$SEX==1] + system.time(rowMeans(DT)[DT$SEX==2]))
```
```
## Error in rowMeans(DT) : 'x' must be numeric
## Error in rowMeans(DT) : 'x' must be numeric
## Error in rowMeans(DT) : 'x' must be numeric
## Timing stopped at: 0.97 0 0.97 
```
```
##6. 
tapply(DT$pwgtp15,DT$SEX,mean)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
```
```
## 1        2 
## 99.80667 96.66534 
## user  system elapsed 
## 0.02    0.00    0.02 
```
