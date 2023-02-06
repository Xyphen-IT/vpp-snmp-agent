VERSION=0.0.1
VPP_SNMP_AGENT:=vpp-snmp-agent
PYTHON?=python3
PIP?=pip
PIP_DEPENDS=build pylint
PIP_DEPENDS+=argparse pyyaml black
WIPE=dist $(VPP_SNMP_AGENT).egg-info .pybuild debian/vpp-snmp-agent debian/vpp-snmp-agent.*.log
WIPE+=debian/vpp-snmp-agent.*.debhelper debian/.debhelper debian/files
WIPE+=debian/vpp-snmp-agent.substvars
WHL_INSTALL=dist/$(VPP_SNMP_AGENT)-$(VERSION)-py3-none-any.whl
TESTS=tests.py

.PHONY: build
build:
	$(PYTHON) -m build

.PHONY: install-deps
install-deps:
	sudo $(PIP) install $(PIP_DEPENDS)

.PHONY: install
install:
	sudo $(PIP) install $(WHL_INSTALL)

.PHONY: pkg-deb
pkg-deb:
	dpkg-buildpackage -uc -us -b

.PHONY: check-style
check-style:
	PYTHONPATH=./$(VPP_SNMP_AGENT) pylint ./$(VPP_SNMP_AGENT)

.PHONY: test
test:
	@cd $(VPP_SNMP_AGENT); PYTHONPATH=./$(VPP_SNMP_AGENT) $(PYTHON) tests.py

.PHONY: uninstall
uninstall:
	sudo $(PIP) uninstall $(VPP_SNMP_AGENT)

.PHONY: wipe
wipe:
	$(RM) -rf $(WIPE)
