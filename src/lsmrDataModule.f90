!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
! File lsmrDataModule.f90
!
! Defines integer(ip), real(dp)
! and a few constants for use in other modules.
!
! 24 Oct 2007: Allows floating-point precision dp to be defined
!              in exactly one place (here).  Note that we need
!                 use lsmrDataModule
!              at the beginning of modules AND inside interfaces.
!              zero and one are not currently used by LSMR,
!              but this shows how they should be declared
!              by a user routine that does need them.
! 16 Jul 2010: LSMR version derived from LSQR equivalent.
! 20 Sep 2012: ip and qp added for qLSQMR.
!              Explicit values are simpler than selected_*_kind!
! 26 Nov 2013: sp added for mm_ioModule and ReadMtxModule.
! 28 Jan 2014: Define all of ip, sp, dp, qp.
!              Define s,d,q versions of 1.0 and 0.0.
!              "done" would be dreadful, so now they are dpone, etc.
! 31 Jan 2014: Remove various versions of zero and one.
!              Other routines declare them locally as needed.
!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

module lsmrDataModule

  use iso_c_binding
  implicit none

  public

! intrinsic                   ::      selected_real_kind
! integer,  parameter, public :: dp = selected_real_kind(15)
! real(dp), parameter, public :: zero = 0.0_dp, one = 1.0_dp
! The above seems too obscure.

  integer(4),  parameter :: ip = 4
! integer(4),  parameter :: sp = 4
  integer(4),  parameter :: dp = 8
! integer(4),  parameter :: qp = 16
! real(sp),    parameter :: spzero = 0.0_sp, spone = 1.0_sp
! real(dp),    parameter :: dpzero = 0.0_dp, dpone = 1.0_dp
! real(qp),    parameter :: qpzero = 0.0_qp, qpone = 1.0_qp

contains
  subroutine fortran_open( funit, output, status ) bind (c, name="fortran_open")
    use iso_c_binding
    implicit none
    integer :: funit, status, i, nchars
    character(len=1,kind=C_CHAR) :: output(64)
    character(len=64) :: fname

    nchars = 64
    do i = 1, 64
      if (output(i) == C_NULL_CHAR) then
        nchars = i-1
        exit
      end if
    enddo
    fname = transfer(output(1:nchars), fname)

    open(funit, file = fname, status = 'UNKNOWN', ERR = 900)
    status = 0
    return
900 continue
    status = 1
    return
  end subroutine fortran_open

  subroutine fortran_close( funit, status ) bind (c, name="fortran_close")
    use iso_c_binding
    implicit none
    integer :: funit, status

    close(funit, ERR = 900)
    status = 0
    return
900 continue
    status = 1
    return
  end subroutine fortran_close

end module lsmrDataModule
