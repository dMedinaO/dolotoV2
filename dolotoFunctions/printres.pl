sub printres{

	my $tfn = (keys %tfall);
	$node =  (keys %nodeall);
		$res{"mot"}{"0"}{"TN"} = - ($res{"mot"}{"0"}{"TP"}+$res{"mot"}{"0"}{"FP"}+$res{"mot"}{"0"}{"FN"}) + ($tfn * ($node - 1) * ($node - 2) * 0.5);#total max of posssible motives - #TP = #TN, with self loops, ABC not the same as ACB
		$res{"mot"}{"1"}{"TN"} = - ($res{"mot"}{"1"}{"TP"}+$res{"mot"}{"1"}{"FP"}+$res{"mot"}{"1"}{"FN"}) +  ($tfn * ($tfn - 1) * ($node - 2));
		$res{"mot"}{"2"}{"TN"} = - ($res{"mot"}{"2"}{"TP"}+$res{"mot"}{"2"}{"FP"}+$res{"mot"}{"2"}{"FN"}) +  ($tfn * ($tfn - 1) * ($node - 2));
		$res{"mot"}{"3"}{"TN"} = - ($res{"mot"}{"3"}{"TP"}+$res{"mot"}{"3"}{"FP"}+$res{"mot"}{"3"}{"FN"}) +  ($tfn * ($tfn - 1) * ($node - 2) * 0.5);
		$res{"mot"}{"4"}{"TN"} = - ($res{"mot"}{"4"}{"TP"}+$res{"mot"}{"4"}{"FP"}+$res{"mot"}{"4"}{"FN"}) +  ($tfn * ($tfn - 1) * ($node - 2));
		$res{"mot"}{"5"}{"TN"} = - ($res{"mot"}{"5"}{"TP"}+$res{"mot"}{"5"}{"FP"}+$res{"mot"}{"5"}{"FN"}) +  ($tfn * ($tfn - 1) * ($node - 2) * 0.5);
		$res{"mot"}{"6"}{"TN"} = - ($res{"mot"}{"6"}{"TP"}+$res{"mot"}{"6"}{"FP"}+$res{"mot"}{"6"}{"FN"}) +  ($tfn * ($tfn - 1) * ($tfn - 2));
		$res{"mot"}{"7"}{"TN"} = - ($res{"mot"}{"7"}{"TP"}+$res{"mot"}{"7"}{"FP"}+$res{"mot"}{"7"}{"FN"}) +  ($tfn * ($tfn-1) * ($tfn - 2) * 0.5);
		$res{"mot"}{"8"}{"TN"} = - ($res{"mot"}{"8"}{"TP"}+$res{"mot"}{"8"}{"FP"}+$res{"mot"}{"8"}{"FN"}) +  ($tfn * ($tfn-1) * ($tfn - 2) * (1/3));
		$res{"mot"}{"9"}{"TN"} = - ($res{"mot"}{"9"}{"TP"}+$res{"mot"}{"9"}{"FP"}+$res{"mot"}{"9"}{"FN"}) +  ($tfn * ($tfn-1) * ($tfn - 2));
		$res{"mot"}{"10"}{"TN"} = - ($res{"mot"}{"10"}{"TP"}+$res{"mot"}{"10"}{"FP"}+$res{"mot"}{"10"}{"FN"}) +  ($tfn * ($tfn-1) * ($tfn - 2) * 0.5);
		$res{"mot"}{"11"}{"TN"} = - ($res{"mot"}{"11"}{"TP"}+$res{"mot"}{"11"}{"FP"}+$res{"mot"}{"11"}{"FN"}) +  ($tfn * ($tfn-1) * ($tfn - 2));
		$res{"mot"}{"12"}{"TN"} = - ($res{"mot"}{"12"}{"TP"}+$res{"mot"}{"12"}{"FP"}+$res{"mot"}{"12"}{"FN"}) +  ($tfn * ($tfn-1) * ($tfn - 2) * (1/6));
	my $ctt = 0;
	my $ctp = 0;
	my $mt = 0;
	for (my $j = 0; $j < 13; $j++){
		$ctt += $countt{$j};
		$ctp += $countp{$j};
		if($countt{$j}||$countp{$j}){$mt++;}
	}

	print "\n\nG\t#T\t#P\tTP\tFP\tTN\tFN\tR\tP\tFPR\tACC\tF1\tMCC\tREC\n";
	$outtxttable .= "\n\nG\t#T\t#P\tTP\tFP\tTN\tFN\tR\tSPC\tP\tNPV\tFPR\tFDR\tFNR\tACC\tF1\tMCC\tinfor\tmarked\tJ\tSD\tK1\tK2\tO\tCR\tH\tREC\n";
	for (my $j = 0; $j < 13; $j++){
		$res{"gm"}[0] += $res{"mot"}{$j}{"TP"};
		$res{"gm"}[1] += $res{"mot"}{$j}{"FP"};
		$res{"gm"}[2] += $res{"mot"}{$j}{"TN"};
		$res{"gm"}[3] += $res{"mot"}{$j}{"FN"};
		print $j+1 . "\t$countt{$j}\t$countp{$j}\t";
		$outtxttable .= $j+1 . "\t$countt{$j}\t$countp{$j}\t";
		my @tmp = compute_stats($res{"mot"}{$j}{"TP"},$res{"mot"}{$j}{"FP"},$res{"mot"}{$j}{"TN"},$res{"mot"}{$j}{"FN"});
		for(my $i = 0; $i < 23; $i++){
			if($i > 3 && $tmp[$i] != 0 && abs($tmp[$i]) != 1 ){

				$outtxttable .= sprintf("%.4f\t",$tmp[$i]);
			}
			else{

				$outtxttable .= "$tmp[$i]\t";
			}
		}

		for my $i(0,1,2,3,4,6,8,11,12,13){
			if($i > 3 && $tmp[$i] != 0 && abs($tmp[$i]) != 1 ){
				printf("%.4f\t",$tmp[$i]);
			}
			else{
				print "$tmp[$i]\t";
			}
		}
		if(defined $countt{$j} && $countt{$j} > 0){
			$res{"gm"}[4] += (($res{"mot"}{$j}{"rec"}/6)/$countt{$j});
			printf("%.4f",(($res{"mot"}{$j}{"rec"}/6)/$countt{$j}));
			$outtxttable .= sprintf("%.4f",(($res{"mot"}{$j}{"rec"}/6)/$countt{$j}));
		}
		else{
			print "0";
			$outtxttable .=  "0";
		}
		print "\n";
		$outtxttable .=  "\n";
	}
	my @tmp = compute_stats($res{"gm"}[0],$res{"gm"}[1],$res{"gm"}[2],$res{"gm"}[3]);
	print "all\t$ctt\t$ctp\t";
	$outtxttable .= "all\t$ctt\t$ctp\t";
	for(my $i = 0; $i < 23; $i++){
		if($i > 3 && $tmp[$i] != 0 && abs($tmp[$i]) != 1 ){
			$outtxttable .= sprintf("%.4f\t",$tmp[$i]);
		}
		else{
			$outtxttable .= "$tmp[$i]\t";
		}
	}
	for my $i(0,1,2,3,4,6,8,11,12,13){
		if($i > 3 && $tmp[$i] != 0 && abs($tmp[$i]) != 1 ){
			printf("%.4f\t",$tmp[$i]);
		}
		else{
			print "$tmp[$i]\t";
		}
	}
	if($res{"gm"}[4]){
		printf("%.4f",($res{"gm"}[4]/$mt));
		$outtxttable .= sprintf("%.4f",($res{"gm"}[4]/$mt));
	}
	else{
		print "0";
		$outtxttable .= "0";
	}
	print "\n";
	$outtxttable .= "\n";
	print "gl\t$countgl[0]\t$countgl[1]\t" ;
	$outtxttable .= "gl\t$countgl[0]\t$countgl[1]\t" ;
	@tmp = compute_stats($res{"global"}[0],$res{"global"}[1],$TNG,$res{"global"}[3]);
	for(my $i = 0; $i < 23; $i++){
		if($i > 3 && $tmp[$i] != 0 && abs($tmp[$i]) != 1 ){
			$outtxttable .= sprintf("%.4f\t",$tmp[$i]);
		}
		else{
			$outtxttable .= "$tmp[$i]\t";
		}
	}
	for my $i(0,1,2,3,4,6,8,11,12,13){
		if($i > 3 && $tmp[$i] != 0 && abs($tmp[$i]) != 1 ){
			printf("%.4f\t",$tmp[$i]);
		}
		else{
			print "$tmp[$i]\t";
		}
	}
	print "nan\n\n";
	$outtxttable .= "nan\n\n\n";
	my %gdd = ();
	my %gbin = ();
	for my $i (@tf){
		@{$gdd{"gold"}{"TF"}{$i}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
		@{$gbin{"gold"}{"TF"}{$i}} = (0,0,0,0);
	}
	for my $i (@tf0){
		@{$gdd{"inf"}{"TF"}{$i}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
		@{$gbin{"inf"}{"TF"}{$i}} = (0,0,0,0);
	}
	for my $type ("TP"){
		$outtxt .= "\n$type (graphlets in both networks):\n";
		for my $j (0..12){
			$outtxt .=  $j+1 . "\n$countlist{$j}{$type}\n";
			my @tmp = split("\n",$countlist{$j}{$type});
			while(@tmp){
				my @t = split(" ", shift @tmp);
				for my $k (0,1,2){
					if(exists $gdd{"gold"}{"TF"}{$t[$k]}){
						$gdd{"gold"}{"TF"}{$t[$k]}[$j]++;
						$gbin{"gold"}{"TF"}{$t[$k]}[0]++;
					}
					else{
						if(!exists $gdd{"gold"}{"noTF"}{$t[$k]}){
							@{$gdd{"gold"}{"noTF"}{$t[$k]}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
							@{$gbin{"gold"}{"noTF"}{$t[$k]}} = (0,0,0,0);
						}
						$gdd{"gold"}{"noTF"}{$t[$k]}[$j]++;
						$gbin{"gold"}{"noTF"}{$t[$k]}[0]++;
					}
					if(exists $gdd{"inf"}{"TF"}{$t[$k]}){
						$gdd{"inf"}{"TF"}{$t[$k]}[$j]++;
						$gbin{"inf"}{"TF"}{$t[$k]}[0]++;
					}
					else{
						if(!exists $gdd{"inf"}{"noTF"}{$t[$k]}){
							@{$gdd{"inf"}{"noTF"}{$t[$k]}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
							@{$gbin{"inf"}{"noTF"}{$t[$k]}} = (0,0,0,0);
						}
						$gdd{"inf"}{"noTF"}{$t[$k]}[$j]++;
						$gbin{"inf"}{"noTF"}{$t[$k]}[0]++;
					}
				}
			}
		}
	}
	for my $type ("FN"){
		$outtxt .= "\n$type (graphlets only in REFERENCE):\n";
		for my $j (0..12){
			$outtxt .=  $j+1 . "\n$countlist{$j}{$type}\n";
			my @tmp = split("\n",$countlist{$j}{$type});
			while(@tmp){
				my @t = split(" ", shift @tmp);
				#~ print "@t||";
				for my $k (0,1,2){
					#~ print "$t[$k]!!";
					if(exists $gdd{"gold"}{"TF"}{$t[$k]}){
						$gdd{"gold"}{"TF"}{$t[$k]}[$j]++;
						$gbin{"gold"}{"TF"}{$t[$k]}[3]++;
					}
					else{
						if(!exists $gdd{"gold"}{"noTF"}{$t[$k]}){
							@{$gdd{"gold"}{"noTF"}{$t[$k]}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
							@{$gbin{"gold"}{"noTF"}{$t[$k]}} = (0,0,0,0);
						}
						$gdd{"gold"}{"noTF"}{$t[$k]}[$j]++;
						$gbin{"gold"}{"noTF"}{$t[$k]}[3]++;
					}
					if(exists $gdd{"inf"}{"TF"}{$t[$k]}){
						#~ $gdd{"inf"}{"TF"}{$t[$k]}[$j]++;
						$gbin{"inf"}{"TF"}{$t[$k]}[3]++;
					}
					else{
						if(!exists $gbin{"inf"}{"noTF"}{$t[$k]}){
							#~ @{$gdd{"inf"}{"noTF"}{$t[$k]}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
							@{$gbin{"inf"}{"noTF"}{$t[$k]}} = (0,0,0,0);
						}
						#~ $gdd{"inf"}{"noTF"}{$t[$k]}[$j]++;
						$gbin{"inf"}{"noTF"}{$t[$k]}[3]++;
						#~ print "$t[$k]!!\n";
					}
				}
			}
		}
	}
	for my $type ("FP"){
		$outtxt .= "\n$type (graphlets only in INPUT):\n";
		for my $j (0..12){
			$outtxt .=  $j+1 . "\n$countlist{$j}{$type}\n";
			my @tmp = split("\n",$countlist{$j}{$type});
			while(@tmp){
				my @t = split(" ", shift @tmp);
				#~ print "@t||";
				for my $k (0,1,2){
					#~ print "$t[$k]!!";
					if(exists $gdd{"inf"}{"TF"}{$t[$k]}){
						$gdd{"inf"}{"TF"}{$t[$k]}[$j]++;
						$gbin{"inf"}{"TF"}{$t[$k]}[1]++;
					}
					else{
						if(!exists $gdd{"inf"}{"noTF"}{$t[$k]}){
							@{$gdd{"inf"}{"noTF"}{$t[$k]}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
							@{$gbin{"inf"}{"noTF"}{$t[$k]}} = (0,0,0,0);
						}
						$gdd{"inf"}{"noTF"}{$t[$k]}[$j]++;
						$gbin{"inf"}{"noTF"}{$t[$k]}[1]++;
					}
					if(exists $gbin{"gold"}{"TF"}{$t[$k]}){
						#~ $gdd{"gold"}{"TF"}{$t[$k]}[$j]++;
						$gbin{"gold"}{"TF"}{$t[$k]}[1]++;
						#~ print "$t[$k]!kk!";
					}
					else{
						if(!exists $gbin{"gold"}{"noTF"}{$t[$k]}){
							#~ @{$gdd{"gold"}{"noTF"}{$t[$k]}} = (0,0,0,0,0,0,0,0,0,0,0,0,0);
							@{$gbin{"gold"}{"noTF"}{$t[$k]}} = (0,0,0,0);
						}
						#~ $gdd{"gold"}{"noTF"}{$t[$k]}[$j]++;
						$gbin{"gold"}{"noTF"}{$t[$k]}[1]++;
						#~ print "$t[$k]!\\!\n";
					}
				}
			}
		}
	}


	my $tmpout = '';
	my $tmpNOG = "$fg TFs not in graphlets:\n";
	my $tmpoutn = '';
	my $tmpNOGn = "$fg Genes (no TF) not in graphlets:\n";

	$tmpout  .= "$fg TFs in graphlets:\nTF";
	for my $j (0..12){
		$tmpout  .= "\t";
		$tmpout  .= $j+1;
	}
	$tmpout  .= "\ttotal\tRGD\tF1\n";
	for my $i (@tf){

		if(0 != $res{"motNode"}{$i}{"true"}{"tot"}){
			$tmpout  .= "$i";
			for my $j (0..12){
				$tmpout  .= "\t$res{motNode}{$i}{true}{$j}";
			}
			$tmpout  .= "\t$res{motNode}{$i}{true}{tot}\t";
			$outnetnodes{$i}[3] = $res{"motNode"}{$i}{"true"}{"tot"};
			$outnetnodes{$i}[4] = sprintf("%.4f",($res{"motNode"}{$i}{"true"}{"rec"}/($res{"motNode"}{$i}{"true"}{"tot"}*6)));
			$tmpout  .= sprintf("%.4f\t",($res{"motNode"}{$i}{"true"}{"rec"}/($res{"motNode"}{$i}{"true"}{"tot"}*6)));
			if ($gbin{"gold"}{"TF"}{$i}[0] != 0){
				$tmpout  .= sprintf("%.4f",((2*($gbin{"gold"}{"TF"}{$i}[0]/($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[1]))*($gbin{"gold"}{"TF"}{$i}[0]/
				($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[3])))/
				(($gbin{"gold"}{"TF"}{$i}[0]/($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[1]))+($gbin{"gold"}{"TF"}{$i}[0]/($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[3])))));
				$outnetnodes{$i}[6] = sprintf("%.4f",((2*($gbin{"gold"}{"TF"}{$i}[0]/($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[1]))*($gbin{"gold"}{"TF"}{$i}[0]/
				($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[3])))/
				(($gbin{"gold"}{"TF"}{$i}[0]/($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[1]))+($gbin{"gold"}{"TF"}{$i}[0]/($gbin{"gold"}{"TF"}{$i}[0]+$gbin{"gold"}{"TF"}{$i}[3])))));
			}
			else{
				$tmpout  .= 0;
				$outnetnodes{$i}[6] = 0;
			}
			$tmpout .= "\n";
		}
		else{
			$tmpNOG .= "$i\n";
			$outnetnodes{$i}[3] = 0;
			$outnetnodes{$i}[4] = 0;
			$outnetnodes{$i}[6] = 0;
		}
		delete $res{"motNode"}{$i}{"true"};
	}

	$tmpoutn.= "$fg Genes (no TF) in graphlets:\ngene";
	for my $j (0..5){
		$tmpoutn.= "\t";
		$tmpoutn.= $j+1;
	}
	$tmpoutn.= "\ttotal\tRGD\tF1\n";
	for my $i (sort keys %{$res{"motNode"}}){
		if(exists $res{"motNode"}{$i}{"true"}){
			if(0 != $res{"motNode"}{$i}{"true"}{"tot"}){
				$tmpoutn.= "$i";
				for my $j (0..5){
					$tmpoutn.= "\t$res{motNode}{$i}{true}{$j}";
				}
				$tmpoutn.= "\t$res{motNode}{$i}{true}{tot}\t";
				$outnetnodes{$i}[3] = $res{"motNode"}{$i}{"true"}{"tot"};
				$outnetnodes{$i}[4] = sprintf("%.4f",($res{"motNode"}{$i}{"true"}{"rec"}/($res{"motNode"}{$i}{"true"}{"tot"}*6)));
				$tmpoutn  .= sprintf("%.4f\t",($res{"motNode"}{$i}{"true"}{"rec"}/($res{"motNode"}{$i}{"true"}{"tot"}*6)));
				if($gbin{"gold"}{"noTF"}{$i}[0] != 0){
					$tmpoutn  .= sprintf("%.4f",((2*($gbin{"gold"}{"noTF"}{$i}[0]/($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[1]))*($gbin{"gold"}{"noTF"}{$i}[0]/
				($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[3])))/
				(($gbin{"gold"}{"noTF"}{$i}[0]/($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[1]))+($gbin{"gold"}{"noTF"}{$i}[0]/($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[3])))));
					$outnetnodes{$i}[6] = sprintf("%.4f",((2*($gbin{"gold"}{"noTF"}{$i}[0]/($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[1]))*($gbin{"gold"}{"noTF"}{$i}[0]/
				($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[3])))/
				(($gbin{"gold"}{"noTF"}{$i}[0]/($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[1]))+($gbin{"gold"}{"noTF"}{$i}[0]/($gbin{"gold"}{"noTF"}{$i}[0]+$gbin{"gold"}{"noTF"}{$i}[3])))));
				}
				else{
					$tmpoutn  .= 0;
					$outnetnodes{$i}[6] = 0;
				}
				$tmpoutn .= "\n";
			}
			else{
				$tmpNOGn .= "$i\n";
				$outnetnodes{$i}[3] = 0;
				$outnetnodes{$i}[4] = 0;
				$outnetnodes{$i}[6] = 0;
			}
		}
	}

	my $tmpouti = '';
	my $tmpNOGi = "$ffg TFs not in graphlets:\n";
	my $tmpoutni = '';
	my $tmpNOGni = "$ffg Genes (no TF) not in graphlets:\n";


	$tmpouti  .= "$ffg TFs in graphlets:\nTF";
	for my $j (0..12){
		$tmpouti  .= "\t";
		$tmpouti  .= $j+1;
	}
	$tmpouti  .= "\ttotal\n";
	for my $i (@tf0){

		if(0 != $res{"motNode"}{$i}{"pred"}{"tot"}){
			$tmpouti  .= "$i";
			for my $j (0..12){
				$tmpouti  .= "\t$res{motNode}{$i}{pred}{$j}";
			}
			$tmpouti .= "\t$res{motNode}{$i}{pred}{tot}\n";
			$outnetnodes{$i}[5] = $res{"motNode"}{$i}{"pred"}{"tot"};
		}
		else{
			$tmpNOGi .= "$i\n";
			$outnetnodes{$i}[5] = 0;
		}
		delete $res{"motNode"}{$i}{"pred"};
	}

	$tmpoutni .= "$ffg Genes (no TF) in graphlets:\ngene";
	for my $j (0..5){
		$tmpoutni .= "\t";
		$tmpoutni .= $j+1;
	}
	$tmpoutni .= "\ttotal\n";
	for my $i (sort keys %{$res{"motNode"}}){
		if(exists $res{"motNode"}{$i}{"pred"}){
			if(0 != $res{"motNode"}{$i}{"pred"}{"tot"}){
				$tmpoutni .= "$i";
				for my $j (0..5){
					$tmpoutni .= "\t$res{motNode}{$i}{pred}{$j}";
				}
				$tmpoutni .= "\t$res{motNode}{$i}{pred}{tot}\n";
				$outnetnodes{$i}[5] = $res{"motNode"}{$i}{"pred"}{"tot"};
			}
			else{
				$tmpNOGni .= "$i\n";
				$outnetnodes{$i}[5] = 0;
			}
		}
	}


	open(F, ">$folder/$outfile") or die "can't open $folder/$outfile";#$countlist{$tmp[0]}{"TP"} .= "$tmp[1] $tmp[2] $tmp[3]\n";
	print F $outtxttable;
	print F "$tmpNOG\n\n";
	print F "$tmpNOGn\n\n";
	print F "$tmpout\n\n";
	print F "$tmpoutn\n\n";
	print F "$tmpNOGi\n\n";
	print F "$tmpNOGni\n\n";
	print F "$tmpouti\n\n";
	print F "$tmpoutni\n\n";

	print F $outtxt;
	close F;
}
