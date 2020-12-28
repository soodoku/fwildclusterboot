// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppEigen.h>
#include <Rcpp.h>

using namespace Rcpp;

// eigenMatMult
SEXP eigenMatMult(Eigen::MatrixXd A, Eigen::MatrixXd B);
RcppExport SEXP _fwildclusterboot_eigenMatMult(SEXP ASEXP, SEXP BSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Eigen::MatrixXd >::type A(ASEXP);
    Rcpp::traits::input_parameter< Eigen::MatrixXd >::type B(BSEXP);
    rcpp_result_gen = Rcpp::wrap(eigenMatMult(A, B));
    return rcpp_result_gen;
END_RCPP
}
// Rcpp_matrix_List_sum
NumericMatrix Rcpp_matrix_List_sum(List x);
RcppExport SEXP _fwildclusterboot_Rcpp_matrix_List_sum(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< List >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Rcpp_matrix_List_sum(x));
    return rcpp_result_gen;
END_RCPP
}
// naomit_cpp
NumericVector naomit_cpp(Rcpp::NumericVector x);
RcppExport SEXP _fwildclusterboot_naomit_cpp(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(naomit_cpp(x));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_fwildclusterboot_eigenMatMult", (DL_FUNC) &_fwildclusterboot_eigenMatMult, 2},
    {"_fwildclusterboot_Rcpp_matrix_List_sum", (DL_FUNC) &_fwildclusterboot_Rcpp_matrix_List_sum, 1},
    {"_fwildclusterboot_naomit_cpp", (DL_FUNC) &_fwildclusterboot_naomit_cpp, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_fwildclusterboot(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
