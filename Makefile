LINUX_TOOLCHAIN_PATH = /home/autobuild/tools/win32

PathToPixman = contrib/sdk/sources/pixman

install libpixman-1.a pixman-1.dll clean:
	$(MAKE) -C $(PathToPixman) $@

kos-pixman-dev: libpixman-1.a pixman-1.dll
	mkdir -p $@$(LINUX_TOOLCHAIN_PATH)/include
	mkdir -p $@$(LINUX_TOOLCHAIN_PATH)/mingw32/lib

	cp -f $(PathToPixman)/*.h $@$(LINUX_TOOLCHAIN_PATH)/include
	cp -f $(PathToPixman)/*.a $@$(LINUX_TOOLCHAIN_PATH)/mingw32/lib

	dpkg-deb --build $@ $@.deb
