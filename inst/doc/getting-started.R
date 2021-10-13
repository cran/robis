## ---- include = FALSE---------------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  purl = NOT_CRAN,
  eval = NOT_CRAN,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(robis)
library(dplyr)
library(ggplot2)

## ----message = FALSE----------------------------------------------------------
occ <- occurrence("Abra aequalis")
occ

## ----message = FALSE----------------------------------------------------------
ggplot(occ) +
  geom_bar(aes(date_year), stat = "count", width = 1)

## ----message = FALSE----------------------------------------------------------
occurrence(taxonid = 293683)

## ----message = FALSE----------------------------------------------------------
occurrence("Abra alba", geometry = "POLYGON ((2.59689 51.16772, 2.62436 51.14059, 2.76066 51.19225, 2.73216 51.20946, 2.59689 51.16772))")

## ----eval = FALSE-------------------------------------------------------------
#  map_leaflet(occurrence("Abra sibogai"))

## ----message = FALSE----------------------------------------------------------
cl <- checklist("Semelidae")
cl

## ----message = FALSE----------------------------------------------------------
ggplot(cl %>% filter(!is.na(genus))) +
  geom_bar(aes(genus)) +
  coord_flip() +
  ylab("species count")

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

## ----message = FALSE----------------------------------------------------------
occ <- occurrence("Prymnesiophyceae", datasetid = "62b97724-da17-4ca7-9b26-b2a22aeaab51", dna = TRUE)
occ

## ----message = FALSE----------------------------------------------------------
dna <- dna_records(occ, fields = c("scientificName"))

dna %>%
  select(scientificName, target_gene, DNA_sequence)

