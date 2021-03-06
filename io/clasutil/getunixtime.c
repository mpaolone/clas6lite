#include <time.h>
#include <stdio.h>

/**********************************************************
  Provides a FORTRAN wrapper for a call to get the ascii
  time string via the ctime functiom.


  to use:

  1)  compile this file:    $cc -c unixtime.c
  2)  link unixtime.o into your application
  3)  get the 32 bit "unix time"

        CALL GetUnixTime(timetp)

  where timetp is an INTEGER*32.

  4)      CALL GetASCIITime(timetp, timestr)

      where time is the 32 bit result of step 3, and
      timesstr is a CHARACTER*26 timestr

(of course, if timetp is from the Header bank, you can skip
step 3)

*********************************************************/

/****** getunixtime_ (FORTRAN WRAPPER) ********/

void getunixtime_(time_tp)

time_t *time_tp;

{
  time(time_tp);
}

/*-------- getasciitime -----------*/

void getasciitime(time_tp, timestr)

/* this will be called by the FORTRAN wrapper */

time_t    *time_tp;      /* 32 bit integer unix time */
char   *timestr;      /* should be at least 27 characters */

{
  char  *datestr;
  datestr = ctime(time_tp);
  strcpy(timestr, datestr);
}

/****** getasciitime_ (FORTRAN WRAPPER) ********/

void getasciitime_(time_tp, fstr, strlen)

int    *time_tp;      /* 32 bit integer unix time */
char   *fstr;      /* should be exactly 26 characters */

{
  int len;
  char  tstr[27];
  getasciitime(time_tp, tstr);
  len = (strlen < 26) ? strlen : 26;
  strncpy(fstr, tstr, len);
}







