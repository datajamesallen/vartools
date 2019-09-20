/* File: oofit.i */
%module oofit
%{
    #define SWIG_FILE_WITH_INIT
    #include "oofit.h"
    #include "levmar.h"
%}
#include "oofit.h"
#include "levmar.h"