library(gutenbergr)
library(tidyverse)

# See 0-load-corpus for more details
libretti <- gutenberg_download(808)$text
libretti <- libretti[-(1:113)]

# Preserve linebreaks as characters:
nchar('\n') # one character!

chars <- libretti |> 
  paste(collapse = '\n') |> 
  str_split_1('')

# Old version without linebreaks preserved
#chars <- libretti |> 
#  str_split("") |> 
#  unlist()

vocab <- sort(unique(chars))

# Encoder
encoder <- setNames(seq_along(vocab), vocab) 

tokens <- encoder[chars]

sort(table(chars), decreasing = TRUE)


libretti[str_detect(libretti, "[{}\\\\`]")]
