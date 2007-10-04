! { dg-do run }
! PR33421 and PR33253 Weird quotation of namelist output of character arrays
! Test case from Toon Moone, adapted by Jerry DeLisle  <jvdelisle@gcc.gnu.org>

! Long names used to test line_buffer feature is working.

program test
implicit none
character(len=45) :: b01234567890123456789012345678901234567890123456789012345678901(3)
namelist /nam/ b01234567890123456789012345678901234567890123456789012345678901
b01234567890123456789012345678901234567890123456789012345678901 = 'x'
open(99)
write(99,'(4(a,/),a)') "&NAM", &
      " b01234567890123456789012345678901234567890123456789012345678901(1)=' AAP NOOT MIES WIM ZUS JET',", &
      " b01234567890123456789012345678901234567890123456789012345678901(2)='SURF.PRESSURE',", &
      " b01234567890123456789012345678901234567890123456789012345678901(3)='APEKOOL',", &
      " /"
rewind(99)
read(99,nml=nam)
close(99)

if (b01234567890123456789012345678901234567890123456789012345678901(1).ne.&
    " AAP NOOT MIES WIM ZUS JET                   ") call abort
if (b01234567890123456789012345678901234567890123456789012345678901(2).ne.&
    "SURF.PRESSURE                                ") call abort
if (b01234567890123456789012345678901234567890123456789012345678901(3).ne.&
    "APEKOOL                                      ") call abort
end program test

