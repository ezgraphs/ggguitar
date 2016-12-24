# ggguitar

[![](http://cranlogs.r-pkg.org/badges/ggguitar)](https://CRAN.R-project.org/package=ggguitar)

Latest release available from [CRAN](https://cran.r-project.org/web/packages/ggguitar/index.html).  

## Description
Create Guitar Tablature and related documentation.  Powered by ggplot2 and the Tidyverse.

## Example Usage
```
> library(ggguitar)
> chord_GM <- c(3, 2, 0, 0, 0, 3)
> tablature('G Major', chord_GM)
```

![alt text](images/G_Major.png "G Major")

```
> chord_for_frets(chord_GM)
[1] "g" "b" "d" "g" "b" "g"
```

See the [Vignette](https://cran.r-project.org/web/packages/ggguitar/vignettes/my-vignette.html) for more examples.
