GetReturn = function(ManagerID) {
  
  ManagerReturn = as.data.table(dbGetQuery(con,paste("SELECT enddate, returnratio 
  FROM zhisheng1828_zswb.btwb_return where uid=",ManagerID,"and sflag=1 and frequency=9;")))
  
  if (dim(ManagerReturn)[1] == 0) {
    print("请输入正确的选手ID号!")
  } else {
    ManagerReturn$enddate = as.Date(as.POSIXct(as.numeric(ManagerReturn$enddate),
                                               origin="1970-01-01",tz="Hongkong"),tz="Hongkong")
    ggplot(ManagerReturn, aes(x=enddate,y=returnratio))+geom_line()+theme_economist()
  }
 
}

#取得昨天交易次数
GetYstdCount = function() {
  Ystd = Sys.Date()-1
  YstdCount = dbGetQuery(con, paste("SELECT count(*) from zhisheng1828_zswb.btwb_return_bstransaction where
sflag = 1 and odate > unix_timestamp('", Ystd,"') and odate < unix_timestamp('",Sys.Date(),
                                    "') and uid <> 170"))
  YstdCount = YstdCount[1,]
  return(YstdCount)
}

GetYstdCountPeople = function() {
  Ystd = Sys.Date()-1
  YstdCountPeople = dbGetQuery(con, paste("SELECT * from zhisheng1828_zswb.btwb_return_bstransaction where
sflag = 1 and odate > unix_timestamp('", Ystd,"') and odate < unix_timestamp('",Sys.Date(),
                                    "')"))
  YstdCountPeople = length(unique(YstdCountPeople$uid))-1
  return(YstdCountPeople)
}


