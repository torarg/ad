CONFIG_PATH = /etc/ad
BIN_PATH = /usr/local/bin/ad
COMMANDS_PATH = $(CONFIG_PATH)/commands
TEMPLATE_PATH = $(CONFIG_PATH)/templates
FUNCTIONS_PATH = $(CONFIG_PATH)/functions

install: uninstall
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
