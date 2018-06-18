# tools for text analysis of pubmed data
# source: pubmed abstracts and metadata
# objective - create tools to information extraction, visualization and knowledge creation

### packages
library(tidyverse)
library(rentrez)
library(tidytext)
library(XML)

### querying pubmed
# example: septic shock
# date: the month of may 2018

q <- '(septic shock AND ("2018/05/01"[PDAT] : "2018/05/31"[PDAT])")'
search_results <- entrez_search(db="pubmed", term = q, retmax = 1000, use_history = T)

# the search results
# search_results$ids

# getting the data from the search_results
q_summary <- entrez_summary(db="pubmed",web_history = search_results$web_history)
q_data <- entrez_fetch(db="pubmed", id = search_results$ids, rettype = "xml")

data_xml <- xmlParse(q_data)
xtop <- xmlRoot(data_xml)
#xtop

metadata_df <- data_frame(uid = sapply(q_summary, function(x) x$uid), title = sapply(q_summary, function(x) x$title))
#abstract_df <- data_frame(uid = xmlSApply(xtop, function(x) {x[[2]][['ArticleIdList']][[1]] %>% xmlValue()}),
#                          abstract = xmlSApply(xtop, function(x) xmlValue(x[[1]][['Article']][['Abstract']]) ))

# create the abstract data_frame
# This inserted an empty space between abstract sections

abstract_df <- data_frame(uid = xmlSApply(xtop, function(x) {x[[2]][['ArticleIdList']][[1]] %>% xmlValue()}),
           
           abstract = xmlSApply(xtop, function(x) { 
             if(is.na(xmlValue(x[[1]][['Article']][['Abstract']]))) { "vazio" } 
             else { getChildrenStrings(node = x[[1]][['Article']][['Abstract']]) %>% paste(collapse = " ") }
             
           } 
           ))

final_df <- inner_join(metadata_df,abstract_df)
