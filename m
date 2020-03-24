Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F621915C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgCXQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:12:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgCXQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AtRDJfwHMsY0ORbW7MH7PeCHOIjSQ1EgEUN44fx3SEo=; b=RRT/eNdbgVqw99udqs/C9sk9l1
        ubqCWMR1KeM25xFIol7CPB1vyMijc7XbLZeAes5UMEi3JxHlzy7Ko0Ty9mFSuXDDY6IcIMRuAhky3
        Vv88+xqvHGL169o+Nv1Rj7C9ByVjEqIYZtd37h5+Vf61DXsfjbjm4Yoh6hqW9hYaAj6ZQ00HpvLdd
        j3mUVQ06LKXEovD+shAva1UxnHVpO0+gYoo8tRjU7JpWy+gco5U/3mwhS1z3lKO8dP6nDgS959DNT
        FZBVIY+Z13fLD63mDFOdVVoFGjgagHzO3Fw71zHHYgFs94YFL310H+C84sPC/qU82iRajX2k1rhRC
        vC+rNSMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9N-0000CN-Eo; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75693307648;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 654B529A490F0; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160925.228938117@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 22/26] objtool: Detect loading function pointers across noinstr
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect if noinstr text loads functions pointers from regular text,
doing so is a definite sign that indirect function calls are unsafe.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch.h  |    2 +
 tools/objtool/check.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/objtool/check.h |    2 -
 3 files changed, 74 insertions(+), 1 deletion(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -75,4 +75,6 @@ int arch_decode_instruction(struct elf *
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+#define MAX_INSN_SIZE 15
+
 #endif /* _ARCH_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -42,6 +42,25 @@ struct instruction *find_insn(struct obj
 	return NULL;
 }
 
+static struct instruction *find_insn_containing(struct objtool_file *file, struct section *sec,
+					 unsigned long offset)
+{
+	struct instruction *insn;
+	unsigned long o;
+
+	for_offset_range(o, offset - MAX_INSN_SIZE - 1, offset) {
+		hash_for_each_possible(file->insn_hash, insn, hash, sec_offset_hash(sec, o)) {
+			if (insn->sec != sec)
+				continue;
+
+			if (insn->offset <= offset && insn->offset + insn->len > offset)
+				return insn;
+		}
+	}
+
+	return NULL;
+}
+
 static struct instruction *next_insn_same_sec(struct objtool_file *file,
 					      struct instruction *insn)
 {
@@ -2101,6 +2120,32 @@ static int validate_return(struct symbol
 	return 0;
 }
 
+static int validate_rela(struct instruction *insn, struct insn_state *state)
+{
+	/*
+	 * Assume that any text rela that's not a CALL or JMP is a load of a
+	 * function pointer.
+	 */
+
+	switch (insn->type) {
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+		return 0;
+
+	default:
+		break;
+	}
+
+	if (state->noinstr && state->instr <= 0 && insn->has_text_rela) {
+		WARN_FUNC("loading non-noinstr function pointer", insn->sec, insn->offset);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2216,6 +2261,10 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		ret = validate_rela(insn, &state);
+		if (ret)
+			return ret;
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
@@ -2484,6 +2533,25 @@ static bool ignore_unreachable_insn(stru
 	return false;
 }
 
+static void prepare_insn_rela(struct objtool_file *file, struct section *sec)
+{
+	struct instruction *insn;
+	struct rela *rela;
+
+	if (!sec->rela)
+		return;
+
+	list_for_each_entry(rela, &sec->rela->rela_list, list) {
+		insn = find_insn_containing(file, sec, rela->offset);
+		if (!insn)
+			continue;
+
+		insn->has_text_rela = rela->sym && rela->sym->sec &&
+				      rela->sym->sec->text &&
+				      !rela->sym->sec->noinstr;
+	}
+}
+
 static int validate_section(struct objtool_file *file, struct section *sec)
 {
 	struct symbol *func;
@@ -2506,6 +2574,9 @@ static int validate_section(struct objto
 	if (vmlinux)
 		state.noinstr = sec->noinstr;
 
+	if (state.noinstr)
+		prepare_insn_rela(file, sec);
+
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -36,7 +36,7 @@ struct instruction {
 	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
-	bool retpoline_safe;
+	bool retpoline_safe, has_text_rela;
 	s8 instr;
 	u8 visited;
 	struct symbol *call_dest;


