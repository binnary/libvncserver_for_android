# Copyright 2005 The Android Open Source Project

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

    #libvncserver/tabletrans24template.c \
    libvncserver/tableinitcmtemplate.c \
    libvncserver/tableinit24.c \
    libvncserver/rfbssl_gnutls.c \
    libvncserver/rfbcrypto_gnutls.c \
    libvncserver/rfbssl_openssl.c \
    libvncserver/rfbcrypto_openssl.c \
    libvncserver/rfbcrypto_polarssl.c \
    libvncserver/zrleencodetemplate.c \
    libvncserver/tableinittctemplate.c \
    libvncserver/tabletranstemplate.c \

LOCAL_SERVER_FILES:= \
    libvncserver/corre.c \
    libvncserver/cargs.c \
    libvncserver/zrleoutstream.c \
    libvncserver/zrle.c \
    libvncserver/websockets.c \
    libvncserver/zlib.c \
    libvncserver/rfbregion.c \
    libvncserver/font.c \
    libvncserver/ultra.c \
    libvncserver/rre.c \
    libvncserver/auth.c \
    libvncserver/tight.c \
    libvncserver/rfbserver.c \
    libvncserver/cursor.c \
    libvncserver/sockets.c \
    libvncserver/zrlepalettehelper.c \
    libvncserver/rfbssl_none.c \
    libvncserver/rfbcrypto_included.c \
    libvncserver/draw.c \
    libvncserver/selbox.c \
    libvncserver/httpd.c \
    libvncserver/translate.c \
    libvncserver/scale.c \
    libvncserver/hextile.c \
    libvncserver/tightvnc-filetransfer/rfbtightserver.c \
    libvncserver/tightvnc-filetransfer/filetransfermsg.c \
    libvncserver/tightvnc-filetransfer/handlefiletransferrequest.c \
    libvncserver/tightvnc-filetransfer/filelistinfo.c \
    libvncserver/stats.c \
    libvncserver/main.c \
    libvncserver/cutpaste.c
    
    #libvncclient/corre.c \
    libvncclient/zrle.c \
    libvncclient/zlib.c \
    libvncclient/ultra.c \
    libvncclient/rre.c \
    libvncclient/tight.c \
    libvncclient/tls_gnutls.c \
    libvncclient/hextile.c \
    libvncclient/tls_openssl.c \

LOCAL_CLIENT_FILES:= \
    libvncclient/tls_none.c \
    libvncclient/cursor.c \
    libvncclient/sockets.c \
    libvncclient/listen.c \
    libvncclient/rfbproto.c \
    libvncclient/vncviewer.c

LOCAL_SRC_COMMON_FILES:= \
    common/d3des.c \
    common/md5.c \
    common/minilzo.c \
    common/sha1.c \
    common/turbojpeg.c \
    common/vncauth.c \
    common/zywrletemplate.c

LOCAL_VNC_INCLUDES += $(LOCAL_PATH)/ \
                    $(LOCAL_PATH)/common \
                    $(LOCAL_PATH)/rfb/  \
                    external/zlib \
                    external/jpeg \
                    external/openssl/include \
                    external/libpng


VNC_CFLAGS += -Dvncserver_EXPORTS -DLIBVNCSERVER_HAVE_LIBZ -DLIBVNCSERVER_HAVE_LIBJPEG -DLIBVNCSERVER_HAVE_LIBPNG -DLIBVNCSERVER_WITH_WEBSOCKETS -O2 -W -Wall -g -fPIC 
VNC_CFLAGS += -D_GNU_SOURCE -DBPP=24 -DOUT=8 -DIN=8

VNC_SHARED_LIBRARIES := libc liblog libcutils \
	libnl libm libnetutils libz libpng libjpeg libssl

VNC_STATIC_LIBRARIES := libjpeg_static libpng \
        libnetutils libnl libz libc libcutils liblog libm \

include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
   $(LOCAL_SERVER_FILES) \
   $(LOCAL_SRC_COMMON_FILES)
LOCAL_CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
LOCAL_CFLAGS += $(VNC_CFLAGS)

LOCAL_MODULE:= libvncserver
LOCAL_C_INCLUDES +=  $(LOCAL_VNC_INCLUDES) \
                    $(LOCAL_PATH)/libvncserver

LOCAL_SHARED_LIBRARIES := $(VNC_SHARED_LIBRARIES)

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_CFLAGS += $(VNC_CFLAGS)
LOCAL_CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
LOCAL_MODULE:= libvncserver
LOCAL_C_INCLUDES +=  $(LOCAL_VNC_INCLUDES) \
                    $(LOCAL_PATH)/libvncserver

LOCAL_STATIC_LIBRARIES := $(VNC_STATIC_LIBRARIES)

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
LOCAL_CFLAGS += $(VNC_CFLAGS)
LOCAL_MODULE:= androidvncserver
LOCAL_C_INCLUDES +=  $(LOCAL_VNC_INCLUDES) \
                    $(LOCAL_PATH)/libvncserver
LOCAL_SRC_FILES:= examples/android/jni/fbvncserver.c

LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_STATIC_LIBRARIES := libvncserver  $(VNC_STATIC_LIBRARIES)

include $(BUILD_EXECUTABLE)

#-----------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
LOCAL_CFLAGS += $(VNC_CFLAGS)
LOCAL_SRC_FILES:= \
   $(LOCAL_CLIENT_FILES) \
   $(LOCAL_SRC_COMMON_FILES)

LOCAL_C_INCLUDES +=  $(LOCAL_VNC_INCLUDES) \
                    $(LOCAL_PATH)/libvncclient

LOCAL_MODULE:= libvncclient
LOCAL_SHARED_LIBRARIES := $(VNC_SHARED_LIBRARIES)

include $(BUILD_SHARED_LIBRARY)

#-------------------------------------------
include $(CLEAR_VARS)
LOCAL_CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
LOCAL_CFLAGS += $(VNC_CFLAGS)
LOCAL_SRC_FILES:= \
   $(LOCAL_CLIENT_FILES) \
   $(LOCAL_SRC_COMMON_FILES)

LOCAL_C_INCLUDES +=  $(LOCAL_VNC_INCLUDES) \
                    $(LOCAL_PATH)/libvncclient

LOCAL_MODULE:= libvncclient
LOCAL_STATIC_LIBRARIES := $(VNC_STATIC_LIBRARIES)

include $(BUILD_STATIC_LIBRARY)

#-------------build server examples--------------------------

DEST :=backchannel \
    blooptest \
    camera \
    colourmaptest \
    example \
    filetransfer \
    fontsel \
    pnmshow \
    pnmshow24 \
    regiontest \
    rotate \
    simple \
    simple15 \
    storepasswd \
    vncev

define BUILD_VNC_EXAMPLES
    include $(CLEAR_VARS) \
    LOCAL_CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP \
    LOCAL_CFLAGS += $(VNC_CFLAGS) \
    LOCAL_MODULE:= examples_$(1) \
    LOCAL_C_INCLUDES +=  $(LOCAL_VNC_INCLUDES) \
                        $(LOCAL_PATH)/libvncserver
    LOCAL_SRC_FILES:= examples/$(1).c \
    LOCAL_FORCE_STATIC_EXECUTABLE := true \
    LOCAL_STATIC_LIBRARIES := libvncserver  $(VNC_STATIC_LIBRARIES) \
    include $(BUILD_EXECUTABLE)
endef

#$(foreach VAR,$(DEST),$(VAR))\
#    $(call BUILD_EXECUTABLE,$(VAR))
    
