library(gutenbergr)
library(tidyverse)

# The Gutenberg id for "The Complete Plays of Gilbert and Sullivan" is 808
# https://www.gutenberg.org/ebooks/808

libretti <- gutenberg_download(808)

# returns a tibble with two columns: on repeats ths gutenberg_id over and over
# while the other contains the individual lines of the text
str(libretti) 

libretti <- libretti$text


# Most of the frontmatter has already been stripped, as has the standard 
# Project Gutenberg boilerplate after the text, since gutenberg_download() 
# defaults to strip = TRUE, but there are many blank lines and every row seems
# to appear twice. But the files on Gutenberg are clean.
head(libretti)
tail(libretti)

# I forked the gutenbergr repo, pointed Claude code at it and provided the
# code and comments from above. Claude found the error: it's from a faulty
# left-join in the case of works with multiple authors. 

# Here are some examples to show that this happens with multiple-author works 
# but not with single author works. In particular, you get as many duplicate
# lines as there are authors. The reason is because gutenbergr does a
# left_join() with the work's metadata on the left, but this will have multiple
# rows when there are multiple authors:

# Plays of Gilberg & Sullivan (2 authors)
gutenberg_metadata |> filter(gutenberg_id == 808)

# The Federalist Papers (3 authors)
gutenberg_metadata |> filter(gutenberg_id == 808)
fed <- gutenberg_download(18)
fed$text[1:10]


# Pride and Prejudice (single author)
gutenberg_metadata |> filter(gutenberg_id == 1342)
pride <- gutenberg_download(1342) 
pride$text[1:100]

# Clean up examples of the bug
rm(fed, pride)

# I've submitted an issue on the GitHub page for gutenbergr about this. In the
# meantime, I can simply keep every other row of the G&S libretti:

libretti <- libretti[seq(1, length(libretti), by = 2)]


# Don't drop blank lines! We're going to imitate tiny Shakespeare: 
# https://raw.githubusercontent.com/karpathy/char-rnn/master/data/tinyshakespeare/input.txt

# So we may want to do basic cleanup: normalize character names, drop list of
# characters and titles of the Operettas? Remove stage directions? Or maybe just
# leave as-is?

# The first 113 lines are the table of contents: drop them
head(libretti, 200)
libretti <- libretti[-(1:113)]

# At the end: use str_flatten() to obtain a single string? In the end we want a
# tensor with the full text at the character level I suppose?
