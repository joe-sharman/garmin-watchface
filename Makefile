APP_NAME      := watchface
DEVICE        ?= fr165
DEVELOPER_KEY ?= $(HOME)/.garmin/developer_key.der

SDK_HOME := $(shell cat "$(HOME)/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg")
SDK_BIN  := $(SDK_HOME)bin
MONKEYC  := "$(SDK_BIN)/monkeyc"
MONKEYDO := "$(SDK_BIN)/monkeydo"

# The default `java` on this machine is an x86_64 JDK 8 running under Rosetta;
# the arm64 JDK 11 is native and compiles noticeably faster.
JAVA_HOME   := $(shell /usr/libexec/java_home -v 11)
export PATH := $(JAVA_HOME)/bin:$(PATH)

BUILD_FLAGS := -f monkey.jungle -y "$(DEVELOPER_KEY)" -l 3 -w

.PHONY: build run watch test package simulator key check-key clean

build: check-key
	@mkdir -p bin
	$(MONKEYC) $(BUILD_FLAGS) -d $(DEVICE) -o bin/$(APP_NAME).prg

run: build simulator
	$(MONKEYDO) bin/$(APP_NAME).prg $(DEVICE)

WATCHED := source resources manifest.xml monkey.jungle
WATCH_STAMP := bin/.watch-stamp

# Polls rather than using fswatch so there is nothing extra to install.
# A failed build must not stop the loop, and the stamp is touched before
# building so a broken build is not retried until the next edit.
watch: check-key simulator
	@mkdir -p bin
	@echo "Watching $(WATCHED) (ctrl+c to stop)"
	@rm -f $(WATCH_STAMP)
	@while true; do \
		if [ ! -f $(WATCH_STAMP) ] || [ -n "$$(find $(WATCHED) -newer $(WATCH_STAMP) -print -quit)" ]; then \
			touch $(WATCH_STAMP); \
			$(MAKE) --no-print-directory run || echo "Build failed, waiting for the next change"; \
		fi; \
		sleep 1; \
	done

test: check-key simulator
	@mkdir -p bin
	$(MONKEYC) $(BUILD_FLAGS) -d $(DEVICE) --unit-test -o bin/$(APP_NAME)-test.prg
	$(MONKEYDO) bin/$(APP_NAME)-test.prg $(DEVICE) -t

package: check-key
	@mkdir -p bin
	$(MONKEYC) $(BUILD_FLAGS) -e -r -o bin/$(APP_NAME).iq

simulator:
	@pgrep -f "ConnectIQ.app/Contents/MacOS/simulator" > /dev/null || (open "$(SDK_BIN)/ConnectIQ.app" && sleep 5)

key:
	@test ! -f "$(DEVELOPER_KEY)" || (echo "Key already exists at $(DEVELOPER_KEY)" && exit 1)
	@mkdir -p "$(dir $(DEVELOPER_KEY))"
	openssl genrsa 4096 | openssl pkcs8 -topk8 -inform PEM -outform DER -nocrypt -out "$(DEVELOPER_KEY)"
	@chmod 600 "$(DEVELOPER_KEY)"

check-key:
	@test -f "$(DEVELOPER_KEY)" || (echo "No developer key at $(DEVELOPER_KEY). Run 'make key'." && exit 1)

clean:
	rm -rf bin
