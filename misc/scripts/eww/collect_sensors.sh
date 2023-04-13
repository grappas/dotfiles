
#!/bin/sh

#while [ true ]
#do
#sensors -j > ~/temp/sensors.json
#zenmonitor-cli -o > ~/temp/zenmonitor.out
#cat ~/temp/sensors.json | jq '."amdgpu-pci-0a00" | .PPT | .power1_average' | sed 's/\..*$//g' > ~/temp/sensors.amdgpu.power
#cat ~/temp/sensors.json  | jq '."zenpower-pci-00c3" |.SVI2_P_Core|.power1_input' | sed 's/\..*$//g' > ~/temp/sensors.zenpower.power
#cat ~/temp/sensors.json | jq '."zenpower-pci-00c3" | .Tdie | .temp1_input' | sed 's/\..*$//g' > ~/temp/sensors.zenpower.temp
#cat ~/temp/sensors.json | jq '."amdgpu-pci-0a00" | .edge | .temp1_input' > ~/temp/sensors.amdgpu.temp
#sudo cat /sys/kernel/debug/dri/0/amdgpu_pm_info | grep SCLK | grep -v PSTATE | sed 's/\ MHz\ (SCLK)//g' | sed 's/\t//g' > ~/temp/gpu_frequency.out

    #BLACHA=0
    #for each in $(cat ~/temp/zenmonitor.out | grep -i frequency | sed 's/Core\ [0-9]\ Frequency\t//g' | sed 's/\.//g' | sed 's/...$//g')
    #do
    #if [ $BLACHA -le $each ]
    #then
    #BLACHA=$each
    #fi
    #done
    #echo $BLACHA > ~/temp/cpu_frequency.out


    #sleep 1s
    #done

    LANG=en mpstat 1 1 -T -P ALL | grep Average | sed 's/Average:    //g' > ~/temp/mpstat.out

    cat ~/temp/mpstat.out | grep all | while read all usr nice sys iowait irq soft steal guest gnice idle
do
    echo $[ 100 - $( echo $idle | sed 's/\..*$//g' ) ] > ~/temp/cpu_usage.out
done

    >~/temp/mpstat.out.per_core.temp

    cat ~/temp/mpstat.out | grep -v all | grep -v CPU | while read CPU CORE SOCK NODE usr nice sys iowait irq soft steal guest gnice idle
do
    if (( ($( echo $idle | sed 's/\.//g' ) % 100 ) >= 50 ))
    then
        SUM=$[ $( echo $idle | sed 's/\..*$//g' ) + 1 ]
    else
        SUM=$(echo $idle | sed 's/\..*$//g')
    fi

    echo "$CORE $(( 100 - $SUM ))" >> ~/temp/mpstat.out.per_core.temp
done

cat ~/temp/mpstat.out.per_core.temp > ~/temp/mpstat.out.per_core
>~/temp/mpstat.out.per_core_raw.temp

seq 0 $[$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}') - 1] | while read each
do
    cat ~/temp/mpstat.out.per_core | grep "$each " | sed 's/^.*\ //g' | tr '\n' ' ' >> ~/temp/mpstat.out.per_core_raw.temp
    echo " " >> ~/temp/mpstat.out.per_core_raw.temp
done
cat ~/temp/mpstat.out.per_core_raw.temp > ~/temp/mpstat.out.per_core_raw

    sensors -j > ~/temp/sensors.json
    sudo zenmonitor-cli -o > ~/temp/zenmonitor.out.temp
    cat ~/temp/zenmonitor.out.temp > ~/temp/zenmonitor.out
    cat ~/temp/sensors.json | jq '."amdgpu-pci-0a00" | .PPT | .power1_average' | sed 's/\..*$//g' > ~/temp/sensors.amdgpu.power
    #cat ~/temp/sensors.json  | jq '."zenpower-pci-00c3" |.SVI2_P_Core|.power1_input' | sed 's/\..*$//g' > ~/temp/sensors.zenpower.power
    cat ~/temp/zenmonitor.out | grep "Package Power" | sed 's/Package\ Power\t//g' | sed 's/\..*$//g' > ~/temp/sensors.zenpower.power
    cat ~/temp/zenmonitor.out | grep "CPU Core Voltage" | sed 's/CPU\ Core\ Voltage\ (SVI2)\t//g' > ~/temp/sensors.zenpower.voltage
    cat ~/temp/sensors.json | jq '."zenpower-pci-00c3" | .Tdie | .temp1_input' | sed 's/\..*$//g' > ~/temp/sensors.zenpower.temp
    cat ~/temp/sensors.json | jq '."amdgpu-pci-0a00" | .edge | .temp1_input' > ~/temp/sensors.amdgpu.temp
    sudo cat /sys/kernel/debug/dri/0/amdgpu_pm_info | grep SCLK | grep -v PSTATE | sed 's/\ MHz\ (SCLK)//g' | sed 's/\t//g' > ~/temp/gpu_frequency.out



BLACHA=0
for each in $(cat ~/temp/zenmonitor.out | grep -i frequency | grep -v -i effective | sed 's/Core\ [0-9]\ Frequency\t//g' | sed 's/\.//g' | sed 's/...$//g')
do
    if [ $BLACHA -le $each ]
    then
        BLACHA=$each
    fi
done
echo $BLACHA > ~/temp/cpu_frequency.out

