#!/bin/sh

modprobe usb_f_rndis
modprobe usb_f_mass_storage

mount -t configfs none /sys/kernel/config

USB_GADGET_PATH=/sys/kernel/config/usb_gadget/multi
mkdir -p ${USB_GADGET_PATH}

echo "64"     > ${USB_GADGET_PATH}/bMaxPacketSize0
echo "0x200"  > ${USB_GADGET_PATH}/bcdUSB    # USB2.0
echo "0x100"  > ${USB_GADGET_PATH}/bcdDevice # 適当
echo "0x03FD" > ${USB_GADGET_PATH}/idVendor  # Xilinx
echo "0x0104" > ${USB_GADGET_PATH}/idProduct # Multifunction Composite Gadget

# refer: https://msdn.microsoft.com/en-us/library/windows/hardware/ff540054.aspx
echo "0xEF"   > ${USB_GADGET_PATH}/bDeviceClass
echo "0x02"   > ${USB_GADGET_PATH}/bDeviceSubClass
echo "0x01"   > ${USB_GADGET_PATH}/bDeviceProtocol

mkdir ${USB_GADGET_PATH}/functions/rndis.rn0
mkdir ${USB_GADGET_PATH}/functions/mass_storage.ms0

echo 0              > ${USB_GADGET_PATH}/functions/mass_storage.ms0/lun.0/cdrom
echo 1              > ${USB_GADGET_PATH}/functions/mass_storage.ms0/lun.0/ro
echo 1              > ${USB_GADGET_PATH}/functions/mass_storage.ms0/lun.0/nofua
echo 1              > ${USB_GADGET_PATH}/functions/mass_storage.ms0/lun.0/removable
echo /dev/mmcblk0p1 > ${USB_GADGET_PATH}/functions/mass_storage.ms0/lun.0/file

mkdir ${USB_GADGET_PATH}/configs/c.1
ln -s ${USB_GADGET_PATH}/functions/rndis.rn0        ${USB_GADGET_PATH}/configs/c.1/
ln -s ${USB_GADGET_PATH}/functions/mass_storage.ms0 ${USB_GADGET_PATH}/configs/c.1/

echo "1"       > ${USB_GADGET_PATH}/os_desc/use
echo "0xcd"    > ${USB_GADGET_PATH}/os_desc/b_vendor_code
echo "MSFT100" > ${USB_GADGET_PATH}/os_desc/qw_sign
echo "RNDIS"   > ${USB_GADGET_PATH}/functions/rndis.rn0/os_desc/interface.rndis/compatible_id
echo "5162001" > ${USB_GADGET_PATH}/functions/rndis.rn0/os_desc/interface.rndis/sub_compatible_id
ln -s ${USB_GADGET_PATH}/configs/c.1 ${USB_GADGET_PATH}/os_desc

echo "musb-hdrc.1.auto" > ${USB_GADGET_PATH}/UDC
