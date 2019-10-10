sub findMotives_edgeres{
	my $count = 0;
	my %donegraphpred = ();
	for my $i(@tf0){#tfs in ture

		for my $l (keys %{$done{"pred"}}){
			for my $j (@{$outDegree{"pred"}{$i}}){
				if(defined $net{"pred"}{$i}{$l} && defined $net{"pred"}{$j}{$l} && defined $net{"pred"}{$l}{$j} && defined $net{"pred"}{$j}{$i} && defined $net{"pred"}{$l}{$i}){
					my (@tmp) = dotriplet_noij($net{"pred"}{$i}{$l}, $net{"pred"}{$j}{$l}, $net{"pred"}{$l}{$j}, $net{"pred"}{$j}{$i}, $net{"pred"}{$l}{$i}, $i, $j, $l);

					if($tmp[1] && !exists $donegraphpred{"$tmp[1] $tmp[2] $tmp[3]"}){

						$donegraphpred{"$tmp[1] $tmp[2] $tmp[3]"} = $tmp[0];
						$donegraphpred{"$tmp[1] $tmp[3] $tmp[2]"} = $tmp[0];
						$donegraphpred{"$tmp[2] $tmp[1] $tmp[3]"} = $tmp[0];
						$donegraphpred{"$tmp[2] $tmp[3] $tmp[1]"} = $tmp[0];
						$donegraphpred{"$tmp[3] $tmp[1] $tmp[2]"} = $tmp[0];
						$donegraphpred{"$tmp[3] $tmp[2] $tmp[1]"} = $tmp[0];
						$res{"motNode"}{$tmp[1]}{"pred"}{$tmp[0]}++;
						$res{"motNode"}{$tmp[2]}{"pred"}{$tmp[0]}++;
						$res{"motNode"}{$tmp[3]}{"pred"}{$tmp[0]}++;
						$res{"motNode"}{$tmp[1]}{"pred"}{"tot"}++;
						$res{"motNode"}{$tmp[2]}{"pred"}{"tot"}++;
						$res{"motNode"}{$tmp[3]}{"pred"}{"tot"}++;
						$countp{$tmp[0]}++;
						$res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[2] $tmp[3]"} = 1;
					}
					$count++;
				}
			}
			if(defined $net{"true"}{$i}{$l}){
				if(defined $net{"pred"}{$i}{$l}){
					if($net{"true"}{$i}{$l} == 0 && $net{"pred"}{$i}{$l} == 0){
						$res{"global"}[2]++;#tn
					}
					elsif($net{"true"}{$i}{$l} == 0 && $net{"pred"}{$i}{$l} == 1){
						$res{"global"}[1]++;#fp
					}
					elsif($net{"true"}{$i}{$l} == 1 && $net{"pred"}{$i}{$l} == 0){
						$res{"global"}[3]++;#fn
					}
					elsif($net{"true"}{$i}{$l} == 1 && $net{"pred"}{$i}{$l} == 1){
						$res{"global"}[0]++;#tp
					}
				}
				else{
					if($net{"true"}{$i}{$l} == 0){
						$res{"global"}[2]++;#tn
					}
					elsif($net{"true"}{$i}{$l} == 1){
						$res{"global"}[3]++;#fn
					}
				}
			}
			elsif(defined $net{"pred"}{$i}{$l}){
				if($net{"pred"}{$i}{$l} == 0){
					$res{"global"}[2]++;#tn
				}
				elsif($net{"pred"}{$i}{$l} == 1){
					$res{"global"}[1]++;#fp
				}
			}

		}
	}
	$count = 0;
	my %donegraph = ();
	for my $i(@tf){#tfs in gold
		for my $l (keys %{$done{"true"}}){
			for my $j (@{$outDegree{"true"}{$i}}){
				if(defined$net{"true"}{$i}{$l} && defined$net{"true"}{$j}{$l} && defined$net{"true"}{$l}{$j} && defined$net{"true"}{$j}{$i} && defined$net{"true"}{$l}{$i}){
					my (@tmp) = dotriplet_noij($net{"true"}{$i}{$l}, $net{"true"}{$j}{$l}, $net{"true"}{$l}{$j}, $net{"true"}{$j}{$i}, $net{"true"}{$l}{$i}, $i, $j, $l);

					if($tmp[1] && !exists $donegraph{"$tmp[1] $tmp[2] $tmp[3]"}){

						$donegraph{"$tmp[1] $tmp[2] $tmp[3]"} = $tmp[0];
						$donegraph{"$tmp[1] $tmp[3] $tmp[2]"} = $tmp[0];
						$donegraph{"$tmp[2] $tmp[1] $tmp[3]"} = $tmp[0];
						$donegraph{"$tmp[2] $tmp[3] $tmp[1]"} = $tmp[0];
						$donegraph{"$tmp[3] $tmp[1] $tmp[2]"} = $tmp[0];
						$donegraph{"$tmp[3] $tmp[2] $tmp[1]"} = $tmp[0];
						$res{"motNode"}{$tmp[1]}{"true"}{$tmp[0]}++;
						$res{"motNode"}{$tmp[2]}{"true"}{$tmp[0]}++;
						$res{"motNode"}{$tmp[3]}{"true"}{$tmp[0]}++;
						$res{"motNode"}{$tmp[1]}{"true"}{"tot"}++;
						$res{"motNode"}{$tmp[2]}{"true"}{"tot"}++;
						$res{"motNode"}{$tmp[3]}{"true"}{"tot"}++;
						$countt{$tmp[0]}++;
						$res{"true"}{$tmp[1]}{$tmp[0]}{"$tmp[2] $tmp[3]"} = 1;
						if(defined$res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[2] $tmp[3]"}||defined$res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[3] $tmp[2]"}
						||defined$res{"pred"}{$tmp[2]}{$tmp[0]}{"$tmp[1] $tmp[3]"}||defined$res{"pred"}{$tmp[2]}{$tmp[0]}{"$tmp[3] $tmp[1]"}
						||defined$res{"pred"}{$tmp[3]}{$tmp[0]}{"$tmp[1] $tmp[2]"}||defined$res{"pred"}{$tmp[3]}{$tmp[0]}{"$tmp[2] $tmp[1]"}){
							$countlist{$tmp[0]}{"TP"} .= "$tmp[1] $tmp[2] $tmp[3]\n";
							$res{"mot"}{$tmp[0]}{"TP"}++;
							$res{"mot"}{$tmp[0]}{"TN"}--;
							$res{"mot"}{$tmp[0]}{"rec"} += 6;
							$res{"motNode"}{$tmp[1]}{"true"}{"rec"}+=6;
							$res{"motNode"}{$tmp[2]}{"true"}{"rec"}+=6;
							$res{"motNode"}{$tmp[3]}{"true"}{"rec"}+=6;
							#~ print "TP @tmp\n";
							delete $res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[2] $tmp[3]"};
							delete $res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[3] $tmp[2]"};
							delete $res{"pred"}{$tmp[2]}{$tmp[0]}{"$tmp[1] $tmp[3]"};
							delete $res{"pred"}{$tmp[2]}{$tmp[0]}{"$tmp[3] $tmp[1]"};
							delete $res{"pred"}{$tmp[3]}{$tmp[0]}{"$tmp[1] $tmp[2]"};
							delete $res{"pred"}{$tmp[3]}{$tmp[0]}{"$tmp[2] $tmp[1]"};
						}
						else{
							#~ print "FN @tmp\n";
							$countlist{$tmp[0]}{"FN"} .= "$tmp[1] $tmp[2] $tmp[3]\n";
							$res{"mot"}{$tmp[0]}{"FN"}++;
							$res{"mot"}{$tmp[0]}{"TN"}--;
							if(defined$net{"pred"}{$i}{$l} && $net{"pred"}{$i}{$l} == $net{"true"}{$i}{$l}){
								$res{"mot"}{$tmp[0]}{"rec"}++;
								$res{"motNode"}{$tmp[1]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[2]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[3]}{"true"}{"rec"}++;
							}
							if(defined$net{"pred"}{$j}{$l} && $net{"pred"}{$j}{$l} == $net{"true"}{$j}{$l}){
								$res{"mot"}{$tmp[0]}{"rec"}++;
								$res{"motNode"}{$tmp[1]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[2]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[3]}{"true"}{"rec"}++;
							}
							if(defined$net{"pred"}{$l}{$j} && $net{"pred"}{$l}{$j} == $net{"true"}{$l}{$j}){
								$res{"mot"}{$tmp[0]}{"rec"}++;
								$res{"motNode"}{$tmp[1]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[2]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[3]}{"true"}{"rec"}++;
							}
							if(defined$net{"pred"}{$j}{$i} && $net{"pred"}{$j}{$i} == $net{"true"}{$j}{$i}){
								$res{"mot"}{$tmp[0]}{"rec"}++;
								$res{"motNode"}{$tmp[1]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[2]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[3]}{"true"}{"rec"}++;
							}
							if(defined$net{"pred"}{$i}{$j} && $net{"pred"}{$i}{$j} == $net{"true"}{$i}{$j}){
								$res{"mot"}{$tmp[0]}{"rec"}++;
								$res{"motNode"}{$tmp[1]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[2]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[3]}{"true"}{"rec"}++;
							}
							if(defined$net{"pred"}{$l}{$i} && $net{"pred"}{$l}{$i} == $net{"true"}{$l}{$i}){
								$res{"mot"}{$tmp[0]}{"rec"}++;
								$res{"motNode"}{$tmp[1]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[2]}{"true"}{"rec"}++;
								$res{"motNode"}{$tmp[3]}{"true"}{"rec"}++;
							}
							delete $res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[2] $tmp[3]"};
							delete $res{"pred"}{$tmp[1]}{$tmp[0]}{"$tmp[3] $tmp[2]"};
							delete $res{"pred"}{$tmp[2]}{$tmp[0]}{"$tmp[1] $tmp[3]"};
							delete $res{"pred"}{$tmp[2]}{$tmp[0]}{"$tmp[3] $tmp[1]"};
							delete $res{"pred"}{$tmp[3]}{$tmp[0]}{"$tmp[1] $tmp[2]"};
							delete $res{"pred"}{$tmp[3]}{$tmp[0]}{"$tmp[2] $tmp[1]"};
						}
					}
					$count++;
				}
			}
		}
	}

	for(my $j = 0; $j < 13; $j++){
		for my $i (@tf0){
			for my $l (keys %{$res{"pred"}{$i}{$j}}){
				$countlist{$j}{"FP"} .= "$i $l\n";
				$res{"mot"}{$j}{"FP"}++;
				delete $res{"pred"}{$i}{$j}{$l};
			}
		}
	}
}
