      subroutine bos_cc

c_begin_doc

c  Documentation for subroutine bos_cc
c  $Id: bos_cc.F,v 1.7 2009/03/14 20:27:52 fklein Exp $

c  Purpose:
c  --------
c	cc bos output routine

c  Author:
c  -------
c     Alexander Vlassov

c  Major revisions:
c  ----------------
c     Elliott Wolin, College of William and Mary, 30-jun-95
c     Alexander Vlassov, Institute of Theoretical and Experimental
c     Physics, 30 - Jun - 95
c     Alexander Vlassov, Institute of Theoretical and Experimental
c     Physics, 03 - Oct - 95
c     Alexander Vlassov 12 - JUL - 1996
c     Alexander Vlassov 10 - OKT - 1996 
c     IADC is changed from N ph.e. to N channels (~ 160 /1ph.e.)
c     Alexander Vlassov 16 - APR - 1998
c     Only CCH bank is to be filled ( like CCH1 before) -
c     One bank per event (#0) 
c_end_doc


      implicit none
      character*(*) cfile,crevis,cstate,cdate,cautho,crname,crauth
      character*132 crcsid
      parameter (cfile=  '$RCSfile: bos_cc.F,v $')
      parameter (crevis= '$Revision: 1.7 $')
      parameter (cstate= '$State: Exp $')
      parameter (cdate=  '$Date: 2009/03/14 20:27:52 $')
      parameter (cautho= '$Author: fklein $')
      parameter (crname= 'BOS_CC')
      parameter (crauth= 'Alexander Vlassov')
      data crcsid/'
     1$Id: bos_cc.F,v 1.7 2009/03/14 20:27:52 fklein Exp $
     1 '/
      save

c  include files:
c  --------------
#include "gcbank.inc"
#include "bcs.inc"
#include "ccdig.inc"
#include "cccom.inc"
#include "gsimpar.inc"
#include "gsimcontrol.inc"
c_end_inc

c  local variables:
c   ----------------
      CHARACTER*100  CRMESS
      integer nhmax
      parameter (nhmax=120)
c
      integer i, j, k, nw, icc, iseg, isect
      integer mbank
      integer itbos(6)
      integer*2 iwbos(nhmax,6)
      real s, x_mean, sigma, ggauss, SPE_SIGMA
c
      data SPE_SIGMA /100./
c
c_end_var
c
c  executable code:
c  ----------------
c
c  filling BOS bank 'CC  '
c
      if(.not.nodata(cc)) then
c
        call vzero(itbos,6)
c
        do isect = 1,6
          do i = 1 , n_hits_CC
            if(n_SECT_CC(i).eq.isect) then
              itbos(isect) = itbos(isect) + 1
              k = 3 * (itbos(isect) - 1)
              if(k.gt.nhmax-3) then
                write(CRMESS,*) ' More than ',nhmax,
     &          ' words for hits in sector',isect
                call recmes(CRNAME,'I',CRMESS)
                go to 10
              end if 
c
              j = n_CC_hit (i)
              iseg = iabs(j)
C------ Right - Left section #
              if(j.lt.0) then
                iwbos(k+1,isect) = 2*iseg - 1
              else
                iwbos(k+1,isect) = 2*iseg
              end if
C------ CC number 1-36 odd /even : left - right
c
              iwbos(k+2,isect) = I_TDC_CC(i)
              s = I_ADC_CC(i)
              x_mean = s * opheamp(isect,iseg)
              sigma  = sqrt(s) * SPE_SIGMA
              s = ggauss(x_mean,sigma)
c** it was ***              iwbos(k+3,isect) = I_ADC_CC(i)
              iwbos(k+3,isect) = int(s + 0.5)
              if(iwbos(k+3,isect).le.0) iwbos(k+3,isect) = 0
c
            end if
   10       continue
          end do
        end do
c
        do isect = 1, 6
          if(itbos(isect).ge.1) then
            icc = mbank(iw,'CC  ',isect,3,itbos(isect))
            if(icc.eq.0) then
              write(CRMESS,*) ' Can not access to bank CC !!!'
              call recmes(CRNAME,'E',CRMESS)
            end if
            j = 2*icc
            do k = 1, 3*itbos(isect)
              iw16(j+k) = iwbos(k,isect) 
            end do 
          end if
        end do
c
      end if
c     =============================================
c
      if(.not.nomcdata(cc)) then
c
c  filling BOS bank 'CCH ' 
c
        nw = 0
        if(jhtrk.ge.1) then    ! ONE track at least
          do i = 1,jhtrk       ! track loop
            if(nw.ge.(mbos_cch - 12)) go to 33   !  CCH bank is full !
            jhit_cc(nw+1) = itrk_num(i)
            jhit_cc(nw+2) = idh_prt(i)
            jhit_cc(nw+3) = ihitrk (i)
            jhit_cc(nw+4) = itrsect(i)
            jhit_cc(nw+5) = itrsegm(i)
            xhit_cc(nw+6) = ph_tot (i)
            call ucopy(xenter(1,i),xhit_cc(nw+7),3)
            call ucopy(xexit (1,i),xhit_cc(nw+10),3)
            nw = nw + 12
          end do
c
 33       continue            
          if(nw.gt.0)then
            k = nw/12
            icc=mbank(iw,'CCH ',0,12,k)
            if(icc.eq.0) then
              write(CRMESS,*) ' Can not create to bank CCH  !!!'
              call recmes(CRNAME,'E',CRMESS)
            end if
            call ucopy(jhit_cc,IW(icc+1),nw)
          end if
        end if 
      end if   
      return
      end

c------------------------------------------------------------------------
