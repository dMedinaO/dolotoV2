sub compute_stats{
	my @tmp = ($_[0],$_[1],$_[2],$_[3]);
	for (my $ii = 4; $ii < 23; $ii++){
		$tmp[$ii] = 0;
	}
	if($tmp[0] + $tmp[3]){
		$tmp[4] = ($tmp[0] / ($tmp[0] + $tmp[3]));#tp/(tp+fn),R
	}
	if($tmp[2] + $tmp[1]){
		$tmp[5] = ($tmp[2] / ($tmp[2] + $tmp[1]));#tn/(tn+fp),TNR
	}
	if($tmp[0] + $tmp[1]){
		$tmp[6] = ($tmp[0] / ($tmp[0] + $tmp[1]));#tp/(tp+fp),P
	}
	if($tmp[2] + $tmp[3]){
		$tmp[7] = ($tmp[2] / ($tmp[2] + $tmp[3]));#tn/(tn+fn),NPV
	}
	if($tmp[2] + $tmp[1]){
		$tmp[8] = ($tmp[1] / ($tmp[2] + $tmp[1]));#fp/(fp+tn),FPR
	}
	if($tmp[0] + $tmp[1]){
		$tmp[9] = ($tmp[1] / ($tmp[0] + $tmp[1]));#fp/(fp+tp),FDR
	}
	if($tmp[0] + $tmp[3]){
		$tmp[10] = ($tmp[3] / ($tmp[0] + $tmp[3]));#fn/(fn+tp),FNR
	}
	if($tmp[0] + $tmp[1] + $tmp[2] + $tmp[3]){
		$tmp[11] = (($tmp[0] + $tmp[2]) / ($tmp[0] + $tmp[1] + $tmp[2] + $tmp[3]));#(tp+tn)/(tp+fp+tn+fn),ACC
	}
	if($tmp[4] + $tmp[6]){
		$tmp[12] = (2* ($tmp[4] * $tmp[6]) / ($tmp[4] + $tmp[6]));#(2PR)/(P+R),F1
	}
	if(0 != (($tmp[0] + $tmp[1])  * ($tmp[0] + $tmp[3]) * ($tmp[2] + $tmp[1])  * ($tmp[2] + $tmp[3]))){
		$tmp[13] = (($tmp[0] * $tmp[2] - $tmp[1] * $tmp[3]) / sqrt(($tmp[0] + $tmp[1])  * ($tmp[0] + $tmp[3]) * ($tmp[2] + $tmp[1])  * ($tmp[2] + $tmp[3])));#MCC
	}
	$tmp[14] =  ($tmp[4] + $tmp[5] - 1);#R+TNR-1, infor
	$tmp[15] =  ($tmp[6] + $tmp[7] - 1);#P+NPV-1,marked
	if($tmp[1] + $tmp[3] + $tmp[0]){
		$tmp[16] = ($tmp[0]/($tmp[1] + $tmp[3] + $tmp[0]));#TP/(TP+FN+FP),J
	}
	if($tmp[0] + $tmp[0] + $tmp[1] + $tmp[3]){
		$tmp[17] = ($tmp[0]  / ($tmp[0] + $tmp[0] + $tmp[1] + $tmp[3]));#(tp)/(2tp+tn+fn),SD
	}
	if($tmp[1] + $tmp[3]){
		$tmp[18] = ($tmp[0]  / ($tmp[1] + $tmp[3]));#(tp)/(fp+fn),K1
	}
	$tmp[19] =  ($tmp[6] + $tmp[7] )/2;#(R+P)/2,K2
	my $temp = ($tmp[0] + $tmp[1]) * ($tmp[0] + $tmp[3]);
	if($temp > 0){
		$tmp[20] = ($tmp[0]  / sqrt($temp));#(tp)/sqrt((tp+fn)(tp+fp)),O
	}
	if($temp > 0){
		$tmp[21] = (($tmp[0] * $tmp[0])  / $temp);#(tp*tp)/(tp+fn)(tp+fp),CR
	}
	$tmp[22] = ($tmp[1] + $tmp[3]);#tp+fn,Hammin
	return @tmp;
}
