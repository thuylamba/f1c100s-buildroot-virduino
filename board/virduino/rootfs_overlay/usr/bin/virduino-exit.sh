#!/bin/sh
USB_GADGET_PATH=/sys/kernel/config/usb_gadget/multi

echo "" > ${USB_GADGET_PATH}/UDC

rm ${USB_GADGET_PATH}/os_desc/c.1
rm ${USB_GADGET_PATH}/configs/c.1/rndis.rn0
rm ${USB_GADGET_PATH}/configs/c.1/mass_storage.ms0

rmdir ${USB_GADGET_PATH}/configs/c.1/

rmdir ${USB_GADGET_PATH}/functions/rndis.rn0
rmdir ${USB_GADGET_PATH}/functions/mass_storage.ms0

rmdir ${USB_GADGET_PATH}

modprobe -r usb_f_rndis
modprobe -r usb_f_mass_storage
umount /sys/kernel/config
