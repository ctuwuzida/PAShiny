library(RMySQL)
library(dplyr)
library(data.table)
library(WindR)
library(ggplot2)
library(ggthemes)
w.start(showmenu=FALSE)

#连接数据库
con = dbConnect(MySQL(),user="wuzida", password="zhisheng@1828", 
                dbname="zhisheng1828_zswb", host="192.168.7.46",port=3306)

#取数据
BenchIndex = as.data.table(dbGetQuery(con,"SELECT * FROM zhisheng1828_zswb.HS300;"))
BenchIndex$enddate = as.Date(BenchIndex$enddate)
SecCode = as.data.table(dbGetQuery(con,"SELECT sid, tradecode FROM zhisheng1828_zswb.btwb_sec_seccode;"))
Sector = fread("Data//Sector.csv")
Sector$V1 = NULL
Sector$Data.wind_code = substr(Sector$Data.wind_code,1,6)
Sector = dplyr::rename(Sector, tradecode = Data.wind_code)

##向SecCode添加sector
setkey(SecCode, tradecode)
setkey(Sector, tradecode)
SecCode = merge(SecCode, Sector,all.x=T)
SecCode = dplyr::select(SecCode, sid, sector)
SecCode$sector[which(is.na(SecCode$sector))] ="WIND现金"

####取交易日期
w_wsd_data<-w.wsd("000300.SH","close","2013-01-01","2015-05-04","Fill=Previous")
w_wsd_data = as.data.frame(w_wsd_data)
w_wsd_data = as.data.table(w_wsd_data)
TransDate = w_wsd_data$Data.DATETIME

#合并BenchIndex和Sector
Sector = dplyr::rename(Sector, symbol = tradecode)
setkey(Sector, symbol)
setkey(BenchIndex, symbol)
BenchIndex = merge(BenchIndex, Sector)
BenchIndex = dplyr::rename(BenchIndex, date=enddate)