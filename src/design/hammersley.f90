subroutine hammersley ( dim_num, r )

!*****************************************************************************80
!
!! HAMMERSLEY computes the next element in a leaped Hammersley subsequence.
!
!  Discussion:
!
!    The DIM_NUM-dimensional Hammersley sequence is really DIM_NUM separate
!    sequences, each generated by a particular base.  If the base is
!    greater than 1, a standard 1-dimensional
!    van der Corput sequence is generated.  But if the base is
!    negative, this is a signal that the much simpler sequence J/(-BASE)
!    is to be generated.  For the standard Hammersley sequence, the
!    first spatial coordinate uses a base of (-N), and subsequent
!    coordinates use bases of successive primes (2, 3, 5, 7, 11, ...).
!    This program allows the user to specify any combination of bases,
!    included nonprimes and repeated values.
!
!    This routine selects elements of a "leaped" subsequence of the
!    Hammersley sequence.  The subsequence elements are indexed by a
!    quantity called STEP, which starts at 0.  The STEP-th subsequence
!    element is simply element
!
!      SEED(1:DIM_NUM) + STEP * LEAP(1:DIM_NUM)
!
!    of the original Hammersley sequence.
!
!
!    This routine "hides" a number of input arguments.  To specify these
!    arguments explicitly, use I4_TO_HAMMERSLEY instead.
!
!    All the arguments have default values.  However, if you want to
!    examine or change them, you may call the appropriate routine first.
!
!    * DIM_NUM, the spatial dimension,
!      Default: DIM_NUM = 1;
!      Required: 1 <= DIM_NUM is required.
!
!    * STEP, the subsequence index.
!      Default: STEP = 0.
!      Required: 0 <= STEP.
!
!    * SEED(1:DIM_NUM), the Hammersley sequence element for  STEP = 0.
!      Default SEED = (0, 0, ... 0).
!      Required: 0 <= SEED(1:DIM_NUM).
!
!    * LEAP(1:DIM_NUM), the succesive jumps in the sequence.
!      Default: LEAP = (1, 1, ..., 1).
!      Required: 1 <= LEAP(1:DIM_NUM).
!
!    * BASE(1:DIM_NUM), the bases.
!      Default: BASE = (2, 3, 5, 7, 11, ... ) or ( -N, 2, 3, 5, 7, 11,...)
!      if N is known.
!      Required: 0, 1 /= BASE(1:DIM_NUM).
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    04 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Reference:
!
!    J M Hammersley,
!    Monte Carlo methods for solving multivariable problems,
!    Proceedings of the New York Academy of Science,
!    Volume 86, 1960, pages 844-874.
!
!    Ladislav Kocis and William Whiten,
!    Computational Investigations of Low-Discrepancy Sequences,
!    ACM Transactions on Mathematical Software,
!    Volume 23, Number 2, 1997, pages 266-294.
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!
!    Output, real ( kind = 8 ) R(DIM_NUM), the next element of the
!    leaped Hammersley subsequence.
!
  implicit none

  integer ( kind = 4 ) dim_num

  integer ( kind = 4 ) base(dim_num)
  integer ( kind = 4 ) leap(dim_num)
  real ( kind = 8 ) r(dim_num)
  integer ( kind = 4 ) seed(dim_num)
  integer ( kind = 4 ) step
  integer ( kind = 4 ) value(1)

  value(1) = dim_num
  call hammersley_memory ( 'SET', 'DIM_NUM', 1, value )
  call hammersley_memory ( 'GET', 'STEP', 1, value )
  step = value(1)
  call hammersley_memory ( 'GET', 'SEED', dim_num, seed )
  call hammersley_memory ( 'GET', 'LEAP', dim_num, leap )
  call hammersley_memory ( 'GET', 'BASE', dim_num, base )

  call i4_to_hammersley ( dim_num, step, seed, leap, base, r )

  value(1) = 1
  call hammersley_memory ( 'INC', 'STEP', 1, value )

  return
end
function hammersley_base_check ( dim_num, base )

!*****************************************************************************80
!
!! HAMMERSLEY_BASE_CHECK checks BASE for a Hammersley sequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    16 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!
!    Input, integer ( kind = 4 ) BASE(DIM_NUM), the bases.
!
!    Output, logical, HAMMERSLEY_BASE_CHECK, is true if BASE is legal.
!
  implicit none

  integer ( kind = 4 ) dim_num

  integer ( kind = 4 ) base(dim_num)
  logical hammersley_base_check

  if ( any ( base(1:dim_num) == 0 ) .or. any ( base(1:dim_num) == 1 ) ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'HAMMERSLEY_BASE_CHECK - Fatal error!'
    write ( *, '(a)' ) '  Some entry of BASE is 0 or 1!'
    write ( *, '(a)' ) ' '
    call i4vec_transpose_print ( dim_num, base, 'BASE:  ' )
    hammersley_base_check = .false.
  else
    hammersley_base_check = .true.
  end if

  return
end
subroutine hammersley_base_get ( base )

!*****************************************************************************80
!
!! HAMMERSLEY_BASE_GET gets the base vector for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    16 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, integer ( kind = 4 ) BASE(DIM_NUM), the bases.
!
  implicit none

  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) base(*)
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)

  call hammersley_memory ( 'GET', 'BASE', dim_num, base )

  return
end
subroutine hammersley_base_set ( base )

!*****************************************************************************80
!
!! HAMMERSLEY_BASE_SET sets the base vector for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    16 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) BASE(DIM_NUM), the bases.
!
  implicit none

  integer ( kind = 4 ) base(*)
  logical hammersley_base_check
  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)

  if ( .not. hammersley_base_check ( dim_num, base ) ) then
    stop
  end if

  call hammersley_memory ( 'SET', 'BASE', dim_num, base )

  return
end
subroutine hammersley_leap_get ( leap )

!*****************************************************************************80
!
!! HAMMERSLEY_LEAP_GET gets the leap vector for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    16 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, integer ( kind = 4 ) LEAP(DIM_NUM), the successive jumps in
!    the sequence.
!
  implicit none

  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) leap(*)
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)

  call hammersley_memory ( 'GET', 'LEAP', dim_num, leap )

  return
end
subroutine hammersley_leap_set ( leap )

!*****************************************************************************80
!
!! HAMMERSLEY_LEAP_SET sets the leap vector for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    16 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) LEAP(DIM_NUM), the successive jumps in
!    the sequence.
!
  implicit none

  logical halham_leap_check
  integer ( kind = 4 ) leap(*)
  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)

  if ( .not. halham_leap_check ( dim_num, leap ) ) then
    stop
  end if

  call hammersley_memory ( 'SET', 'LEAP', dim_num, leap )

  return
end
subroutine hammersley_memory ( action, name, dim_num, value )

!*****************************************************************************80
!
!! HAMMERSLEY_MEMORY holds data associated with a leaped Hammersley subsequence.
!
!  Discussion:
!
!    If you're going to define a new problem, it's important that
!    you set the value of DIM_NUM before setting the values of BASE,
!    LEAP or SEED.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    04 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, character ( len = * ) ACTION, the desired action.
!    'GET' means get the value of a particular quantity.
!    'SET' means set the value of a particular quantity.
!    'INC' means increment the value of a particular quantity.
!          (Only SEED and STEP can be incremented.)
!
!    Input, character ( len = * ) NAME, the name of the quantity.
!    'BASE' means the base vector.
!    'LEAP' means the leap vector.
!    'DIM_NUM' means the spatial dimension.
!    'SEED' means the seed vector.
!    'STEP' means the step.
!
!    Input/output, integer ( kind = 4 ) DIM_NUM, the dimension of the quantity.
!    If ACTION is 'SET' and NAME is 'BASE', then DIM_NUM is input, and
!    is the number of entries in VALUE to be put into BASE.
!
!    Input/output, integer ( kind = 4 ) VALUE(DIM_NUM), contains a value.
!    If ACTION is 'SET', then on input, VALUE contains values to be assigned
!    to the internal variable.
!    If ACTION is 'GET', then on output, VALUE contains the values of
!    the specified internal variable.
!    If ACTION is 'INC', then on input, VALUE contains the increment to
!    be added to the specified internal variable.
!
  implicit none

  character ( len = * ) action
  integer ( kind = 4 ), allocatable, save, dimension ( : ) :: base
  logical, save :: first_call = .true.
  integer ( kind = 4 ) i
  integer ( kind = 4 ), allocatable, save, dimension ( : ) :: leap
  character ( len = * ) name
  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ), save :: dim_num_save = 0
  integer ( kind = 4 ) prime
  integer ( kind = 4 ), allocatable, save, dimension ( : ) :: seed
  integer ( kind = 4 ), save :: step = 0
  integer ( kind = 4 ) value(*)

  if ( first_call ) then
    dim_num_save = 1
    allocate ( base(dim_num_save) )
    allocate ( leap(dim_num_save) )
    allocate ( seed(dim_num_save) )
    base(1) = 2
    leap(1) = 1
    seed(1) = 0
    step = 0
    first_call = .false.
  end if
!
!  If this is a SET DIM_NUM call, and the input value of DIM_NUM
!  differs from the internal value, discard all old information.
!
  if ( action(1:1) == 'S' .or. action(1:1) == 's') then
    if ( name == 'DIM_NUM' .or. name == 'dim_num' ) then
      if ( dim_num_save /= value(1) ) then
        deallocate ( base )
        deallocate ( leap )
        deallocate ( seed )
        dim_num_save = value(1)
        allocate ( base(dim_num_save) )
        allocate ( leap(dim_num_save) )
        allocate ( seed(dim_num_save) )
        do i = 1, dim_num_save
          base(i) = prime ( i )
        end do
        leap(1:dim_num_save) = 1
        seed(1:dim_num_save) = 0
      end if
    end if
  end if
!
!  Set
!
  if ( action(1:1) == 'S' .or. action(1:1) == 's' ) then

    if ( name == 'BASE' .or. name == 'base' ) then

      if ( dim_num_save /= dim_num ) then
        write ( *, '(a)' ) ' '
        write ( *, '(a)' ) 'HAMMERSLEY_MEMORY - Fatal error!'
        write ( *, '(a)' ) '  Internal and input values of DIM_NUM disagree'
        write ( *, '(a)' ) '  while setting BASE.'
        stop
      end if

      base(1:dim_num) = value(1:dim_num)

    else if ( name == 'LEAP' .or. name == 'leap' ) then

      if ( dim_num_save /= dim_num ) then
        write ( *, '(a)' ) ' '
        write ( *, '(a)' ) 'HAMMERSLEY_MEMORY - Fatal error!'
        write ( *, '(a)' ) '  Internal and input values of DIM_NUM disagree'
        write ( *, '(a)' ) '  while setting LEAP.'
        stop
      end if

      leap(1:dim_num) = value(1:dim_num)

    else if ( name == 'DIM_NUM' .or. name == 'dim_num' ) then

      dim_num_save = value(1)

    else if ( name == 'SEED' .or. name == 'seed' ) then

      if ( dim_num_save /= dim_num ) then
        write ( *, '(a)' ) ' '
        write ( *, '(a)' ) 'HAMMERSLEY_MEMORY - Fatal error!'
        write ( *, '(a)' ) '  Internal and input values of DIM_NUM disagree'
        write ( *, '(a)' ) '  while setting SEED.'
        stop
      end if

      seed(1:dim_num) = value(1:dim_num)

    else if ( name == 'STEP' .or. name == 'step' ) then

      if ( value(1) < 0 ) then
        write ( *, '(a)' ) ' '
        write ( *, '(a)' ) 'HAMMERSLEY_MEMORY - Fatal error!'
        write ( *, '(a)' ) '  Input value of STEP < 0.'
        stop
      end if

      step = value(1)

    end if
!
!  Get
!
  else if ( action(1:1) == 'G' .or. action(1:1) == 'g' ) then

    if ( name == 'BASE' .or. name == 'base' ) then

      value(1:dim_num_save) = base(1:dim_num_save)

    else if ( name == 'LEAP' .or. name == 'leap' ) then

      value(1:dim_num_save) = leap(1:dim_num_save)

    else if ( name == 'DIM_NUM' .or. name == 'dim_num' ) then

      value(1) = dim_num_save

    else if ( name == 'SEED' .or. name == 'seed' ) then

      value(1:dim_num_save) = seed(1:dim_num_save)

    else if ( name == 'STEP' .or. name == 'step' ) then

      value(1) = step

    end if
!
!  Increment
!
  else if ( action(1:1) == 'I' .or. action(1:1) == 'i' ) then

    if ( name == 'SEED' .or. name == 'seed' ) then
      if ( dim_num == 1 ) then
        seed(1:dim_num_save) = seed(1:dim_num_save) + value(1)
      else
        seed(1:dim_num_save) = seed(1:dim_num_save) + value(1:dim_num_save)
      end if
    else if ( name == 'STEP' .or. name == 'step' ) then
      step = step + value(1)
    end if

  end if

  return
end
subroutine hammersley_dim_num_get ( dim_num )

!*****************************************************************************80
!
!! HAMMERSLEY_DIM_NUM_GET: spatial dimension, leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    28 August 2002
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!
  implicit none

  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)

  return
end
subroutine hammersley_dim_num_set ( dim_num )

!*****************************************************************************80
!
!! HAMMERSLEY_DIM_NUM_SET sets spatial dimension, leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    26 February 2001
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!    1 <= DIM_NUM is required.
!
  implicit none

  logical halham_dim_num_check
  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) value(1)

  if ( .not. halham_dim_num_check ( dim_num ) ) then
    stop
  end if

  value(1) = dim_num
  call hammersley_memory ( 'SET', 'DIM_NUM', 1, value )

  return
end
subroutine hammersley_seed_get ( seed )

!*****************************************************************************80
!
!! HAMMERSLEY_SEED_GET gets the seed vector for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    20 October 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, integer ( kind = 4 ) SEED(DIM_NUM), the Hammersley sequence
!    index corresponding to STEP = 0.
!
  implicit none

  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) seed(*)
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)
  call hammersley_memory ( 'GET', 'SEED', dim_num, seed )

  return
end
subroutine hammersley_seed_set ( seed )

!*****************************************************************************80
!
!! HAMMERSLEY_SEED_SET sets the seed vector for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    20 October 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) SEED(DIM_NUM), the Hammersley sequence index
!    corresponding to STEP = 0.
!
  implicit none

  logical halham_seed_check
  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) seed(*)
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'DIM_NUM', 1, value )
  dim_num = value(1)

  if ( .not. halham_seed_check ( dim_num, seed ) ) then
    stop
  end if

  call hammersley_memory ( 'SET', 'SEED', dim_num, seed )

  return
end
subroutine hammersley_sequence ( dim_num, n, r )

!*****************************************************************************80
!
!! HAMMERSLEY_SEQUENCE computes N elements of a leaped Hammersley subsequence.
!
!  Discussion:
!
!    The DIM_NUM-dimensional Hammersley sequence is really DIM_NUM separate
!    sequences, each generated by a particular base.  If the base is
!    greater than 1, a standard 1-dimensional
!    van der Corput sequence is generated.  But if the base is
!    negative, this is a signal that the much simpler sequence J/(-BASE)
!    is to be generated.  For the standard Hammersley sequence, the
!    first spatial coordinate uses a base of (-N), and subsequent
!    coordinates use bases of successive primes (2, 3, 5, 7, 11, ...).
!    This program allows the user to specify any combination of bases,
!    included nonprimes and repeated values.
!
!    This routine selects elements of a "leaped" subsequence of the
!    Hammersley sequence.  The subsequence elements are indexed by a
!    quantity called STEP, which starts at 0.  The STEP-th subsequence
!    element is simply element
!
!      SEED(1:DIM_NUM) + STEP * LEAP(1:DIM_NUM)
!
!    of the original Hammersley sequence.
!
!
!    This routine "hides" a number of input arguments.  To specify these
!    arguments explicitly, use I4_TO_HAMMERSLEY_SEQUENCE instead.
!
!    All the arguments have default values.  However, if you want to
!    examine or change them, you may call the appropriate routine first.
!
!    The arguments that the user may set include:
!
!    * DIM_NUM, the spatial dimension,
!      Default: DIM_NUM = 1;
!      Required: 1 <= DIM_NUM is required.
!
!    * STEP, the subsequence index.
!      Default: STEP = 0.
!      Required: 0 <= STEP.
!
!    * SEED(1:DIM_NUM), the sequence element corresponding to STEP = 0.
!      Default SEED = (0, 0, ... 0).
!      Required: 0 <= SEED(1:DIM_NUM).
!
!    * LEAP(1:DIM_NUM), the succesive jumps in the sequence.
!      Default: LEAP = (1, 1, ..., 1).
!      Required: 1 <= LEAP(1:DIM_NUM).
!
!    * BASE(1:DIM_NUM), the bases.
!      Default: BASE = (2, 3, 5, 7, 11, ... ) or ( -N, 2, 3, 5, 7, 11,...)
!      if N is known.
!      Required: 0, 1 /= BASE(1:DIM_NUM).
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    04 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Reference:
!
!    J M Hammersley,
!    Monte Carlo methods for solving multivariable problems,
!    Proceedings of the New York Academy of Science,
!    Volume 86, 1960, pages 844-874.
!
!    Ladislav Kocis and William Whiten,
!    Computational Investigations of Low-Discrepancy Sequences,
!    ACM Transactions on Mathematical Software,
!    Volume 23, Number 2, 1997, pages 266-294.
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!
!    Input, integer ( kind = 4 ) N, the number of elements desired.
!
!    Output, real ( kind = 8 ) R(DIM_NUM,N), the next N elements of the
!    leaped Hammersley subsequence.
!
  implicit none

  integer ( kind = 4 ) dim_num
  integer ( kind = 4 ) n

  integer ( kind = 4 ) base(dim_num)
  integer ( kind = 4 ) leap(dim_num)
  real ( kind = 8 ) r(dim_num,n)
  integer ( kind = 4 ) seed(dim_num)
  integer ( kind = 4 ) step
  integer ( kind = 4 ) value(1)
!f2py integer intent(in) :: dim_num
!f2py integer intent(in) :: n
!f2py real*8 intent(out),depend(dim_num,n),dimension(dim_num,n) :: r

  value(1) = dim_num
  call hammersley_memory ( 'SET', 'DIM_NUM', 1, value )
  call hammersley_memory ( 'GET', 'STEP', 1, value )
  step = value(1)
  call hammersley_memory ( 'GET', 'SEED', dim_num, seed )
  call hammersley_memory ( 'GET', 'LEAP', dim_num, leap )
  call hammersley_memory ( 'GET', 'BASE', dim_num, base )

  call i4_to_hammersley_sequence ( dim_num, n, step, seed, leap, base, r )

  value(1) = n
  call hammersley_memory ( 'INC', 'STEP', 1, value )

  return
end
subroutine hammersley_step_get ( step )

!*****************************************************************************80
!
!! HAMMERSLEY_STEP_GET gets the "step" for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    04 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, integer ( kind = 4 ) STEP, the index of the subsequence element.
!
  implicit none

  integer ( kind = 4 ) step
  integer ( kind = 4 ) value(1)

  call hammersley_memory ( 'GET', 'STEP', 1, value )
  step = value(1)

  return
end
subroutine hammersley_step_set ( step )

!*****************************************************************************80
!
!! HAMMERSLEY_STEP_SET sets the "step" for a leaped Hammersley subsequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    04 July 2004
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) STEP, the index of the subsequence element.
!    0 <= STEP is required.
!
  implicit none

  logical halham_step_check
  integer ( kind = 4 ) step
  integer ( kind = 4 ) value(1)

  if ( .not. halham_step_check ( step ) ) then
    stop
  end if

  value(1) = step
  call hammersley_memory ( 'SET', 'STEP', 1, value )

  return
end
subroutine i4_to_hammersley ( dim_num, step, seed, leap, base, r )

!*****************************************************************************80
!
!! I4_TO_HAMMERSLEY computes one element of a leaped Hammersley subsequence.
!
!  Discussion:
!
!    The DIM_NUM-dimensional Hammersley sequence is really DIM_NUM separate
!    sequences, each generated by a particular base.  If the base is
!    greater than 1, a standard 1-dimensional
!    van der Corput sequence is generated.  But if the base is
!    negative, this is a signal that the much simpler sequence J/(-BASE)
!    is to be generated.  For the standard Hammersley sequence, the
!    first spatial coordinate uses a base of (-N), and subsequent
!    coordinates use bases of successive primes (2, 3, 5, 7, 11, ...).
!    This program allows the user to specify any combination of bases,
!    included nonprimes and repeated values.
!
!    This routine selects elements of a "leaped" subsequence of the
!    Hammersley sequence.  The subsequence elements are indexed by a
!    quantity called STEP, which starts at 0.  The STEP-th subsequence
!    element is simply element
!
!      SEED(1:DIM_NUM) + STEP * LEAP(1:DIM_NUM)
!
!    of the original Hammersley sequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    20 October 2004
!
!  Author:
!
!    John Burkardt
!
!  Reference:
!
!    J M Hammersley,
!    Monte Carlo methods for solving multivariable problems,
!    Proceedings of the New York Academy of Science,
!    Volume 86, 1960, pages 844-874.
!
!    Ladislav Kocis and William Whiten,
!    Computational Investigations of Low-Discrepancy Sequences,
!    ACM Transactions on Mathematical Software,
!    Volume 23, Number 2, 1997, pages 266-294.
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!    1 <= DIM_NUM is required.
!
!    Input, integer ( kind = 4 ) STEP, the index of the subsequence element.
!    0 <= STEP is required.
!
!    Input, integer ( kind = 4 ) SEED(DIM_NUM), the sequence index corresponding
!    to STEP = 0.
!    0 <= SEED(1:DIM_NUM) is required.
!
!    Input, integer ( kind = 4 ) LEAP(DIM_NUM), the successive jumps in
!    the sequence.
!    1 <= LEAP(1:DIM_NUM) is required.
!
!    Input, integer ( kind = 4 ) BASE(DIM_NUM), the bases.
!
!    Output, real ( kind = 8 ) R(DIM_NUM), the STEP-th element of the leaped
!    Hammersley subsequence.
!
  implicit none

  integer ( kind = 4 ) dim_num

  integer ( kind = 4 ) base(dim_num)
  real ( kind = 8 ) base_inv
  integer ( kind = 4 ) digit
  real ( kind = 8 ) :: fiddle = 1.0D+00
  logical halham_leap_check
  logical halham_dim_num_check
  logical halham_seed_check
  logical halham_step_check
  logical hammersley_base_check
  integer ( kind = 4 ) i
  integer ( kind = 4 ) leap(dim_num)
  real ( kind = 8 ) r(dim_num)
  integer ( kind = 4 ) seed(dim_num)
  integer ( kind = 4 ) seed2
  integer ( kind = 4 ) step
!
!  Check the input.
!
  if ( .not. halham_dim_num_check ( dim_num ) ) then
    stop
  end if

  if ( .not. halham_step_check ( step ) ) then
    stop
  end if

  if ( .not. halham_seed_check ( dim_num, seed ) ) then
    stop
  end if

  if ( .not. halham_leap_check ( dim_num, leap ) ) then
    stop
  end if

  if ( .not. hammersley_base_check ( dim_num, base ) ) then
    stop
  end if
!
!  Calculate the data.
!
  do i = 1, dim_num

    if ( 1 < base(i) ) then

      seed2 = seed(i) + step * leap(i)

      r(i) = 0.0D+00

      base_inv = real ( 1.0D+00, kind = 8 ) / real ( base(i), kind = 8 )

      do while ( seed2 /= 0 )
        digit = mod ( seed2, base(i) )
        r(i) = r(i) + real ( digit, kind = 8 ) * base_inv
        base_inv = base_inv / real ( base(i), kind = 8 )
        seed2 = seed2 / base(i)
      end do
!
!  In the following computation, the value of FIDDLE can be:
!
!    0,   for the sequence 0/N, 1/N, ..., N-1/N
!    1,   for the sequence 1/N, 2/N, ..., N/N
!    1/2, for the sequence 1/(2N), 3/(2N), ..., (2*N-1)/(2N)
!
    else if ( base(i) <= -1 ) then

      seed2 = seed(i) + step * leap(i)

      seed2 = mod ( seed2, abs ( base(i) ) )

      r(i) = ( real ( seed2, kind = 8 ) + fiddle ) &
             / real ( -base(i), kind = 8 )

    end if

  end do

  return
end
subroutine i4_to_hammersley_sequence ( dim_num, n, step, seed, leap, base, r )

!*****************************************************************************80
!
!! I4_TO_HAMMERSLEY_SEQUENCE: N elements of a leaped Hammersley subsequence.
!
!  Discussion:
!
!    The DIM_NUM-dimensional Hammersley sequence is really DIM_NUM separate
!    sequences, each generated by a particular base.  If the base is
!    greater than 1, a standard 1-dimensional
!    van der Corput sequence is generated.  But if the base is
!    negative, this is a signal that the much simpler sequence J/(-BASE)
!    is to be generated.  For the standard Hammersley sequence, the
!    first spatial coordinate uses a base of (-N), and subsequent
!    coordinates use bases of successive primes (2, 3, 5, 7, 11, ...).
!    This program allows the user to specify any combination of bases,
!    included nonprimes and repeated values.
!
!    This routine selects elements of a "leaped" subsequence of the
!    Hammersley sequence.  The subsequence elements are indexed by a
!    quantity called STEP, which starts at 0.  The STEP-th subsequence
!    element is simply element
!
!      SEED(1:DIM_NUM) + STEP * LEAP(1:DIM_NUM)
!
!    of the original Hammersley sequence.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    20 October 2004
!
!  Author:
!
!    John Burkardt
!
!  Reference:
!
!    J M Hammersley,
!    Monte Carlo methods for solving multivariable problems,
!    Proceedings of the New York Academy of Science,
!    Volume 86, 1960, pages 844-874.
!
!    Ladislav Kocis and William Whiten,
!    Computational Investigations of Low-Discrepancy Sequences,
!    ACM Transactions on Mathematical Software,
!    Volume 23, Number 2, 1997, pages 266-294.
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) DIM_NUM, the spatial dimension.
!    1 <= DIM_NUM is required.
!
!    Input, integer ( kind = 4 ) N, the number of elements of the sequence.
!
!    Input, integer ( kind = 4 ) STEP, the index of the subsequence element.
!    0 <= STEP is required.
!
!    Input, integer ( kind = 4 ) SEED(DIM_NUM), the sequence index corresponding
!    to STEP = 0.
!
!    Input, integer ( kind = 4 ) LEAP(DIM_NUM), the succesive jumps in
!    the sequence.
!
!    Input, integer ( kind = 4 ) BASE(DIM_NUM), the bases.
!
!    Output, real ( kind = 8 ) R(DIM_NUM,N), the next N elements of the
!    leaped Hammersley subsequence, beginning with element STEP.
!
  implicit none

  integer ( kind = 4 ) n
  integer ( kind = 4 ) dim_num

  integer ( kind = 4 ) base(dim_num)
  real ( kind = 8 ) base_inv
  integer ( kind = 4 ) digit(n)
  real ( kind = 8 ) :: fiddle = 1.0D+00
  logical halham_leap_check
  logical halham_dim_num_check
  logical halham_seed_check
  logical halham_step_check
  logical hammersley_base_check
  integer ( kind = 4 ) i
  integer ( kind = 4 ) j
  integer ( kind = 4 ) leap(dim_num)
  real ( kind = 8 ) r(dim_num,n)
  integer ( kind = 4 ) seed(dim_num)
  integer ( kind = 4 ) seed2(n)
  integer ( kind = 4 ) step
!
!  Check the input.
!
  if ( .not. halham_dim_num_check ( dim_num ) ) then
    stop
  end if

  if ( .not. halham_step_check ( step ) ) then
    stop
  end if

  if ( .not. halham_seed_check ( dim_num, seed ) ) then
    stop
  end if

  if ( .not. halham_leap_check ( dim_num, leap ) ) then
    stop
  end if

  if ( .not. hammersley_base_check ( dim_num, base ) ) then
    stop
  end if
!
!  Calculate the data.
!
  do i = 1, dim_num

    if ( 1 < base(i) ) then

      do j = 1, n
        seed2(j) = seed(i) + ( step + j - 1 ) * leap(i)
      end do

      r(i,1:n) = 0.0D+00

      base_inv = real ( 1.0D+00, kind = 8 ) / real ( base(i), kind = 8 )

      do while ( any ( seed2(1:n) /= 0 ) )
        digit(1:n) = mod ( seed2(1:n), base(i) )
        r(i,1:n) = r(i,1:n) + real ( digit(1:n), kind = 8 ) * base_inv
        base_inv = base_inv / real ( base(i), kind = 8 )
        seed2(1:n) = seed2(1:n) / base(i)
      end do
!
!  In the following computation, the value of FIDDLE can be:
!
!    0,   for the sequence 0/N, 1/N, ..., N-1/N
!    1,   for the sequence 1/N, 2/N, ..., N/N
!    1/2, for the sequence 1/(2N), 3/(2N), ..., (2*N-1)/(2N)
!
    else if ( base(i) <= -1 ) then

      do j = 1, n
        seed2(j) = seed(i) + ( step + j - 1 ) * leap(i)
      end do

      seed2(1:n) = mod ( seed2(1:n), abs ( base(i) ) )

      r(i,1:n) = ( real ( seed2(1:n), kind = 8 ) + fiddle ) &
                 / real ( -base(i), kind = 8 )

    end if

  end do

  return
end