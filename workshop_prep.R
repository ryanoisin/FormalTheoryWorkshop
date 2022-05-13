# install.packages("devtools")
library(devtools)

install_github("jmbh/PanicModel")

# if this is an error, double check that you have installed R tools
# https://cran.r-project.org/bin/windows/Rtools/
# if you have set it up as described on the website
devtools::find_rtools()
# should return TRUE
