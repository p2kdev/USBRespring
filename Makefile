include $(THEOS)/makefiles/common.mk

TWEAK_NAME = USBRespring
USBRespring_FILES = Tweak.xm
USBRespring_FRAMEWORKS = MediaPlayer

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
