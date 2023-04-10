
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
echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')] > ~/temp/cpu_usage.out
sensors -j > ~/temp/sensors.json
sudo zenmonitor-cli -o > ~/temp/zenmonitor.out
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



