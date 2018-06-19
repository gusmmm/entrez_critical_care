# tidying the query results for text analysis
# https://www.tidytextmining.com/

###1 extract words ###

w_df <- final_df %>% unnest_tokens(sentence, abstract, token = "sentences")
w_df$title <- NULL

### number of lines per uid
tt <- w_df$uid %>% table() %>% as_data_frame()
str(tt)
tt$n
linhas <- c()
for(linha in tt$n){
  print(linha)
  linhas <- c(linhas,(1:linha))
}
linhas

w_df$line_num <- linhas


w_df %>% unnest_tokens(word,sentence) -> w_df
w_df %>% anti_join(stop_words) -> w_df
# count words
w_df %>% count(word,sort = T)


#___ remove lines without meaningful tokens 
# remove digits
filtro <- str_detect(w_df$word,pattern = "^\\d+\\.*\\d*$")
filtro
w_df <- w_df[!filtro,]


########################


# bigrams
s_df <- final_df %>% unnest_tokens(sentence, abstract, token = "sentences")
bbigram <- s_df %>% unnest_tokens(bigram,sentence, token = "ngrams", n=2)
bbigram %>% count(bigram,sort = T)
bbigram_sep <- bbigram %>% separate(bigram, c("word1","word2"), sep = " ")
   # remove rows with integers
vv <- bbigram_sep$word1 %>% str_detect("^\\d+\\.*\\d*$")
vv2 <- bbigram_sep$word2 %>% str_detect("^\\d+\\.*\\d*$")
bbigram_sep <- bbigram_sep[!(vv|vv2),]
rm(vv)
rm(vv2)

bbigram_filt <- bbigram_sep %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)
bigrams_count <- bbigram_filt %>%
  count(word1,word2,sort = T)
