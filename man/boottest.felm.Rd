% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/boottest_felm.R
\name{boottest.felm}
\alias{boottest.felm}
\title{Fast wild cluster bootstrap inference for object of class felm}
\usage{
\method{boottest}{felm}(
  object,
  param,
  B,
  clustid = NULL,
  bootcluster = "max",
  fe = NULL,
  conf_int = TRUE,
  R = NULL,
  r = 0,
  beta0 = NULL,
  sign_level = 0.05,
  type = "rademacher",
  impose_null = TRUE,
  bootstrap_type = "fnw11",
  p_val_type = "two-tailed",
  tol = 1e-06,
  maxiter = 10,
  sampling = "dqrng",
  nthreads = getBoottest_nthreads(),
  ssc = boot_ssc(adj = TRUE, fixef.K = "none", cluster.adj = TRUE, cluster.df =
    "conventional"),
  engine = getBoottest_engine(),
  floattype = "Float64",
  maxmatsize = FALSE,
  bootstrapc = FALSE,
  getauxweights = FALSE,
  ...
)
}
\arguments{
\item{object}{An object of class felm}

\item{param}{A character vector or rhs formula. The name of the regression
coefficient(s) for which the hypothesis is to be tested}

\item{B}{Integer. The number of bootstrap iterations. When the number
of clusters is low,
increasing B adds little additional runtime.}

\item{clustid}{A character vector or rhs formula containing the names of
the cluster variables. If NULL,
a heteroskedasticity-robust (HC1) wild bootstrap is run.}

\item{bootcluster}{A character vector or rhs formula of length 1.
Specifies the bootstrap clustering variable or variables. If more
than one variable is specified, then bootstrapping is clustered
by the intersections of
clustering implied by the listed variables. To mimic the behavior
of stata's boottest command,
the default is to cluster by the intersection of all the variables
specified via the \code{clustid} argument,
even though that is not necessarily recommended (see the paper by
Roodman et al cited below, section 4.2).
Other options include "min", where bootstrapping is clustered by
the cluster variable with the fewest clusters.
Further, the subcluster bootstrap (MacKinnon & Webb, 2018) is
supported - see the \code{vignette("fwildclusterboot", package = "fwildclusterboot")} for details.}

\item{fe}{A character vector or rhs formula of length one which contains
the name of the fixed effect to be projected
out in the bootstrap. Note: if regression weights are used, fe
needs to be NULL.}

\item{conf_int}{A logical vector. If TRUE, boottest computes confidence
intervals by test inversion. If FALSE, only the p-value is returned.}

\item{R}{Hypothesis Vector giving linear combinations of coefficients.
Must be either NULL or a vector of the same length as \code{param}. If NULL,
a vector of ones of length param.}

\item{r}{A numeric. Shifts the null hypothesis
H0: param = r vs H1: param != r}

\item{beta0}{Deprecated function argument. Replaced by function argument 'r'.}

\item{sign_level}{A numeric between 0 and 1 which sets the significance level
of the inference procedure. E.g. sign_level = 0.05
returns 0.95\% confidence intervals. By default, sign_level = 0.05.}

\item{type}{character or function. The character string specifies the type
of boostrap to use: One of "rademacher", "mammen", "norm"
and "webb". Alternatively, type can be a function(n) for drawing
wild bootstrap factors. "rademacher" by default.
For the Rademacher distribution, if the number of replications B
exceeds the number of possible draw ombinations,
2^(#number of clusters), then \code{boottest()}
will use each possible combination once (enumeration).}

\item{impose_null}{Logical. Controls if the null hypothesis is imposed on
the bootstrap dgp or not. Null imposed \code{(WCR)} by default.
If FALSE, the null is not imposed \code{(WCU)}}

\item{bootstrap_type}{Determines which wild cluster bootstrap type should be
run. Options are "fnw11","11", "13", "31" and "33" for the wild cluster
bootstrap and "11" and "31" for the heteroskedastic bootstrap.
For more information, see the details section. "fnw11" is the default for
the cluster bootstrap, which runs a "11" type
wild cluster bootstrap via the algorithm outlined in "fast and wild"
(Roodman et al (2019)). "11" is the default for the heteroskedastic
bootstrap.}

\item{p_val_type}{Character vector of length 1. Type of p-value.
By default "two-tailed". Other options include "equal-tailed",
">" and "<".}

\item{tol}{Numeric vector of length 1. The desired accuracy
(convergence tolerance) used in the root finding procedure to find
the confidence interval.
1e-6 by default.}

\item{maxiter}{Integer. Maximum number of iterations used in the root
finding procedure to find the confidence interval.
10 by default.}

\item{sampling}{'dqrng' or 'standard'. If 'dqrng', the 'dqrng' package is
used for random number generation (when available). If 'standard',
functions from the 'stats' package are used when available.
This argument is mostly a convenience to control random number generation in
a wrapper package around \code{fwildclusterboot}, \code{wildrwolf}.
I recommend to use the fast' option.}

\item{nthreads}{The number of threads. Can be: a) an integer lower than,
or equal to, the maximum number of threads; b) 0: meaning
all available threads will be used; c) a number strictly
between 0 and 1 which represents the fraction of all threads
to use. The default is to use 1 core.}

\item{ssc}{An object of class \code{boot_ssc.type} obtained with the function
\code{\link[=boot_ssc]{boot_ssc()}}. Represents how the small sample
adjustments are computed. The defaults are
adj = TRUE, fixef.K = "none", cluster.adj = "TRUE",
cluster.df = "conventional". You can find more details in the help
file for \code{boot_ssc()}. The function is purposefully designed to mimic
fixest's \code{\link[fixest:ssc]{fixest::ssc()}} function.}

\item{engine}{Character scalar. Either "R" or "WildBootTests.jl".
Controls the algorithm employed by boottest.
"R" is the default and implements the cluster bootstrap
as in Roodman (2019). "WildBootTests.jl" executes the wild
cluster bootstrap by via the WildBootTests.jl
package. For it to run, Julia and WildBootTests.jl need to
be installed. Check out the set_up_ ... functions
The "fast and wild" algorithm is extremely fast for small
number of clusters, but because it is fully vectorized,
very memory-demanding.
For large number of clusters and large number of bootstrap
iterations, the fast and wild algorithm becomes infeasible.
If a out-of-memory error #
occurs, the "lean" algorithm is a memory friendly, but less
performant rcpp-armadillo based implementation of the wild
cluster bootstrap.
Note that if no cluster is provided, boottest() always
defaults to the "lean" algorithm. Note that you can set the
employed algorithm globally by using the
\code{setBoottest_engine()} function.}

\item{floattype}{Float64 by default. Other option: Float32. Should floating
point numbers in Julia be represented as 32 or 64 bit? Only relevant when
'engine = "WildBootTests.jl"'}

\item{maxmatsize}{NULL by default = no limit. Else numeric scalar to set the
maximum size of auxilliary weight matrix (v), in gigabytes. Only relevant
when 'engine = "WildBootTests.jl"'}

\item{bootstrapc}{Logical scalar, FALSE by default. TRUE  to request
bootstrap-c instead of bootstrap-t. Only relevant when 'engine =
"WildBootTests.jl"'}

\item{getauxweights}{Logical. Whether to save auxilliary weight matrix (v)}

\item{...}{Further arguments passed to or from other methods.}
}
\value{
An object of class \code{boottest}
\item{p_val}{The bootstrap p-value.}
\item{conf_int}{The bootstrap confidence interval.}
\item{param}{The tested parameter.}
\item{N}{Sample size. Might differ from the regression sample size if
the cluster variables contain NA values.}
\item{boot_iter}{Number of Bootstrap Iterations.}
\item{clustid}{Names of the cluster Variables.}
\item{N_G}{Dimension of the cluster variables as used in boottest.}
\item{sign_level}{Significance level used in boottest.}
\item{type}{Distribution of the bootstrap weights.}
\item{impose_null}{Whether the null was imposed on the bootstrap dgp or not.}
\item{R}{The vector "R" in the null hypothesis of interest Rbeta = r.}
\item{r}{The scalar "r" in the null hypothesis of interest Rbeta = r.}
\item{point_estimate}{R'beta. A scalar: the constraints vector times the
regression coefficients.}
\item{grid_vals}{All t-statistics calculated while calculating the
confidence interval.}
\item{p_grid_vals}{All p-values calculated while calculating the confidence
interval.}
\item{t_stat}{The 'original' regression test statistics.}
\item{t_boot}{All bootstrap t-statistics.}
\item{regression}{The regression object used in boottest.}
\item{call}{Function call of boottest.}
\item{engine}{The employed bootstrap algorithm.}
\item{nthreads}{The number of threads employed.}
}
\description{
\code{boottest.felm} is a S3 method that allows for fast wild cluster
bootstrap inference for objects of class felm by  implementing
fast wild bootstrap algorithms as developed in Roodman et al., 2019
and MacKinnon, Nielsen & Webb (2022).
}
\section{Setting Seeds}{

To guarantee reproducibility, you need to
set a global random seed via
\itemize{
\item \code{set.seed()} when using
\enumerate{
\item the lean algorithm (via \code{engine = "R-lean"}) including the
heteroskedastic wild bootstrap
\item the wild cluster bootstrap via \code{engine = "R"} with Mammen weights or
\item \code{engine = "WildBootTests.jl"}
}
\item \code{dqrng::dqset.seed()} when using \code{engine = "R"} for Rademacher, Webb
or Normal weights
}
}

\section{Confidence Intervals}{

\code{boottest} computes confidence intervals by inverting p-values.
In practice, the following procedure is used:
\itemize{
\item Based on an initial guess for starting values, calculate p-values for
26 equal spaced points between the starting values.
\item Out of the 26 calculated p-values, find the two pairs of values x
for which the corresponding p-values px cross the significance level
sign_level.
\item Feed the two pairs of x into an numerical root finding procedure and
solve for the root. boottest currently relies on
\code{stats::uniroot} and sets an absolute tolerance of 1e-06 and
stops the procedure after 10 iterations.
}
}

\section{Standard Errors}{

\code{boottest} does not calculate standard errors.
}

\section{Stata, Julia and Python Implementations}{

The fast wild cluster bootstrap algorithms are further implemented in the
following software packages:
\itemize{
\item Stata:\href{https://github.com/droodman/boottest}{boottest}
\item Julia:\href{https://github.com/droodman/WildBootTests.jl}{WildBootTests.jl}
\item Python:\href{https://github.com/s3alfisc/wildboottest}{wildboottest}
}
}

\examples{
\dontrun{
  requireNamespace("lfe") 
  data(voters)
  felm_fit <- felm(proposition_vote ~ treatment + ideology1 + log_income |
    Q1_immigration,
  data = voters
  )
  boot1 <- boottest(felm_fit,
    B = 9999,
    param = "treatment",
    clustid = "group_id1"
  )
  boot2 <- boottest(felm_fit,
    B = 9999,
    param = "treatment",
    clustid = c("group_id1", "group_id2")
  )
  boot3 <- boottest(felm_fit,
    B = 9999,
    param = "treatment",
    clustid = c("group_id1", "group_id2"),
    fe = "Q1_immigration"
  )
  boot4 <- boottest(felm_fit,
    B = 999,
    param = "treatment",
    clustid = c("group_id1", "group_id2"),
    fe = "Q1_immigration",
    sign_level = 0.2,
    r = 2
  )
  # test treatment + ideology1 = 2
  boot5 <- boottest(felm_fit,
    B = 9999,
    clustid = c("group_id1", "group_id2"),
    param = c("treatment", "ideology1"),
    R = c(1, 1),
    r = 2
  )
  summary(boot1)
  print(boot1)
  plot(boot1)
  nobs(boot1)
  pval(boot1)
  confint(boot1)
  generics::tidy(boot1)
  
# run different bootstrap types following MacKinnon, Nielsen & Webb (2022):

# default: the fnw algorithm
boot_fnw11 <- boottest(lm_fit,
  B = 9999,
  param = "treatment",
  clustid = "group_id1", 
  bootstrap_type = "fnw11"
)

# WCR 31 
boot_WCR31 <- boottest(lm_fit,
  B = 9999,
  param = "treatment",
  clustid = "group_id1",
  bootstrap_type = "31"
)

# WCU33 
boot_WCR31 <- boottest(lm_fit,
  B = 9999,
  param = "treatment",
  clustid = "group_id1",
  bootstrap_type = "33", 
  impose_null = FALSE
)
}

}
\references{
Roodman et al., 2019, "Fast and wild: Bootstrap inference in
STATA using boottest", The STATA Journal.
(\url{https://ideas.repec.org/p/qed/wpaper/1406.html})

MacKinnon, James G., Morten Ørregaard Nielsen, and
Matthew D. Webb. Fast and reliable jackknife and bootstrap
methods for cluster-robust inference. No. 1485. 2022.

Cameron, A. Colin, Jonah B. Gelbach, and Douglas L. Miller.
"Bootstrap-based improvements for inference with clustered errors."
The Review of Economics and Statistics 90.3 (2008): 414-427.

Cameron, A.Colin & Douglas L. Miller.
"A practitioner's guide to cluster-robust inference"
Journal of Human Resources (2015) \doi{doi:10.3368/jhr.50.2.317}

Davidson & MacKinnon. "Wild Bootstrap Tests for IV regression"
Journal of Economics and Business Statistics (2010)
\doi{https://doi.org/10.1198/jbes.2009.07221}

MacKinnon, James G., and Matthew D. Webb.
"The wild bootstrap for few (treated) clusters.
" The Econometrics Journal 21.2 (2018): 114-135.

MacKinnon, James G., and Matthew D. Webb.
"Cluster-robust inference: A guide to empirical practice"
Journal of Econometrics (2022)
\doi{https://doi.org/10.1016/j.jeconom.2022.04.001}

MacKinnon, James. "Wild cluster bootstrap confidence intervals."
L'Actualite economique 91.1-2 (2015): 11-33.

Webb, Matthew D. Reworking wild bootstrap based inference for
clustered errors. No. 1315. Queen's Economics Department Working Paper,
2013.
}
