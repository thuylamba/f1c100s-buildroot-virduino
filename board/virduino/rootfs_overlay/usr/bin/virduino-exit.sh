#!/bin/sh
USB_GADGET_PATH=/sys/kernel/config/usb_gadget/multi
# TODO: More
echo "" > ${USB_GADGET_PATH}/UDC
umount /sys/kernel/config
