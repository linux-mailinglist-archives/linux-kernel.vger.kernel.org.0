Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3893CCE027
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfJGLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:23:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HA/pCtgy84G9zjEH4qHuR5OpimT1qPdHRTNPmuQJOY4=; b=Qs5GFWOBXo/x7m3z1z5+L2RFHj
        jv2FR9y6nlTq0G3PeZTaSXv1sgjGSjFmjI1XB40rPETYdEz34CihwSbRdOR/PArCN1J0ljTWhrW3k
        VG8TGbKJ5p+zxhI4km+SN65aAiwD4RvWhRR8TvGYL8AXsWcjl4P/ZCZgi16+F++UP8JWl46K3C1wX
        CPD8O7e8zlbAlrA8GSUfcY06wLR2q8jT0U63US/BxWSs3jYBYFiRQsRJwbdkIQWA+AlPo/yhSLwt2
        3EZlgFYRoKPaOjYO0hXMU+Eq4UUY7cTL603hszPeOtPqfE4yP47oYWqsj30852SvjdULxXY41I5qa
        Qyp66Kyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0003GX-5i; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 858DD305EF7;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7446F20244F8C; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007081944.99652529.7@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:17:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v3 3/6] x86/alternatives,jump_label: Provide better text_poke() batching interface
References: <20191007081716.07616230.8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding another text_poke_bp_batch() user made me realize the interface
is all sorts of wrong. The text poke vector should be internal to the
implementation.

This then results in a trivial interface:

  text_poke_queue()  - which has the 'normal' text_poke_bp() interface
  text_poke_finish() - which takes no arguments and flushes any
                       pending text_poke()s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 arch/x86/include/asm/text-patching.h |   15 +----
 arch/x86/kernel/alternative.c        |   64 ++++++++++++++++++++--
 arch/x86/kernel/jump_label.c         |   99 ++++++++++++-----------------------
 3 files changed, 96 insertions(+), 82 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -25,14 +25,6 @@ static inline void apply_paravirt(struct
  */
 #define POKE_MAX_OPCODE_SIZE	5
 
-struct text_poke_loc {
-	void *addr;
-	int len;
-	s32 rel32;
-	u8 opcode;
-	const char text[POKE_MAX_OPCODE_SIZE];
-};
-
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
@@ -53,9 +45,10 @@ extern void *text_poke(void *addr, const
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
-extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
-extern void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-			       const void *opcode, size_t len, const void *emulate);
+
+extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
+extern void text_poke_finish(void);
+
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,6 +936,14 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+struct text_poke_loc {
+	void *addr;
+	int len;
+	s32 rel32;
+	u8 opcode;
+	const char text[POKE_MAX_OPCODE_SIZE];
+};
+
 static struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
@@ -1023,6 +1031,10 @@ int poke_int3_handler(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(poke_int3_handler);
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
+static struct text_poke_loc tp_vec[TP_VEC_MAX];
+static int tp_vec_nr;
+
 /**
  * text_poke_bp_batch() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch
@@ -1044,7 +1056,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  *		  replacing opcode
  *	- sync cores
  */
-void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
+static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
@@ -1118,11 +1130,7 @@ void text_poke_loc_init(struct text_poke
 {
 	struct insn insn;
 
-	if (!opcode)
-		opcode = (void *)tp->text;
-	else
-		memcpy((void *)tp->text, opcode, len);
-
+	memcpy((void *)tp->text, opcode, len);
 	if (!emulate)
 		emulate = opcode;
 
@@ -1167,6 +1175,50 @@ void text_poke_loc_init(struct text_poke
 	}
 }
 
+/*
+ * We hard rely on the tp_vec being ordered; ensure this is so by flushing
+ * early if needed.
+ */
+static bool tp_order_fail(void *addr)
+{
+	struct text_poke_loc *tp;
+
+	if (!tp_vec_nr)
+		return false;
+
+	if (!addr) /* force */
+		return true;
+
+	tp = &tp_vec[tp_vec_nr - 1];
+	if ((unsigned long)tp->addr > (unsigned long)addr)
+		return true;
+
+	return false;
+}
+
+static void text_poke_flush(void *addr)
+{
+	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
+		text_poke_bp_batch(tp_vec, tp_vec_nr);
+		tp_vec_nr = 0;
+	}
+}
+
+void text_poke_finish(void)
+{
+	text_poke_flush(NULL);
+}
+
+void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
+{
+	struct text_poke_loc *tp;
+
+	text_poke_flush(addr);
+
+	tp = &tp_vec[tp_vec_nr++];
+	text_poke_loc_init(tp, addr, opcode, len, emulate);
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -35,18 +35,19 @@ static void bug_at(unsigned char *ip, in
 	BUG();
 }
 
-static void __jump_label_set_jump_code(struct jump_entry *entry,
-				       enum jump_label_type type,
-				       union jump_code_union *code,
-				       int init)
+static const void *
+__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
+	static union jump_code_union code; /* relies on text_mutex */
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 	const void *expect;
 	int line;
 
-	code->jump = 0xe9;
-	code->offset = jump_entry_target(entry) -
+	lockdep_assert_held(&text_mutex);
+
+	code.jump = JMP32_INSN_OPCODE;
+	code.offset = jump_entry_target(entry) -
 		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
 	if (init) {
@@ -54,23 +55,23 @@ static void __jump_label_set_jump_code(s
 	} else if (type == JUMP_LABEL_JMP) {
 		expect = ideal_nop; line = __LINE__;
 	} else {
-		expect = code->code; line = __LINE__;
+		expect = code.code; line = __LINE__;
 	}
 
 	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
 		bug_at((void *)jump_entry_code(entry), line);
 
 	if (type == JUMP_LABEL_NOP)
-		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+		memcpy(&code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+
+	return &code;
 }
 
-static void __ref __jump_label_transform(struct jump_entry *entry,
-					 enum jump_label_type type,
-					 int init)
+static void inline __jump_label_transform(struct jump_entry *entry,
+					  enum jump_label_type type,
+					  int init)
 {
-	union jump_code_union code;
-
-	__jump_label_set_jump_code(entry, type, &code, init);
+	const void *opcode = __jump_label_set_jump_code(entry, type, init);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -84,31 +85,33 @@ static void __ref __jump_label_transform
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), &code,
+		text_poke_early((void *)jump_entry_code(entry), opcode,
 				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
 }
 
-void arch_jump_label_transform(struct jump_entry *entry,
-			       enum jump_label_type type)
+static void __ref jump_label_transform(struct jump_entry *entry,
+				       enum jump_label_type type,
+				       int init)
 {
 	mutex_lock(&text_mutex);
-	__jump_label_transform(entry, type, 0);
+	__jump_label_transform(entry, type, init);
 	mutex_unlock(&text_mutex);
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
-static struct text_poke_loc tp_vec[TP_VEC_MAX];
-static int tp_vec_nr;
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	jump_label_transform(entry, type, 0);
+}
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	struct text_poke_loc *tp;
-	void *entry_code;
+	const void *opcode;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -118,53 +121,19 @@ bool arch_jump_label_transform_queue(str
 		return true;
 	}
 
-	/*
-	 * No more space in the vector, tell upper layer to apply
-	 * the queue before continuing.
-	 */
-	if (tp_vec_nr == TP_VEC_MAX)
-		return false;
-
-	tp = &tp_vec[tp_vec_nr];
-
-	entry_code = (void *)jump_entry_code(entry);
-
-	/*
-	 * The INT3 handler will do a bsearch in the queue, so we need entries
-	 * to be sorted. We can survive an unsorted list by rejecting the entry,
-	 * forcing the generic jump_label code to apply the queue. Warning once,
-	 * to raise the attention to the case of an unsorted entry that is
-	 * better not happen, because, in the worst case we will perform in the
-	 * same way as we do without batching - with some more overhead.
-	 */
-	if (tp_vec_nr > 0) {
-		int prev = tp_vec_nr - 1;
-		struct text_poke_loc *prev_tp = &tp_vec[prev];
-
-		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
-			return false;
-	}
-
-	__jump_label_set_jump_code(entry, type,
-				   (union jump_code_union *)&tp->text, 0);
-
-	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
-
-	tp_vec_nr++;
-
+	mutex_lock(&text_mutex);
+	opcode = __jump_label_set_jump_code(entry, type, 0);
+	text_poke_queue((void *)jump_entry_code(entry),
+			opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	mutex_unlock(&text_mutex);
 	return true;
 }
 
 void arch_jump_label_transform_apply(void)
 {
-	if (!tp_vec_nr)
-		return;
-
 	mutex_lock(&text_mutex);
-	text_poke_bp_batch(tp_vec, tp_vec_nr);
+	text_poke_finish();
 	mutex_unlock(&text_mutex);
-
-	tp_vec_nr = 0;
 }
 
 static enum {
@@ -193,5 +162,5 @@ __init_or_module void arch_jump_label_tr
 			jlstate = JL_STATE_NO_UPDATE;
 	}
 	if (jlstate == JL_STATE_UPDATE)
-		__jump_label_transform(entry, type, 1);
+		jump_label_transform(entry, type, 1);
 }


