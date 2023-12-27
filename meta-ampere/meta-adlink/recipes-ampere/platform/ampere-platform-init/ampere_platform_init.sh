#!/bin/bash

# shellcheck source=meta-ampere/meta-jade/recipes-ampere/platform/ampere-utils/gpio-lib.sh
source /usr/sbin/gpio-lib.sh
# shellcheck source=meta-ampere/meta-jade/recipes-ampere/platform/ampere-platform-init/comhpcalt_platform_gpios_init.sh
source /usr/sbin/platform_gpios_init.sh
source /usr/sbin/ampere_uart_console_setup.sh

#pre platform init function. implemented in platform_gpios_init.sh
pre-platform-init

# =======================================================
# Setting default value for device sel and mux
bootstatus=$(cat /sys/class/watchdog/watchdog0/bootstatus)
if [ "$bootstatus" == '32' ]; then
    echo "CONFIGURE: gpio pins to output high after AC power"
    for gpioName in "${output_high_gpios_in_ac[@]}"; do
        gpio_name_set "$gpioName" 1
    done
    echo "CONFIGURE: gpio pins to output low after AC power"
    for gpioName in "${output_low_gpios_in_ac[@]}"; do
        gpio_name_set "$gpioName" 0
    done
    echo "CONFIGURE: gpio pins to input after AC power"
    for gpioName in "${input_gpios_in_ac[@]}"; do
        gpio_name_input "$gpioName"
    done
fi

# =======================================================
# Setting default value for others gpio pins
echo "CONFIGURE: gpio pins to output high"
for gpioName in "${output_high_gpios_in_bmc_reboot[@]}"; do
    gpio_name_set "$gpioName" 1
done
echo "CONFIGURE: gpio pins to output low"
for gpioName in "${output_low_gpios_in_bmc_reboot[@]}"; do
    gpio_name_set "$gpioName" 0
done
echo "CONFIGURE: gpio pins to input"
for gpioName in "${input_gpios_in_bmc_reboot[@]}"; do
    gpio_name_input "$gpioName"
done

echo "Switch the host SPI bus to HOST"
gpioset $(gpiofind spi0-program-sel)=1

# =======================================================
# Setting uart muxes to BMC as default
uart_console_setup

#post platform init function. implemented in platform_gpios_init.sh
post-platform-init

exit 0
