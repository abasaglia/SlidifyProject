require(rCharts)
library(reshape2)
library(ggplot2)
library(data.table)

cleanEta <- function (df) {
    res <- data.frame(Year=character(),Age=numeric(),Sex=character(),HowMany=numeric(),stringsAsFactors=FALSE)
    for (r in 1:nrow(df)) {  
        row <- df[r,]
        y<-row[[1]]#$Anno.di.censimento  
        e<-row[[2]]#$Età
        s<-row[[3]]#$Genere
        v<-row[[4]]#$Numerosità
        if (is.na(as.numeric(e))) {
            if (grepl("\\d* e.*", e, perl=TRUE)) {
                # cases where age is "xx e più" return xx
                res<-rbindlist(list(res, as.list(c(y, sub("(\\d*) e.*", "\\1", e, perl=TRUE), s, v))))
            } else if (e == 'Età ignota') {
                #age not known discard value
            } else if (grepl("\\d\\d-\\d\\d", e, perl=TRUE)) {
                #case where age is xx-yy
                xy<-unlist(strsplit (e,"-"))
                nl<-xy[1]:xy[2]
                for (i in nl) {
                    res<-rbindlist(list(res, as.list(c(y, i, s, as.numeric(v)/length(nl)))))
                }
            }
        } else {
            res<-rbindlist(list(res, as.list(c(y, e, s, v))))
        }
    }
    res$HowMany<-as.numeric(res$HowMany)
    return (res)
}

# dataset has been downloaded from http://dati.comune.milano.it/dato/item/300-300%20-%20Popolazione:%20censimenti%20storici%20-%20popolazione%20per%20et%C3%A0%20(1881-2011).html
df<-read.csv2(".//Censimento_eta_1881-2011.csv",sep=';',colClasses=c("character", "character","character","numeric"))
x<-cleanEta(df)
        
output$nvd3plot <- renderChart({
    a<-subset(x,subset = x$Year==input$YYYY)
    a$Year<-as.numeric(a$Year)
    a$Age<-as.numeric(a$Age)
    n1 <- nPlot(HowMany ~ Age, group = 'Sex',type = 'lineChart',
        data = a
    )
    n1$set(dom = 'nvd3plot', width = 600)
    n1
})

# output$nvd3plot <- renderChart({
#     haireye = as.data.frame(HairEyeColor)
#     n1 <- nPlot(Freq ~ Hair, group = 'Eye', type = input$type,
#                 data = subset(haireye, Sex == input$sex)
#     )
#     n1$set(dom = 'nvd3plot', width = 600)
#     n1
# })