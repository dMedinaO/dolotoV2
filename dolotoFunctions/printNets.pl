sub printNets{
	my $nodesx = '';
	my $nodestable = '';
	my $nodestableD3 = '';
	my $edgesx = '';
	my $edgestable = '';
	my $edgestableD3 = '';
	my $numnodes = (keys %outnetnodes);
	my $xdim = $numnodes;
	my $ydim = 2*$numnodes/3;
	my $xcent = $xdim/2;
	my $ycent = $ydim/2;
	my $headnet ="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>
<graph id=\"9908\" label=\"$id\" directed=\"1\" cy:documentVersion=\"3.0\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:cy=\"http://www.cytoscape.org\" xmlns=\"http://www.cs.rpi.edu/XGMML\">
  <att name=\"networkMetadata\">
    <rdf:RDF>
      <rdf:Description rdf:about=\"http://www.cytoscape.org/\">
        <dc:type>Regulatory Interaction</dc:type>
        <dc:description>LoTo comparison of directed networks</dc:description>
        <dc:identifier>N/A</dc:identifier>
        <dc:date>2015</dc:date>
        <dc:title>$id</dc:title>
        <dc:source>http://www.cytoscape.org/</dc:source>
        <dc:format>Cytoscape-XGMML</dc:format>
      </rdf:Description>
    </rdf:RDF>
  </att>
  <att name=\"shared name\" value=\"$id\" type=\"string\"/>
  <att name=\"selected\" value=\"1\" type=\"boolean\"/>
  <att name=\"name\" value=\"$id\" type=\"string\"/>
  <att name=\"__Annotations\" type=\"list\">
  </att>
  <graphics>
    <att name=\"NETWORK_TITLE\" value=\"$id\" type=\"string\"/>
    <att name=\"NETWORK_CENTER_Y_LOCATION\" value=\"-$ycent\" type=\"string\"/>
    <att name=\"NETWORK_HEIGHT\" value=\"$ydim\" type=\"string\"/>
    <att name=\"NETWORK_DEPTH\" value=\"0.0\" type=\"string\"/>
    <att name=\"NETWORK_CENTER_Z_LOCATION\" value=\"0.0\" type=\"string\"/>
    <att name=\"NETWORK_BACKGROUND_PAINT\" value=\"#ffffff\" type=\"string\"/>
    <att name=\"NETWORK_SCALE_FACTOR\" value=\"2.5\" type=\"string\"/>
    <att name=\"NETWORK_NODE_SELECTION\" value=\"true\" type=\"string\"/>
    <att name=\"NETWORK_CENTER_X_LOCATION\" value=\"-$xcent\" type=\"string\"/>
    <att name=\"NETWORK_EDGE_SELECTION\" value=\"true\" type=\"string\"/>
    <att name=\"NETWORK_WIDTH\" value=\"$xdim\" type=\"string\"/>
  </graphics>";


my $nodenet = "
  <node id=\"XXXXX\" label=\"YYYYY\">
    <att name=\"selected\" value=\"0\" type=\"boolean\"/>
    <att name=\"name\" value=\"YYYYY\" type=\"string\"/>
    <att name=\"type\" value=\"PPPPP\" type=\"string\"/>
    <att name=\"graphlet degree in reference\" value=\"MMMMM\" type=\"string\"/>
    <att name=\"RGD\" value=\"OOOOO\" type=\"string\"/>
    <att name=\"F1\" value=\"QQQQQ\" type=\"string\"/>
    <att name=\"graphlet degree in compared\" value=\"NNNNN\" type=\"string\"/>
    <att name=\"class\" value=\"LLLLL\" type=\"string\"/>
    <att name=\"presence in reference\" value=\"JJJJJ\" type=\"string\"/>
    <att name=\"presence in compared\" value=\"KKKKK\" type=\"string\"/>
    <att name=\"color\" value=\"ZZZZZ\" type=\"string\"/>
    <graphics y=\"-$ycent\" fill=\"ZZZZZ\" x=\"-$xcent\" outline=\"#333333\" h=\"35.0\" z=\"0.0\" width=\"3.0\" w=\"35.0\" type=\"ROUND_RECTANGLE\">
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_1\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_4\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_5\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_SELECTED_PAINT\" value=\"#ffff00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_2\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_4\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_9\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_DEPTH\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_BORDER_STROKE\" value=\"SOLID\" type=\"string\"/>
      <att name=\"NODE_NESTED_NETWORK_IMAGE_VISIBLE\" value=\"true\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_3\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_9\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_7\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_TRANSPARENCY\" value=\"255\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_3\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_9\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_LABEL_FONT_SIZE\" value=\"12\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_4\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_7\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_LABEL_COLOR\" value=\"#000000\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_6\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_6\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_2\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_2\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_7\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_6\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_LABEL_WIDTH\" value=\"200.0\" type=\"string\"/>
      <att name=\"NODE_VISIBLE\" value=\"true\" type=\"string\"/>
      <att name=\"NODE_SELECTED\" value=\"false\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_8\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_POSITION_5\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_1\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_LABEL_POSITION\" value=\"C,C,c,0.00,0.00\" type=\"string\"/>
      <att name=\"NODE_TOOLTIP\" value=\"\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_8\" value=\"org.cytoscape.ding.customgraphics.NullCustomGraphics,0,[ Remove Graphics ],\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_5\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_LABEL\" value=\"YYYYY\" type=\"string\"/>
      <att name=\"NODE_LABEL_TRANSPARENCY\" value=\"255\" type=\"string\"/>
      <att name=\"NODE_LABEL_FONT_FACE\" value=\"Dialog.plain,plain,12\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_1\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_8\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_CUSTOMGRAPHICS_SIZE_3\" value=\"0.0\" type=\"string\"/>
      <att name=\"NODE_BORDER_TRANSPARENCY\" value=\"255\" type=\"string\"/>
    </graphics>
  </node>";

my $edgenet = "
  <edge id=\"XXXXX\" label=\"YYYYY\" source=\"JJJJJ\" target=\"KKKKK\" cy:directed=\"1\">
    <att name=\"interaction\" value=\"1\" type=\"string\"/>
    <att name=\"selected\" value=\"0\" type=\"boolean\"/>
    <att name=\"name\" value=\"YYYYY\" type=\"string\"/>
    <att name=\"source\" value=\"PPPPP\" type=\"string\"/>
    <att name=\"target\" value=\"QQQQQ\" type=\"string\"/>
    <att name=\"reference presence\" value=\"RRRRR\" type=\"string\"/>
    <att name=\"compared presence\" value=\"SSSSS\" type=\"string\"/>
    <att name=\"source presence\" value=\"MMMMM\" type=\"string\"/>
    <att name=\"target presence\" value=\"NNNNN\" type=\"string\"/>
    <att name=\"class\" value=\"OOOOO\" type=\"string\"/>
    <att name=\"color\" value=\"ZZZZZ\" type=\"string\"/>
    <graphics fill=\"ZZZZZ\" width=\"2.0\">
      <att name=\"EDGE_SOURCE_ARROW_SHAPE\" value=\"NONE\" type=\"string\"/>
      <att name=\"EDGE_TRANSPARENCY\" value=\"255\" type=\"string\"/>
      <att name=\"EDGE_LABEL_TRANSPARENCY\" value=\"255\" type=\"string\"/>
      <att name=\"EDGE_BEND\" value=\"\" type=\"string\"/>
      <att name=\"EDGE_TARGET_ARROW_SELECTED_PAINT\" value=\"#ffff00\" type=\"string\"/>
      <att name=\"EDGE_LINE_TYPE\" value=\"SOLID\" type=\"string\"/>
      <att name=\"EDGE_TOOLTIP\" value=\"\" type=\"string\"/>
      <att name=\"EDGE_SOURCE_ARROW_SELECTED_PAINT\" value=\"#ffff00\" type=\"string\"/>
      <att name=\"EDGE_LABEL_FONT_FACE\" value=\"Dialog.plain,plain,10\" type=\"string\"/>
      <att name=\"EDGE_STROKE_SELECTED_PAINT\" value=\"#0033ff\" type=\"string\"/>
      <att name=\"EDGE_LABEL_COLOR\" value=\"#000000\" type=\"string\"/>
      <att name=\"EDGE_CURVED\" value=\"true\" type=\"string\"/>
      <att name=\"EDGE_TARGET_ARROW_UNSELECTED_PAINT\" value=\"ZZZZZ\" type=\"string\"/>
      <att name=\"EDGE_LABEL\" value=\"\" type=\"string\"/>
      <att name=\"EDGE_SELECTED\" value=\"false\" type=\"string\"/>
      <att name=\"EDGE_LABEL_FONT_SIZE\" value=\"10\" type=\"string\"/>
      <att name=\"EDGE_SOURCE_ARROW_UNSELECTED_PAINT\" value=\"ZZZZZ\" type=\"string\"/>
      <att name=\"EDGE_TARGET_ARROW_SHAPE\" value=\"DELTA\" type=\"string\"/>
      <att name=\"EDGE_VISIBLE\" value=\"true\" type=\"string\"/>
    </graphics>
  </edge>";

	if($ff eq ''){
		$nodestable = "name\tcolor\tgraphlet_degree\ttype\n";
		$edgestable = "name\tsource\ttarget\tinteraction\tcolor\n";
		$nodenet =~ s/
    <att name=\"RGD\" value=\"OOOOO\" type=\"string\"\/>
    <att name=\"F1\" value=\"QQQQQ\" type=\"string\"\/>
    <att name=\"graphlet degree in compared\" value=\"NNNNN\" type=\"string\"\/>
    <att name=\"class\" value=\"LLLLL\" type=\"string\"\/>
    <att name=\"presence in reference\" value=\"JJJJJ\" type=\"string\"\/>
    <att name=\"presence in compared\" value=\"KKKKK\" type=\"string\"\/>//;
		$edgenet =~ s/
    <att name=\"reference presence\" value=\"RRRRR\" type=\"string\"\/>
    <att name=\"compared presence\" value=\"SSSSS\" type=\"string\"\/>
    <att name=\"source presence\" value=\"MMMMM\" type=\"string\"\/>
    <att name=\"target presence\" value=\"NNNNN\" type=\"string\"\/>
    <att name=\"class\" value=\"OOOOO\" type=\"string\"\/>//;
		my $counter = 1;
		my %numnodes = ();
		for my $i (keys %outnetnodes){
			$numnodes{$i} = $counter;
			my $color = $colorEFTP;
			if($outnetnodes{$i}[0] eq 'TF'){
				$color = $colorTFTP;
			}
			$nodestable .= "$i\t$color\t$outnetnodes{$i}[3]\t$outnetnodes{$i}[0]\n";
			$nodestableD3 .= "\t\t{id: $counter, label: \'$i\', color:\'$color\'},\n";
			my $tmpnode = $nodenet;
			$tmpnode =~ s/XXXXX/$counter/g;
			$tmpnode =~ s/YYYYY/$i/g;
			$tmpnode =~ s/PPPPP/$outnetnodes{$i}[0]/g;
			$tmpnode =~ s/MMMMM/$outnetnodes{$i}[3]/g;
			$tmpnode =~ s/ZZZZZ/$color/g;
			$nodesx .= $tmpnode;
			$counter++;
		}
		for my $i (keys %outnet){
			for my $j (keys %{$outnet{$i}}){
				my $color = $coloredgeTP;
				$edgestable .= "$i(1)$j\t$i\t$j\t1\t$color\n";
				$edgestableD3 .= "\t\t{from: $numnodes{$i}, to: $numnodes{$j}, color:{color:\'$color\'}},\n";
				my $tmpedge = $edgenet;
				$tmpedge =~ s/XXXXX/$counter/g;
				$tmpedge =~ s/YYYYY/$i(1)$j/g;
				$tmpedge =~ s/JJJJJ/$numnodes{$i}/g;
				$tmpedge =~ s/KKKKK/$numnodes{$j}/g;
				$tmpedge =~ s/PPPPP/$i/g;
				$tmpedge =~ s/QQQQQ/$j/g;
				$tmpedge =~ s/ZZZZZ/$color/g;
				$edgesx .= $tmpedge;
				$counter++;
			}
		}
	}
	else{
		$nodestable = "name\tcolor\ttype\tpresence reference\tpresence compared\tclass\tgraphlet_degree reference\tgraphlet_degree compared\tREC\n";
		$edgestable = "name\tsource\ttarget\tinteraction\tcolor\tpresence reference\tpresence compared\tsource presence\ttarget presence\tclass\n";
		my $counter = 1;
		my %numnodes = ();
		for my $i (keys %outnetnodes){
			$numnodes{$i} = $counter;
			my $color = $colorEFTP;
			my $class = "TP";
			if($outnetnodes{$i}[0] eq 'TF'){
				if($outnetnodes{$i}[1] eq 'A' && $outnetnodes{$i}[2] eq 'P'){
					$color = $colorTFFP;
					$class = "FP";
				}
				elsif($outnetnodes{$i}[1] eq 'P' && $outnetnodes{$i}[2] eq 'A'){
					$color = $colorTFFN;
					$class = "FN";
				}
				else{
					$color = $colorTFTP;
				}
			}
			else{
				if($outnetnodes{$i}[1] eq 'A' && $outnetnodes{$i}[2] eq 'P'){
					$color = $colorEFFP;
					$class = "FP";
				}
				elsif($outnetnodes{$i}[1] eq 'P' && $outnetnodes{$i}[2] eq 'A'){
					$color = $colorEFFN;
					$class = "FN";
				}
			}
			if($outnetnodes{$i}[1] eq 'A'){
				$outnetnodes{$i}[3] = 0;
				$outnetnodes{$i}[4] = 0;
			}
			if($outnetnodes{$i}[2] eq 'A'){
				$outnetnodes{$i}[5] = 0;
			}
			$nodestable .= "$i\t$color\t$outnetnodes{$i}[0]\t$outnetnodes{$i}[1]\t$outnetnodes{$i}[2]\t$class\t$outnetnodes{$i}[3]\t$outnetnodes{$i}[5]\t$outnetnodes{$i}[4]\n";
			$nodestableD3 .= "\t\t{id: $counter, label: \'$i\', color:\'$color\'},\n";
			my $tmpnode = $nodenet;
			$tmpnode =~ s/XXXXX/$counter/g;
			$tmpnode =~ s/YYYYY/$i/g;
			$tmpnode =~ s/LLLLL/$class/g;
			$tmpnode =~ s/PPPPP/$outnetnodes{$i}[0]/g;
			$tmpnode =~ s/JJJJJ/$outnetnodes{$i}[1]/g;
			$tmpnode =~ s/KKKKK/$outnetnodes{$i}[2]/g;
			$tmpnode =~ s/MMMMM/$outnetnodes{$i}[3]/g;
			$tmpnode =~ s/OOOOO/$outnetnodes{$i}[4]/g;
			$tmpnode =~ s/QQQQQ/$outnetnodes{$i}[6]/g;
			$tmpnode =~ s/NNNNN/$outnetnodes{$i}[5]/g;
			$tmpnode =~ s/ZZZZZ/$color/g;
			$nodesx .= $tmpnode;
			$counter++;
		}
		for my $i (keys %outnet){
			for my $j (keys %{$outnet{$i}}){
				my $color = $coloredgeTP;
				my $class = "TP";
				if($outnet{$i}{$j}[0] eq 'A'&& $outnet{$i}{$j}[1] eq 'P'){
					$color = $coloredgeFP;
					$class = "FP";
				}
				elsif($outnet{$i}{$j}[0] eq 'P'&& $outnet{$i}{$j}[1] eq 'A'){
					$color = $coloredgeFN;
					$class = "FN";
				}
				$edgestable .= "$i(1)$j\t$i\t$j\t1\t$color\t$outnet{$i}{$j}[0]\t$outnet{$i}{$j}[1]\t$outnetnodes{$i}[1]$outnetnodes{$i}[2]\t$outnetnodes{$j}[1]$outnetnodes{$j}[2]\t$class\n";
				$edgestableD3 .= "\t\t{from: $numnodes{$i}, to: $numnodes{$j}, color:{color:\'$color\'}},\n";
				my $tmpedge = $edgenet;
				$tmpedge =~ s/XXXXX/$counter/g;
				$tmpedge =~ s/YYYYY/$i(1)$j/g;
				$tmpedge =~ s/JJJJJ/$numnodes{$i}/g;
				$tmpedge =~ s/KKKKK/$numnodes{$j}/g;
				$tmpedge =~ s/PPPPP/$i/g;
				$tmpedge =~ s/QQQQQ/$j/g;
				$tmpedge =~ s/OOOOO/$class/g;
				$tmpedge =~ s/RRRRR/$outnet{$i}{$j}[0]/g;
				$tmpedge =~ s/SSSSS/$outnet{$i}{$j}[1]/g;
				$tmpedge =~ s/MMMMM/$outnetnodes{$i}[1]$outnetnodes{$i}[2]/g;
				$tmpedge =~ s/NNNNN/$outnetnodes{$j}[1]$outnetnodes{$j}[2]/g;
				$tmpedge =~ s/ZZZZZ/$color/g;
				$edgesx .= $tmpedge;
				$counter++;
			}
		}
	}
	open (F, ">$folder/$outfile.xgmml") or die "can't open $outfile.xgmml\n";
	print F $headnet;
	print F $nodesx;
	print F $edgesx;
	print F "</graph>";
	close F;
	open (F, ">$folder/$outfile\_nodes.tsv") or die "can't open $outfile\_nodes.tsv\n";
	print F $nodestable;
	close F;
	open (F, ">$folder/$outfile\_edges.tsv") or die "can't open $outfile\_edges.tsv\n";
	print F $edgestable;
	close F;
	open (F, ">$folder/$outfile\_D3.tsv") or die "can't open $outfile\_nodesD3.tsv\n";
	print F "\tvar nodes = new vis.DataSet([\n";
	print F $nodestableD3;
	print F "\t]);\n\tvar edges = new vis.DataSet([\n";
	print F $edgestableD3;
	print F "\t]);";
	close F;
	#~ open (F, ">$folder/$outfile\_nodesD3.tsv") or die "can't open $outfile\_nodesD3.tsv\n";
	#~ print F $nodestableD3;
	#~ close F;
	#~ open (F, ">$folder/$outfile\_edgesD3.tsv") or die "can't open $outfile\_edgesD3.tsv\n";
	#~ print F $edgestableD3;
	#~ close F;
}
