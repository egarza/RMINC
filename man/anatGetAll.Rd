% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/minc_anatomy.R
\name{anatGetAll}
\alias{anatGetAll}
\title{Faster AnatGet}
\usage{
anatGetAll(filenames, atlas = NULL,
  defs = getOption("RMINC_LABEL_DEFINITIONS"), method = c("jacobians",
  "labels", "sums", "means", "text"), side = c("both", "left", "right"),
  parallel = NULL, strict = TRUE,
  conf_file = getOption("RMINC_BATCH_CONF"))
}
\arguments{
\item{filenames}{A vector of filenames (strings) which contain the
information to be extracted at every structure in the atlas.}

\item{atlas}{A single filename containing the atlas definitions. This MINC
volume has to be of the same sampling (sizes and dimension
order) as the filenames specified in the first argument and
use a separate integer for each atlas label.}

\item{defs}{A string pointing to the filename containing the label
definitions. Used to map the integers in the atlas to a
proper name for the structure and contains additional
information for laterality of each structure. See \link{voxel_atlas_defs}
for details.}

\item{method}{A string specifying the way information is to be computed at
every voxel. See the details section for the possible options
and what they mean.}

\item{side}{Three choices, "right", "left", and "both" (the default)
which specify what labels to obtain.}

\item{parallel}{how many processors to run on (default=single processor).
Specified as a two element vector, with the first element corresponding to
the type of parallelization, and the second to the number
of processors to use. For local running set the first element to "local" or "snowfall"
for back-compatibility, anything else will be run with batchtools see \link{pMincApply}
Leaving this argument NULL runs sequentially.}

\item{strict}{check if any files differ in step sizes}

\item{conf_file}{A batchtools configuration file defaulting to \code{getOption("RMINC_BATCH_CONF")}}
}
\value{
A matrix with ncols equal to the number of labels in the atlas and
nrows equal to the number of files.
}
\description{
Computes volumes, means, sums, and similar values across a
segmented atlas
}
\details{
anatGetAll needs a set of files along with an atlas and a set of
atlas definitions. In the end it will produce one value per label
in the atlas for each of the input files. How that value is
computed depends on the methods argument:
\itemize{
  \item{jacobians -}{ Each file contains log jacobians, and the volume for
  each atlas label is computed by multiplying the jacobian with
  the voxel volume at each voxel.
  }
  \item{labels -}{ Each file contains integer labels (i.e. same as the atlas).
  The volume is computed by counting the number of voxels with
  each label and multiplying by the voxel volume.
  }
  \item{means -}{ Each file contains an arbitrary number and the mean of all
  voxels inside each label is computed.
  }
  \item{sums -}{ Each file contains an aribtrary number and the sum of all
  voxels inside each label is computed.
  }
  \item{text -}{ Each file is a comma separated values text file and is simply
  read in.
  }
}
}
