% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_to_omv.R
\name{convert_to_omv}
\alias{convert_to_omv}
\title{Convert data files (CSV, R, other statistics packages) into .omv-files for the statistical spreadsheet 'jamovi' (\url{https://www.jamovi.org})}
\usage{
convert_to_omv(
  fleInp = "",
  fleOut = "",
  varSrt = c(),
  usePkg = c("foreign", "haven"),
  selSet = "",
  ...
)
}
\arguments{
\item{fleInp}{Name (including the path, if required) of the data file to be read ("FILENAME.ext"; default: ""); supports CSV and R-files natively, or other file types if "foreign" or "haven" are installed}

\item{fleOut}{Name (including the path, if required) of the data file to be written ("FILENAME.omv"; default: ""); if empty, the extension of fleInp is replaced with ".omv"}

\item{varSrt}{Variable(s) that are used to sort the data frame (see Details; if empty, the row order of the input file is kept; default: c())}

\item{usePkg}{Name of the package: "foreign" or "haven" that shall be used to read SPSS, Stata and SAS files; "foreign" is the default (it comes with base R), but "haven" is newer and more comprehensive}

\item{selSet}{Name of the data set that is to be selected from the workspace (only applies when reading .RData-files)}

\item{...}{Additional arguments passed on to methods; see Details below}
}
\description{
Convert data files (CSV, R, other statistics packages) into .omv-files for the statistical spreadsheet 'jamovi' (\url{https://www.jamovi.org})
}
\details{
The ellipsis-parameter (...) can be used to submit arguments / parameters to the functions that are used for reading the data. These are: \code{read_omv} (for jamovi-files), \code{read.table} (for
CSV / TSV files), \code{readRDS} (for rds-files), \code{read_sav} (needs R-package "haven") or \code{read.spss} (needs R-package "foreign") for SPSS-files,  read_dta ("haven") / read.dta ("foreign") for
Stata-files, \code{read_sas} ("haven") for SAS-data-files, and \code{read_xpt} ("haven") / \code{read.xport} ("foreign") for SAS-transport-files. For reading CSV / TSV files, similar defaults as \code{read.csv} (CSV)
and \code{read.delim} (TSV) are used; both are based upon \code{read.table} but with setting reasonable defaults for the respective file types. If you would like to use "haven", it may be needed to install
it manually (i.e., \code{install.packages("haven", dep = TRUE)}).
}
\examples{
\dontrun{
library(jmvReadWrite)

# Example 1: Convert from RDS
# (use ToothGrowth as example, save it as RDS)
nmeInp <- paste0(tempfile(), ".rds")
nmeOut <- paste0(tempfile(), ".omv")
saveRDS(jmvReadWrite::ToothGrowth, nmeInp)
convert_to_omv(fleInp = nmeInp, fleOut = nmeOut)
cat(list.files(dirname(nmeOut), basename(nmeOut)))
# -> "file[...].omv" ([...] contains a random combination of numbers / characters
cat(file.info(nmeOut)$size)
# -> 2448 (size may differ on different OSes)
cat(str(read_omv(nmeOut, sveAtt = FALSE)))
# gives a overview of the dataframe (all columns and some attributes,
# sveAtt is intentionally set to FALSE to make the output not too overwhelming)
unlink(nmeInp)
unlink(nmeOut)

# Example 2: Convert from CSV
# (use ToothGrowth again as example, this time save it as CSV)
nmeInp <- paste0(tempfile(), ".csv")
nmeOut <- paste0(tempfile(), ".omv")
write.csv(jmvReadWrite::ToothGrowth, nmeInp)
convert_to_omv(fleInp = nmeInp, fleOut = nmeOut)
cat(list.files(dirname(nmeOut), basename(nmeOut)))
cat(file.info(nmeOut)$size)
# -> 2104 (size may differ acc. to OS; the size is smaller than for the RDS-file
# because CSV can store fewer attributes, e.g., labels)
cat(str(read_omv(nmeOut, sveAtt = FALSE)))
# gives a overview of the dataframe (all columns and some attributes)
unlink(nmeInp)
unlink(nmeOut)
}

}
