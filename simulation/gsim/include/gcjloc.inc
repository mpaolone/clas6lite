c  from patch gcdes in file /usr/site3/cern/hp700_ux90/94a/src/car/geant321.car on Thu Nov 10 11:00:38 EST 1994
c  this is seq: GCJLOC
      COMMON/GCJLOC/NJLOC(2),JTM,JMA,JLOSS,JPROB,JMIXT,JPHOT,JANNI
     +                  ,JCOMP,JBREM,JPAIR,JDRAY,JPFIS,JMUNU,JRAYL
     +                  ,JMULOF,JCOEF,JRANG
C
      INTEGER       NJLOC   ,JTM,JMA,JLOSS,JPROB,JMIXT,JPHOT,JANNI
     +                  ,JCOMP,JBREM,JPAIR,JDRAY,JPFIS,JMUNU,JRAYL
     +                  ,JMULOF,JCOEF,JRANG
C
      COMMON/GCJLCK/NJLCK(2),JTCKOV,JABSCO,JEFFIC,JINDEX,JCURIN
     +                      ,JPOLAR,JTSTRA,JTSTCO,JTSTEN,JTASHO
C
      EQUIVALENCE (JLASTV,JTSTEN)
C
      INTEGER       NJLCK,JTCKOV,JABSCO,JEFFIC,JINDEX,JCURIN
     +                   ,JPOLAR,JLASTV,JTSTRA,JTSTCO,JTSTEN
     +                   ,JTASHO
C
