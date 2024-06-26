% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xml.R
\name{escapeXmlText}
\alias{escapeXmlText}
\title{Escape xml text}
\usage{
escapeXmlText(x)
}
\arguments{
\item{x}{a \code{character} vector meant to be xml-text content.}
}
\value{
The same \code{character} vector x but xml text escaped.
}
\description{
Escape the characters '<' and \code{&} in a character vector meant to be xml-text content.
}
