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
