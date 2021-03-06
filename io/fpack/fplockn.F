*CMZ :  1.00/00 16/12/94  17.00.00  by  Pavel Binko
*-- Author :    Zbigniew Szkutnik   16/12/94
      SUBROUTINE FPLOCKN(KEYWORD,MODE,IRET)
*
************************************************************************
*
*     An interface to C-routine cploc which sets/releases a lock
*     on a remote file for MODE=1/0. The action is taken for the
*     current F-pack output file. IRET=0/1 means success/failure.
*
************************************************************************
*
*KEEP,FCOMMON.
#ifndef Linux
*     IEEE format
      PARAMETER (LOCAL=1)
#else /* Linux */
*     DEC format (little-endian IEEE)
      PARAMETER (LOCAL=4)
#endif /* Linux */
*     Number of units
      PARAMETER (NUNITS=30)
*     The first possible free logical unit number
      PARAMETER (NFREEU=11)
*     Length of the integer vector IOPEN (for open and close)
      PARAMETER (IOPMAX=30)
*     Length of the integer vector LUNPAR (for statistics and inquire)
      PARAMETER (ILPMAX=30)
*     Length of the integer vector LISTI (file attributes)
      PARAMETER (ILIMAX=5)
*     length of different unit-information
      PARAMETER (NOPEN=50,NLGEN=15,NLSTU=25,NLSTA=10,NLKEY=11,NLHDR=70)
*     offset of different unit-information
      PARAMETER (ISGEN=NOPEN)
      PARAMETER (IRSTU=NOPEN+NLGEN,
     +           IRSTA=NOPEN+NLGEN+NLSTU,
     +           IRKEY=NOPEN+NLGEN+NLSTU+NLSTA,
     +           IRHDR=NOPEN+NLGEN+NLSTU+NLSTA+NLKEY,
     +           IWSTU=NOPEN+NLGEN+NLSTU+NLSTA+NLKEY+NLHDR)
      PARAMETER (IWSTA=IWSTU+NLSTU,
     +           IWKEY=IWSTU+NLSTU+NLSTA,
     +           IWHDR=IWSTU+NLSTU+NLSTA+NLKEY,
     +           NLDIM=IWSTU+NLSTU+NLSTA+NLKEY+NLHDR)
      COMMON/FUCOM/LUNW,LUNR,LW,LR,INDW,INDR,LUND,IVL(NUNITS),
     +             LUNIT(99),LUNBK(NUNITS),INFU(NLDIM,NUNITS),
     +             INFMT(200),IFMT(200),NFMT,
     +             NAMEB1,NAMEB2,NFMTB,IFMTB(200),NFMTH,IFMTH(64)
*     NAMEB1=  first part of BOSname
*     NAMEB2= second part of BOSname
*     IFMTB(1) ... IFMTB(NFMTB) = integer format information
*     IFMTH(1) ... IFMTH(NFMTH) = hollerith format information
      CHARACTER  FILNAM*256,HOSNAM*127,DATNAM*16,GENNAM*256,VOLNAM*6
      COMMON/DBCHOM/FILNAM(NUNITS),HOSNAM(NUNITS),DATNAM(NUNITS)
     +,             GENNAM(NUNITS),VOLNAM(NUNITS)
*     name of the data file
      CHARACTER*256 DTFLNM(NUNITS),RLFLNM(NUNITS)
*     host name for the data file
      CHARACTER*127 DTFLHO(NUNITS),RLFLHO(NUNITS)
*     MeDia type for the DaTa FiLe
      CHARACTER*16  DTFLMD(NUNITS),RLFLMD(NUNITS)
*     CuRrent data NaMe in DaTa file (it's used by index files)
      INTEGER     DTCRNM(2,NUNITS)
*     CuRrent Run Number in DaTa file (it's used by index files)
      INTEGER     DTCRRN(NUNITS)
*     volume name of cartridge for the data file
      CHARACTER*127 DTFLVS(NUNITS)
*     key block in data file
      INTEGER DTFLKB(NUNITS)
*     key position in data file block
      INTEGER DTFLPS(NUNITS)
*     index type
      LOGICAL IDXNEW
      COMMON/DBCHC1/DTFLNM,DTFLHO,DTFLMD,DTFLVS
     +,             RLFLNM,RLFLHO,RLFLMD
      COMMON/DBCHC2/DTFLKB,DTFLPS,DTCRNM,DTCRRN
      COMMON/DBCHC3/IDXNEW
      SAVE/FUCOM/,/DBCHOM/,/DBCHC1/,/DBCHC2/,/DBCHC3/
*KEND.
      INTEGER STREAM,CLIENT
      PARAMETER(MAXMAL=20)
      CHARACTER*(*) KEYWORD
      INTEGER*2 STRLEN
      COMMON/LOCKSTAT/LOCKFLAG
      IF(LW.EQ.0) THEN
        IRET = 1
        RETURN
      ENDIF
      STREAM=INFU(8,LW)
      CLIENT=INFU(9,LW)
      IF(CLIENT.LT.0) THEN
*       network channel is dead, try to recover
        CALL FNRES(CLIENT,STREAM,1,IRET)
        IF(IRET.NE.0) THEN
*         reconnect failed
          IRET=2
          RETURN
        END IF
      END IF
      DO 10 I=1,MAXMAL
      STRLEN=LENB(KEYWORD)
  1   CALL CPLOC(KEYWORD(1:STRLEN),MODE,CLIENT,STREAM,IRET,STRLEN)
      IF(IRET.EQ.-1) THEN
*        network channel is dead, try to recover
         CALL FNRES(CLIENT,STREAM,1,IRET)
         IF(IRET.EQ.0) THEN
*          reconnect successful
           GO TO 1
         ELSE
           IRET=2
           RETURN
         END IF
      END IF
      IF(IRET.EQ.0) THEN
*       set flag used in the recovery procedure
        IF(MODE.EQ.1) THEN
          LOCKFLAG=1
        ELSE
          LOCKFLAG=0
        END IF
      END IF
      IF(IRET.EQ.0.OR.I.EQ.MAXMAL) RETURN
*     just wait I seconds
      CALL FPWAIT(I)
  10  CONTINUE
      IRET=1
*
      RETURN
      END
