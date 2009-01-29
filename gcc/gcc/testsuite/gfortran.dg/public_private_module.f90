! { dg-do compile }
! See PR fortran/36251.
module a
  implicit none
  integer :: i = 42
end module a

module b
  use a
  implicit none
  public a  ! { dg-warning "attribute applied to" }
end module b

module d
  use a
  implicit none
  private a  ! { dg-warning "attribute applied to" }
end module d
! { dg-final { cleanup-modules "a" } }
