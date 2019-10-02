#!/bin/bash
jusqua20(){
	zeroVingt=('zéro' 'un' 'deux' 'trois' 'quatre' 'cinq' 'six' 'sept' 'huit' 'neuf' 'dix' 'onze' 'douze' 'treize' 'quatorze' 'quinze' 'seize' 'dix-sept' 'dix-huit' 'dix-neuf');
	echo -n ${zeroVingt[$1]};
}
jusqua100(){
	vingtCent=('ving' 'trente' 'quarante' 'cinquante' 'soixante' 'soixante-dix' 'quatre-vingts' 'quatre-vingts-dix');
	if test $1 -lt 20; then
		jusqua20 $1;
	else
		#echo -n ${vingtCent[$[$(($1/10))-2] | bc ]};
		decade=$(($1/10));
		remains=$[$1-$[10*$decade]];
		if test $remains -eq 0;then
			echo -n ${vingtCent[$[$decade-2]]};
		else if test $decade -le 6; then
			echo -n ${vingtCent[$[$decade-2]]};
			#echo -n " ";
			if test $remains -eq 1; then
				echo -n " et ";
			else
				echo -n "-"
			fi
			jusqua20 $remains;
			else
				dbldecade=$[$decade/2];
				echo -n ${vingtCent[$[$[$dbldecade*2]-2]]};
				rmn=$[$1-$[20*$dbldecade]];
				if test $dbldecade -eq 3 && test $rmn -eq 11; then
					echo -n "-et-"
				else
					echo -n "-";
				fi
				jusqua20 $rmn;
			fi
		fi
	fi
}
jusqua1000(){
	if test $1 -lt 100; then
		jusqua100 $1;
	else
		cents=$[$1/100];
		rem=$[$1-$[$cents*100]];
		if test $rem -eq 0; then
			if test $cents -eq 1; then
				echo -n "cent";
			else
				jusqua20 $cents;
				echo -n " cents";
			fi
		else
			jusqua20 $cents;
			echo -n " cent ";
			jusqua100 $rem;
		fi
	fi
}
jusqua1000000(){
	if test $1 -lt 1000; then
		jusqua1000 $1;
	else
		milles=$[$1/1000];
		remm=$[$1-$[$milles*1000]];
		jusqua1000 $milles;
		echo -n " mille ";
		if test $remm -gt 0; then
			jusqua1000 $remm;
		fi
	fi
}

jusqua1000000000(){
	if test $1 -lt 1000000; then
		jusqua1000000 $1;
	else
		millions=$[$1/1000000];
		remmm=$[$1-$[$millions*1000000]];
		jusqua1000 $millions;
		echo -n " million ";
		if test $remmm -gt 0; then
			jusqua1000000 $remmm;
		fi
	fi
}

re='^[0-9]+$'
if ! [[ $1 =~ $re ]]; then
	echo "Erreur: Pas un nombre!";
	exit 1;
else
	if test $1 -lt 1000000000; then
		jusqua1000000000 $1;
		echo;
	else
		echo "Erreur: Nombre trop grand!";

	fi
fi
