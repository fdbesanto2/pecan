% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metutils.R
\name{get.rh}
\alias{get.rh}
\title{get RH}
\usage{
get.rh(T, Td)
}
\arguments{
\item{T}{air temperature, Kelvin}

\item{Td}{dewpoint, Kelvin}
}
\value{
Relative Humidity numeric vector
}
\description{
Calculate RH from temperature and dewpoint
}
\details{
Based on equation 12 in Lawrence 2005, The Relationship between
Relative Humidity and the Dewpoint Temperature in Moist Air
A Simple Conversion and Applications. BAMS
https://doi.org/10.1175/BAMS-86-2-225
R = 461.5 K-1 kg-1 gas constant H2O
L enthalpy of vaporization 
linear dependence on T (p 226, following eq 9)
}
\author{
David LeBauer
}
