
# A brcm_patchram_plus.c file may be downloaded using:
#     git clone https://code.google.com/p/broadcom-bluetooth/
#
# The tool needs also a bluetooth firmware. Depend on value in
# /sys/class/rfkill/rfkill0/name, it may be rk903_26M.hcd or rk903.hcd
# or maybe another; the firmware should be located in /etc/bluetooth directory

brcm_patchram_plus : brcm_patchram_plus.c
	gcc brcm_patchram_plus.c -o brcm_patchram_plus


install:
	install brcm_patchram_plus /usr/sbin/
	install rk903-bluetooth.init.d /etc/init.d/rk903-bluetooth
	update-rc.d rk903-bluetooth defaults
