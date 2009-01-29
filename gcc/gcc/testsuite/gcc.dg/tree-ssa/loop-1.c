/* { dg-do compile } */
/* -mlongcall will cause us to place &foo in the CTR register.  */
/* { dg-skip-if "" { powerpc*-*-* } { "-mlongcall" } { "" } } */
/* { dg-options "-O1 -ftree-loop-ivcanon -funroll-loops -fdump-tree-ivcanon-details -fdump-tree-cunroll-details -fdump-tree-optimized" } */

/* On 31-bit S/390 the function address will be stored (once) in the literal pool,
   so scan-assembler-times "foo" will return 1 even if the loop is fully unrolled.
   -msmall-exec avoids this by enabling a call instruction with immediate operand.  */
/* { dg-options "-O1 -ftree-loop-ivcanon -funroll-loops -fdump-tree-ivcanon-details -fdump-tree-cunroll-details -fdump-tree-optimized -msmall-exec" { target s390-*-* } } */

/* On Darwin, we call extern functions via a stub in PIC mode which is default and
   the stub is named after the function.  To avoid this we use -static to go out
   of PIC mode.  */
/* { dg-options "-O1 -ftree-loop-ivcanon -funroll-loops -fdump-tree-ivcanon-details -fdump-tree-cunroll-details -fdump-tree-optimized -static" { target *-*-darwin* } } */

void xxx(void)
{
  int x = 45;

  while (x >>= 1)
    foo ();
}

/* We should be able to find out that the loop iterates four times and unroll it completely.  */

/* { dg-final { scan-tree-dump-times "Added canonical iv to loop 1, 4 iterations" 1 "ivcanon"} } */
/* { dg-final { cleanup-tree-dump "ivcanon" } } */
/* { dg-final { scan-tree-dump-times "Unrolled loop 1 completely" 1 "cunroll"} } */
/* { dg-final { cleanup-tree-dump "cunroll" } } */
/* { dg-final { scan-tree-dump-times "foo" 5 "optimized"} } */
/* { dg-final { cleanup-tree-dump "optimized" } } */

/* Because hppa, ia64 and Windows targets include an external declaration
   for foo as well as the calls we need to look for something more specific
   than just foo in order to count only the calls and not the declaration.  */
/* The SH targets always use separate instructions to load the address
   and to do the actual call - bsr is only generated by link time
   relaxation.  */
/* CRIS keeps the address in a register.  */
/* m68k sometimes puts the address in a register, depending on CPU and PIC.  */

/* { dg-final { scan-assembler-times "foo" 5 { xfail hppa*-*-* ia64*-*-* sh*-*-* cris-*-* crisv32-*-* fido-*-* m68k-*-* i?86-*-mingw* i?86-*-cygwin* } } } */
/* { dg-final { scan-assembler-times "foo,%r" 5 { target hppa*-*-* } } } */
/* { dg-final { scan-assembler-times "= foo"  5 { target ia64*-*-* } } } */
/* { dg-final { scan-assembler-times "call\[ \t\]*_foo" 5 { target i?86-*-mingw* i?86-*-cygwin* } } } */
/* { dg-final { scan-assembler-times "jsr|bsrf|blink\ttr?,r18"  5 { target sh*-*-* } } } */
/* { dg-final { scan-assembler-times "Jsr \\\$r" 5 { target cris-*-* } } } */
/* { dg-final { scan-assembler-times "\[jb\]sr" 5 { target fido-*-* m68k-*-* } } } */
