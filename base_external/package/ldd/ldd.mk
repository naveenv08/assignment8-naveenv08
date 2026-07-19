LDD_VERSION = cb99aa714532ff8597b717342d8e93710facb25f
LDD_SITE = git@github.com:naveenv08/assignment7-naveenv08.git
LDD_SITE_METHOD = git

LDD_LICENSE = GPL-2.0

LDD_MODULE_SUBDIRS = \
	misc-modules \
	scull

$(eval $(kernel-module))
$(eval $(generic-package))
