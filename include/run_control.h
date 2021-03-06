/* This file generated by inc2h.pl on Wed Jul  7 12:47:00 EDT 1999 */

/* C representation of run_control common block */

/* MUST BE KEPT IN SYNCH WITH run_control.inc */

#define REC_STRING 1024
#define NCMD 20

/* run types */


typedef struct {

   double rnew_value;
   int nevt_to_process;
   int nevt_to_skip;
   int nrun_to_process;
   int nrun_to_skip;
   int nstamp;
   int lstat;
   int levent_class[21];
   int ltrk_do;
   int legn_do;
   int lcc_do;
   int ltof_do;
   int lst_do;
   int lusr0_do;
   int lusr1_do;
   int lusr2_do;
   int ltime_do;
   int ltagger_do;
   int lrf_do;
   int lreg1_do;
   int lic_do;
   int ldisplay;
   int levent_all;
   char fpk_file[1024];
   char tcl_init[1024];
   char rec_input[4096];
   char rec_output[1024];
   char arg_fpk_init[1024];
   char arg_rec_input[4096];
   char arg_rec_output[1024];
   char rec_prompt[1024];
   int lclose;
   int lcall_do;
   int lpause;
   int lexit;
   int lquit;
   int fstat;
   char fpk_cmd[NCMD][4096];
   int lnever_pause;
   int ldisplay_all;
   char ddl_file[1024];
   int ntcl_check;
   int lpause_exit;
   int itcl_catch;
   int leof;
   int lec1_do;
   int lbnkdmp;
   char cbname[4];
   int lpar;
   int lnamdmp;
   int levtdmp;
   int nrow_tcl;
   int ncol_tcl;
   int nrec_tcl;
   int lbnkedt;
   int ibos_array;
   int ncol_screen;
   int ifpack;
   int lseb_do;
   int mapmanager;
   int read_et;
   int number_events_read;
   int lhbid_do;
   int lexit_pend;
   char log_file_name[132];
   double rec_rate;
   char ipc_name[20];
   int lpid_make_trks;
   int start_tb;
   int ltbid_do;
   int lgpid_do;
   int ltbid_nost_do;
   int lpipltdc;
   int lgem_do;
   int lcc_eg4;
   int lsh_do;
} run_control_t;

extern run_control_t run_control_;



