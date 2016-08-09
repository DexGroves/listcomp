# listcomp
Minimal list comprehensions in R, for fun.

Pass a Python-style list comprehension as a string to `lc` and have it 
evaluated in the calling environment. Actual logic uses R syntax.
 
Supports nesting by wrapping inner comprehensions with `[]`.

Can handle anything* of the form `<R expression> for name in <R object> if <R expression>`.

\* Probably not anything

```R
# install.packages("devtools")
# devtools::install_github("DexGroves/listcomp")

my_sequence <- seq(10)
nested_list <- list(seq(5), seq(10))

lc('item ^ 2 for item in my_sequence if item %% 2 == 0')
lc('x ^ 2 for x in [max(y) for y in nested_list]')
lc('j for i in seq(5) if i > 3 for j in seq(i)')
```

Works just fine for anything that can be indexed, including data.frames.

```R
library("ggplot2")
data(diamonds)

lc('mean(x) for x in diamonds if is.numeric(x)')
#       carat        depth        table        price            x            y            z 
#   0.7979397   61.7494049   57.4571839 3932.7997219    5.7311572    5.7345260    3.5387338 
```
