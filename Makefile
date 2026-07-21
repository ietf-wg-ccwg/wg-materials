# WG-materials uploader: thin downstream Makefile (installed from wg-materials-template).
# The tool lives in lib/ (a git submodule). For local development against a
# checkout of the tool, set WG_MATERIALS_HOME=/path/to/wg-materials-template.
#
# Common usage:
#   make resolve MEETING=<n>      # show detected group + session id(s)
#   make upload                   # dry-run: preview uploads for changed files
#   make upload DRY_RUN=false     # actually upload (creates datatracker revisions)
#   make check-auth               # verify datatracker login

LIBDIR := lib
-include $(LIBDIR)/main.mk

# Bootstrap the tool if it is not present yet.
$(LIBDIR)/main.mk:
ifneq (,$(wildcard $(WG_MATERIALS_HOME)))
	ln -s "$(WG_MATERIALS_HOME)" $(LIBDIR)
else ifneq (,$(wildcard .gitmodules))
	git submodule sync
	git submodule update --init
else
	git clone -q --depth 10 -b main https://github.com/ekinnear/wg-materials-template $(LIBDIR)
endif
