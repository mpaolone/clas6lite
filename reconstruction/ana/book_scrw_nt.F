      SUBROUTINE BOOK_SCRW_NT(NTID)
c
c_begin_doc
c  RCS ID string
c  $Id: book_scrw_nt.F,v 1.2 1997/09/10 16:23:45 stepanya Exp $
c
c  Documentation for subroutine BOOK_SCRW_NT.F
c
c  Purpose:
c  --------
c
c  Input Parameters: Non (Name - Type - Meaning)
c  ----------------
c
c  Output Parameters:Non  (Name - Type - Meaning)
c  -----------------
c
c  Other routines:
c  ---------------
c
c  Notes:
c  ------
c
c  Author:  S. Stepanyan       Created:  Fri Dec 20 11:12:59 EST 1996
c  -------
c
c  Major revisions:
c  ----------------
c     
c
c_end_doc
c
      IMPLICIT NONE
      SAVE
c
c_begin_inc
c  include files :
c  ---------------------
#include "scrw_nt.inc"
c_end_inc
c
c_begin_var
c  input/output variables:
c  -----------------------
c
c  Local pre-defined variables:
c  ---------------------------
c  RCS information: 
      CHARACTER*132  CFILE, CREVIS, CSTATE, CDATE, CAUTHO, CRCSID
      PARAMETER (CFILE = '$RCSfile: book_scrw_nt.F,v $')
      PARAMETER (CREVIS = '$Revision: 1.2 $')
      PARAMETER (CSTATE = '$State: Exp $')
      PARAMETER (CDATE = '$Date: 1997/09/10 16:23:45 $')
      PARAMETER (CAUTHO = '$Author: stepanya $')
      DATA CRCSID/   
     1'$Id: book_scrw_nt.F,v 1.2 1997/09/10 16:23:45 stepanya Exp $'   
     2/   
c  Module information:
      CHARACTER*(*)  CRNAME, CRAUTH
      CHARACTER*100  CRMESS
      PARAMETER (CRNAME='BOOK_SCRW_NT.F')
      PARAMETER (CRAUTH='Stepan Stepanyan')
c
c  Local User defined variables:
c  -----------------------------
      INTEGER NWRITE, NTID
c_end_var
c
c  executable code for routine BOOK_SCRW_NT.F:
c----6----------------------------------------------------------------72
c
      IF (NWRITE .LT. 1) THEN
        NWRITE = NWRITE + 1
        CRMESS='Booking a N-tuple for SC hits'
        CALL RECMES(CRNAME,'I',CRMESS)
      ENDIF
      CALL hbname(NTID,'schit',nschit,
     +'nschit[0,10]:I,scsect(nschit):I,schid(nschit):I,'//
     +'scpid(nschit):I,sct(nschit):R,sce(nschit):R,'//
     +'scx(nschit):R,scy(nschit):R,scz(nschit):R')
      RETURN
      END
c
c------------------------------------------------------------------------------




