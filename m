Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBBE723
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfD2QAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 12:00:30 -0400
Received: from foss.arm.com ([217.140.101.70]:32994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbfD2QA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:00:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A22E31993;
        Mon, 29 Apr 2019 09:00:27 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7998B3F5C1;
        Mon, 29 Apr 2019 09:00:25 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 5/5] arm64: fix kernel stack overflow in kdump capture kernel
Date:   Mon, 29 Apr 2019 17:00:07 +0100
Message-Id: <1556553607-46531-6-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
References: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

When enabling ARM64_PSEUDO_NMI feature in kdump capture kernel, it will
report a kernel stack overflow exception:

[    0.000000] CPU features: detected: IRQ priority masking
[    0.000000] alternatives: patching kernel code
[    0.000000] Insufficient stack space to handle exception!
[    0.000000] ESR: 0x96000044 -- DABT (current EL)
[    0.000000] FAR: 0x0000000000000040
[    0.000000] Task stack:     [0xffff0000097f0000..0xffff0000097f4000]
[    0.000000] IRQ stack:      [0x0000000000000000..0x0000000000004000]
[    0.000000] Overflow stack: [0xffff80002b7cf290..0xffff80002b7d0290]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.34-lw+ #3
[    0.000000] pstate: 400003c5 (nZcv DAIF -PAN -UAO)
[    0.000000] pc : el1_sync+0x0/0xb8
[    0.000000] lr : el1_irq+0xb8/0x140
[    0.000000] sp : 0000000000000040
[    0.000000] pmr_save: 00000070
[    0.000000] x29: ffff0000097f3f60 x28: ffff000009806240
[    0.000000] x27: 0000000080000000 x26: 0000000000004000
[    0.000000] x25: 0000000000000000 x24: ffff000009329028
[    0.000000] x23: 0000000040000005 x22: ffff000008095c6c
[    0.000000] x21: ffff0000097f3f70 x20: 0000000000000070
[    0.000000] x19: ffff0000097f3e30 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffff0000097f9708 x14: ffff000089a382ef
[    0.000000] x13: ffff000009a382fd x12: ffff000009824000
[    0.000000] x11: ffff0000097fb7b0 x10: ffff000008730028
[    0.000000] x9 : ffff000009440018 x8 : 000000000000000d
[    0.000000] x7 : 6b20676e69686374 x6 : 000000000000003b
[    0.000000] x5 : 0000000000000000 x4 : ffff000008093600
[    0.000000] x3 : 0000000400000008 x2 : 7db2e689fc2b8e00
[    0.000000] x1 : 0000000000000000 x0 : ffff0000097f3e30
[    0.000000] Kernel panic - not syncing: kernel stack overflow
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.34-lw+ #3
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x0/0x1b8
[    0.000000]  show_stack+0x24/0x30
[    0.000000]  dump_stack+0xa8/0xcc
[    0.000000]  panic+0x134/0x30c
[    0.000000]  __stack_chk_fail+0x0/0x28
[    0.000000]  handle_bad_stack+0xfc/0x108
[    0.000000]  __bad_stack+0x90/0x94
[    0.000000]  el1_sync+0x0/0xb8
[    0.000000]  init_gic_priority_masking+0x4c/0x70
[    0.000000]  smp_prepare_boot_cpu+0x60/0x68
[    0.000000]  start_kernel+0x1e8/0x53c
[    0.000000] ---[ end Kernel panic - not syncing: kernel stack overflow ]---

The reason is init_gic_priority_masking() may unmask PSR.I while the
irq stacks are not inited yet. Some "NMI" could be raised unfortunately
and it will just go into this exception.

In this patch, we just write the PMR in smp_prepare_boot_cpu(), and delay
unmasking PSR.I after irq stacks inited in init_IRQ().

Fixes: e79321883842 ("arm64: Switch to PMR masking when starting CPUs")
Signed-off-by: Wei Li <liwei391@huawei.com>
[JT: make init_gic_priority_masking() not modify daif, rebase on other
     priority masking fixes]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/kernel/irq.c | 9 +++++++++
 arch/arm64/kernel/smp.c | 8 +-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index fdd9cb2..e8daa7a 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -77,6 +77,15 @@ void __init init_IRQ(void)
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+
+	if (system_uses_irq_prio_masking()) {
+		/*
+		 * Now that we have a stack for our IRQ handler, set
+		 * the PMR/PSR pair to a consistent state.
+		 */
+		WARN_ON(read_sysreg(daif) & PSR_A_BIT);
+		local_daif_restore(DAIF_PROCCTX_NOIRQ);
+	}
 }
 
 /*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2a6d0dd1..c08a075 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -192,13 +192,7 @@ static void init_gic_priority_masking(void)
 
 	WARN_ON(!(cpuflags & PSR_I_BIT));
 
-	/* We can only unmask PSR.I if we can take aborts */
-	if (!(cpuflags & PSR_A_BIT)) {
-		gic_write_pmr(GIC_PRIO_IRQOFF);
-		write_sysreg(cpuflags & ~PSR_I_BIT, daif);
-	} else {
-		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_IGNORE_PMR);
-	}
+	gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_IGNORE_PMR);
 }
 
 /*
-- 
1.9.1

