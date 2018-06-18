# tidying the query results for text analysis
# https://www.tidytextmining.com/

#1 extract the abstracts

a <- final_df[1:10,] %>% unnest_tokens(sentence, abstract, token = "sentences")
a$title <- NULL
a$line_num <- 1:NROW(a)
a[10,]$sentence

a %>% unnest_tokens(word,sentence) -> b
b <- b %>% anti_join(stop_words)
b %>% count(word,sort = T)

# bigrams
bbigram <- a %>% unnest_tokens(bigram,sentence, token = "ngrams", n=2)
bbigram %>% count(bigram,sort = T)
bbigram_sep <- bbigram %>% separate(bigram, c("word1","word2"), sep = " ")
bbigram_filt <- bbigram_sep %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)
bigrams_count <- bbigram_filt %>%
  count(word1,word2,sort = T)
