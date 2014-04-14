#!/usr/bin/env Rscript
require(knitr); 
grDevices::pdf.options(useDingbats = FALSE); 
opts_chunk$set(prompt=TRUE, fig.width=5, fig.height=4, background='gray', echo=FALSE);
knit('chap99.Rnw')
#knit('chap12.Rnw')
