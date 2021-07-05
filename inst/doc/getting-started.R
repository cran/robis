## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(robis)

## ----message = FALSE----------------------------------------------------------
occurrence("Abra aequalis")

## ----message = FALSE----------------------------------------------------------
occurrence(taxonid = 293683)

## ----message = FALSE----------------------------------------------------------
occurrence("Abra alba", geometry = "POLYGON ((2.59689 51.16772, 2.62436 51.14059, 2.76066 51.19225, 2.73216 51.20946, 2.59689 51.16772))")

## ----eval = FALSE-------------------------------------------------------------
#  map_leaflet(occurrence("Abra sibogai"))

## ----message = FALSE----------------------------------------------------------
checklist("Semelidae")

## ----message = FALSE----------------------------------------------------------
checklist(geometry = "POLYGON ((2.59689 51.16772, 2.62436 51.14059, 2.76066 51.19225, 2.73216 51.20946, 2.59689 51.16772))")

## ----message = FALSE----------------------------------------------------------
occ <- occurrence("Abra tenuis", mof = TRUE)

## ----message = FALSE----------------------------------------------------------
mof <- measurements(occ, fields = c("scientificName", "decimalLongitude", "decimalLatitude"))
mof

## ----message = FALSE----------------------------------------------------------
library(dplyr)

occurrence("Abra tenuis", mof = TRUE, measurementtype = "biomass") %>%
  measurements()

