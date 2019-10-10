sub loadGold{
	my $di = '';
	open (F, "<$f") or die "can't open $f\n$!\n";
	{ local $/=undef;  $di=<F>; }
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
			#~ for my $i(keys %{$done{"true"}}){
				#~ for my $j (keys %{$done{"true"}}){
					#~ if(!defined $net{"true"}{$i}{$j}){
						#~ $net{"true"}{$i}{$j} = 0;
						#~ $cc0++;
					#~ }
				#~ }
			#~ }
	}
	elsif($case == 2){
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
		for my $i(keys %{$done{"true"}}){
			for my $j (keys %{$done{"true"}}){
				if(!defined $net{"true"}{$i}{$j}){
					$net{"true"}{$i}{$j} = 0;
					$cc0++;
				}
			}
		}
	}
	#~ @tf = keys %{$net{"true"}};
	@tf = sort keys %tfs;
	my $tmp = @tf;
	$TNG  = $cc0;
	print "           \t#TFs\tn\t#P\t#N\n";
	print "REFERENCE :\t$tmp\t$node\t$cc\t$cc0\n";
	$outtxttable .= "      \t#TFs\tn\t#P\t#N\n";
	$outtxttable .= "REFERENCE :\t$tmp\t$node\t$cc\t$cc0\n";
	$countgl[0] = $cc;
}
