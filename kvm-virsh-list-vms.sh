#this is nice by holeun.lee@gmail.com

#!/bin/bash

virsh list | grep running | while read -r line;
        do
                #VM=$(echo "$line" | sed 's/[0-9][ ]*\([-._0-9a-zA-Z]*\)[ ]*running/\1/' );
                VM=$(echo "$line" | awk '{print $2}' );
                        VCPU=$(virsh dumpxml $VM | grep "vcpu" | sed "s/.*<vcpu[^>]*>\(.*\)<\/vcpu>.*/\1/g")
                        MEMORY=$(virsh dumpxml $VM | grep "memory unit" | sed "s/.*<memory[^>]*>\(.*\)<\/memory>.*/\1/g")
                        let "NEWMEMORY= $MEMORY/1024"
                        MAC=$(virsh dumpxml $VM | grep "mac address" | sed "s/.*'\(.*\)'.*/\1/g")
                        BRIDGE=$(virsh dumpxml $VM | grep "source bridge" | sed "s/.*'\(.*\)'.*/\1/g")
                        IP=$(arp -an | grep "`virsh dumpxml $VM | grep "mac address" | sed "s/.*'\(.*\)'.*/\1/g"`" | awk '{ gsub(/[\(\)]/,"",$2); print $2 }')
                echo "========================================================="
                        printf "VM Name \t = \t $VM \n"
                echo "========================================================="
                        printf "Assigned CPU's \t = \t $VCPU \n"
                        printf "RAM Memory \t = \t $NEWMEMORY MB \n"
                        printf "MAC Address \t = \t $MAC \n"
                        printf "VLAN \t\t = \t $BRIDGE \n"
                        printf "IP Address \t = \t $IP \n"
                echo "========================================================="
                echo ""
        done;

