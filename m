Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1284727322
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 02:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfEWAEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 20:04:38 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13607 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728415AbfEWAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:04:18 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 May 2019 17:03:44 -0700
Received: from rlwimi.localdomain (unknown [10.129.221.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id CFD2BB2067;
        Wed, 22 May 2019 20:03:57 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 09/13] objtool: Prepare to merge recordmcount
Date:   Wed, 22 May 2019 17:03:32 -0700
Message-ID: <6b39c7518fa32bd311e51b258f3ed3cd3f5f759b.1558569448.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558569448.git.mhelsley@vmware.com>
References: <cover.1558569448.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move recordmcount into the objtool directory. We keep this step separate
so changes which turn recordmcount into a subcommand of objtool don't
get obscured.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/.gitignore                         |  1 -
 scripts/Makefile                           |  1 -
 scripts/Makefile.build                     | 11 ++++++-----
 tools/objtool/.gitignore                   |  1 +
 tools/objtool/Build                        |  2 ++
 tools/objtool/Makefile                     | 13 ++++++++++++-
 {scripts => tools/objtool}/recordmcount.c  |  0
 {scripts => tools/objtool}/recordmcount.h  |  0
 {scripts => tools/objtool}/recordmcount.pl |  0
 9 files changed, 21 insertions(+), 8 deletions(-)
 rename {scripts => tools/objtool}/recordmcount.c (100%)
 rename {scripts => tools/objtool}/recordmcount.h (100%)
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

diff --git a/scripts/.gitignore b/scripts/.gitignore
index 17f8cef88fa8..1b5b5d595d80 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -6,7 +6,6 @@ conmakehash
 kallsyms
 pnmtologo
 unifdef
-recordmcount
 sortextable
 asn1_compiler
 extract-cert
diff --git a/scripts/Makefile b/scripts/Makefile
index 9d442ee050bd..5fca50fee42b 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -14,7 +14,6 @@ hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
 hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
 hostprogs-$(CONFIG_LOGO)         += pnmtologo
 hostprogs-$(CONFIG_VT)           += conmakehash
-hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
 hostprogs-$(CONFIG_BUILDTIME_EXTABLE_SORT) += sortextable
 hostprogs-$(CONFIG_ASN1)	 += asn1_compiler
 hostprogs-$(CONFIG_MODULE_SIG)	 += sign-file
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ae9cf740633e..f32cfe63bb0e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -186,18 +186,19 @@ endif
 # files, including recordmcount.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
-recordmcount_source := $(srctree)/scripts/recordmcount.c \
-		    $(srctree)/scripts/recordmcount.h
+
+recordmcount_source := $(srctree)/tools/objtool/recordmcount.c \
+		    $(srctree)/tools/objtool/recordmcount.h
 else
-sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
-recordmcount_source := $(srctree)/scripts/recordmcount.pl
+recordmcount_source := $(srctree)/tools/objtool/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 914cff12899b..ee471f353caa 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,3 +1,4 @@
 arch/x86/lib/inat-tables.c
 objtool
+recordmcount
 fixdep
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 749becdf5b90..78c4a8a2f9e7 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -20,3 +20,5 @@ $(OUTPUT)libstring.o: ../lib/string.c FORCE
 $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 88158239622b..bd9d0b6534cf 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -29,6 +29,12 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
 LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
 
+RECORDMCOUNT := $(OUTPUT)recordmcount
+RECORDMCOUNT_IN := $(RECORDMCOUNT)-in.o
+ifeq ($(BUILD_C_RECORDMCOUNT),y)
+all:  $(RECORDMCOUNT)
+endif
+
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
@@ -49,16 +55,21 @@ include $(srctree)/tools/build/Makefile.include
 $(OBJTOOL_IN): fixdep FORCE
 	@$(MAKE) $(build)=objtool
 
+$(RECORDMCOUNT_IN): fixdep FORCE
+	@$(MAKE) $(build)=recordmcount
+
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	@$(CONFIG_SHELL) ./sync-check.sh
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
+$(RECORDMCOUNT): $(RECORDMCOUNT_IN)
+	$(QUIET_LINK)$(CC) $(RECORDMCOUNT_IN) $(KBUILD_HOSTLDFLAGS) -o $@
 
 $(LIBSUBCMD): fixdep FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
 
 clean:
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
+	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL) $(RECORDMCOUNT)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 
diff --git a/scripts/recordmcount.c b/tools/objtool/recordmcount.c
similarity index 100%
rename from scripts/recordmcount.c
rename to tools/objtool/recordmcount.c
diff --git a/scripts/recordmcount.h b/tools/objtool/recordmcount.h
similarity index 100%
rename from scripts/recordmcount.h
rename to tools/objtool/recordmcount.h
diff --git a/scripts/recordmcount.pl b/tools/objtool/recordmcount.pl
similarity index 100%
rename from scripts/recordmcount.pl
rename to tools/objtool/recordmcount.pl
-- 
2.20.1

