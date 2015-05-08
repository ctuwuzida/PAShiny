library(shiny)
library(shinydashboard)


dashboardPage(skin = "blue",
  dashboardHeader(title = "模拟盘选手评价系统"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("仪表盘", tabName = "Dashboard", icon = icon("dashboard")),
      menuItem("归因分析", tabName = "widgets", icon = icon("th"))
    )
    ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Dashboard",
              fluidRow(
                
                # Dynamic valueBoxes
                valueBoxOutput("YetdCount"),
                
                valueBoxOutput("approvalBox"),
                
                valueBoxOutput("box")
              )
              
              ),
      tabItem(tabName = "widgets",
              fluidRow(
                
                )
              )
      )
 
    )
  )
