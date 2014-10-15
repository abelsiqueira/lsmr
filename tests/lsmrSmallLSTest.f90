module lsmrSmallLSTestModule
  use lsmrDataModule, only: ip, dp
  use lsmrModule,     only: LSMR

  implicit none
  public :: Aprod1, Aprod2
contains

  subroutine Aprod1(m,n,x,y)

    use   lsmrDataModule, only : ip, dp
    implicit none

    integer(ip),  intent(in)    :: m, n
    real(dp),     intent(in)    :: x(n)
    real(dp),     intent(inout) :: y(m)

    y(1) = y(1) + x(1)+x(2)
    y(2) = y(2) + x(1)
    y(3) = y(3) + x(2)

  end subroutine Aprod1

  subroutine Aprod2(m,n,x,y)

    use   lsmrDataModule, only : ip, dp
    implicit none

    integer(ip),  intent(in)    :: m, n
    real(dp),     intent(inout) :: x(n)
    real(dp),     intent(in)    :: y(m)

    x(1) = x(1) + y(1) + y(2)
    x(2) = x(2) + y(1) + y(3)

  end subroutine Aprod2
end module lsmrSmallLSTestModule

program lsmrSmallLSTest

  use   lsmrDataModule, only : ip, dp
  use   lsmrSmallLSTestModule
  implicit none

  intrinsic     :: date_and_time, cpu_time

  integer(ip)   :: ios,m,n,nbar,ndamp,nduplc,npower,nout
  integer(ip)   :: localSize
  real(dp)      :: time1, time2
  real(dp)      :: damp
  character(8)  :: date
  character(10) :: time
  character(80) :: output_file
  real(dp)      :: b(3), x(2)
  integer(ip)   :: istop, itn, itnlim
  real(dp)      :: atol, btol, conlim, normA, condA, normr, normAr, normx


  nout   = 10
  output_file = 'LSMR.txt'
  open(nout, file=output_file, status='unknown', iostat=ios)

  if (ios /= 0) then
    write(*,*)
    write(*,*) "Error opening file ", trim(output_file)
    stop
  end if

  call date_and_time( date, time )
  write(*,*)
  write(*,*) 'Date: ', date, '        Time: ', time
  call cpu_time( time1 )

  m = 3
  n = 2
  b(1) = 1
  b(2) = 1
  b(3) = 1
  damp = 0
  localSize = 0
  atol = 1e-12_dp
  btol = atol
  conlim = 1e+6_dp
  itnlim = 400

  call LSMR ( m, n, Aprod1, Aprod2, b, damp, &
    atol, btol, conlim, itnlim, localSize, nout, &
    x, istop, itn, normA, condA, normr, normAr, normx )

  close(nout)
  call cpu_time( time2 )

  write(*,'(a, f13.3)') " Total CPU time (seconds) ", time2-time1
  write(*,*) "Results are in output file   ", trim(output_file)
  write(*,*) "Search the file for 'appears'"
  write(*,*) "For example,    grep appears ", trim(output_file)
  write(*,*)
  write(*,*) "x = ", x

end program lsmrSmallLSTest
