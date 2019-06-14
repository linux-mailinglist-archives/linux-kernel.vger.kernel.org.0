Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBB46779
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFNSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 14:23:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfFNSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:23:32 -0400
Received: from zn.tnic (p200300EC2F097F008D9D08C27DC27982.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:8d9d:8c2:7dc2:7982])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90A9B1EC0B55;
        Fri, 14 Jun 2019 20:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560536610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Wec5vQanv6yPIqThg8M5yFUSlRvqBHzjjusYTgRF1pI=;
        b=EfJK0Cs9Ok+OVYrc+KH90xtzobKZ+ONF/fHGMSME9mNSkWE5WVWwYA69HNMjyV0phydi8y
        IPJ8UJOGDGVvhA/cRkKChS34cLFQkrubeScNbvNID4bA4hDrVB4tcOhSMXOIPCFWLhPyIK
        drYYh/bqy2VgLuJT8Kx5252KTLT1GPk=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Adric Blake <promarbler14@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH] x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback
Date:   Fri, 14 Jun 2019 20:23:17 +0200
Message-Id: <20190614182317.29292-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Adric Blake reported the following warning during suspend-resume:

  Enabling non-boot CPUs ...
  x86: Booting SMP configuration:
  smpboot: Booting Node 0 Processor 1 APIC 0x2
  unchecked MSR access error: WRMSR to 0x10f (tried to write 0x0000000000000000) \
   at rIP: 0xffffffff8d267924 (native_write_msr+0x4/0x20)
  Call Trace:
   intel_set_tfa
   intel_pmu_cpu_starting
   ? x86_pmu_dead_cpu
   x86_pmu_starting_cpu
   cpuhp_invoke_callback
   ? _raw_spin_lock_irqsave
   notify_cpu_starting
   start_secondary
   secondary_startup_64
  microcode: sig=0x806ea, pf=0x80, revision=0x96
  microcode: updated to revision 0xb4, date = 2019-04-01
  CPU1 is up

The MSR in question is MSR_TFA_RTM_FORCE_ABORT and that MSR is emulated
by microcode. The log above shows that the microcode loader callback
happens after the PMU restoration, leading to the conjecture that
because the microcode hasn't been updated yet, that MSR is not present
yet, leading to the #GP.

Add a microcode loader-specific hotplug vector which comes before
the PERF vectors and thus executes earlier and makes sure the MSR is
present.

Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
Reported-by: Adric Blake <promarbler14@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203637
---
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 include/linux/cpuhotplug.h           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 70a04436380e..a813987b5552 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -872,7 +872,7 @@ int __init microcode_init(void)
 		goto out_ucode_group;
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
+	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6a381594608c..5c6062206760 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -101,6 +101,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
+	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
-- 
2.21.0

