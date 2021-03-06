*CMZ :  1.00/00 16/12/94  17.00.00  by  Pavel Binko
*-- Author :    Volker Blobel   16/12/94
      SUBROUTINE FTITOH(IFMT,NFMT,IHFMT,IHF)
*
      INTEGER IFMT(*),IHFMT(64)
*
************************************************************************
*
*     Translate FormaT from Integer array TO Hollerith (integer)
*     ( takes about 25 mikro seconds )
*
************************************************************************
*
      CHARACTER*256 FMT, FM*1, CHJ(7)*1, CHB(3)*3,CHD(0:9)*1,DIG(12)*1
      CHARACTER*4 CHA
      DATA CHJ/'F','I','A','J','K','Z','C'/,CHB/'B16','B08','B32'/
      DATA CHD/'0','1','2','3','4','5','6','7','8','9'/
*
      FMT=' '
      NCH=LEN(FMT)
      J=IFMT(1)
*
*     special case: one descriptor only
      IF(NFMT.EQ.1.AND.J.GE.1.AND.J.LE.6) THEN
         FMT(1:1)=CHJ(J)
         IF(J.GE.3.AND.NCH.GE.3) THEN
            FMT(1:3)=CHB(J-3)
            NCH=3
         ELSE
            NCH=1
         END IF
         GOTO 100
      END IF
*
*     general case
      NCT=0
      DO 10 I=1,NFMT
      NR=IFMT(I)/10
      KF=IFMT(I)-10*NR
      IF(IFMT(I).EQ.0) THEN
         FM=')'
      ELSE
*        comma eventually
         IF(NCT.NE.0) THEN
            IF(FMT(NCT:NCT).NE.'(') THEN
               NCT=NCT+1
               FMT(NCT:NCT)=','
            END IF
         END IF
         IF(KF.EQ.0) THEN
            FM='('
         ELSE
            FM=CHJ(KF)
         END IF
         IF(NR.GT.1) THEN
*           convert number NR
            K=0
  11        K=K+1
            DIG(K)=CHD(MOD(NR,10))
            NR=NR/10
            IF(NR.NE.0) GOTO 11
            IF(NCT+K+1.GT.NCH) GOTO 90
*           store number
  12        NCT=NCT+1
            FMT(NCT:NCT)=DIG(K)
            K=K-1
            IF(K.GT.0) GOTO 12
         END IF
      END IF
*
*     store character
      NCT=NCT+1
      FMT(NCT:NCT)=FM
   10 CONTINUE
      NCH=NCT
      GOTO 100
*
*     error
   90 FMT='Error in format'
      NCH=MIN0(15,NCH)
*
*     convert to hollerith
   98 IHF=(NCH+3)/4
      DO 99 I=IHF
      CHA=FMT(4*I-3:4*I)
*KEEP,ICHCHA.
*     get hollerith 4H from char*4
#ifndef Linux
      ICH=IOR(ISHFT(ICHAR(CHA(1:1)),24),IOR(ISHFT(ICHAR(CHA(2:2)),16),
     +    IOR(ISHFT(ICHAR(CHA(3:3)), 8),ICHAR(          CHA(4:4)))))
#else /* Linux */
      ICH=IOR(ISHFT(ICHAR(CHA(4:4)),24),IOR(ISHFT(ICHAR(CHA(3:3)),16),
     +    IOR(ISHFT(ICHAR(CHA(2:2)), 8),ICHAR(          CHA(1:1)))))
#endif /* Linux */
*KEND.
   99 IHFMT(I)=ICH
*
  100 RETURN
      END
