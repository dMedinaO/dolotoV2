#!/usr/bin/perl
$| = 1;
use strict;
#~ use warnings;

my $f = '';#DREAM5_NetworkInference_GoldStandard_Network3.tsv
my $ff = '';#DREAM5_NetworkInference_inferred_Network3.tsv
my $threshold = 0;
my $case = 2;
my $folder = '.';
my $outfile = 'outfile.txt';
my $fg = '';
my $ffg = '';
my $id = '';


my %net = ();#tf->gene
%{$net{"true"}} = ();#tf->gene 1, 0 else
%{$net{"pred"}} = ();#p(tf->gene)>threshold 1, 0 else
my %inDegree = ();#indegree
%{$inDegree{"true"}} = ();
%{$inDegree{"pred"}} = ();
my %outDegree = ();#outdegree
%{$outDegree{"true"}} = ();
%{$outDegree{"pred"}} = ();
my @tf = ();#true TFs
my @tf0 = ();#pred TFs
my %tfall= ();#all TFs
my %nodeall= ();#all TFs
my $TNG = 0;
my %done = ();#all nodes
%{$done{"true"}} = ();
%{$done{"pred"}} = ();
my $node = 0;
my %res = ();#motives
%{$res{"true"}} = ();
%{$res{"pred"}} = ();
%{$res{"mot"}} = ();
%{$res{"motNode"}} = ();
@{$res{"gm"}} = (0,0,0,0,0);#global motives
@{$res{"global"}} = (0,0,0,0);#single edge res
my @countgl = (0,0);
my %countt = ();#motive counts
my %countp = ();
my %countlist = ();#to store lists of graphlets TP, FP and FN
my %outnet = ();
my %outnetnodes = ();

my $colorTFTP = '#ff6f00';
my $colorTFFN = '#bf008f';
my $colorTFFP = '#ffb300';

my $colorEFTP = '#0276cf';
my $colorEFFN = '#3b3176';
my $colorEFFP = '#ffffff';


my $coloredgeTP = '#000000';
my $coloredgeFN = '#bf008f';
my $coloredgeFP = '#ffb300';

my $outtxt = '';
my $outtxttable = '';

for my $i(0..12){
	$countt{$i} = 0;
	$countp{$i} = 0;
	%{$res{"mot"}{$i}} = ("TP",0,"FP",0,"TN",0,"FN",0);
}

sub getopt{
	my $usage = "
	runit options
	-g file\t: reference file (tsv TF\\tGENE\\t1)
	-i file\t: input file (tsv TF\\tGENE\\t1)
	-t num\t: threshold to consider an edge in input file as existing (default 0)
	-c num\t: case 1 (ref and input contain all TP and TN, only those interactions in ref are considered)
			 case 2 (ref and input contain only all TP, negatives are assumed to happen among all nodes without a true between them, default)
	-f folder\t: folder where the output file will be placed
	-o name\t: name of output file

	-h||--help : print help

";
	while(@ARGV){
		if($ARGV[0] eq '-g'){
			$f = $ARGV[1];
			shift @ARGV;
			shift @ARGV;
		}
		if($ARGV[0] eq '-i'){
			$ff = $ARGV[1];
			shift @ARGV;
			shift @ARGV;
		}
		if($ARGV[0] eq '-t'){
			$threshold = $ARGV[1];
			shift @ARGV;
			shift @ARGV;
		}
		if($ARGV[0] eq '-c'){
			$case = $ARGV[1];
			shift @ARGV;
			shift @ARGV;
		}
		if($ARGV[0] eq '-f'){
			$folder = $ARGV[1];
			shift @ARGV;
			shift @ARGV;
		}
		if($ARGV[0] eq '-o'){
			$outfile = $ARGV[1];
			shift @ARGV;
			shift @ARGV;
		}
		if($ARGV[0] eq '-h' || $ARGV[0] eq '--help'){
			die $usage;
		}
	}

	#~ if($f eq '' || $ff eq ''){
	if($f eq ''){
		die $usage;
	}
	elsif($case != 1 && $case != 2){
		die $usage;
	}
	else{
		my @tfg = split('/',$f);
		$fg = $tfg[$#tfg];
		@tfg = split('/',$ff);
		$ffg = $tfg[$#tfg];
		#~ print "\nGOLD       \t:\t$f\nINPUT      \t:\t$ff\nThreshold\t:\t$threshold\nCase       \t:\t$case\n\n";
		print "\nREFERENCE       \t:\t$fg\nINPUT            \t:\t$ffg\nThreshold        \t:\t$threshold\nCase             \t:\t$case\n\n";
		$outtxttable .= "\nREFERENCE       \t:\t$fg\nINPUT            \t:\t$ffg\nThreshold        \t:\t$threshold\nCase            \t:\t$case\n\n";
		print "Print David ffg $ffg\n";
		print "Print David fg $fg\n";
		if($ff ne ''){
			$id = "$fg\_$ffg";
			print "Print David id if $id\n";
		}
		else{
			$id = "$fg";
			print "Print David id else $id\n";
		}

		print "Print David id $id\n";
	}
}

sub loadGold{
	my $di = '';
	open (F, "<$f") or die "can't open $f\n$!\n";
	{ local $/=undef;  $di=<F>;}
	my @d=split /[\r\n]+/, $di;
	close F;

	my $cc = 0;
	my $cc0 = 0;
	my @nodes = ();
	my %tfs = ();

	if($case == 1){
	  while(@d){
	    if($d[0] =~ /\t/){
	      my @t =  split("\t",shift @d);
	      $tfs{$t[0]} = 1;
	      $tfall{$t[0]} = 1;
	      $nodeall{$t[0]} = 1;
	      $nodeall{$t[1]} = 1;
	      if($t[2] > $threshold){
	        $net{"true"}{$t[0]}{$t[1]} = 1;
	        $outnet{$t[0]}{$t[1]}[0] = 'P';
	        $outnet{$t[0]}{$t[1]}[1] = 'A';
	        if(!defined $outnetnodes{$t[0]}){
	          $outnetnodes{$t[0]}[0] = 'TF';
	        }
	        elsif($outnetnodes{$t[0]}[0] ne 'TF'){
	          $outnetnodes{$t[0]}[0] = 'TF';
	        }
	        if(!defined $outnetnodes{$t[1]}){
	          $outnetnodes{$t[1]}[0] = 'nTF';
	        }
	        $outnetnodes{$t[0]}[1] = 'P';
	        $outnetnodes{$t[1]}[1] = 'P';
	        $res{"motNode"}{$t[0]}{"true"} = {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0};
	        $res{"motNode"}{$t[1]}{"true"} = {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0};
	        $cc++;
	        if(!defined $inDegree{"true"}{$t[1]}){
	          @{$inDegree{"true"}{$t[1]}} = ();
	        }
	        if(!defined $outDegree{"true"}{$t[0]}){
	          @{$outDegree{"true"}{$t[0]}} = ();
	          #~ push (@tf,$t[0]);
	        }
	        push (@{$outDegree{"true"}{$t[0]}},$t[1]);
	        push (@{$inDegree{"true"}{$t[1]}},$t[0]);
	      }
	      else{
	        $net{"true"}{$t[0]}{$t[1]} = 0;
	        $cc0++;
	      }
	      if(!defined $done{"true"}{$t[0]}){
	        $node++;
	        $done{"true"}{$t[0]} = $t[0] ;
	      }
	      if(!defined $done{"true"}{$t[1]}){
	        $node++;
	        $done{"true"}{$t[1]} = $t[1] ;
	      }
	    }
	    else{
	      shift @d;
	    }
	  }
	}
	
}


getopt();
loadGold();
