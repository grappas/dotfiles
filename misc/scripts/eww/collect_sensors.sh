
#!/bin/sh

LANG=en mpstat 1 1 -T -P ALL | grep Average | sed 's/Average:    //g' > /tmp/eww/mpstat.out

cat /tmp/eww/mpstat.out | grep all | while read all usr nice sys iowait irq soft steal guest gnice idle
do
    echo $[ 100 - $( echo $idle | sed 's/\..*$//g' ) ] > /tmp/eww/cpu_usage.out
done

>/tmp/eww/mpstat.out.per_core.temp

cat /tmp/eww/mpstat.out | grep -v all | grep -v CPU | while read CPU CORE SOCK NODE usr nice sys iowait irq soft steal guest gnice idle
do
    if (( ($( echo $idle | sed 's/\.//g' ) % 100 ) >= 50 ))
    then
        SUM=$[ $( echo $idle | sed 's/\..*$//g' ) + 1 ]
    else
        SUM=$(echo $idle | sed 's/\..*$//g')
    fi

    echo "$CORE $(( 100 - $SUM ))" >> /tmp/eww/mpstat.out.per_core.temp
done

cat /tmp/eww/mpstat.out.per_core.temp > /tmp/eww/mpstat.out.per_core
>/tmp/eww/mpstat.out.per_core_raw.temp

seq 0 $[$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}') - 1] | while read each
do
    cat /tmp/eww/mpstat.out.per_core | grep "$each " | sed 's/^.*\ //g' | tr '\n' ' ' >> /tmp/eww/mpstat.out.per_core_raw.temp
    echo " " >> /tmp/eww/mpstat.out.per_core_raw.temp
done
cat /tmp/eww/mpstat.out.per_core_raw.temp > /tmp/eww/mpstat.out.per_core_raw

sensors -j > /tmp/eww/sensors.json

AMDGPU=$(cat /tmp/eww/sensors.json | grep amdgpu-pci | sed 's/^.*\"a/a/g' | sed 's/\".*$//g')
ZENPOWER=$(cat /tmp/eww/sensors.json | grep zenpower-pci | sed 's/^.*\"z/z/g' | sed 's/\".*$//g')
sudo zenmonitor-cli -o > /tmp/eww/zenmonitor.out.temp
cat /tmp/eww/zenmonitor.out.temp > /tmp/eww/zenmonitor.out
cat /tmp/eww/sensors.json | jq --arg AMDGPU "$AMDGPU" '.[$ARGS.named.AMDGPU] | .PPT | .power1_average' | sed 's/\..*$//g' > /tmp/eww/sensors.amdgpu.power
cat /tmp/eww/zenmonitor.out | grep "Package Power" | sed 's/Package\ Power\t//g' | sed 's/\..*$//g' > /tmp/eww/sensors.zenpower.power
cat /tmp/eww/zenmonitor.out | grep "CPU Core Voltage" | sed 's/CPU\ Core\ Voltage\ (SVI2)\t//g' > /tmp/eww/sensors.zenpower.voltage
cat /tmp/eww/sensors.json | jq --arg ZENPOWER "$ZENPOWER" '.[$ARGS.named.ZENPOWER] | .Tdie | .temp1_input' | sed 's/\..*$//g' > /tmp/eww/sensors.zenpower.temp
cat /tmp/eww/sensors.json | jq --arg AMDGPU "$AMDGPU" '.[$ARGS.named.AMDGPU] | .edge | .temp1_input' > /tmp/eww/sensors.amdgpu.temp
cat /tmp/eww/sensors.json | jq --arg AMDGPU "$AMDGPU" '.[$ARGS.named.AMDGPU] | .vddgfx | .in0_input' > /tmp/eww/sensors.amdgpu.vdd

echo "$(cat /sys/class/drm/card1/device/mem_info_gtt_used)/1024/1024" | bc > /tmp/eww/gpu.gtt.used
echo "$(cat /sys/class/drm/card1/device/mem_info_gtt_total)/1024/1024" | bc > /tmp/eww/gpu.gtt.total
echo "$(cat /sys/class/drm/card1/device/mem_info_vram_used)/1024/1024" | bc > /tmp/eww/gpu.vram.used
echo "$(cat /sys/class/drm/card1/device/mem_info_vram_total)/1024/1024" | bc > /tmp/eww/gpu.vram.total
sh ~/.config/eww/scripts/gpu_percentage_polling.sh&

BLACHA=0
for each in $(cat /tmp/eww/zenmonitor.out | grep -i frequency | grep -v -i effective | sed 's/Core\ [0-9]\ Frequency\t//g' | sed 's/\.//g' | sed 's/...$//g')
do
    if [ $BLACHA -le $each ]
    then
        BLACHA=$each
    fi
done
echo $BLACHA > /tmp/eww/cpu_frequency.out

