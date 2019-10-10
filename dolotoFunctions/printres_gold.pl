sub printres_gold{

	my $tmpoutall = '';
	my $tmpout = '';
	my $tmpNOG = "TFs not in graphlets:\n";
	my $tmpoutn = '';
	my $tmpNOGn = "Genes (no TF) not in graphlets:\n";

	print "\nGRAPHLETS:\n";
	print "Type:";
	$tmpoutall  .= "\nGRAPHLETS:\n";
	$tmpoutall  .= "Type:";
	for my $j (0..12){
		print "\t";
		print $j+1;
		$tmpoutall  .= "\t";
		$tmpoutall  .= $j+1;
	}
	print "\ttotal\ncount";
	$tmpoutall  .= "\ttotal\ncount";
	my $i = 0;
	for my $j (0..12){
		print "\t";
		print $countt{$j};
		$tmpoutall  .= "\t";
		$tmpoutall  .= $countt{$j};
		$i += $countt{$j};
	}
	print "\t$i\n\n";
	$tmpoutall  .= "\t$i";

	$tmpout  .= "TFs in graphlets:\nTF";
	for my $j (0..12){
		$tmpout  .= "\t";
		$tmpout  .= $j+1;
	}
	$tmpout  .= "\ttotal\n";
	for my $i (@tf){

		if(0 != $res{"motNode"}{$i}{"true"}{"tot"}){
			$tmpout  .= "$i";
			for my $j (0..12){
				$tmpout  .= "\t$res{motNode}{$i}{true}{$j}";
			}
			$tmpout  .= "\t$res{motNode}{$i}{true}{tot}\n";
			$outnetnodes{$i}[3] =  $res{"motNode"}{$i}{"true"}{"tot"};
		}
		else{
			$tmpNOG .= "$i\n";
			$outnetnodes{$i}[3] = 0;
		}
		delete $res{"motNode"}{$i};
	}

	$tmpoutn.= "Genes (no TF) in graphlets:\ngene";
	for my $j (0..5){
		$tmpoutn.= "\t";
		$tmpoutn.= $j+1;
	}
	$tmpoutn.= "\ttotal\n";
	for my $i (sort keys %{$res{"motNode"}}){
		if(0 != $res{"motNode"}{$i}{"true"}{"tot"}){
			$tmpoutn.= "$i";
			for my $j (0..5){
				$tmpoutn.= "\t$res{motNode}{$i}{true}{$j}";
			}
			$tmpoutn.= "\t$res{motNode}{$i}{true}{tot}\n";
			$outnetnodes{$i}[3] = $res{"motNode"}{$i}{"true"}{"tot"};
		}
		else{
			$tmpNOGn .= "$i\n";
			$outnetnodes{$i}[3] = 0;
		}
	}


	open(F, ">$folder/$outfile") or die "can't open $folder/$outfile";#$countlist{$tmp[0]}{"TP"} .= "$tmp[1] $tmp[2] $tmp[3]\n";
	print F "$tmpoutall\n\n";
	print F "$tmpNOG\n\n";
	print F "$tmpNOGn\n\n";
	print F "$tmpout\n\n";
	print F "$tmpoutn\n";

	print F "GRAPHLETS:\n\n";
	for my $i (0..12){
		print F "Type ";
		print F $i+1;
		print F ":\n";
		for my $j (@tf){
			for my $k (keys %{$res{"true"}{$j}{$i}}){
				print  F "$j $k\n";
			}
		}
		print F "\n";
	}
	close F;

}
