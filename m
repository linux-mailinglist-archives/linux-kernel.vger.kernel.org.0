Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38AE20397
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfEPKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:38:06 -0400
Received: from foss.arm.com ([217.140.101.70]:40836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfEPKiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2AE19BF;
        Thu, 16 May 2019 03:38:04 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700253F703;
        Thu, 16 May 2019 03:38:02 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 02/16] objtool: orc: Refactor ORC API for other architectures to implement.
Date:   Thu, 16 May 2019 11:36:41 +0100
Message-Id: <20190516103655.5509-3-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ORC unwinder is only supported on x86 at the moment and should thus be
in the x86 architecture code. In order not to break the whole structure in
case another architecture decides to support the ORC unwinder via objtool
we choose to let the implementation be done in the architecture dependent
code.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/Build                     |   2 -
 tools/objtool/arch.h                    |   3 +
 tools/objtool/arch/x86/Build            |   2 +
 tools/objtool/{ => arch/x86}/orc_dump.c |   4 +-
 tools/objtool/{ => arch/x86}/orc_gen.c  | 104 ++++++++++++++++++++++--
 tools/objtool/check.c                   |  99 +---------------------
 tools/objtool/orc.h                     |   4 +-
 7 files changed, 111 insertions(+), 107 deletions(-)
 rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (69%)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 749becdf5b90..2ed83344e0a5 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -2,8 +2,6 @@ objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
 objtool-y += check.o
-objtool-y += orc_gen.o
-objtool-y += orc_dump.o
 objtool-y += elf.o
 objtool-y += special.o
 objtool-y += objtool.o
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 9897f9f94b29..653812457966 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include "elf.h"
 #include "cfi.h"
+#include "orc.h"
 
 #define INSN_JUMP_CONDITIONAL	1
 #define INSN_JUMP_UNCONDITIONAL	2
@@ -87,6 +88,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+int arch_orc_read_unwind_hints(struct objtool_file *file);
+
 unsigned long arch_jump_destination(struct instruction *insn);
 
 unsigned long arch_dest_rela_offset(int addend);
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index b998412c017d..1f11b45999d0 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,4 +1,6 @@
 objtool-y += decode.o
+objtool-y += orc_dump.o
+objtool-y += orc_gen.o
 
 inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/arch/x86/orc_dump.c
similarity index 98%
rename from tools/objtool/orc_dump.c
rename to tools/objtool/arch/x86/orc_dump.c
index faa444270ee3..8ad0e5764118 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/arch/x86/orc_dump.c
@@ -16,8 +16,8 @@
  */
 
 #include <unistd.h>
-#include "orc.h"
-#include "warn.h"
+#include "../../orc.h"
+#include "../../warn.h"
 
 static const char *reg_name(unsigned int reg)
 {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/arch/x86/orc_gen.c
similarity index 69%
rename from tools/objtool/orc_gen.c
rename to tools/objtool/arch/x86/orc_gen.c
index 3f98dcfbc177..a1ee3b12c937 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/arch/x86/orc_gen.c
@@ -18,11 +18,11 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "orc.h"
-#include "check.h"
-#include "warn.h"
+#include "../../orc.h"
+#include "../../check.h"
+#include "../../warn.h"
 
-int create_orc(struct objtool_file *file)
+int arch_create_orc(struct objtool_file *file)
 {
 	struct instruction *insn;
 
@@ -128,7 +128,7 @@ static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
 	return 0;
 }
 
-int create_orc_sections(struct objtool_file *file)
+int arch_create_orc_sections(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
 	struct section *sec, *u_sec, *ip_relasec;
@@ -221,3 +221,97 @@ int create_orc_sections(struct objtool_file *file)
 
 	return 0;
 }
+
+int arch_orc_read_unwind_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct rela *rela;
+	struct unwind_hint *hint;
+	struct instruction *insn;
+	struct cfi_reg *cfa;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.unwind_hints section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(struct unwind_hint)) {
+		WARN("struct unwind_hint size mismatch");
+		return -1;
+	}
+
+	file->hints = true;
+
+	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
+		hint = (struct unwind_hint *)sec->data->d_buf + i;
+
+		rela = find_rela_by_dest(sec, i * sizeof(*hint));
+		if (!rela) {
+			WARN("can't find rela for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		cfa = &insn->state.cfa;
+
+		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
+			insn->save = true;
+			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
+			insn->restore = true;
+			insn->hint = true;
+			continue;
+		}
+
+		insn->hint = true;
+
+		switch (hint->sp_reg) {
+		case ORC_REG_UNDEFINED:
+			cfa->base = CFI_UNDEFINED;
+			break;
+		case ORC_REG_SP:
+			cfa->base = CFI_SP;
+			break;
+		case ORC_REG_BP:
+			cfa->base = CFI_BP;
+			break;
+		case ORC_REG_SP_INDIRECT:
+			cfa->base = CFI_SP_INDIRECT;
+			break;
+		case ORC_REG_R10:
+			cfa->base = CFI_R10;
+			break;
+		case ORC_REG_R13:
+			cfa->base = CFI_R13;
+			break;
+		case ORC_REG_DI:
+			cfa->base = CFI_DI;
+			break;
+		case ORC_REG_DX:
+			cfa->base = CFI_DX;
+			break;
+		default:
+			WARN_FUNC("unsupported unwind_hint sp base reg %d",
+				  insn->sec, insn->offset, hint->sp_reg);
+			return -1;
+		}
+
+		cfa->offset = hint->sp_offset;
+		insn->state.type = hint->type;
+		insn->state.end = hint->end;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2a803ab4d5b7..cd9cd26206d1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1156,99 +1156,6 @@ static int add_switch_table_alts(struct objtool_file *file)
 	return 0;
 }
 
-static int read_unwind_hints(struct objtool_file *file)
-{
-	struct section *sec, *relasec;
-	struct rela *rela;
-	struct unwind_hint *hint;
-	struct instruction *insn;
-	struct cfi_reg *cfa;
-	int i;
-
-	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
-	if (!sec)
-		return 0;
-
-	relasec = sec->rela;
-	if (!relasec) {
-		WARN("missing .rela.discard.unwind_hints section");
-		return -1;
-	}
-
-	if (sec->len % sizeof(struct unwind_hint)) {
-		WARN("struct unwind_hint size mismatch");
-		return -1;
-	}
-
-	file->hints = true;
-
-	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
-		hint = (struct unwind_hint *)sec->data->d_buf + i;
-
-		rela = find_rela_by_dest(sec, i * sizeof(*hint));
-		if (!rela) {
-			WARN("can't find rela for unwind_hints[%d]", i);
-			return -1;
-		}
-
-		insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!insn) {
-			WARN("can't find insn for unwind_hints[%d]", i);
-			return -1;
-		}
-
-		cfa = &insn->state.cfa;
-
-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
-			insn->save = true;
-			continue;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
-			insn->restore = true;
-			insn->hint = true;
-			continue;
-		}
-
-		insn->hint = true;
-
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
-			WARN_FUNC("unsupported unwind_hint sp base reg %d",
-				  insn->sec, insn->offset, hint->sp_reg);
-			return -1;
-		}
-
-		cfa->offset = hint->sp_offset;
-		insn->state.type = hint->type;
-		insn->state.end = hint->end;
-	}
-
-	return 0;
-}
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
@@ -1343,7 +1250,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_unwind_hints(file);
+	ret = arch_orc_read_unwind_hints(file);
 	if (ret)
 		return ret;
 
@@ -2465,11 +2372,11 @@ int check(const char *_objname, bool orc)
 	}
 
 	if (orc) {
-		ret = create_orc(&file);
+		ret = arch_create_orc(&file);
 		if (ret < 0)
 			goto out;
 
-		ret = create_orc_sections(&file);
+		ret = arch_create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
 
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index b0e92a6d0903..1aa02dce3bca 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -22,8 +22,8 @@
 
 struct objtool_file;
 
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
+int arch_create_orc(struct objtool_file *file);
+int arch_create_orc_sections(struct objtool_file *file);
 
 int orc_dump(const char *objname);
 
-- 
2.17.1

