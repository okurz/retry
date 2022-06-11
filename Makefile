.PHONY: all
all:

.PHONY: test
test: checkstyle test-unit

.PHONY: test-unit
test-unit: test-more-bash
	@command -v prove >/dev/null 2>&1 || echo "Command 'git' not found, can not get test-more-bash to execute tests"
	prove -r test/

test-more-bash:
	@command -v git >/dev/null 2>&1 || echo "Command 'git' not found, can not get test-more-bash to execute tests"
	git clone https://github.com/ingydotnet/test-more-bash.git --depth 1 -b 0.0.5

checkbashisms:
	@command -v wget >/dev/null 2>&1 || echo "Command 'wget' not found, can not download checkbashisms"
	wget -q https://salsa.debian.org/debian/devscripts/-/raw/master/scripts/checkbashisms.pl -O checkbashisms
	chmod +x checkbashisms
	command -v checkbashisms >/dev/null || echo "Downloaded checkbashisms. You can check the file and add to PATH, then call make again"

.PHONY: checkstyle
checkstyle: test-shellcheck test-checkbashisms

.PHONY: test-shellcheck
test-shellcheck:
	@command -v shellcheck >/dev/null 2>&1 || echo "Command 'shellcheck' not found, can not execute shell script checks"
	shellcheck -x $$(file --mime-type * | sed -n 's/^\(.*\):.*text\/x-shellscript.*$$/\1/p')

.PHONY: test-checkbashisms
test-checkbashisms:
	@command -v checkbashisms >/dev/null 2>&1 || echo "Command 'checkbashisms' not found, can not execute shell script checks"
	checkbashisms -x $$(file --mime-type * | sed -n 's/^\(.*\):.*text\/x-shellscript.*$$/\1/p')

.PHONY: install
install:
	install -m 755 retry "$(DESTDIR)"/usr/bin/retry
