#!/system/bin/sh
#=============================================================================
#persist.debug.cpu.dvfs.config
#testing_phase=`getprop persist.debug.cpu.dvfs.config`
#=============================================================================

echo "Just for CPU DVFS Debug"

#ntest*delay= 1200S
ntest=4000
delay=0.3	## 300ms

platform=`getprop ro.board.platform`

lit_cfrqs=(300000 691200 806400 940800 115200 1324800 1516800 1651200 1804800)
big_cfrqs=(691200 940800 1228800 1344000 1516800 1651200 1900800 2054400 2131200 2400000)
gold_cfrqs=(806400 1056000 1324800 1516800 1766400 1862400 2035200 2208000 2380800 2400000)
policies=(0 4 7)

if [ x"$platform" = x"taro" ]; then
	echo taro
	lit_cfrqs=(307200 403200 518400 614400 710400 806400 902400 998400 1094400 1190400 1286400 1363200 1459200 1536000 1632000 1708800 1785600)
	big_cfrqs=(633600 729600 844800 940800 1036800 1152000 1248000 1344000 1459200 1555200 1651200 1766400 1862400 1977600 2073600 2169600)
	gold_cfrqs=(729600 844800 960000 1075200 1190400 1305600 1420800 1536000 1651200 1766400 1881600 1996800 2112000 2227200 2323200 2419200)
	policies=(0 4 7)
fi

if [ x"$platform" = x"kalama" ]; then
	echo kalama
	lit_cfrqs=(307200 403200 518400 614400 729600 825600 921600 1017600 1113600 1228800 1324800 1420800 1516800 1632000 1728000 1824000)
	big_cfrqs=(307200 422400 537600 652800 768000 883200 998400 1113600 1228800 1344000 1459200 1555200 1670400 1766400 1881600 1996800 2112000 2227200 2342400)
	gold_cfrqs=(384000 499200 633600 748800 883200 998400 1132800 1248000 1382400 1497600 1593600 1708800 1804800 1920000 2016000 2131200 2246400 2361600 2476800 2592000 2707200)
	policies=(0 3 7)
fi

if [ x"$platform" = x"pineapple" ]; then
	echo pineapple
	lit_cfrqs=(307200 460800 556800 672000 787200 902400 1017600 1132800 1248000 1344000 1440000 1536000 1651200 1747200 1843200 1939200)
	mid_cfrqs=(460800 576000 691200 806400 902400 1036800 1152000 1267200 1382400 1497600 1612800 1728000 1843200 1958400 2073600 2188800 2304000 2400000)
	big_cfrqs=(460800 576000 691200 806400 902400 1036800 1152000 1267200 1382400 1497600 1612800 1728000 1843200 1958400 2073600 2188800 2304000 2400000)
	gold_cfrqs=(499200 614400 729600 844800 940800 1075200 1190400 1305600 1420800 1555200 1670400 1804800 1939200 2073600 2208000 2342400 2457600 2361600 2457600)
	policies=(0 2 5 7)
fi

display_freq() {
  echo "policy0 cur_freq: " $(< /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq)
  if [ x"$platform" = x"pineapple" ]; then
    echo "policy2 cur_freq: " $(< /sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq)
  fi
  if [ x"$platform" = x"kalama" ]; then
    echo "policy3 cur_freq: " $(< /sys/devices/system/cpu/cpufreq/policy3/scaling_cur_freq)
  elif [ x"$platform" = x"pineapple" ]; then
    echo "policy5 cur_freq: " $(< /sys/devices/system/cpu/cpufreq/policy5/scaling_cur_freq)
  else
    echo "policy4 cur_freq: " $(< /sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq)
  fi
  echo "policy7 cur_freq: " $(< /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq)
}

#cpu dvfs ramdom
do_cpudvfs_ramdom(){
	for i in $(seq 1 ${ntest})
	do
		l=$(($RANDOM%${#lit_cfrqs[@]}))
		g=$(($RANDOM%${#big_cfrqs[@]}))
		gg=$(($RANDOM%${#gold_cfrqs[@]}))
		if [ x"$platform" = x"pineapple" ]; then
		  m=$(($RANDOM%${#mid_cfrqs[@]}))
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_min_freq
		else
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		fi
		display_freq
		sleep ${delay}
	done
}

#cpu dvfs fixOPP0
do_cpudvfs_fixOPPmin(){
	echo "cpu dvfs fixOPPmin"
	for i in $(seq 1 ${ntest})
	do
		l=0
		g=0
		gg=0
		if [ x"$platform" = x"pineapple" ]; then
		  m=0
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_min_freq
                else
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		fi
		display_freq
		sleep ${delay}
	done
}


#cpu dvfs fixOPP15
do_cpudvfs_fixOPPmax(){
	echo "cpu dvfs fixOPPmax"
	for i in $(seq 1 ${ntest})
	do
		l=${#lit_cfrqs[@]}-1
		g=${#big_cfrqs[@]}-1
		gg=${#gold_cfrqs[@]}-1
		if [ x"$platform" = x"pineapple" ]; then
		  m=${#mid_cfrqs[@]}-1
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_min_freq
                else
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
                fi
		
		display_freq
		sleep ${delay}
	done
}


#cpu dvfs OPP0-OPP15
do_cpudvfs_OPPmax_OPPmin(){
	echo "cpu dvfs fixOPP0"
	for i in $(seq 1 ${ntest})
	do
		check=$(($RANDOM%2))
		if [ $check -eq 0 ]; then
			l=0
			g=0
			gg=0
		else
			l=${#lit_cfrqs[@]}-1
			g=${#big_cfrqs[@]}-1
			gg=${#gold_cfrqs[@]}-1
		fi
		if [ x"$platform" = x"pineapple" ]; then
		  if [ $check -eq 0 ]; then
		        m=0
                  else
                        m=${#mid_cfrqs[@]}-1
                  fi
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_min_freq
                else
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
                fi
		display_freq
		sleep ${delay}
	done
}

do_cpudvfs_longstep_random(){
	echo "cpu dvfs long step random"
	llen=$((${#lit_cfrqs[@]}-1))
	glen=$((${#big_cfrqs[@]}-1))
	gglen=$((${#gold_cfrqs[@]}-1))
	lcurrent=0
	gcurrent=0
	ggcurrent=0
	lmid=$(($llen/2))
	gmid=$(($glen/2))
	ggmid=$(($gglen/2))
	if [ x"$platform" = x"pineapple" ]; then
	  mlen=$((${#mid_cfrqs[@]}-1))
          mcurrent=0
          mmid=$(($mlen/2))
        fi
	for i in $(seq 1 ${ntest})
	do
		do_cpuhotplug
	
		lstep=$(($(($RANDOM%$(($llen-5))))+5))
		gstep=$(($(($RANDOM%$(($glen-5))))+5))
		ggstep=$(($(($RANDOM%$(($gglen-5))))+5))
	        if [ x"$platform" = x"pineapple" ]; then
                  mstep=$(($(($RANDOM%$(($mlen-5))))+5))
		fi

		if [ $lcurrent -lt $lstep ]; then
			lcurrent=$(($lcurrent+$lstep))
		else
			lcurrent=$(($lcurrent-$lstep))
		fi
	        if [ x"$platform" = x"pineapple" ]; then
		  if [ $mcurrent -lt $mstep ]; then
			mcurrent=$(($mcurrent+$mstep))
		  else
			mcurrent=$(($mcurrent-$mstep))
		  fi
                fi  
		if [ $gcurrent -lt $gstep ]; then
			gcurrent=$(($gcurrent+$gstep))
		else
			gcurrent=$(($gcurrent-$gstep))
		fi
		if [ $ggcurrent -lt $ggstep ]; then
			ggcurrent=$(($ggcurrent+$ggstep))
		else
			ggcurrent=$(($ggcurrent-$ggstep))
		fi
		
		if [ $lcurrent -lt 0 ]; then
			lcurrent=0
		fi
	        if [ x"$platform" = x"pineapple" ]; then
		  if [ $mcurrent -lt 0 ]; then
			mcurrent=0
		  fi
                fi
		if [ $gcurrent -lt 0 ]; then
			gcurrent=0
		fi
		if [ $ggcurrent -lt 0 ]; then
			ggcurrent=0
		fi
		
		if [ $lcurrent -eq $llen ]; then
			lcurrent=$llen
		fi
	        if [ x"$platform" = x"pineapple" ]; then
		  if [ $mcurrent -eq $mlen ]; then
			mcurrent=$mlen
		  fi
                fi
		if [ $gcurrent -eq $glen ]; then
			gcurrent=$glen
		fi
		if [ $ggcurrent -eq $gglen ]; then
			ggcurrent=$gglen
		fi
		
		if [ $lcurrent -gt $llen ]; then
			lcurrent=$llen
		fi
	        if [ x"$platform" = x"pineapple" ]; then
		  if [ $mcurrent -gt $mlen ]; then
			mcurrent=$mlen
		  fi
                fi
		if [ $gcurrent -gt $glen ]; then
			gcurrent=$glen
		fi
		if [ $ggcurrent -gt $gglen ]; then
			ggcurrent=$gglen
		fi
		
	        if [ x"$platform" = x"pineapple" ]; then
		  echo ${lit_cfrqs[lcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[lcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${mid_cfrqs[mcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${mid_cfrqs[mcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${big_cfrqs[gcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${big_cfrqs[gcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		  echo ${gold_cfrqs[ggcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_max_freq
		  echo ${gold_cfrqs[ggcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_min_freq
                else
		  echo ${lit_cfrqs[lcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[lcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${big_cfrqs[gcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${big_cfrqs[gcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${gold_cfrqs[ggcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${gold_cfrqs[ggcurrent]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
                fi
		echo ${lcurrent}
	        if [ x"$platform" = x"pineapple" ]; then
		  echo ${mcurrent}
		fi
		echo ${gcurrent}
		echo ${ggcurrent}
		display_freq
		sleep ${delay}
	done
}

do_cpudvfs_shortstep_random(){
	echo "cpu dvfs short step random"
	l=$(($RANDOM%${#lit_cfrqs[@]}))
	if [ x"$platform" = x"pineapple" ]; then
	  m=$(($RANDOM%${#mid_cfrqs[@]}))
	fi
	g=$(($RANDOM%${#big_cfrqs[@]}))
	gg=$(($RANDOM%${#gold_cfrqs[@]}))
	for i in $(seq 1 ${ntest})
	do
		do_cpuhotplug
		LL_step=$(($RANDOM%3))
		L_step=$(($RANDOM%3))
		SL_step=$(($RANDOM%3))

		l=$(($l+1+$LL_step))
		g=$(($g+1+$L_step))
		gg=$(($gg+1+$SL_step))

		l=$(($l%${#lit_cfrqs[@]}))
		g=$(($g%${#big_cfrqs[@]}))
		gg=$(($gg%${#gold_cfrqs[@]}))

	        if [ x"$platform" = x"pineapple" ]; then
		  M_step=$(($RANDOM%3))
		  m=$(($m+1+$M_step))
		  m=$(($m%${#mid_cfrqs[@]}))
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${mid_cfrqs[m]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[3]}/scaling_min_freq
                else
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_max_freq
		  echo ${lit_cfrqs[l]} > /sys/devices/system/cpu/cpufreq/policy${policies[0]}/scaling_min_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_max_freq
		  echo ${big_cfrqs[g]} > /sys/devices/system/cpu/cpufreq/policy${policies[1]}/scaling_min_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_max_freq
		  echo ${gold_cfrqs[gg]} > /sys/devices/system/cpu/cpufreq/policy${policies[2]}/scaling_min_freq
                fi
		display_freq
		sleep ${delay}
	done
}


#cpu Hotplug ittle cpu core >=2, big core >=0
do_cpuhotplug(){
	# little cpu core >=2, big core >=0
	
}


enable_cpu_hotplug_dvfs_test(){
	while [ 1 ]
	do
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		if [ "$cpu_debugconfig" = "done" ]; then
			break
		fi
		setprop persist.debug.cpu.dvfs.config max
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		echo "cpu_debugconfig:$cpu_debugconfig."
		if [ "$cpu_debugconfig" = "max" ]; then
			do_cpudvfs_fixOPPmax
		fi

		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		if [ "$cpu_debugconfig" = "done" ]; then
			break
		fi
		setprop persist.debug.cpu.dvfs.config min
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		echo "cpu_debugconfig:$cpu_debugconfig."
		if [ "$cpu_debugconfig" = "min" ]; then
			do_cpudvfs_fixOPPmin
		fi

		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		if [ "$cpu_debugconfig" = "done" ]; then
			break
		fi
		setprop persist.debug.cpu.dvfs.config max_min
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		echo "cpu_debugconfig:$cpu_debugconfig."
		if [ "$cpu_debugconfig" = "max_min" ]; then
			do_cpudvfs_OPPmax_OPPmin
		fi

		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		if [ "$cpu_debugconfig" = "done" ]; then
			break
		fi
		setprop persist.debug.cpu.dvfs.config longstep_random
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		echo "cpu_debugconfig:$cpu_debugconfig."
		if [ "$cpu_debugconfig" = "longstep_random" ]; then
			do_cpudvfs_longstep_random
		fi

		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		if [ "$cpu_debugconfig" = "done" ]; then
			break
		fi
		setprop persist.debug.cpu.dvfs.config shortstep_random
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		echo "cpu_debugconfig:$cpu_debugconfig."
		if [ "$cpu_debugconfig" = "shortstep_random" ]; then
			do_cpudvfs_shortstep_random
		fi

		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		if [ "$cpu_debugconfig" = "done" ]; then
			break
		fi
		setprop persist.debug.cpu.dvfs.config ramdom
		cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
		echo "cpu_debugconfig:$cpu_debugconfig."
		if [ "$cpu_debugconfig" = "random" ]; then
			do_cpudvfs_ramdom
		fi
	done
	echo "The test is done and PASS if no exception occurred."
}

enable_cpu_hotplug_dvfs_test_manual(){
	cpu_debugconfig=`getprop persist.debug.cpu.dvfs.config`
	while [ 1 ] 
	do
		if [ "$cpu_debugconfig" != "done" ]; then
			break
		fi
		cpu_manualconfig=`getprop persist.debug.cpu.dvfs.manual`
		echo "cpu_manualconfig:$cpu_manualconfig."
		if [ "$cpu_manualconfig" = "random" ]; then
			do_cpudvfs_ramdom
		elif [ "$cpu_manualconfig" = "max" ]; then
			do_cpudvfs_fixOPPmax
		elif [ "$cpu_manualconfig" = "min" ]; then
			do_cpudvfs_fixOPPmin
		elif [ "$cpu_manualconfig" = "max_min" ]; then
			do_cpudvfs_OPPmax_OPPmin
		elif [ "$cpu_manualconfig" = "longstep_random" ]; then
			do_cpudvfs_longstep_random
		elif [ "$cpu_manualconfig" = "shortstep_random" ]; then
			do_cpudvfs_shortstep_random
		elif [ "$cpu_manualconfig" = "done" ]; then
			break
		else
			sleep 10
		fi
	done
	echo "The cpu_manualconfig is done and PASS if no exception occurred."
}

enable_cpu_hotplug_dvfs_test
enable_cpu_hotplug_dvfs_test_manual
