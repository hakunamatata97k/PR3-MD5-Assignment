
# current status of the program:
## Everything is working :) but we still have things to do.
# Refrences that i used to learn:

### for `split()`
1. https://www.dotnetperls.com/split-ruby
2. https://ruby-doc.org/core-2.7.1/String.html#method-i-split
3. https://www.thoughtco.com/splitting-strings-2908301

### for `eval`

1. https://stackoverflow.com/questions/1902744/when-is-eval-in-ruby-justified
2. https://stackoverflow.com/questions/637421/is-eval-supposed-to-be-nasty
3. https://blog.udemy.com/ruby-eval/

### for the exit-codes

1. http://tldp.org/LDP/abs/html/exitcodes.html

### for Regexp
1. https://ruby-doc.org/core-2.7.1/Regexp.html
2. https://stackoverflow.com/questions/8652715/convert-a-string-to-regular-expression-ruby

### for reading Regex expressions from file

1. (MY QUESTION https://stackoverflow.com/questions/61719344/eval-certain-regex-from-file-to-replace-chars-in-string


### for breaking nested loops in ruby
1.https://coderwall.com/p/7cnnew/breaking-nested-loop-like-each_slice-with-style
2.https://stackoverflow.com/questions/1352120/how-to-break-outer-cycle-in-ruby

# **flaws that the code might cause**
due to the fact that the professor wrote the trans file in non-standard, difficult to parse format the program would fail to recognize some complex
Regexes such like `/a-z/ 3` which will replace every letter with the number 3.

# still to do

1. check for the safety of the files and paths.
