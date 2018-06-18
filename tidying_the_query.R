# tidying the query results for text analysis
# https://www.tidytextmining.com/

#1 extract the abstracts

a <- final_df[1,] %>% unnest_tokens(sentence, abstract, token = "sentences")
a[2,]$sentence

