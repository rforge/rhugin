\name{compress}
\alias{compress}

\title{Compress}

\description{
Remove the zero entries from the clique and separator tables in a compiled domain.
}

\usage{
compress(domain)
}

\arguments{
  \item{domain}{an RHugin domain.}
}

\value{
a single numeric value providing a measure of the compression achieved. A value less than 1 indicates that the compressed domain requires less memory than the uncompressed domain. If the measure is larger than 1 then the compressed domain requires more memory than the uncompressed domain.
}

\references{
HUGIN API Reference Manual \url{http://download.hugin.com/webdocs/manuals/api-manual.pdf}: \code{h_domain_compress}.
}

\author{Kjell Konis \email{kjell.konis@icloud.com}}

\examples{
demo("apple", echo = FALSE)

# Compile the domain
compile(apple)

# Compress domain
compress(apple)
}

\keyword{programming}


