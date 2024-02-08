#!/bin/bash
#
# This script is used to set the default MAC address to the same one that's used
# in the ADLINK MegaRAC BMC images. If the eth address exists in the U-boot
# environment, that's used in preference to the hard-coded address.
#

function Usage () {
	echo "Usage:"
	echo "      adlink_update_mac.sh <ethX>"
	echo "Example:"
	echo "      adlink_update_mac.sh eth0"
}

ETHERNET_INTERFACE=$1

# Check eth port
case ${ETHERNET_INTERFACE} in
	"eth0")
		ENV_PORT="1"
		;;
	"eth1")
		ENV_PORT="2"
		;;
	"eth2")
		ENV_PORT="3"
		;;
	*)
		Usage
		exit
		;;
esac

MAC_ADDR=00:30:64:33:87:e5

if fw_printenv "ethaddr" 2>/dev/null; then
  MAC_ADDR=$(fw_printenv "ethaddr" 2>/dev/null | sed "s/^ethaddr=//")
fi

# Check if the Ethernet port has correct MAC Address
ETH_INCLUDE_MAC=$(ip link show "${ETHERNET_INTERFACE}" | grep link | awk '{print $2}' | grep -i "$MAC_ADDR")
if [ -n "$ETH_INCLUDE_MAC" ]; then
	echo "BMC MAC Address is already configured"
	exit 0
fi

# Request to restart the service
ip link set "${ETHERNET_INTERFACE}" down
fw_setenv ethaddr "${MAC_ADDR}"

ip link set dev "${ETHERNET_INTERFACE}" address "${MAC_ADDR}"
retval=$?
if [[ $retval -ne 0 ]]; then
	echo "ERROR: Can not update ${ETHERNET_INTERFACE} MAC ADDR"
	exit 1
fi
# Setting LAN MAC Address to xx:xx:xx:xx:xx:xx
ipmitool lan set "${ENV_PORT}" macaddr "${MAC_ADDR}"
# Enabling BMC-generated ARP responses & setting SNMP Community String to public
ipmitool lan set "${ENV_PORT}" arp respond on
ipmitool lan set "${ENV_PORT}" snmp public
ip link set "${ETHERNET_INTERFACE}" up

echo "Successfully updated the MAC address ${MAC_ADDR} for ${ETHERNET_INTERFACE}"
