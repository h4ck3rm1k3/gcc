/* Test the `vreinterprets16_s8' ARM Neon intrinsic.  */
/* This file was autogenerated by neon-testgen.  */

/* { dg-do assemble } */
/* { dg-require-effective-target arm_neon_ok } */
/* { dg-options "-save-temps -O0 -mfpu=neon -mfloat-abi=softfp" } */

#include "arm_neon.h"

void test_vreinterprets16_s8 (void)
{
  int16x4_t out_int16x4_t;
  int8x8_t arg0_int8x8_t;

  out_int16x4_t = vreinterpret_s16_s8 (arg0_int8x8_t);
}

/* { dg-final { cleanup-saved-temps } } */
