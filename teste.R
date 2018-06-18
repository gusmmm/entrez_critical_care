a_df <- data_frame(uid = xmlSApply(xtop, function(x) {x[[2]][['ArticleIdList']][[1]] %>% xmlValue()}),
                   
                          abstract = xmlSApply(xtop, function(x) { 
                            if(is.na(xmlValue(x[[1]][['Article']][['Abstract']]))) { "vazio" } 
                            else { xmlValue(x[[1]][['Article']][['Abstract']]) }
                            
                          } 
                          ))

getChildrenStrings(node = xtop[[1]][[1]][['Article']][['Abstract']]) %>% paste(collapse = " ")

b_df <- data_frame(uid = xmlSApply(xtop, function(x) {x[[2]][['ArticleIdList']][[1]] %>% xmlValue()}),
                   
                   abstract = xmlSApply(xtop, function(x) { 
                     if(is.na(xmlValue(x[[1]][['Article']][['Abstract']]))) { "vazio" } 
                     else { getChildrenStrings(node = x[[1]][['Article']][['Abstract']]) %>% paste(collapse = " ") }
                     
                   } 
                   ))

# cleaning abstracts from unusable characters


a <- str_replace_all(string = final_df$abstract[2], pattern = "[0-9]+",replacement = "__NUMBER__")
a <- str_replace_all(string = a, pattern = "__NUMBER__\\.__NUMBER__",replacement = "__NUMBER__")
a <- str_replace_all(string = a, pattern = "__NUMBER__%",replacement = "__NUMBER__")
#aa <- final_df$abstract[1:2]
#str_replace_all(string = aa, pattern = "[0-9]+",replacement = "__NUMBER__")