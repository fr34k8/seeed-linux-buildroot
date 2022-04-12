################################################################################
#
# libwebsockets
#
################################################################################

LIBWEBSOCKETS_VERSION = 4.3.1
LIBWEBSOCKETS_SITE = $(call github,warmcat,libwebsockets,v$(LIBWEBSOCKETS_VERSION))
LIBWEBSOCKETS_LICENSE = MIT with exceptions
LIBWEBSOCKETS_LICENSE_FILES = LICENSE
LIBWEBSOCKETS_DEPENDENCIES = zlib
LIBWEBSOCKETS_INSTALL_STAGING = YES
LIBWEBSOCKETS_CONF_OPTS = \
	-DLWS_WITHOUT_TESTAPPS=ON \
	-DLWS_IPV6=ON \
	-DLWS_UNIX_SOCK=ON \
	-DLWS_WITHOUT_EXTENSIONS=OFF

# If LWS_MAX_SMP=1, then there is no code related to pthreads compiled
# in the library. If unset, LWS_MAX_SMP defaults to 32 and a small
# amount of pthread mutex code is built into the library.
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),)
LIBWEBSOCKETS_CONF_OPTS += -DLWS_MAX_SMP=1
else
LIBWEBSOCKETS_CONF_OPTS += -DLWS_MAX_SMP=
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBWEBSOCKETS_DEPENDENCIES += openssl host-openssl
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_SSL=ON
else
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_SSL=OFF
endif

ifeq ($(BR2_PACKAGE_LIBEV),y)
LIBWEBSOCKETS_DEPENDENCIES += libev
LIBWEBSOCKETS_CONF_OPTS += \
	-DLWS_WITH_LIBEV=ON \
	-DLWS_WITH_LIBEVENT=OFF
else ifeq ($(BR2_PACKAGE_LIBEVENT),y)
LIBWEBSOCKETS_DEPENDENCIES += libevent
LIBWEBSOCKETS_CONF_OPTS += \
	-DLWS_WITH_LIBEV=OFF \
	-DLWS_WITH_LIBEVENT=ON
else
LIBWEBSOCKETS_CONF_OPTS += \
	-DLWS_WITH_LIBEV=OFF \
	-DLWS_WITH_LIBEVENT=OFF
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
LIBWEBSOCKETS_DEPENDENCIES += libglib2
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_GLIB=ON
else
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_GLIB=OFF
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBMOUNT),y)
LIBWEBSOCKETS_DEPENDENCIES += util-linux
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_FSMOUNT=ON
else
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_FSMOUNT=OFF
endif

ifeq ($(BR2_PACKAGE_LIBUV),y)
LIBWEBSOCKETS_DEPENDENCIES += libuv
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_LIBUV=ON
else
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_LIBUV=OFF
endif

ifeq ($(BR2_SHARED_LIBS),y)
LIBWEBSOCKETS_CONF_OPTS += -DLWS_WITH_STATIC=OFF
endif

$(eval $(cmake-package))
