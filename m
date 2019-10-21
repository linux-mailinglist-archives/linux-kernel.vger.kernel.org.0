Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4896DF334
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfJUQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 12:35:03 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57554 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfJUQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:35:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4C8105A;
        Mon, 21 Oct 2019 09:34:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04AA83F71F;
        Mon, 21 Oct 2019 09:34:37 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCH 2/8] module/ftrace: handle patchable-function-entry
Date:   Mon, 21 Oct 2019 17:34:20 +0100
Message-Id: <20191021163426.9408-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021163426.9408-1-mark.rutland@arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using patchable-function-entry, the compiler will record the
callsites into a section named "__patchable_function_entries" rather
than "__mcount_loc". Let's abstract this difference behind a new
FTRACE_CALLSITE_SECTION, so that architectures don't have to handle this
explicitly (e.g. with custom module linker scripts).

As parisc currently handles this explicitly, it is fixed up accordingly,
with its custom linker script removed. Since FTRACE_CALLSITE_SECTION is
only defined when DYNAMIC_FTRACE is selected, the parisc module loading
code is updated to only use the definition in that case. When
DYNAMIC_FTRACE is not selected, modules shouldn't have this section, so
this removes some redundant work in that case.

I built parisc generic-{32,64}bit_defconfig with DYNAMIC_FTRACE enabled,
and verified that the section made it into the .ko files for modules.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@stackframe.org>
---
 arch/parisc/Makefile          |  1 -
 arch/parisc/kernel/module.c   | 10 +++++++---
 arch/parisc/kernel/module.lds |  7 -------
 include/linux/ftrace.h        |  5 +++++
 kernel/module.c               |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)
 delete mode 100644 arch/parisc/kernel/module.lds

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 36b834f1c933..dca8f2de8cf5 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -60,7 +60,6 @@ KBUILD_CFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY=1 \
 		 -DFTRACE_PATCHABLE_FUNCTION_SIZE=$(NOP_COUNT)
 
 CC_FLAGS_FTRACE := -fpatchable-function-entry=$(NOP_COUNT),$(shell echo $$(($(NOP_COUNT)-1)))
-KBUILD_LDS_MODULE += $(srctree)/arch/parisc/kernel/module.lds
 endif
 
 OBJCOPY_FLAGS =-O binary -R .note -R .comment -S
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index ac5f34993b53..1c50093e2ebe 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -43,6 +43,7 @@
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <linux/ftrace.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
@@ -862,7 +863,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const char *strtab = NULL;
 	const Elf_Shdr *s;
 	char *secstrings;
-	int err, symindex = -1;
+	int symindex = -1;
 	Elf_Sym *newptr, *oldptr;
 	Elf_Shdr *symhdr = NULL;
 #ifdef DEBUG
@@ -946,11 +947,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 			/* patch .altinstructions */
 			apply_alternatives(aseg, aseg + s->sh_size, me->name);
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 		/* For 32 bit kernels we're compiling modules with
 		 * -ffunction-sections so we must relocate the addresses in the
-		 *__mcount_loc section.
+		 *  ftrace callsite section.
 		 */
-		if (symindex != -1 && !strcmp(secname, "__mcount_loc")) {
+		if (symindex != -1 && !strcmp(secname, FTRACE_CALLSITE_SECTION)) {
+			int err;
 			if (s->sh_type == SHT_REL)
 				err = apply_relocate((Elf_Shdr *)sechdrs,
 							strtab, symindex,
@@ -962,6 +965,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 			if (err)
 				return err;
 		}
+#endif
 	}
 	return 0;
 }
diff --git a/arch/parisc/kernel/module.lds b/arch/parisc/kernel/module.lds
deleted file mode 100644
index 1a9a92aca5c8..000000000000
--- a/arch/parisc/kernel/module.lds
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-SECTIONS {
-	__mcount_loc : {
-		*(__patchable_function_entries)
-	}
-}
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..cea0746c8f4c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -709,6 +709,11 @@ static inline unsigned long get_lock_parent_ip(void)
 
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 extern void ftrace_init(void);
+#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
+#define FTRACE_CALLSITE_SECTION	"__patchable_function_entries"
+#else
+#define FTRACE_CALLSITE_SECTION	"__mcount_loc"
+#endif
 #else
 static inline void ftrace_init(void) { }
 #endif
diff --git a/kernel/module.c b/kernel/module.c
index ff2d7359a418..acf7962936c4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3222,7 +3222,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 	/* sechdrs[0].sh_size is always zero */
-	mod->ftrace_callsites = section_objs(info, "__mcount_loc",
+	mod->ftrace_callsites = section_objs(info, FTRACE_CALLSITE_SECTION,
 					     sizeof(*mod->ftrace_callsites),
 					     &mod->num_ftrace_callsites);
 #endif
-- 
2.11.0

