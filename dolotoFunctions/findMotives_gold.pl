sub findMotives_gold{
	my %donegraph = ();
	for my $i(@tf){#tfs in gold
		for my $l (keys %{$done{"true"}}){
			for my $j (@{$outDegree{"true"}{$i}}){
				if(defined$net{"true"}{$i}{$l} && defined$net{"true"}{$j}{$l} && defined$net{"true"}{$l}{$j} && defined$net{"true"}{$j}{$i} && defined$net{"true"}{$l}{$i}){
					my (@tmp) = dotriplet_noij($net{"true"}{$i}{$l}, $net{"true"}{$j}{$l}, $net{"true"}{$l}{$j}, $net{"true"}{$j}{$i}, $net{"true"}{$l}{$i}, $i, $j, $l);

					if($tmp[1] && !exists $donegraph{"$tmp[1] $tmp[2] $tmp[3]"}){

						#~ if($tmp[0] == 10){
							#~ print "TRUE: $net{true}{$i}{$j}, $net{true}{$i}{$l}, $net{true}{$j}{$l}, $net{true}{$l}{$j}, $net{true}{$j}{$i}, $net{true}{$l}{$i}, $i, $j, $l\n";
						#~ }
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
						$res{"true"}{$tmp[1]}{$tmp[0]}{"$tmp[2] $tmp[3]"} = 1;
						$countt{$tmp[0]}++;
					}
				}
			}
		}
	}
}
