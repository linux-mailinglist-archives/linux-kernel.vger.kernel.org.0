Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6195C04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfHTKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 06:09:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45456 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:09:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so2510335plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mfLB/ati0j2C8qaf9rakUdrPr3gVciWve+pCFbGuAY=;
        b=PK4TBJdvHeWQT+1Mb1a6qpfFFFZcu4fiQDfBeTIOKCuZ0U9UfvVfHuaXKl7q1xLWwO
         KgLh11z9ftxMTjENP8d5g9Wr81kBA6jglclNZ4pT7g6ot5VY376dfiNFrfoZSpOPKIsE
         v0cstJA9iAEIbHN0xOe6aZM5Kjohev4Btz7ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mfLB/ati0j2C8qaf9rakUdrPr3gVciWve+pCFbGuAY=;
        b=MlWOn7p9fQuDzESKG+3kmPMzauTIwOUssywEhXJFyrYrCUEsQIeHdJjt2ufs7SeoLl
         8Zm7KAviZbSgHSEKiPVnQEnmq3u8gNr8daqImDmHbLOecMkX3pXjf+JF+WNdgpMz0jFs
         zoHJPEJ1GHyuPzbVfr0wzRCuA/wbDNJNstSCiY7W+D6HAJXbpU+NEUXKRZ50nriwVmoK
         3rWBfhtyBHiRQzCfnsbctEcotgFzefkYtRrFrDjh+Lrjaf3pRZf3bIjs51VQEEDGJyfq
         DzlbgGRBVXe+j/B54rC8DvAwndDaCFFOyaHjTDlE2xyPe9vZzzhS4V0T4sDHA8gH89kZ
         s9gg==
X-Gm-Message-State: APjAAAUnEBQpMPm1fMwF11rHNbgWzN2kulWWMm0W+s49MvjTMZtLmNen
        FvcAWiiIdFXj7SeStR2HpnWIPA==
X-Google-Smtp-Source: APXvYqwW9t48G6FJq6HTShCj3DfCYg4Nwm3BPM5+YlO3N2cLP28CtDUah+v+/dBIdbOAwQaSkUIPXw==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr28047607plb.324.1566295772657;
        Tue, 20 Aug 2019 03:09:32 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id a11sm6610906pju.2.2019.08.20.03.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 03:09:31 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin )" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] smp: Add cpu unstopped mask for smp_send_stop/stop_other_cpus
Date:   Tue, 20 Aug 2019 18:08:43 +0800
Message-Id: <20190820100843.3028-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arm/arm64/x86, reboot IPI function uses CPU online mask to let
primary CPU know how many secondary CPUs it has to wait for in
smp_send_stop()/native_stop_other_cpus().

However, sometimes this would trigger unnecessary warnings, since
interrupts and tasks might fall on a CPU that has already executed
the reboot ipi function. This is fine since CPU is already in spinloop.
But warnings are generated since it finds that the CPU is marked as
offiline. The warnings are supposed to catch failures in normal hotplug
offline CPUs, and reboot isn't a regular hotplug. So instead of reusing
online masks, we should use a new mask in reboot IPI functions to do the
work.

Take tick broadcast for example. If broadcast and smp_send_stop()
happen together, most of the time, the CPU getting earliest broadcast
is already in spinloop and thus won't do anything. If the first
broadcast arrives to CPU that hasn't already executed reboot ipi, it
would try to IPI another CPU, but the CPU is already marked as offline,
and warning comes out:

[   22.481523] reboot: Restarting system
[   22.481608] WARNING: CPU: 4 PID: 0 at ...
.....
[   22.481980] Call trace:
[   22.481991]  tick_handle_oneshot_broadcast+0x1f8/0x214
[   22.482003]  mtk_syst_handler+0x34/0x44
[   22.482016]  __handle_irq_event_percpu+0x16c/0x28c
[   22.482026]  handle_irq_event_percpu+0x34/0x8c
[   22.482035]  handle_irq_event+0x48/0x78
[   22.482044]  handle_fasteoi_irq+0xd0/0x1a0
[   22.482054]  __handle_domain_irq+0x84/0xc4
[   22.482065]  gic_handle_irq+0x154/0x1a4
[   22.482073]  el1_irq+0xb0/0x128
[   22.482081]  __do_softirq+0x88/0x2fc
[   22.482091]  irq_exit+0xa0/0xa4
[   22.482101]  handle_IPI+0x1ac/0x2cc
[   22.482109]  gic_handle_irq+0x124/0x1a4
[   22.482117]  el1_irq+0xb0/0x128
[   22.482127]  cpuidle_enter_state+0x298/0x328
[   22.482135]  cpuidle_enter+0x30/0x40
[   22.482146]  do_idle+0x154/0x270
[   22.482154]  cpu_startup_entry+0x24/0x28
[   22.482164]  secondary_start_kernel+0x15c/0x168
[   22.482171] ---[ end trace 25f699b7e87857ff ]---

From kernel/time/tick-broadcast.c:
  /*
   * Sanity check. Catch the case where we try to broadcast to
   * offline cpus.
   */
  if (WARN_ON_ONCE(!cpumask_subset(tmpmask, cpu_online_mask)))
          cpumask_and(tmpmask, tmpmask, cpu_online_mask);

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Note
- The warning comes from arm64 device
- Previous related patches
 - https://lkml.org/lkml/2012/8/22/3
 - https://patchwork.kernel.org/patch/10535409/
---
 arch/arm/kernel/smp.c     |  9 +++++----
 arch/arm64/kernel/smp.c   | 12 +++++++-----
 arch/x86/kernel/process.c |  2 +-
 arch/x86/kernel/smp.c     |  6 +++---
 arch/x86/kernel/smpboot.c |  2 ++
 include/linux/cpumask.h   | 18 ++++++++++++++++++
 kernel/cpu.c              |  4 ++++
 7 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4b0bab2607e4..18f90cea05b2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -245,6 +245,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	set_cpu_unstopped(cpu, false);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -430,6 +431,7 @@ asmlinkage void secondary_start_kernel(void)
 	 * before we continue - which happens after __cpu_up returns.
 	 */
 	set_cpu_online(cpu, true);
+	set_cpu_unstopped(cpu, true);
 
 	check_other_bugs();
 
@@ -593,11 +595,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 		raw_spin_unlock(&stop_lock);
 	}
 
-	set_cpu_online(cpu, false);
-
 	local_fiq_disable();
 	local_irq_disable();
 
+	set_cpu_unstopped(cpu, false);
 	while (1) {
 		cpu_relax();
 		wfe();
@@ -713,10 +714,10 @@ void smp_send_stop(void)
 
 	/* Wait up to one second for other CPUs to stop */
 	timeout = USEC_PER_SEC;
-	while (num_online_cpus() > 1 && timeout--)
+	while (num_unstopped_cpus() > 1 && timeout--)
 		udelay(1);
 
-	if (num_online_cpus() > 1)
+	if (num_unstopped_cpus() > 1)
 		pr_warn("SMP: failed to stop secondary CPUs\n");
 }
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 018a33e01b0e..ff0d9fcf97ed 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -249,6 +249,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 					 read_cpuid_id());
 	update_cpu_boot_status(CPU_BOOT_SUCCESS);
 	set_cpu_online(cpu, true);
+	set_cpu_unstopped(cpu, true);
 	complete(&cpu_running);
 
 	local_daif_restore(DAIF_PROCCTX);
@@ -299,6 +300,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	set_cpu_unstopped(cpu, false);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -827,7 +829,7 @@ void arch_irq_work_raise(void)
 
 static void local_cpu_stop(void)
 {
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_unstopped(smp_processor_id(), false);
 
 	local_daif_mask();
 	sdei_mask_local_cpu();
@@ -957,7 +959,7 @@ void smp_send_stop(void)
 {
 	unsigned long timeout;
 
-	if (num_online_cpus() > 1) {
+	if (num_unstopped_cpus() > 1) {
 		cpumask_t mask;
 
 		cpumask_copy(&mask, cpu_online_mask);
@@ -970,12 +972,12 @@ void smp_send_stop(void)
 
 	/* Wait up to one second for other CPUs to stop */
 	timeout = USEC_PER_SEC;
-	while (num_online_cpus() > 1 && timeout--)
+	while (num_unstopped_cpus() > 1 && timeout--)
 		udelay(1);
 
-	if (num_online_cpus() > 1)
+	if (num_unstopped_cpus() > 1)
 		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(cpu_online_mask));
+			   cpumask_pr_args(cpu_unstopped_mask));
 
 	sdei_mask_local_cpu();
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e94c4354d4e..fb286f189082 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -601,7 +601,6 @@ void stop_this_cpu(void *dummy)
 	/*
 	 * Remove this CPU:
 	 */
-	set_cpu_online(smp_processor_id(), false);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 
@@ -616,6 +615,7 @@ void stop_this_cpu(void *dummy)
 	 */
 	if (boot_cpu_has(X86_FEATURE_SME))
 		native_wbinvd();
+	set_cpu_unstopped(smp_processor_id(), false);
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b8d4e9c3c070..99daba583a9a 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -167,7 +167,7 @@ static void native_stop_other_cpus(int wait)
 	 * code.  By syncing, we give the cpus up to one second to
 	 * finish their work before we force them off with the NMI.
 	 */
-	if (num_online_cpus() > 1) {
+	if (num_unstopped_cpus() > 1) {
 		/* did someone beat us here? */
 		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
 			return;
@@ -184,12 +184,12 @@ static void native_stop_other_cpus(int wait)
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (num_unstopped_cpus() > 1 && timeout--)
 			udelay(1);
 	}
 
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	if (num_unstopped_cpus() > 1) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2d446c..2fa96cc9e7d2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -247,6 +247,7 @@ static void notrace start_secondary(void *unused)
 	 */
 	lock_vector_lock();
 	set_cpu_online(smp_processor_id(), true);
+	set_cpu_unstopped(smp_processor_id(), true);
 	lapic_online();
 	unlock_vector_lock();
 	cpu_set_state_online(smp_processor_id());
@@ -1562,6 +1563,7 @@ static void remove_siblinginfo(int cpu)
 static void remove_cpu_from_maps(int cpu)
 {
 	set_cpu_online(cpu, false);
+	set_cpu_unstopped(cpu, false);
 	cpumask_clear_cpu(cpu, cpu_callout_mask);
 	cpumask_clear_cpu(cpu, cpu_callin_mask);
 	/* was set by cpu_init() */
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 78a73eba64dd..3cd929d4ebc8 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -89,10 +89,12 @@ extern unsigned int nr_cpu_ids;
 
 extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
+extern struct cpumask __cpu_unstopped_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
+#define cpu_unstopped_mask   ((const struct cpumask *)&__cpu_unstopped_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 
@@ -111,6 +113,12 @@ static inline unsigned int num_online_cpus(void)
 {
 	return atomic_read(&__num_online_cpus);
 }
+
+static inline unsigned int num_unstopped_cpus(void)
+{
+	return atomic_read(&__cpu_unstopped_mask);
+}
+
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
@@ -120,6 +128,7 @@ static inline unsigned int num_online_cpus(void)
 #define cpu_active(cpu)		cpumask_test_cpu((cpu), cpu_active_mask)
 #else
 #define num_online_cpus()	1U
+#define num_unstopped_cpus()	1U
 #define num_possible_cpus()	1U
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
@@ -837,6 +846,15 @@ set_cpu_present(unsigned int cpu, bool present)
 
 void set_cpu_online(unsigned int cpu, bool online);
 
+static inline void
+set_cpu_unstopped(unsigned int cpu, bool unstopped)
+{
+	if (unstopped)
+		cpumask_set_cpu(cpu, &__cpu_unstopped_mask);
+	else
+		cpumask_clear_cpu(cpu, &__cpu_unstopped_mask);
+}
+
 static inline void
 set_cpu_active(unsigned int cpu, bool active)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e1967e9eddc2..8b95c06e674f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2292,6 +2292,9 @@ EXPORT_SYMBOL(__cpu_possible_mask);
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
 
+struct cpumask __cpu_unstopped_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_unstopped_mask);
+
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
 
@@ -2346,6 +2349,7 @@ void __init boot_cpu_init(void)
 
 	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
 	set_cpu_online(cpu, true);
+	set_cpu_unstopped(cpu, true);
 	set_cpu_active(cpu, true);
 	set_cpu_present(cpu, true);
 	set_cpu_possible(cpu, true);
-- 
2.20.1

