Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F4D0FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfJIN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 09:26:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfJIN0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eglXfc5yIhbuVzRR7OSZGxfyFM5ff9DnhpzaECv3jGs=; b=OCJlq83s5WxIt9XQKSrzxGOfq
        Y2zK6xSfGzy/6TArOiA4avqDxUYfUk4ldUwsBgKB4oFkl3GlN3+YrAidGdJFv+ujWgmdc5PstZmZ4
        fpULk/53wuFfffg9yG7PvsWBPwKQjeoWLDMjJC0zHGrfZ0mNVezt1oQWuBcKxX9dxa1pYnriLSkw5
        8Uhnz+tEEHAjGTm20w7GTdjVU0QCU+Dn69B41c/iAgsvgQhLbJPEEJbTnqs/v1lCbXsAfVkcfPNuw
        T2d2Jzx+0/tBRchVUS1dqRjuiFxYtnEnOIjZDagDLSJ1TfQdwDbtQyqiL9vkN/xlcB8ZsnSxU/CvD
        yUdUxkNoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIBzF-0000pj-RI; Wed, 09 Oct 2019 13:26:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E51513062B5;
        Wed,  9 Oct 2019 15:25:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF824205A430A; Wed,  9 Oct 2019 15:26:39 +0200 (CEST)
Date:   Wed, 9 Oct 2019 15:26:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        paulmck@kernel.org
Subject: Re: x86/kprobes bug? (was: [PATCH 1/3] x86/alternatives: Teach
 text_poke_bp() to emulate instructions)
Message-ID: <20191009132639.GF2359@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
 <20191003110106.GI4581@hirez.programming.kicks-ass.net>
 <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
 <20191009130754.GL2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009130754.GL2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:07:54PM +0200, Peter Zijlstra wrote:
> So from what I can tell of kernel/kprobes.c, what it does is something like:
> 
> ARM: (__arm_kprobe)
> 	text_poke(INT3)
> 	/* guarantees nothing, INT3 will become visible at some point, maybe */
> 
>      (kprobe_optimizer)
> 	if (opt) {
> 		/* guarantees the bytes after INT3 are unused */
> 		syncrhonize_rcu_tasks();
> 		text_poke_bp(JMP32);
> 		/* implies IPI-sync, kprobe really is enabled */
> 	}
> 
> 
> DISARM: (__unregister_kprobe_top)
> 	if (opt) {
> 		text_poke_bp(INT3 + tail);
> 		/* implies IPI-sync, so tail is guaranteed visible */
> 	}
> 	text_poke(old);
> 
> 
> FREE: (__unregister_kprobe_bottom)
> 	/* guarantees 'old' is visible and the kprobe really is unused, maybe */
> 	synchronize_rcu();
> 	free();
> 
> 
> Now the problem is that I don't think the synchronize_rcu() at free
> implies enough to guarantee 'old' really is visible on all CPUs.
> Similarly, I don't think synchronize_rcu_tasks() is sufficient on the
> ARM side either. It only provides the guarantee -provided- the INT3 is
> actually visible. If it is not, all bets are off.
> 
> I'd feel much better if we switch arch_arm_kprobe() over to using
> text_poke_bp(). Or at the very least add the on_each_cpu(do_sync_core)
> to it.
> 
> Hmm?

So I suppose I'm suggesting we do something like the below on top of
what I already have here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ftrace

All it needs are a few comments ;-) Also note how this nicely gets rid
of the one text_poke_bp(.emulate) user, so we can go and remove that as
well.

---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 11 ++++++++---
 arch/x86/kernel/kprobes/core.c       |  1 +
 arch/x86/kernel/kprobes/opt.c        | 12 ++++--------
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index d553175212b3..d3269558e5b5 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -42,6 +42,7 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
  * an inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
+extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 34a08bc68e9a..9e81ab542190 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,6 +936,11 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+void text_poke_sync(void)
+{
+	on_each_cpu(do_sync_core, NULL, 1);
+}
+
 struct text_poke_loc {
 	s32 rel_addr; /* addr := _stext + rel_addr */
 	s32 rel32;
@@ -1089,7 +1094,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	for (i = 0; i < nr_entries; i++)
 		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
 
-	on_each_cpu(do_sync_core, NULL, 1);
+	text_poke_sync();
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -1111,7 +1116,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		on_each_cpu(do_sync_core, NULL, 1);
+		text_poke_sync();
 	}
 
 	/*
@@ -1127,7 +1132,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	}
 
 	if (do_sync)
-		on_each_cpu(do_sync_core, NULL, 1);
+		text_poke_sync();
 
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7e4a8a1c9d9a..8ae5170207b2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -503,6 +503,7 @@ void arch_arm_kprobe(struct kprobe *p)
 void arch_disarm_kprobe(struct kprobe *p)
 {
 	text_poke(p->addr, &p->opcode, 1);
+	text_poke_sync();
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 36d7249f2145..30a2646cfc8a 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -446,14 +446,10 @@ void arch_optimize_kprobes(struct list_head *oplist)
 /* Replace a relative jump with a breakpoint (int3).  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
-	u8 insn_buff[JMP32_INSN_SIZE];
-
-	/* Set int3 to first byte for kprobes */
-	insn_buff[0] = INT3_INSN_OPCODE;
-	memcpy(insn_buff + 1, op->optinsn.copied_insn, DISP32_SIZE);
-
-	text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE,
-		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
+	arch_arm_kprobe(&op->kp);
+	text_poke(op->kp.addr + INT3_INSN_SIZE,
+		  op->optinsn.copied_insn, DISP32_SIZE);
+	text_poke_sync();
 }
 
 /*
