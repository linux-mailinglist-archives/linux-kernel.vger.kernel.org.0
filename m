Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9733F124F95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLRRmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 12:42:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:42:02 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihdKh-0007b9-K9; Wed, 18 Dec 2019 18:41:59 +0100
Date:   Wed, 18 Dec 2019 18:41:59 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] Revert "cpumask: Disable CONFIG_CPUMASK_OFFSTACK for RT"
Message-ID: <20191218174159.ndcvzgqxavpcb37c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one x86 case we had was fixed in commit
	832df3d47badc ("x86/smp: Enhance native_send_call_func_ipi()")

I didn't find another in-IRQ user. Most callers use GFP_KERNEL and the
ATOMIC users are allocating the mask while holding a spinlock_t.

Allow to use CPUMASK_OFFSTACK becauase it no longer is a problem on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/Kconfig | 2 +-
 lib/Kconfig      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f359aacf8148..4b77b3273051e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -967,7 +967,7 @@ config CALGARY_IOMMU_ENABLED_BY_DEFAULT
 config MAXSMP
 	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
 	depends on X86_64 && SMP && DEBUG_KERNEL
-	select CPUMASK_OFFSTACK if !PREEMPT_RT
+	select CPUMASK_OFFSTACK
 	---help---
 	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
 	  If unsure, say N.
diff --git a/lib/Kconfig b/lib/Kconfig
index 298b41298e487..3321d04dfa5a5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -468,7 +468,6 @@ config CHECK_SIGNATURE
 
 config CPUMASK_OFFSTACK
 	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
-	depends on !PREEMPT_RT
 	help
 	  Use dynamic allocation for cpumask_var_t, instead of putting
 	  them on the stack.  This is a bit more expensive, but avoids
-- 
2.24.0
