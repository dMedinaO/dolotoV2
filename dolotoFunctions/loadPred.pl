sub loadPred{
	my $di = '';#abre el archivo
	open (F, "<$ff") or die "can't open $ff\n$!\n";
	{ local $/=undef;  $di=<F>; }
	my @d=split /[\r\n]+/, $di;#quita el enter
	close F;

	my $cc = 0;#contador
	my $cc0 = 0;#contador
	my @nodes = ();#array
	my %tfs = ();#hash
	$node = 0;#index

	if($case == 1){#solo una red
		while(@d){#recorre el array
			if($d[0] =~ /\t/){
				my @t =  split("\t",shift @d);#divide por \t
				$tfs{$t[0]} = 1;#nodo1
				$tfall{$t[0]} = 1;#nodo1
				$nodeall{$t[0]} = 1;#nodo1
				$nodeall{$t[1]} = 1;#nodo2

				#$outnetnodes tiene tres pocisiones en sus correspondientes keys!!!

				if(exists $net{"true"}{$t[0]}{$t[1]}){#si existe el hash nodo1 y nodo2
					if($t[2] > $threshold){#superar el umbral
						$net{"pred"}{$t[0]}{$t[1]} = 1;#update pred de la clave nodo1-nodo2
						$outnet{$t[0]}{$t[1]}[1] = 'P';#uodate dic de outnet[nodo1][nodo2]
						if(!defined $outnetnodes{$t[0]}){#solo si la key existe en forma de arreglo...
							$outnetnodes{$t[0]}[0] = 'TF';#actualizamos la pocision [node1][0]
						}
						elsif($outnetnodes{$t[0]}[0] ne 'TF'){#modificamos los valores si se encuentra vacia o nula
							$outnetnodes{$t[0]}[0] = 'TF';
						}
						if(!defined $outnetnodes{$t[1]}){#lo mismo pero para el nodo2
							$outnetnodes{$t[1]}[0] = 'nTF';
						}
						$outnetnodes{$t[0]}[2] = 'P';#actualizamos la pocision dos del array en la key correspondiente .. OJO!!! ES POCISION 2!!!
						$outnetnodes{$t[1]}[2] = 'P';
						if($outnetnodes{$t[0]}[1] ne 'P'){#actualizar valor de node 1 en pos
							$outnetnodes{$t[0]}[1] = 'A';
						}
						if($outnetnodes{$t[1]}[1] ne 'P'){#actualzamos los datos
							$outnetnodes{$t[1]}[1] = 'A';
						}
						#actualizacion de los res
						$res{"motNode"}{$t[0]}{"pred"} = {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0};
						$res{"motNode"}{$t[1]}{"pred"} = {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0};
						$cc++;

						#preguntamos por el array y obtenemos la data y agregamos con push
						if(!defined $inDegree{"pred"}{$t[1]}){
							@{$inDegree{"pred"}{$t[1]}} = ();
						}
						if(!defined $outDegree{"pred"}{$t[0]}){
							@{$outDegree{"pred"}{$t[0]}} = ();
							#~ push (@tf0,$t[0]);
						}
						push (@{$outDegree{"pred"}{$t[0]}},$t[1]);
						push (@{$inDegree{"pred"}{$t[1]}},$t[0]);
					}
					else{
						$net{"pred"}{$t[0]}{$t[1]} = 0;
						$cc0++;
					}
					if(!defined $done{"pred"}{$t[0]}){
						$node++;
						$done{"pred"}{$t[0]} = $t[0] ;
					}
					if(!defined $done{"pred"}{$t[1]}){
						$node++;
						$done{"pred"}{$t[1]} = $t[1] ;
					}
				}
			}
			else{
				shift @d;
			}
		}
		for my $i(keys %{$net{"true"}}){
			for my $j (keys %{$done{"true"}}){
				if(!defined $net{"pred"}{$i}{$j} && exists $net{"true"}{$i}{$j}){
					$net{"pred"}{$i}{$j} = 0;
					$cc0++;
				}
				if($outnetnodes{$j}[1] eq 'P' && $outnetnodes{$j}[2] ne 'P'){
					$outnetnodes{$j}[2] = 'A';
				}
			}
			if($outnetnodes{$i}[1] eq 'P' && $outnetnodes{$i}[2] ne 'P'){
				$outnetnodes{$i}[2] = 'A';
			}
		}
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
					$net{"pred"}{$t[0]}{$t[1]} = 1;
					$outnet{$t[0]}{$t[1]}[1] = 'P';
					if(!defined $outnetnodes{$t[0]}){
						$outnetnodes{$t[0]}[0] = 'TF';
					}
					elsif($outnetnodes{$t[0]}[0] ne 'TF'){
						$outnetnodes{$t[0]}[0] = 'TF';
					}
					if(!defined $outnetnodes{$t[1]}){
						$outnetnodes{$t[1]}[0] = 'nTF';
					}
					$outnetnodes{$t[0]}[2] = 'P';
					$outnetnodes{$t[1]}[2] = 'P';
					if($outnetnodes{$t[0]}[1] ne 'P'){
						$outnetnodes{$t[0]}[1] = 'A';
					}
					if($outnetnodes{$t[1]}[1] ne 'P'){
						$outnetnodes{$t[1]}[1] = 'A';
					}
					$res{"motNode"}{$t[0]}{"pred"} = {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0};
					$res{"motNode"}{$t[1]}{"pred"} = {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0};
					$cc++;
					if(!defined $inDegree{"pred"}{$t[1]}){
						@{$inDegree{"pred"}{$t[1]}} = ();
					}
					if(!defined $outDegree{"pred"}{$t[0]}){
						@{$outDegree{"pred"}{$t[0]}} = ();
						#~ push (@tf0,$t[0]);
					}
					push (@{$outDegree{"pred"}{$t[0]}},$t[1]);
					push (@{$inDegree{"pred"}{$t[1]}},$t[0]);
				}
				if(!defined $done{"pred"}{$t[0]}){
					$node++;
					$done{"pred"}{$t[0]} = $t[0] ;
				}
				if(!defined $done{"pred"}{$t[1]}){
					$node++;
					$done{"pred"}{$t[1]} = $t[1] ;
				}
			}
			else{
				shift @d;
			}
		}
		for my $i(keys %{$done{"pred"}}){
			for my $j (keys %{$done{"pred"}}){
				if(!defined $net{"true"}{$i}{$j}){
					$net{"true"}{$i}{$j} = 0;
				}
				if($net{"pred"}{$i}{$j} == 1 && $outnet{$i}{$j}[0] ne 'P'){
					$outnet{$i}{$j}[0] = 'A';
				}
				if(!defined $net{"pred"}{$i}{$j}){
					$net{"pred"}{$i}{$j} = 0;
					$cc0++;
				}
			}
		}
		for my $i(keys %{$net{"true"}}){
			for my $j (keys %{$done{"true"}}){
				if(!defined $net{"pred"}{$i}{$j} && exists $net{"true"}{$i}{$j}){
					$net{"pred"}{$i}{$j} = 0;
					$cc0++;
				}
				if($outnetnodes{$j}[1] eq 'P' && $outnetnodes{$j}[2] ne 'P'){
					$outnetnodes{$j}[2] = 'A';
				}
			}
			if($outnetnodes{$i}[1] eq 'P' && $outnetnodes{$i}[2] ne 'P'){
				$outnetnodes{$i}[2] = 'A';
			}
		}
	}
	#~ @tf0 = keys %{$net{"pred"}};
	@tf0 = sort keys %tfs;
	my $tmp = @tf0;
	print "INPUT :   \t$tmp\t$node\t$cc\t$cc0\n";
	$outtxttable .= "INPUT :   \t$tmp\t$node\t$cc\t$cc0\n";
	#~ print "@tf0\n";
	$countgl[1] = $cc;
}
