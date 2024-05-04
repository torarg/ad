PREFIX ?= /usr/local
CONFIG_PATH = ${PREFIX}/etc/ad
BIN_PATH = ${PREFIX}/bin/ad
COMMANDS_PATH = $(CONFIG_PATH)/commands
TEMPLATE_PATH = $(CONFIG_PATH)/templates
FUNCTIONS_PATH = $(CONFIG_PATH)/functions
OPENBSD_PORTS_DIR = /usr/ports/sysutils/ad
OPENBSD_PKG_DIR = /usr/ports/packages/amd64/all
OPENBSD_SIGNED_PKG_DIR = /usr/ports/packages/amd64/all/signed
OPENBSD_PKG_KEY = ~/1wilson-pkg.sec

install:
	install -m 0755 -d $(CONFIG_PATH)
	install -m 0755 ./bin/ad $(BIN_PATH)
	install -m 0755 ./config $(CONFIG_PATH)/
	cp -r ./templates $(CONFIG_PATH)/
	cp -r ./commands $(CONFIG_PATH)/
	cp -r ./functions $(CONFIG_PATH)/
	chmod -R 755 $(COMMANDS_PATH)
	chmod -R 755 $(TEMPLATE_PATH)
	chmod -R 755 $(FUNCTIONS_PATH)

uninstall:
	rm -r $(CONFIG_PATH) $(BIN_PATH)

all:

clean:

openbsd-package:
	rm -rf $(OPENBSD_PORTS_DIR)
	cp -r openbsd_package/ $(OPENBSD_PORTS_DIR)
	cd /usr/ports/sysutils/ad && \
	make clean && make package
	pkg_sign -C -o $(OPENBSD_SIGNED_PKG_DIR) -S $(OPENBSD_PKG_DIR) -s signify2 -s $(OPENBSD_PKG_KEY)

publish-openbsd-package: openbsd-package
	scp $(OPENBSD_SIGNED_PKG_DIR)/ad-*.tgz www:
	ssh www "doas mv ad-*.tgz /var/www/htdocs/pub/OpenBSD/packages/"
	ssh www "doas chown www /var/www/htdocs/pub/OpenBSD/packages/ad-*.tgz"
