#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(rvest)
library(dplyr)
library(readxl)
library(pander)
library(knitr)
library(googledrive)
library(kableExtra)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  observeEvent(input$button,{
    output$table <- renderText({
      brand<-input$brand
      abbr<-c('FT','SO','ZP','TI','CA','TX','BR','XY')
      full2<-c("FASTRACK", "SONATA", "ZOOP", "TITAN", "CASIO", "TIMEX", "TOMMY",'XYLYS')
      full<-c("Fastrack", "Sonata", "Titan", "Titan", "Casio", "Timex", "Helios",'Xylys')
      brand_df<-data.frame(cbind(abbr,full,full2),stringsAsFactors = F)
      brandABBR<-brand_df[brand_df$full2==brand,1]
      stock<-read_xlsx(input$file$datapath)
      stock<-stock[stock$Division=='01-Watches',]
      stock<-stock[!is.na(stock$Material),]
      stock<-merge(stock,brand_df,by.x = 'Brand',by.y = 'abbr')
      stock$Material2<-stock$Material
      stock$Material2[grepl('^N[A-Z]',stock$Material)]<-gsub('^N[A-Z]','',stock$Material[grepl('^N[A-Z]',stock$Material)])
      stock$Material2<-gsub('CJ$','',stock$Material2)
      stock$Material2<-gsub('J$','',stock$Material2)
      stock$Material2<-gsub('C$','',stock$Material2)
      
      stock<-stock[stock$Brand==brandABBR,]
      mat<-matrix(ncol = 9,nrow = nrow(stock))
      
      
      for (i in 1:nrow(stock)){
        model <- stock$Material2[i]
        model2 <- stock$Material[i]
        brand <- stock$full[i]
        stocks <- stock$`Free Stock`[i]
        price <- stock$Price[i]
        num<-c(1:5)
        url <- paste('https://staticimg.titan.co.in/',brand,'/Catalog/',model,'_',num,'.jpg',sep = '')
        url<-paste0('=IMAGE("',url,'")')
        #url <- pandoc.image.return(url)
        mat[i,]<-c(model,model2,stocks,price,url)
      }
      mat<-as.data.frame(mat)
      names(mat)<-c('search','Model','stock','price',1,2,3,4,5)
      mat$order<-' '
      named<-paste0(brand,'_OrderSheet_',format(Sys.time(), '%d-%m-%Y'),'.csv')
      write.csv(mat,named,row.names = F)
      drive_upload(named)
      #browseURL('https://drive.google.com/drive/u/0/my-drive')
      print('Done, Please open Google Drive')
    })
  })
})
