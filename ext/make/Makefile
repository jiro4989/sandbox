LOG_DIR := log
DIST_DIR := dist

default: build arch

aba: tet foo

tet:
	echo tet

clean:
	echo clean --------------------------------------
	-rm -rf $(LOG_DIR)

build: clean
	echo build --------------------------------------
	mkdir $(LOG_DIR)
	touch $(LOG_DIR)/001.log
	touch $(LOG_DIR)/002.log
	touch $(LOG_DIR)/003.log
	touch $(LOG_DIR)/004.log
	touch $(LOG_DIR)/005.log

arch: build
	echo arch --------------------------------------
	-rm -rf $(DIST_DIR)
	mkdir $(DIST_DIR)
	tar czf $(DIST_DIR)/logs.tar.gz $(LOG_DIR)/*.log

.PHONY: clean tet
