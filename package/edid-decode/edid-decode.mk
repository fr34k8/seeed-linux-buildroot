################################################################################
#
# edid-decode
#
################################################################################

EDID_DECODE_VERSION = 6f117a8f8c0e76e85f599a8b05c21c5f51c5c3c1
EDID_DECODE_SITE = https://git.linuxtv.org/edid-decode.git
EDID_DECODE_SITE_METHOD = git
EDID_DECODE_LICENSE = MIT
EDID_DECODE_LICENSE_FILES = LICENSE

define EDID_DECODE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		CFLAGS="$(TARGET_CXXFLAGS) -std=c++11" WARN_FLAGS=
endef

define EDID_DECODE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))
