ARCHIVE_PATH = IgnoreXcodeImageCompletions.tar.gz
INSTALL_PATH = $(HOME)/Library/Application Support/Developer/Shared/Xcode/Plug-ins/IgnoreXcodeImageCompletions.xcplugin

install:
	xcodebuild -configuration Release

uninstall:
	rm -rf "$(INSTALL_PATH)"

archive: install
	tar -pvczf $(ARCHIVE_PATH) "$(INSTALL_PATH)"
	shasum -a 256 $(ARCHIVE_PATH)
