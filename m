Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4F6D811
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 03:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfGSA70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 20:59:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfGSA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so9396558pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iaq6WeOIheWC0wFmh71b4ZNjJw0kGnLLqqfVf05ZfMg=;
        b=V/gH7gsViq4j1BwVl1a0gbHikMnaxy9xI5e6bsUJBIF1KEbPdJ2RemQ7xSjPUyrHRn
         UXu6JMlkhaWOIFwRpTqDsFa8ylKtFaRF/NJ/YQAJsDl445jy2WLu+3b2zLOP4qC6MuAf
         3uey0O/hJgbjUXTqDRuRzYgwu2NPm5cx/4eEQuTRKnvej1jIQ3ElacK2BYaJSn5yTCQ1
         4NCMyQL2IXQTkO56f0D0hxE25WhMjD9fqYtzWMXkpnih9/Lv3lynm+nSLv8Zz6DkEVFj
         hizzF3+cjlryP4yACsdjrf/Pg6alm33w1LUGI21movGJz+2FxOkJTHx1HmIwmuMYpIfO
         f6MA==
X-Gm-Message-State: APjAAAX+/J5hWXvfRh9/38oJMhAExK6PdmeQ3FqIvjC14F0yTAjAGmXz
        6Q06q4pFLj04rW2hVj7sDXk=
X-Google-Smtp-Source: APXvYqyPhUA6O/FiscFejE+FTw7EjodZ+CGV3gjCjIO70wIPARqLoyBWr/Aa/leq8pDwd8eT4QLQCQ==
X-Received: by 2002:a65:6152:: with SMTP id o18mr49039055pgv.279.1563497945544;
        Thu, 18 Jul 2019 17:59:05 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.59.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:59:04 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Date:   Thu, 18 Jul 2019 17:58:33 -0700
Message-Id: <20190719005837.4150-6-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_tlbstate is mostly private and only the variable is_lazy is shared.
This causes some false-sharing when TLB flushes are performed.

Break cpu_tlbstate intro cpu_tlbstate and cpu_tlbstate_shared, and mark
each one accordingly.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h | 39 ++++++++++++++++++---------------
 arch/x86/mm/init.c              |  2 +-
 arch/x86/mm/tlb.c               | 15 ++++++++-----
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 610e47dc66ef..8490591d3cdf 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -178,23 +178,6 @@ struct tlb_state {
 	u16 loaded_mm_asid;
 	u16 next_asid;
 
-	/*
-	 * We can be in one of several states:
-	 *
-	 *  - Actively using an mm.  Our CPU's bit will be set in
-	 *    mm_cpumask(loaded_mm) and is_lazy == false;
-	 *
-	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
-	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
-	 *
-	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
-	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
-	 *    We're heuristically guessing that the CR3 load we
-	 *    skipped more than makes up for the overhead added by
-	 *    lazy mode.
-	 */
-	bool is_lazy;
-
 	/*
 	 * If set we changed the page tables in such a way that we
 	 * needed an invalidation of all contexts (aka. PCIDs / ASIDs).
@@ -240,7 +223,27 @@ struct tlb_state {
 	 */
 	struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
 };
-DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
+DECLARE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate);
+
+struct tlb_state_shared {
+	/*
+	 * We can be in one of several states:
+	 *
+	 *  - Actively using an mm.  Our CPU's bit will be set in
+	 *    mm_cpumask(loaded_mm) and is_lazy == false;
+	 *
+	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
+	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
+	 *
+	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
+	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
+	 *    We're heuristically guessing that the CR3 load we
+	 *    skipped more than makes up for the overhead added by
+	 *    lazy mode.
+	 */
+	bool is_lazy;
+};
+DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 
 /*
  * Blindly accessing user memory from NMI context can be dangerous
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index fd10d91a6115..34027f36a944 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -951,7 +951,7 @@ void __init zone_sizes_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-__visible DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) = {
+__visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
 	.loaded_mm = &init_mm,
 	.next_asid = 1,
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 63c00908bdd9..af80c274c88d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -145,7 +145,7 @@ void leave_mm(int cpu)
 		return;
 
 	/* Warn if we're not lazy. */
-	WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
+	WARN_ON(!this_cpu_read(cpu_tlbstate_shared.is_lazy));
 
 	switch_mm(NULL, &init_mm, NULL);
 }
@@ -277,7 +277,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
+	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -322,7 +322,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate.is_lazy, false);
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
@@ -463,7 +463,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
-	this_cpu_write(cpu_tlbstate.is_lazy, true);
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
 }
 
 /*
@@ -544,7 +544,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
-	if (this_cpu_read(cpu_tlbstate.is_lazy)) {
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy)) {
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
@@ -660,11 +660,14 @@ static void flush_tlb_func_remote(void *info)
 
 static bool tlb_is_not_lazy(int cpu)
 {
-	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
+	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
 }
 
 static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
 
+DEFINE_PER_CPU_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
+EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);
+
 void native_flush_tlb_multi(const struct cpumask *cpumask,
 			    const struct flush_tlb_info *info)
 {
-- 
2.20.1

