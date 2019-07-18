Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577AC6D49A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbfGRTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:20:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:20:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJK16i2125797
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:20:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJK16i2125797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477602;
        bh=CQcJQVloIa4EcDJIDsphByGJkJ8vBwFmOaqJ6pgJocM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZC+f//z7yLXj8zp/PtQXDtjOQeKdISBq8bV2ASJSx8lE5uAQwmmqbLMTH9a9QFa1z
         XQQi9qEzgS6krbPxH15p2U22yZnHV6DQYePzI0NU/fvSuhoeax3EWr1Ut4Xs9Oi1IT
         +xRR1gSBuCXsTUEr6CzCY+jaExD/LgIy1Cbvk8+ypmE5DOowFCaAildnP+Ka7Vk4qC
         AH0tmlOu/AmCpSufzdzSTuzTGX8B+2zTUrWqHn9NPt/PCIOwBlTfmKamdDJcYIMt6M
         WLaa7pCz9YjT6EgxXkaJsKoLnIZjur7R38R3TixwRwY0wwp16/0A3SHvV8PQ0MQEQz
         mwFv1TX8Uj3ew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJK1bE2125794;
        Thu, 18 Jul 2019 12:20:01 -0700
Date:   Thu, 18 Jul 2019 12:20:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e7c2bc37bfae120bce3e7cc8c8abf9d110af0757@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, jpoimboe@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        ndesaulniers@google.com
Reply-To: ndesaulniers@google.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, tglx@linutronix.de, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <cf951b0c0641628e0b9b81f7ceccd9bcabcb4bd8.1563413318.git.jpoimboe@redhat.com>
References: <cf951b0c0641628e0b9b81f7ceccd9bcabcb4bd8.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Refactor jump table code
Git-Commit-ID: e7c2bc37bfae120bce3e7cc8c8abf9d110af0757
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_48_96,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e7c2bc37bfae120bce3e7cc8c8abf9d110af0757
Gitweb:     https://git.kernel.org/tip/e7c2bc37bfae120bce3e7cc8c8abf9d110af0757
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:53 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:09 +0200

objtool: Refactor jump table code

Now that C jump tables are supported, call them "jump tables" instead of
"switch tables".  Also rename some other variables, add comments, and
simplify the code flow a bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/cf951b0c0641628e0b9b81f7ceccd9bcabcb4bd8.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 82 +++++++++++++++++++++++++++------------------------
 tools/objtool/elf.c   |  2 +-
 tools/objtool/elf.h   |  2 +-
 3 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7fe31e0f8afe..4525cf677a1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -627,7 +627,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * However this code can't completely replace the
 			 * read_symbols() code because this doesn't detect the
 			 * case where the parent function's only reference to a
-			 * subfunction is through a switch table.
+			 * subfunction is through a jump table.
 			 */
 			if (!strstr(insn->func->name, ".cold.") &&
 			    strstr(insn->jump_dest->func->name, ".cold.")) {
@@ -899,20 +899,24 @@ out:
 	return ret;
 }
 
-static int add_switch_table(struct objtool_file *file, struct instruction *insn,
+static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			    struct rela *table, struct rela *next_table)
 {
 	struct rela *rela = table;
-	struct instruction *alt_insn;
+	struct instruction *dest_insn;
 	struct alternative *alt;
 	struct symbol *pfunc = insn->func->pfunc;
 	unsigned int prev_offset = 0;
 
-	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
+	/*
+	 * Each @rela is a switch table relocation which points to the target
+	 * instruction.
+	 */
+	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
 		if (rela == next_table)
 			break;
 
-		/* Make sure the switch table entries are consecutive: */
+		/* Make sure the table entries are consecutive: */
 		if (prev_offset && rela->offset != prev_offset + 8)
 			break;
 
@@ -921,12 +925,12 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 		    rela->addend == pfunc->offset)
 			break;
 
-		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!alt_insn)
+		dest_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!dest_insn)
 			break;
 
-		/* Make sure the jmp dest is in the function or subfunction: */
-		if (alt_insn->func->pfunc != pfunc)
+		/* Make sure the destination is in the same function: */
+		if (dest_insn->func->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
@@ -935,7 +939,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 			return -1;
 		}
 
-		alt->insn = alt_insn;
+		alt->insn = dest_insn;
 		list_add_tail(&alt->list, &insn->alts);
 		prev_offset = rela->offset;
 	}
@@ -950,7 +954,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 }
 
 /*
- * find_switch_table() - Given a dynamic jump, find the switch jump table in
+ * find_jump_table() - Given a dynamic jump, find the switch jump table in
  * .rodata associated with it.
  *
  * There are 3 basic patterns:
@@ -992,13 +996,13 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
  *
  *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
-static struct rela *find_switch_table(struct objtool_file *file,
+static struct rela *find_jump_table(struct objtool_file *file,
 				      struct symbol *func,
 				      struct instruction *insn)
 {
-	struct rela *text_rela, *rodata_rela;
+	struct rela *text_rela, *table_rela;
 	struct instruction *orig_insn = insn;
-	struct section *rodata_sec;
+	struct section *table_sec;
 	unsigned long table_offset;
 
 	/*
@@ -1031,7 +1035,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 			continue;
 
 		table_offset = text_rela->addend;
-		rodata_sec = text_rela->sym->sec;
+		table_sec = text_rela->sym->sec;
 
 		if (text_rela->type == R_X86_64_PC32)
 			table_offset += 4;
@@ -1045,29 +1049,31 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
 		 * have symbols associated with them.
 		 */
-		if (find_symbol_containing(rodata_sec, table_offset) &&
-		    strcmp(rodata_sec->name, C_JUMP_TABLE_SECTION))
+		if (find_symbol_containing(table_sec, table_offset) &&
+		    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
 
-		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
-		if (rodata_rela) {
-			/*
-			 * Use of RIP-relative switch jumps is quite rare, and
-			 * indicates a rare GCC quirk/bug which can leave dead
-			 * code behind.
-			 */
-			if (text_rela->type == R_X86_64_PC32)
-				file->ignore_unreachables = true;
+		/* Each table entry has a rela associated with it. */
+		table_rela = find_rela_by_dest(table_sec, table_offset);
+		if (!table_rela)
+			continue;
 
-			return rodata_rela;
-		}
+		/*
+		 * Use of RIP-relative switch jumps is quite rare, and
+		 * indicates a rare GCC quirk/bug which can leave dead code
+		 * behind.
+		 */
+		if (text_rela->type == R_X86_64_PC32)
+			file->ignore_unreachables = true;
+
+		return table_rela;
 	}
 
 	return NULL;
 }
 
 
-static int add_func_switch_tables(struct objtool_file *file,
+static int add_func_jump_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
 	struct instruction *insn, *last = NULL, *prev_jump = NULL;
@@ -1080,7 +1086,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 
 		/*
 		 * Store back-pointers for unconditional forward jumps such
-		 * that find_switch_table() can back-track using those and
+		 * that find_jump_table() can back-track using those and
 		 * avoid some potentially confusing code.
 		 */
 		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
@@ -1095,17 +1101,17 @@ static int add_func_switch_tables(struct objtool_file *file,
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
-		rela = find_switch_table(file, func, insn);
+		rela = find_jump_table(file, func, insn);
 		if (!rela)
 			continue;
 
 		/*
-		 * We found a switch table, but we don't know yet how big it
+		 * We found a jump table, but we don't know yet how big it
 		 * is.  Don't add it until we reach the end of the function or
-		 * the beginning of another switch table in the same function.
+		 * the beginning of another jump table in the same function.
 		 */
 		if (prev_jump) {
-			ret = add_switch_table(file, prev_jump, prev_rela, rela);
+			ret = add_jump_table(file, prev_jump, prev_rela, rela);
 			if (ret)
 				return ret;
 		}
@@ -1115,7 +1121,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	}
 
 	if (prev_jump) {
-		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
+		ret = add_jump_table(file, prev_jump, prev_rela, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1128,7 +1134,7 @@ static int add_func_switch_tables(struct objtool_file *file,
  * section which contains a list of addresses within the function to jump to.
  * This finds these jump tables and adds them to the insn->alts lists.
  */
-static int add_switch_table_alts(struct objtool_file *file)
+static int add_jump_table_alts(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
@@ -1142,7 +1148,7 @@ static int add_switch_table_alts(struct objtool_file *file)
 			if (func->type != STT_FUNC)
 				continue;
 
-			ret = add_func_switch_tables(file, func);
+			ret = add_func_jump_tables(file, func);
 			if (ret)
 				return ret;
 		}
@@ -1339,7 +1345,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_switch_table_alts(file);
+	ret = add_jump_table_alts(file);
 	if (ret)
 		return ret;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 9194732a673d..edba4745f25a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -385,7 +385,7 @@ static int read_relas(struct elf *elf)
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
 			rela->sym = find_symbol_by_index(elf, symndx);
-			rela->rela_sec = sec;
+			rela->sec = sec;
 			if (!rela->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 2fe0b0aa741d..d4d3e0528d4a 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -57,7 +57,7 @@ struct rela {
 	struct list_head list;
 	struct hlist_node hash;
 	GElf_Rela rela;
-	struct section *rela_sec;
+	struct section *sec;
 	struct symbol *sym;
 	unsigned int type;
 	unsigned long offset;
