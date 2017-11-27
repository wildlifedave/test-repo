# PRICING------------------------------------------------
OpenRaw <- raw[c(1,2)] # Choose Open Price for that day
HighRaw <- raw[c(1,3)] # Choose High Price for that day
LowRaw <- raw[c(1,4)] # Choose Low Price for that day
CloseRaw <- raw[c(1,5)] # Choose Close Price for that day
# PRICING------------------------------------------------

# CALCULATE ALL PRICE DIFFERENCES------------------------------------------------
BuyPrice <- OpenRaw[, 2]
SellPrice <- OpenRaw[, 2]
BuyPrice <- BuyPrice[['Open']]
SellPrice <- SellPrice[['Open']]
BuyPrice <- rev(BuyPrice)
SellPrice <- rev(SellPrice)
FinalPriceTest <- c()
Tmp <- c()

for(i in 1:1552) {
    Tmp <- SellPrice[i:1552]-BuyPrice[i]
    FinalPriceTest <- c(FinalPriceTest, Tmp)
  }
# CALCULATE ALL PRICE DIFFERENCES------------------------------------------------


# BLANK DATE VECTORS------------------------------------------------
FinalBuy <- c()
TempBuy <-c()
FinalSell <- c()
TempSell <- c()
# BLANK DATE VECTORS------------------------------------------------

# BUILDING FINAL BUY DATE LIST------------------------------------------------
BuyDateList <- OpenRaw[, 1]
BuyDateList <- BuyDateList[['Date']]
BuyDateList <- rev(BuyDateList)

for(i in 1:1552) {
TempBuy <- rep(BuyDateList[i], 1553-i)
FinalBuy <- c(FinalBuy, TempBuy)
}
# BUILDING FINAL BUY DATE LIST------------------------------------------------

# BUILDING FINAL SELL DATE LIST------------------------------------------------
SellDateList <- BuyDateList

    for(i in 1:1552) {
      TempSell <- SellDateList[i:1552]
      FinalSell <- c(FinalSell, TempSell)
    }
# BUILDING FINAL SELL DATE LIST------------------------------------------------

# CALCULATING INTERVAL DAYS------------------------------------------------
 Days <- c()
 TempDays <- c()
 DaysList <- 0:1551
 Days <- DaysList
  
  for(i in 1:1552) {
    TempDays <- head(DaysList,-i)
    Days <- c(Days, TempDays)
  }
# CALCULATING INTERVAL DAYS  ------------------------------------------------
  
# PUTTING COLUMNS TOGETHER WITH LABELS------------------------------------------------
FinalTable <- data.frame()
FinalTable <- cbind(FinalBuy, FinalSell, Days, FinalPriceTest)
colnames(FinalTable) <- c("BuyDate", "SellDate", "Days", "PriceDiff")
# PUTTING COLUMNS TOGETHER WITH LABELS------------------------------------------------

# DATA CLASS & TYPE MANIPULATIONS------------------------------------------------
FinalTable <- as.data.frame(FinalTable)
PriceVector <- FinalTable[[4]]
DaysVector <- FinalTable[[3]]
# DATA CLASS & TYPE MANIPULATIONS------------------------------------------------