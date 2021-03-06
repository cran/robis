% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/taxon.R
\name{taxon}
\alias{taxon}
\title{Get taxon by taxon ID.}
\usage{
taxon(taxonid, verbose = FALSE)
}
\arguments{
\item{taxonid}{the taxon identifier (WoRMS AphiaID).}

\item{verbose}{logical. Optional parameter to enable verbose logging (default = \code{FALSE}).}
}
\value{
Tibble containing taxon records.
}
\description{
Get taxon by taxon ID.
}
\examples{
taxon(c(141433, 141434))
}
