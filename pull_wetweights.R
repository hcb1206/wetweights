## all wet weights from 2020 generations

setwd("F:/Cultivation/Records/2020/Crop Generations")

library(readxl)
library(xlsx)
library(dplyr)
library(tidyr)
library(data.table)
library(ggplot2)

## here are the names of all the other generation files we want to read in:
gens <- paste("C", 22:33, sep = "") #add new generations by expanding x:y range
tables <- paste0("weight_",gens)
tables <- list(tables)

## for loop to create table for all generations
for(c in gens){
  assign(paste0("weight_", c), read_xlsx(paste0(c,".xlsx"), 
                                         sheet = "Wet Hang Weights", skip = 2))
}

## fixing up some tables, making sure theyre all formatted the same way
weight_C33 <- weight_C33[,c(1,2,4,5,6,7,8)]
weight_C30$`Wet Weight per plant (g)` <- as.character(weight_C30$`Wet Weight per plant (g)`)
weight_C31$`Wet Weight per plant (g)` <- as.character(weight_C31$`Wet Weight per plant (g)`)
weight_C32$`Wet Weight per plant (g)` <- as.character(weight_C32$`Wet Weight per plant (g)`)
weight_C33$`Wet Weight per plant (g)` <- as.character(weight_C33$`Wet Weight per plant (g)`)


## I want to figure out how to bind the rows of a list of objects using 'rbindlist',
## but for now I've listed all the tables to bind together
weight <- bind_rows(weight_C22, weight_C23, weight_C24,weight_C25, weight_C26,
                    weight_C27, weight_C28, weight_C29, weight_C30, weight_C31, 
                    weight_C32, weight_C33) ## add gen tables here as necessary

## tidying up the final dataframe
weight <- filter(weight, !is.na(weight$gen))
weight <- weight[,3:7]

##let's save this file
write.xlsx(weight, "C:/Users/Hannah/Documents/R/github/wetweights/masterWetWeight.xlsx")

