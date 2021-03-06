#!/apps/bin/perl

# This is a perl library to be used for the CLAS cooking scripts
#
# by: Simeon McAleer
#        Florida State University
#        March 5, 1999

CONFIG:{
    package RunG8_mon;
}

sub RunG8_mon {

# Runs the monitoring program photon_mon. It parses the output
# text file for important database information.
#
# Usage: RunPhoton_mon($files, $Outpath, $db_file, $basename, $db_mysql)
#
# Inputs: $files          = List of files to be processed
#         $Outpath        = Path where the ouput file should be copied
#         $db_file        = Database file including path
#         $basename       = Basename for output files
#         $db_mysql      = Flag to use the MYSQL db instead of the perl db.
    
    require "ctime.pl";
    $perl_lib = "$ENV{'CLAS_SCRIPTS'}";
    require "$perl_lib/MoveFile.pl";

    local($t) = time();
    local($start_time) = &ctime($t);
    local($end_time);
    
    local($files)   = $_[0];
    local($OutPath) = $_[1];
    local($db_file) = $_[2];
    local($basename) = $_[3];
    local($dispatcher) = $_[4];
    local($db_mysql) = $_[5];

    local($os) = $ENV{"OSNAME"};
    local($clas_bin) = $ENV{"CLAS_BIN"};

    if ($clas_bin eq "") {
	$clas_bin = "/group/clasdev/clas/src/prod-1-5/bin/$os/";
    }

    if ($dispatcher){
	$photon_cmd = "$clas_bin/g8_mon -R -D -P -i -vm ";
    } else{
	$photon_cmd = "$clas_bin/g8_mon -R -P -i -vm ";
    }

# MYSQL db info is stored using the -z flag
    if($db_mysql) {
      $photon_cmd .= " -z ";
    }

    $photon_cmd .= " -og8m$basename.hbook $files";

    print  "\n$0 EXECUTE: $photon_cmd at $start_time\n";

    system($photon_cmd);

    if (!$db_mysql) {
      dbmopen(%RUN,$db_file, 0644) || print  "$0: Could not open $db_file for offline db\n";

      $RUN{"g8_mon_cmd"} = $photon_cmd;

      dbmclose(%RUN);
    }
#    MoveFile("g8m*txt", $OutPath, "g8_mon text file", $db_file);
    MoveFile("g8m*hbook", $OutPath, "g8_mon histo file", $db_file);

    $t = time();
    $end_time = &ctime($t);
    
    print "\n$0 FINISHED: $photon_cmd at $end_time\n";

    print "\n\n";

}

1;

sub DO_IT {

    $sth = $dbh->prepare($sql)
        or die "Can't prepare $sql: $dbh->errstr\n";

    $rv = $sth->execute
        or die "Can't execute the query $sql\n error: $sth->errstr\n";

    return 0;
}
