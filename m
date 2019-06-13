Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018CF438E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfFMPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:09:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49626 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbfFMN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lKYQKwrJfQo2MNMZJ5wnSQSzwwx/J9BZ2QpcLaaOhqI=; b=mcw0iG8GhdxCqw5pAZOom7DVDR
        p7EygH0CPT4iqaGccWVO1PjNrBiEHtZwk+Rprf8oYe2X7dDlihNy6GyRrniNWaxat0UD/+LiPQ9qy
        hFaRRo6atSoVyN/7t7Kp+EqqXWF0n3ZlasKANvcqr3gMwEj8MzJNNj31bU+Nnkx/HEacCqH9Irmq4
        J2qCzALgzpz8LKGHjfRkA7djecoVefize4ug9t0DgkKQ8HWfok/0w0GN7pi7K+TIpxD9v+hIrLFFq
        gUf3D72MVzaC7z+GhSDnlFBipfLoOvKp14De5SKsBq1UDqE/MeHi6sWWEMvWdw+uM04KVQ3QXfqzC
        JGeEQJfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQDy-0004GE-9G; Thu, 13 Jun 2019 13:57:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 14D9520435AA7; Thu, 13 Jun 2019 15:57:05 +0200 (CEST)
Message-Id: <20190613135653.415699001@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:54:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 3/5] x86/percpu, x86/irq: Relax {set,get}_irq_regs()
References: <20190613135445.318096781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav reported that since the this_cpu_*() ops got asm-volatile
constraints on, code generation suffered for do_IRQ(), but since this
is all with IRQs disabled we can use __this_cpu_*().

smp_x86_platform_ipi                                      234        222   -12,+0
smp_kvm_posted_intr_ipi                                    74         66   -8,+0
smp_kvm_posted_intr_wakeup_ipi                             86         78   -8,+0
smp_apic_timer_interrupt                                  292        284   -8,+0
smp_kvm_posted_intr_nested_ipi                             74         66   -8,+0
do_IRQ                                                    195        187   -8,+0

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/irq_regs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/irq_regs.h
+++ b/arch/x86/include/asm/irq_regs.h
@@ -16,7 +16,7 @@ DECLARE_PER_CPU(struct pt_regs *, irq_re
 
 static inline struct pt_regs *get_irq_regs(void)
 {
-	return this_cpu_read(irq_regs);
+	return __this_cpu_read(irq_regs);
 }
 
 static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
@@ -24,7 +24,7 @@ static inline struct pt_regs *set_irq_re
 	struct pt_regs *old_regs;
 
 	old_regs = get_irq_regs();
-	this_cpu_write(irq_regs, new_regs);
+	__this_cpu_write(irq_regs, new_regs);
 
 	return old_regs;
 }


