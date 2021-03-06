% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flag_if.R
\name{detect_if}
\alias{detect_if}
\title{Apply a predicate function to a column of a dataframe.}
\usage{
detect_if(.data, name, predicate)
}
\arguments{
\item{.data}{A dataframe.}

\item{name}{String. The name of a column of a dataframe.}

\item{predicate}{A predicate function.}
}
\value{
Logical of length 1.
}
\description{
Apply a predicate function to a column of a dataframe.
}
\examples{
dfm <- data.frame(CensusID = c(1, 2, NA))
detect_if(dfm, "censusid", is_multiple)
detect_if(dfm, "censusid", is_duplicated)

dfm <- data.frame(CensusID = c(1, 1))
detect_if(dfm, "censusid", is_duplicated)
detect_if(dfm, "censusid", is_multiple)

dfm <- data.frame(CensusID = c(1, 1, 2))
detect_if(dfm, "censusid", is_duplicated)
detect_if(dfm, "censusid", is_multiple)
}
\seealso{
Other general predicates: \code{\link{has_table_names}},
  \code{\link{is_multiple}}, \code{\link{is_named}}
}
\concept{general predicates}
