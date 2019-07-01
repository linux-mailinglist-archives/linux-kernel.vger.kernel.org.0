Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11350647
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfFXJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 05:57:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfFXJ4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 183E6ED1;
        Mon, 24 Jun 2019 02:56:18 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2893F71E;
        Mon, 24 Jun 2019 02:56:16 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC V3 05/18] objtool: special: Adapt special section handling
Date:   Mon, 24 Jun 2019 10:55:35 +0100
Message-Id: <20190624095548.8578-6-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch abstracts the few architecture dependent tests that are
perform when handling special section and switch tables. It enables any
architecture to ignore a particular CPU feature or not to handle switch
tables.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch/arm64/Build                |  1 +
 tools/objtool/arch/arm64/arch_special.c       | 22 +++++++++++++++
 .../objtool/arch/arm64/include/arch_special.h | 10 +++++--
 tools/objtool/arch/x86/Build                  |  1 +
 tools/objtool/arch/x86/arch_special.c         | 28 +++++++++++++++++++
 tools/objtool/arch/x86/include/arch_special.h |  9 ++++++
 tools/objtool/check.c                         | 15 ++++++++--
 tools/objtool/special.c                       |  9 ++----
 tools/objtool/special.h                       |  3 ++
 9 files changed, 87 insertions(+), 11 deletions(-)
 create mode 100644 tools/objtool/arch/arm64/arch_special.c
 create mode 100644 tools/objtool/arch/x86/arch_special.c

diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
index bf7a32c2b9e9..3d09be745a84 100644
--- a/tools/objtool/arch/arm64/Build
+++ b/tools/objtool/arch/arm64/Build
@@ -1,3 +1,4 @@
+objtool-y += arch_special.o
 objtool-y += decode.o
 objtool-y += orc_dump.o
 objtool-y += orc_gen.o
diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
new file mode 100644
index 000000000000..a21d28876317
--- /dev/null
+++ b/tools/objtool/arch/arm64/arch_special.c
@@ -0,0 +1,22 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "../../special.h"
+#include "arch_special.h"
+
+void arch_force_alt_path(unsigned short feature,
+			 bool uaccess,
+			 struct special_alt *alt)
+{
+}
diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
index 63da775d0581..185103be8a51 100644
--- a/tools/objtool/arch/arm64/include/arch_special.h
+++ b/tools/objtool/arch/arm64/include/arch_special.h
@@ -30,7 +30,13 @@
 #define ALT_ORIG_LEN_OFFSET	10
 #define ALT_NEW_LEN_OFFSET	11
 
-#define X86_FEATURE_POPCNT (4 * 32 + 23)
-#define X86_FEATURE_SMAP   (9 * 32 + 20)
+static inline bool arch_should_ignore_feature(unsigned short feature)
+{
+	return false;
+}
 
+static inline bool arch_support_switch_table(void)
+{
+	return false;
+}
 #endif /* _ARM64_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 1f11b45999d0..63e167775bc8 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,3 +1,4 @@
+objtool-y += arch_special.o
 objtool-y += decode.o
 objtool-y += orc_dump.o
 objtool-y += orc_gen.o
diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
new file mode 100644
index 000000000000..6583a1770bb2
--- /dev/null
+++ b/tools/objtool/arch/x86/arch_special.c
@@ -0,0 +1,28 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "../../special.h"
+#include "arch_special.h"
+
+void arch_force_alt_path(unsigned short feature,
+			 bool uaccess,
+			 struct special_alt *alt)
+{
+		if (feature == X86_FEATURE_SMAP) {
+			if (uaccess)
+				alt->skip_orig = true;
+			else
+				alt->skip_alt = true;
+		}
+}
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
index 424ce47013e3..fce2b1193194 100644
--- a/tools/objtool/arch/x86/include/arch_special.h
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -33,4 +33,13 @@
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
 
+static inline bool arch_should_ignore_feature(unsigned short feature)
+{
+	return feature == X86_FEATURE_POPCNT;
+}
+
+static inline bool arch_support_switch_table(void)
+{
+	return true;
+}
 #endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1a7ee85e9878..0fba7b70d73a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -729,7 +729,7 @@ static int handle_group_alt(struct objtool_file *file,
 		last_orig_insn = insn;
 	}
 
-	if (next_insn_same_sec(file, last_orig_insn)) {
+	if (last_orig_insn && next_insn_same_sec(file, last_orig_insn)) {
 		fake_jump = malloc(sizeof(*fake_jump));
 		if (!fake_jump) {
 			WARN("malloc failed");
@@ -1045,6 +1045,17 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(rodata_sec, table_offset))
 			continue;
 
+		/*
+		 * If we are on arm64 architecture, we now that we
+		 * are in presence of a switch table thanks to
+		 * the `br <Xn>` insn. but we can't retrieve it yet.
+		 * So we just ignore unreachable for this file.
+		 */
+		if (!arch_support_switch_table()) {
+			file->ignore_unreachables = true;
+			return NULL;
+		}
+
 		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
 		if (rodata_rela) {
 			/*
@@ -1844,7 +1855,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (!insn->visited && insn->alt_group && list_empty(&insn->alts)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index b8ccee1b5382..7a0092d6e5b3 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -81,7 +81,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		 * feature path which is a "very very small percentage of
 		 * machines".
 		 */
-		if (feature == X86_FEATURE_POPCNT)
+		if (arch_should_ignore_feature(feature))
 			alt->skip_orig = true;
 
 		/*
@@ -93,12 +93,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		 * find paths that see the STAC but take the NOP instead of
 		 * CLAC and the other way around.
 		 */
-		if (feature == X86_FEATURE_SMAP) {
-			if (uaccess)
-				alt->skip_orig = true;
-			else
-				alt->skip_alt = true;
-		}
+		arch_force_alt_path(feature, uaccess, alt);
 	}
 
 	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 35061530e46e..90626a7e41cf 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -27,5 +27,8 @@ struct special_alt {
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
+void arch_force_alt_path(unsigned short feature,
+			 bool uaccess,
+			 struct special_alt *alt);
 
 #endif /* _SPECIAL_H */
-- 
2.17.1

