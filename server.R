shinyServer(function(input, output){
  output$YetdCount <- renderValueBox({
    valueBox(
      GetYstdCount(), "昨日交易次数", icon = icon("bar-chart"),
      color = "purple"
    )
  })
  
  output$approvalBox <- renderValueBox({
    valueBox(
      GetYstdCountPeople(), "昨日交易人数", icon = icon("user"),
      color = "yellow"
    )
  })
  
  output$box <- renderValueBox({
    valueBox(
      "80%", "Approval", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "lime"
    )
  })
})