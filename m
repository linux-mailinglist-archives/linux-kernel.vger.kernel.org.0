Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9468013343
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfECRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 13:46:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:46:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43HkH6R2844885
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 10:46:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43HkH6R2844885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556905578;
        bh=qFQVdOve9Ugu+uNMTVAHb21CONJySGuQ4ojCLhQGwrQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MDIj1hMNgtnErkG5bKx3OXT06VRMViKoWRnDC4lfcxGpEXgRx1hEHNNh2J25n7a0G
         znk/3yxuRoNN0xqTG3FCEELDc+aVy0x+OWdhUxuCHPZ9DCH1r9RaRyL1dtdl2r2MDS
         AjrRVPKyb8JpAbUfPDlgFu/U3u46RBTLMEvsHj91hrSGvmBGre3JOlBP1/GOMQ3zWl
         Mc/zkBoKlvZ/RecrHaftUuuKkS7kRydGC1rxWloCbU5Me/hrD3ovwCPi+v2T7mj5r2
         mn/Ysa5AK57DSWAxpAy6TA99fAr/nkwCKRVpvIfvKR23/55DQueWMNtCm3nJjAFNEH
         X95O8duJa6Xkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43HkGJQ2844882;
        Fri, 3 May 2019 10:46:16 -0700
Date:   Fri, 3 May 2019 10:46:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-2f1a6fbbef7781382850c3104ecb658f21b5d460@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        fweisbec@gmail.com, npiggin@gmail.com,
        torvalds@linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          rafael.j.wysocki@intel.com, torvalds@linux-foundation.org,
          peterz@infradead.org, fweisbec@gmail.com, npiggin@gmail.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190411033448.20842-3-npiggin@gmail.com>
References: <20190411033448.20842-3-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] power/suspend: Add function to disable secondaries
 for suspend
Git-Commit-ID: 2f1a6fbbef7781382850c3104ecb658f21b5d460
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2f1a6fbbef7781382850c3104ecb658f21b5d460
Gitweb:     https://git.kernel.org/tip/2f1a6fbbef7781382850c3104ecb658f21b5d460
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Thu, 11 Apr 2019 13:34:45 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 19:42:41 +0200

power/suspend: Add function to disable secondaries for suspend

This adds a function to disable secondary CPUs for suspend that are
not necessarily non-zero / non-boot CPUs. Platforms will be able to
use this to suspend using non-zero CPUs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lkml.kernel.org/r/20190411033448.20842-3-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cpu.h      | 12 ++++++++++++
 kernel/kexec_core.c      |  4 ++--
 kernel/power/hibernate.c | 12 ++++++------
 kernel/power/suspend.c   |  4 ++--
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..7ab2f09c0a14 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -137,9 +137,21 @@ static inline int disable_nonboot_cpus(void)
 	return freeze_secondary_cpus(0);
 }
 extern void enable_nonboot_cpus(void);
+
+static inline int suspend_disable_secondary_cpus(void)
+{
+	return freeze_secondary_cpus(0);
+}
+static inline void suspend_enable_secondary_cpus(void)
+{
+	return enable_nonboot_cpus();
+}
+
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
+static inline int suspend_disable_secondary_cpus(void) { return 0; }
+static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
 void cpu_startup_entry(enum cpuhp_state state);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..fd5c95ff9251 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1150,7 +1150,7 @@ int kernel_kexec(void)
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
 			goto Resume_devices;
-		error = disable_nonboot_cpus();
+		error = suspend_disable_secondary_cpus();
 		if (error)
 			goto Enable_cpus;
 		local_irq_disable();
@@ -1183,7 +1183,7 @@ int kernel_kexec(void)
  Enable_irqs:
 		local_irq_enable();
  Enable_cpus:
-		enable_nonboot_cpus();
+		suspend_enable_secondary_cpus();
 		dpm_resume_start(PMSG_RESTORE);
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..cfc7a57049e4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -281,7 +281,7 @@ static int create_image(int platform_mode)
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || hibernation_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -323,7 +323,7 @@ static int create_image(int platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	platform_finish(platform_mode);
@@ -417,7 +417,7 @@ int hibernation_snapshot(int platform_mode)
 
 int __weak hibernate_resume_nonboot_cpu_disable(void)
 {
-	return disable_nonboot_cpus();
+	return suspend_disable_secondary_cpus();
 }
 
 /**
@@ -486,7 +486,7 @@ static int resume_target_kernel(bool platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Cleanup:
 	platform_restore_cleanup(platform_mode);
@@ -564,7 +564,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error)
 		goto Enable_cpus;
 
@@ -586,7 +586,7 @@ int hibernation_platform_enter(void)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	hibernation_ops->finish();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..59b6def23046 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -428,7 +428,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -458,7 +458,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_wake:
 	platform_resume_noirq(state);
