# listcomp
Minimal list comprehensions in R, for fun.

Pass a Python-style list comprehension as a string to `lc` and have it 
evaluated in the calling environment. Actual logic uses R syntax.

Supports hopefully anything with complexity less than or equal to:

 `fn_a(item) for item in my_list if fn_b(item)`
 
and greater than or equal to:

 `item for item in list`
 
Supports nesting by wrapping inner comprehensions with `[]`.

```R
# install.packages("devtools")
# devtools::install_github("DexGroves/listcomp")

my_sequence <- seq(10)
nested_list <- list(seq(5), seq(10))

lc('item ^ 2 for item in my_sequence if item %% 2 == 0')
lc('x ^ 2 for x in [max(y) for y in nested_list]')
```

Works just fine for anything that can be indexed, including data.frames.

```R
library("ggplot2")
data(diamonds)

lc('mean(x) for x in diamonds if is.numeric(x)')
#       carat        depth        table        price            x            y            z 
#   0.7979397   61.7494049   57.4571839 3932.7997219    5.7311572    5.7345260    3.5387338 
```
