// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// QRGibbsSim
NumericVector QRGibbsSim(NumericVector CountScore, NumericVector SizeScore, NumericVector CountList, NumericVector SizeList, int nSims, int CountVectorSize, int SizeVectorSize);
RcppExport SEXP _RemixAutoML_QRGibbsSim(SEXP CountScoreSEXP, SEXP SizeScoreSEXP, SEXP CountListSEXP, SEXP SizeListSEXP, SEXP nSimsSEXP, SEXP CountVectorSizeSEXP, SEXP SizeVectorSizeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type CountScore(CountScoreSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type SizeScore(SizeScoreSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type CountList(CountListSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type SizeList(SizeListSEXP);
    Rcpp::traits::input_parameter< int >::type nSims(nSimsSEXP);
    Rcpp::traits::input_parameter< int >::type CountVectorSize(CountVectorSizeSEXP);
    Rcpp::traits::input_parameter< int >::type SizeVectorSize(SizeVectorSizeSEXP);
    rcpp_result_gen = Rcpp::wrap(QRGibbsSim(CountScore, SizeScore, CountList, SizeList, nSims, CountVectorSize, SizeVectorSize));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_RemixAutoML_QRGibbsSim", (DL_FUNC) &_RemixAutoML_QRGibbsSim, 7},
    {NULL, NULL, 0}
};

RcppExport void R_init_RemixAutoML(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
