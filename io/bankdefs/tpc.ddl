!-----------------------------------------------------------------------
!       BANKname BANKtype      ! Comments
 TABLE  TPC      B16   ! create write display delete ! BONUS event bank
!
!   ATTributes:
!   -----------
!COL ATT-name FMT Min    Max   ! Comments
!
  1  ID       I     0   65536  ! the address of the hit detector element
  2  TDC      I     0   65536  ! tdc information (channels)
  3  ADC      I     0   65536  ! adc information (channels)
!
!    RELations:
!    ----------
!COL RELname  RELtype INTbank  ! Comments
!                     (COL)
!
 END TABLE
!
