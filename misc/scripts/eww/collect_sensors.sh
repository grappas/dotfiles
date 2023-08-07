
#!/bin/sh

LANG=en mpstat 1 1 -T -P ALL | grep Average | sed 's/Average:    //g' > ~/temp/eww/mpstat.out

cat ~/temp/eww/mpstat.out | grep all | while read all usr nice sys iowait irq soft steal guest gnice idle
do
    echo $[ 100 - $( echo $idle | sed 's/\..*$//g' ) ] > ~/temp/eww/cpu_usage.out
done

>~/temp/eww/mpstat.out.per_core.temp

cat ~/temp/eww/mpstat.out | grep -v all | grep -v CPU | while read CPU CORE SOCK NODE usr nice sys iowait irq soft steal guest gnice idle
do
    if (( ($( echo $idle | sed 's/\.//g' ) % 100 ) >= 50 ))
    then
        SUM=$[ $( echo $idle | sed 's/\..*$//g' ) + 1 ]
    else
        SUM=$(echo $idle | sed 's/\..*$//g')
    fi

    echo "$CORE $(( 100 - $SUM ))" >> ~/temp/eww/mpstat.out.per_core.temp
done

cat ~/temp/eww/mpstat.out.per_core.temp > ~/temp/eww/mpstat.out.per_core
>~/temp/eww/mpstat.out.per_core_raw.temp

seq 0 $[$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}') - 1] | while read each
do
    cat ~/temp/eww/mpstat.out.per_core | grep "$each " | sed 's/^.*\ //g' | tr '\n' ' ' >> ~/temp/eww/mpstat.out.per_core_raw.temp
    echo " " >> ~/temp/eww/mpstat.out.per_core_raw.temp
done
cat ~/temp/eww/mpstat.out.per_core_raw.temp > ~/temp/eww/mpstat.out.per_core_raw

sensors -j > ~/temp/eww/sensors.json

AMDGPU=$(cat ~/temp/eww/sensors.json | grep amdgpu-pci | sed 's/^.*\"a/a/g' | sed 's/\".*$//g')
ZENPOWER=$(cat ~/temp/eww/sensors.json | grep zenpower-pci | sed 's/^.*\"z/z/g' | sed 's/\".*$//g')
sudo zenmonitor-cli -o > ~/temp/eww/zenmonitor.out.temp
cat ~/temp/eww/zenmonitor.out.temp > ~/temp/eww/zenmonitor.out
cat ~/temp/eww/sensors.json | jq --arg AMDGPU "$AMDGPU" '.[$ARGS.named.AMDGPU] | .PPT | .power1_average' | sed 's/\..*$//g' > ~/temp/eww/sensors.amdgpu.power
cat ~/temp/eww/zenmonitor.out | grep "Package Power" | sed 's/Package\ Power\t//g' | sed 's/\..*$//g' > ~/temp/eww/sensors.zenpower.power
cat ~/temp/eww/zenmonitor.out | grep "CPU Core Voltage" | sed 's/CPU\ Core\ Voltage\ (SVI2)\t//g' > ~/temp/eww/sensors.zenpower.voltage
cat ~/temp/eww/sensors.json | jq --arg ZENPOWER "$ZENPOWER" '.[$ARGS.named.ZENPOWER] | .Tdie | .temp1_input' | sed 's/\..*$//g' > ~/temp/eww/sensors.zenpower.temp
cat ~/temp/eww/sensors.json | jq --arg AMDGPU "$AMDGPU" '.[$ARGS.named.AMDGPU] | .edge | .temp1_input' > ~/temp/eww/sensors.amdgpu.temp
cat ~/temp/eww/sensors.json | jq --arg AMDGPU "$AMDGPU" '.[$ARGS.named.AMDGPU] | .vddgfx | .in0_input' > ~/temp/eww/sensors.amdgpu.vdd

echo "$(cat /sys/class/drm/card1/device/mem_info_gtt_used)/1024/1024" | bc > ~/temp/eww/gpu.gtt.used
echo "$(cat /sys/class/drm/card1/device/mem_info_gtt_total)/1024/1024" | bc > ~/temp/eww/gpu.gtt.total
echo "$(cat /sys/class/drm/card1/device/mem_info_vram_used)/1024/1024" | bc > ~/temp/eww/gpu.vram.used
echo "$(cat /sys/class/drm/card1/device/mem_info_vram_total)/1024/1024" | bc > ~/temp/eww/gpu.vram.total
sh ~/.config/eww/scripts/gpu_percentage_polling.sh&

BLACHA=0
for each in $(cat ~/temp/eww/zenmonitor.out | grep -i frequency | grep -v -i effective | sed 's/Core\ [0-9]\ Frequency\t//g' | sed 's/\.//g' | sed 's/...$//g')
do
    if [ $BLACHA -le $each ]
    then
        BLACHA=$each
    fi
done
echo $BLACHA > ~/temp/eww/cpu_frequency.out

