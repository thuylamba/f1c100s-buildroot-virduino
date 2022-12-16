################################################################################
#
# usbmount
#
################################################################################

WFSCAN_VERSION = 0.0.1
WFSCAN_SITE:= package/wfscan/wfscan
WFSCAN_SITE_METHOD:=local
WFSCAN_INSTALL_TARGET:=YES
WFSCAN_LICENSE = BSD-2-Clause
WFSCAN_LICENSE_FILES = debian/copyright

define WFSCAN_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define WFSCAN_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/wfscan $(TARGET_DIR)/bin
endef
$(eval $(generic-package))
