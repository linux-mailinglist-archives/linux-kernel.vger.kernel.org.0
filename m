Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4BBE985
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbfIZAdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbfIZAdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:50 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2045222C6;
        Thu, 26 Sep 2019 00:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458029;
        bh=LO0rk8nwNZlv70LW4M7f8Y7lUPTVOCRLUJpT8gsMv6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3SqdjXY0HBMbqLw/4rTshlAdjK74kR8Er0hFjn0wdSNP56pMVgh6Ffz12f/yQwNo
         NgrWkeeVp+Z1MseT6eAZtdZ/Ok4bSBIACkAkSKetJGSL4C9Lc5TCt9GeQI/EKOFnmM
         CrBpNfcBp/iRTVNH20E9dZNFm9Gb5ggou2JnaS38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/66] libtraceevent: Move traceevent plugins in its own subdirectory
Date:   Wed, 25 Sep 2019 21:31:50 -0300
Message-Id: <20190926003244.13962-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

All traceevent plugins code is moved to tools/lib/traceevent/plugins
subdirectory. It makes traceevent implementation in trace-cmd and in
kernel tree consistent. There is no changes in the way libtraceevent and
plugins are compiled and installed.

Committer notes:

Applied fixup provided by Steven, fixing the tools/perf/Makefile.perf
target for the plugin dynamic list file. Problem noticed when cross
building to aarch64 from a Ubuntu 19.04 container.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/lkml/20190923115929.453b68f1@oasis.local.home
Link: http://lore.kernel.org/lkml/20190919212542.377333393@goodmis.org
Link: http://lore.kernel.org/linux-trace-devel/20190917105055.18983-1-tz.stoyanov@gmail.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Build                    |  11 -
 tools/lib/traceevent/Makefile                 |  94 ++------
 tools/lib/traceevent/plugins/Build            |  10 +
 tools/lib/traceevent/plugins/Makefile         | 222 ++++++++++++++++++
 .../{ => plugins}/plugin_cfg80211.c           |   0
 .../{ => plugins}/plugin_function.c           |   0
 .../traceevent/{ => plugins}/plugin_hrtimer.c |   0
 .../traceevent/{ => plugins}/plugin_jbd2.c    |   0
 .../traceevent/{ => plugins}/plugin_kmem.c    |   0
 .../lib/traceevent/{ => plugins}/plugin_kvm.c |   0
 .../{ => plugins}/plugin_mac80211.c           |   0
 .../{ => plugins}/plugin_sched_switch.c       |   0
 .../traceevent/{ => plugins}/plugin_scsi.c    |   0
 .../lib/traceevent/{ => plugins}/plugin_xen.c |   0
 tools/perf/Makefile.perf                      |   4 +-
 15 files changed, 250 insertions(+), 91 deletions(-)
 create mode 100644 tools/lib/traceevent/plugins/Build
 create mode 100644 tools/lib/traceevent/plugins/Makefile
 rename tools/lib/traceevent/{ => plugins}/plugin_cfg80211.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_function.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_hrtimer.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_jbd2.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_kmem.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_kvm.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_mac80211.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_sched_switch.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_scsi.c (100%)
 rename tools/lib/traceevent/{ => plugins}/plugin_xen.c (100%)

diff --git a/tools/lib/traceevent/Build b/tools/lib/traceevent/Build
index ba54bfce0b0b..f9a5d79578f5 100644
--- a/tools/lib/traceevent/Build
+++ b/tools/lib/traceevent/Build
@@ -6,14 +6,3 @@ libtraceevent-y += parse-utils.o
 libtraceevent-y += kbuffer-parse.o
 libtraceevent-y += tep_strerror.o
 libtraceevent-y += event-parse-api.o
-
-plugin_jbd2-y         += plugin_jbd2.o
-plugin_hrtimer-y      += plugin_hrtimer.o
-plugin_kmem-y         += plugin_kmem.o
-plugin_kvm-y          += plugin_kvm.o
-plugin_mac80211-y     += plugin_mac80211.o
-plugin_sched_switch-y += plugin_sched_switch.o
-plugin_function-y     += plugin_function.o
-plugin_xen-y          += plugin_xen.o
-plugin_scsi-y         += plugin_scsi.o
-plugin_cfg80211-y     += plugin_cfg80211.o
diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index a39cdd0d890d..5315f3787f8d 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -58,30 +58,6 @@ export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
 export EVENT_PARSE_VERSION
 
-set_plugin_dir := 1
-
-# Set plugin_dir to preffered global plugin location
-# If we install under $HOME directory we go under
-# $(HOME)/.local/lib/traceevent/plugins
-#
-# We dont set PLUGIN_DIR in case we install under $HOME
-# directory, because by default the code looks under:
-# $(HOME)/.local/lib/traceevent/plugins by default.
-#
-ifeq ($(plugin_dir),)
-ifeq ($(prefix),$(HOME))
-override plugin_dir = $(HOME)/.local/lib/traceevent/plugins
-set_plugin_dir := 0
-else
-override plugin_dir = $(libdir)/traceevent/plugins
-endif
-endif
-
-ifeq ($(set_plugin_dir),1)
-PLUGIN_DIR = -DPLUGIN_DIR="$(plugin_dir)"
-PLUGIN_DIR_SQ = '$(subst ','\'',$(PLUGIN_DIR))'
-endif
-
 include ../../scripts/Makefile.include
 
 # copy a bit from Linux kbuild
@@ -105,7 +81,6 @@ export prefix libdir src obj
 # Shell quotes
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
-plugin_dir_SQ = $(subst ','\'',$(plugin_dir))
 
 CONFIG_INCLUDES = 
 CONFIG_LIBS	=
@@ -151,29 +126,14 @@ MAKEOVERRIDES=
 export srctree OUTPUT CC LD CFLAGS V
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-PLUGINS  = plugin_jbd2.so
-PLUGINS += plugin_hrtimer.so
-PLUGINS += plugin_kmem.so
-PLUGINS += plugin_kvm.so
-PLUGINS += plugin_mac80211.so
-PLUGINS += plugin_sched_switch.so
-PLUGINS += plugin_function.so
-PLUGINS += plugin_xen.so
-PLUGINS += plugin_scsi.so
-PLUGINS += plugin_cfg80211.so
-
-PLUGINS    := $(addprefix $(OUTPUT),$(PLUGINS))
-PLUGINS_IN := $(PLUGINS:.so=-in.o)
-
 TE_IN      := $(OUTPUT)libtraceevent-in.o
 LIB_TARGET := $(addprefix $(OUTPUT),$(LIB_TARGET))
-DYNAMIC_LIST_FILE := $(OUTPUT)libtraceevent-dynamic-list
 
-CMD_TARGETS = $(LIB_TARGET) $(PLUGINS) $(DYNAMIC_LIST_FILE)
+CMD_TARGETS = $(LIB_TARGET)
 
 TARGETS = $(CMD_TARGETS)
 
-all: all_cmd
+all: all_cmd plugins
 
 all_cmd: $(CMD_TARGETS)
 
@@ -188,17 +148,6 @@ $(OUTPUT)libtraceevent.so.$(EVENT_PARSE_VERSION): $(TE_IN)
 $(OUTPUT)libtraceevent.a: $(TE_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
-$(OUTPUT)libtraceevent-dynamic-list: $(PLUGINS)
-	$(QUIET_GEN)$(call do_generate_dynamic_list_file, $(PLUGINS), $@)
-
-plugins: $(PLUGINS)
-
-__plugin_obj = $(notdir $@)
-  plugin_obj = $(__plugin_obj:-in.o=)
-
-$(PLUGINS_IN): force
-	$(Q)$(MAKE) $(build)=$(plugin_obj)
-
 $(OUTPUT)%.so: $(OUTPUT)%-in.o
 	$(QUIET_LINK)$(CC) $(CFLAGS) -shared $(LDFLAGS) -nostartfiles -o $@ $^
 
@@ -258,25 +207,6 @@ define do_install
 	$(INSTALL) $(if $3,-m $3,) $1 '$(DESTDIR_SQ)$2'
 endef
 
-define do_install_plugins
-	for plugin in $1; do				\
-	  $(call do_install,$$plugin,$(plugin_dir_SQ));	\
-	done
-endef
-
-define do_generate_dynamic_list_file
-	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
-	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
-	if [ "$$symbol_type" = "U W" ];then				\
-		(echo '{';						\
-		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
-		echo '};';						\
-		) > $2;							\
-	else								\
-		(echo Either missing one of [$1] or bad version of $(NM)) 1>&2;\
-	fi
-endef
-
 PKG_CONFIG_FILE = libtraceevent.pc
 define do_install_pkgconfig_file
 	if [ -n "${pkgconfig_dir}" ]; then 					\
@@ -296,10 +226,6 @@ install_lib: all_cmd install_plugins install_headers install_pkgconfig
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
 
-install_plugins: $(PLUGINS)
-	$(call QUIET_INSTALL, trace_plugins) \
-		$(call do_install_plugins, $(PLUGINS))
-
 install_pkgconfig:
 	$(call QUIET_INSTALL, $(PKG_CONFIG_FILE)) \
 		$(call do_install_pkgconfig_file,$(prefix))
@@ -313,7 +239,7 @@ install_headers:
 
 install: install_lib
 
-clean:
+clean: clean_plugins
 	$(call QUIET_CLEAN, libtraceevent) \
 		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd; \
 		$(RM) TRACEEVENT-CFLAGS tags TAGS; \
@@ -351,7 +277,19 @@ help:
 	@echo '  doc-install         - install the man pages'
 	@echo '  doc-uninstall       - uninstall the man pages'
 	@echo''
-PHONY += force plugins
+
+PHONY += plugins
+plugins:
+	$(call descend,plugins)
+
+PHONY += install_plugins
+install_plugins:
+	$(call descend,plugins,install)
+
+PHONY += clean_plugins
+clean_plugins:
+	$(call descend,plugins,clean)
+
 force:
 
 # Declare the contents of the .PHONY variable as phony.  We keep that
diff --git a/tools/lib/traceevent/plugins/Build b/tools/lib/traceevent/plugins/Build
new file mode 100644
index 000000000000..210d26910613
--- /dev/null
+++ b/tools/lib/traceevent/plugins/Build
@@ -0,0 +1,10 @@
+plugin_jbd2-y         += plugin_jbd2.o
+plugin_hrtimer-y      += plugin_hrtimer.o
+plugin_kmem-y         += plugin_kmem.o
+plugin_kvm-y          += plugin_kvm.o
+plugin_mac80211-y     += plugin_mac80211.o
+plugin_sched_switch-y += plugin_sched_switch.o
+plugin_function-y     += plugin_function.o
+plugin_xen-y          += plugin_xen.o
+plugin_scsi-y         += plugin_scsi.o
+plugin_cfg80211-y     += plugin_cfg80211.o
diff --git a/tools/lib/traceevent/plugins/Makefile b/tools/lib/traceevent/plugins/Makefile
new file mode 100644
index 000000000000..f440989fa55e
--- /dev/null
+++ b/tools/lib/traceevent/plugins/Makefile
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0
+
+#MAKEFLAGS += --no-print-directory
+
+
+# Makefiles suck: This macro sets a default value of $(2) for the
+# variable named by $(1), unless the variable has been set by
+# environment or command line. This is necessary for CC and AR
+# because make sets default values, so the simpler ?= approach
+# won't work as expected.
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,NM,$(CROSS_COMPILE)nm)
+$(call allow-override,PKG_CONFIG,pkg-config)
+
+EXT = -std=gnu99
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?= /usr/local
+libdir = $(prefix)/$(libdir_relative)
+
+set_plugin_dir := 1
+
+# Set plugin_dir to preffered global plugin location
+# If we install under $HOME directory we go under
+# $(HOME)/.local/lib/traceevent/plugins
+#
+# We dont set PLUGIN_DIR in case we install under $HOME
+# directory, because by default the code looks under:
+# $(HOME)/.local/lib/traceevent/plugins by default.
+#
+ifeq ($(plugin_dir),)
+ifeq ($(prefix),$(HOME))
+override plugin_dir = $(HOME)/.local/lib/traceevent/plugins
+set_plugin_dir := 0
+else
+override plugin_dir = $(libdir)/traceevent/plugins
+endif
+endif
+
+ifeq ($(set_plugin_dir),1)
+PLUGIN_DIR = -DPLUGIN_DIR="$(plugin_dir)"
+PLUGIN_DIR_SQ = '$(subst ','\'',$(PLUGIN_DIR))'
+endif
+
+include ../../../scripts/Makefile.include
+
+# copy a bit from Linux kbuild
+
+ifeq ("$(origin V)", "command line")
+  VERBOSE = $(V)
+endif
+ifndef VERBOSE
+  VERBOSE = 0
+endif
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+export prefix libdir src obj
+
+# Shell quotes
+plugin_dir_SQ = $(subst ','\'',$(plugin_dir))
+
+CONFIG_INCLUDES =
+CONFIG_LIBS    =
+CONFIG_FLAGS   =
+
+OBJ            = $@
+N              =
+
+INCLUDES = -I. -I.. -I $(srctree)/tools/include $(CONFIG_INCLUDES)
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+# Append required CFLAGS
+override CFLAGS += -fPIC
+override CFLAGS += $(CONFIG_FLAGS) $(INCLUDES) $(PLUGIN_DIR_SQ)
+override CFLAGS += $(udis86-flags) -D_GNU_SOURCE
+
+ifeq ($(VERBOSE),1)
+  Q =
+else
+  Q = @
+endif
+
+# Disable command line variables (CFLAGS) override from top
+# level Makefile (perf), otherwise build Makefile will get
+# the same command line setup.
+MAKEOVERRIDES=
+
+export srctree OUTPUT CC LD CFLAGS V
+
+build := -f $(srctree)/tools/build/Makefile.build dir=. obj
+
+DYNAMIC_LIST_FILE := $(OUTPUT)libtraceevent-dynamic-list
+
+PLUGINS  = plugin_jbd2.so
+PLUGINS += plugin_hrtimer.so
+PLUGINS += plugin_kmem.so
+PLUGINS += plugin_kvm.so
+PLUGINS += plugin_mac80211.so
+PLUGINS += plugin_sched_switch.so
+PLUGINS += plugin_function.so
+PLUGINS += plugin_xen.so
+PLUGINS += plugin_scsi.so
+PLUGINS += plugin_cfg80211.so
+
+PLUGINS    := $(addprefix $(OUTPUT),$(PLUGINS))
+PLUGINS_IN := $(PLUGINS:.so=-in.o)
+
+plugins: $(PLUGINS) $(DYNAMIC_LIST_FILE)
+
+__plugin_obj = $(notdir $@)
+  plugin_obj = $(__plugin_obj:-in.o=)
+
+$(PLUGINS_IN): force
+	$(Q)$(MAKE) $(build)=$(plugin_obj)
+
+$(OUTPUT)libtraceevent-dynamic-list: $(PLUGINS)
+	$(QUIET_GEN)$(call do_generate_dynamic_list_file, $(PLUGINS), $@)
+
+$(OUTPUT)%.so: $(OUTPUT)%-in.o
+	$(QUIET_LINK)$(CC) $(CFLAGS) -shared $(LDFLAGS) -nostartfiles -o $@ $^
+
+define update_dir
+  (echo $1 > $@.tmp;                           \
+   if [ -r $@ ] && cmp -s $@ $@.tmp; then      \
+     rm -f $@.tmp;                             \
+   else                                                \
+     echo '  UPDATE                 $@';       \
+     mv -f $@.tmp $@;                          \
+   fi);
+endef
+
+tags:	force
+	$(RM) tags
+	find . -name '*.[ch]' | xargs ctags --extra=+f --c-kinds=+px \
+	--regex-c++='/_PE\(([^,)]*).*/TEP_ERRNO__\1/'
+
+TAGS:	force
+	$(RM) TAGS
+	find . -name '*.[ch]' | xargs etags \
+	--regex='/_PE(\([^,)]*\).*/TEP_ERRNO__\1/'
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	$(call do_install_mkdir,$2);                    \
+	$(INSTALL) $(if $3,-m $3,) $1 '$(DESTDIR_SQ)$2'
+endef
+
+define do_install_plugins
+       for plugin in $1; do                            \
+         $(call do_install,$$plugin,$(plugin_dir_SQ)); \
+       done
+endef
+
+define do_generate_dynamic_list_file
+	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
+	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
+	if [ "$$symbol_type" = "U W" ];then				\
+		(echo '{';                                              \
+		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
+		echo '};';                                              \
+		) > $2;                                                 \
+	else                                                            \
+		(echo Either missing one of [$1] or bad version of $(NM)) 1>&2;\
+		fi
+endef
+
+install: $(PLUGINS)
+	$(call QUIET_INSTALL, trace_plugins) \
+	$(call do_install_plugins, $(PLUGINS))
+
+clean:
+	$(call QUIET_CLEAN, trace_plugins) \
+		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd; \
+		$(RM) $(OUTPUT)libtraceevent-dynamic-list \
+		$(RM) TRACEEVENT-CFLAGS tags TAGS;
+
+PHONY += force plugins
+force:
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable so we can use it in if_changed and friends.
+.PHONY: $(PHONY)
diff --git a/tools/lib/traceevent/plugin_cfg80211.c b/tools/lib/traceevent/plugins/plugin_cfg80211.c
similarity index 100%
rename from tools/lib/traceevent/plugin_cfg80211.c
rename to tools/lib/traceevent/plugins/plugin_cfg80211.c
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugins/plugin_function.c
similarity index 100%
rename from tools/lib/traceevent/plugin_function.c
rename to tools/lib/traceevent/plugins/plugin_function.c
diff --git a/tools/lib/traceevent/plugin_hrtimer.c b/tools/lib/traceevent/plugins/plugin_hrtimer.c
similarity index 100%
rename from tools/lib/traceevent/plugin_hrtimer.c
rename to tools/lib/traceevent/plugins/plugin_hrtimer.c
diff --git a/tools/lib/traceevent/plugin_jbd2.c b/tools/lib/traceevent/plugins/plugin_jbd2.c
similarity index 100%
rename from tools/lib/traceevent/plugin_jbd2.c
rename to tools/lib/traceevent/plugins/plugin_jbd2.c
diff --git a/tools/lib/traceevent/plugin_kmem.c b/tools/lib/traceevent/plugins/plugin_kmem.c
similarity index 100%
rename from tools/lib/traceevent/plugin_kmem.c
rename to tools/lib/traceevent/plugins/plugin_kmem.c
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugins/plugin_kvm.c
similarity index 100%
rename from tools/lib/traceevent/plugin_kvm.c
rename to tools/lib/traceevent/plugins/plugin_kvm.c
diff --git a/tools/lib/traceevent/plugin_mac80211.c b/tools/lib/traceevent/plugins/plugin_mac80211.c
similarity index 100%
rename from tools/lib/traceevent/plugin_mac80211.c
rename to tools/lib/traceevent/plugins/plugin_mac80211.c
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugins/plugin_sched_switch.c
similarity index 100%
rename from tools/lib/traceevent/plugin_sched_switch.c
rename to tools/lib/traceevent/plugins/plugin_sched_switch.c
diff --git a/tools/lib/traceevent/plugin_scsi.c b/tools/lib/traceevent/plugins/plugin_scsi.c
similarity index 100%
rename from tools/lib/traceevent/plugin_scsi.c
rename to tools/lib/traceevent/plugins/plugin_scsi.c
diff --git a/tools/lib/traceevent/plugin_xen.c b/tools/lib/traceevent/plugins/plugin_xen.c
similarity index 100%
rename from tools/lib/traceevent/plugin_xen.c
rename to tools/lib/traceevent/plugins/plugin_xen.c
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2ccc12f3730b..902c792f326a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -292,7 +292,7 @@ endif
 LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
 export LIBTRACEEVENT
 
-LIBTRACEEVENT_DYNAMIC_LIST = $(TE_PATH)libtraceevent-dynamic-list
+LIBTRACEEVENT_DYNAMIC_LIST = $(TE_PATH)plugins/libtraceevent-dynamic-list
 
 #
 # The static build has no dynsym table, so this does not work for
@@ -737,7 +737,7 @@ libtraceevent_plugins: FORCE
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
 
 $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent-dynamic-list
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)plugins/libtraceevent-dynamic-list
 
 $(LIBTRACEEVENT)-clean:
 	$(call QUIET_CLEAN, libtraceevent)
-- 
2.21.0

