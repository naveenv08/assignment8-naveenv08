
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = c3ac0dbedd850c37c3d6592d1c8307bcb3bd5b86
#a68a74e12099546f488f2d9ae1b3bc037095ed21
#40f0bd00f9da50a63d4d6c50e2bb1b4cdacc07e7
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:naveenv08/assignment3-naveenv08.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server

        $(MAKE) -C $(LINUX_DIR) \
                ARCH=$(KERNEL_ARCH) \
                CROSS_COMPILE=$(TARGET_CROSS) \
                M=$(@D)/aesd-char-driver \
                modules

endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin

	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh  $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer  $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh  $(TARGET_DIR)/usr/bin
	
	
	#SOCKET program
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop \
		$(TARGET_DIR)/etc/init.d/S99aesdsocket

	
	# Install kernel module
        $(INSTALL) -D -m 0644 \
                $(@D)/aesd-char-driver/aesdchar.ko \
                $(TARGET_DIR)/lib/modules/aesdchar.ko

        # Install helper scripts
        $(INSTALL) -m 0755 \
                $(@D)/aesd-char-driver/aesdchar_load \
                $(TARGET_DIR)/usr/bin

        $(INSTALL) -m 0755 \
                $(@D)/aesd-char-driver/aesdchar_unload \
                $(TARGET_DIR)/usr/bin

endef

$(eval $(generic-package))
