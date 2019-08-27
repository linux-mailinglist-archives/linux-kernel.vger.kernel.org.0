Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088679DBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 05:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfH0DDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 23:03:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33913 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0DDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:03:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so13143106pfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SGTeDHexoCYSPVhgMIw18ehtYnn6GEwOzdP2C4vqF0E=;
        b=GEI+TEjFNOCg49hA3KDAVajj6f25aDnnNTROW/6GSLWGc71ZmP2fAi5TBbjIKzIWyX
         NsffsRWqSjw4xeRcS6iXWoazrjhen0xvPavJr4/OYZsIh0q1GCbqtCs8AKkAtKeUpvBA
         1yRwcACoJd6hcnYsf3L06vjXDKnq4eZjMiISrncyGRxyAXqvqH90AqR7bs0Rl+EsENDH
         1BoxGhNzEFqJn2sF17ZQCmewX0Kx2gOLZ1RbkmI43+qU1azb9O42k/2SZrhTIzUxmu9m
         JIv9bTShPaPN3ssOzRW+JPxtMm8zVYPZwmIKtvpS8VDg0t18xAxFM6Vu1xssrW4dATDt
         RIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SGTeDHexoCYSPVhgMIw18ehtYnn6GEwOzdP2C4vqF0E=;
        b=C9GttcDd+wtKFK5eM9MGBZDsNsCcB6iIVdyoztwnoW0INUJgYAN3UohkbcOsiALnJW
         SxfpCmbbUWrYW60Eq4+x37y9OpKmPcFxXFfHyoPVnLgnZoEcCbTmXc+0f+Afwu3rW64E
         dnWVbIKQPUkAFua0cXcM4K+O4pKRNNqNsHWya1Q6dU+mq3FJtrURcGGZXuKMqNzOuj67
         /SLCwGPCOsGfReUtI/ZlhFlAmZJFnakEj2zDQZtzZuK0spXvMEDZLznU23nZvjMmQCIg
         DTXUuMYoyVAeqU8Jmc99KOtYlRGwWfmZhrXmYVUB4WZgdqvBcavBl9uW0egC0FU3pKOl
         27GA==
X-Gm-Message-State: APjAAAUQDuM39eNhANR8a5q7xHaPtHCuKZASq+bqifNWCtv46E4x3fgV
        XQ/92l9TW99rMbSL7Jm7xQ==
X-Google-Smtp-Source: APXvYqzvV4BKEgoYA5PNssQweH9Tx5pQzQcMhXxgeOKWBigoZx43HxHr4+EPTK43CmKtennZp0aszA==
X-Received: by 2002:a17:90a:35e3:: with SMTP id r90mr23544506pjb.34.1566874991774;
        Mon, 26 Aug 2019 20:03:11 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s24sm11696535pgm.3.2019.08.26.20.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 20:03:11 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: [PATCHv2 3/4] x86/smp: send capped cpus to a stable state when smp_init()
Date:   Tue, 27 Aug 2019 11:02:22 +0800
Message-Id: <1566874943-4449-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** Back ground ***

On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.

The option 'nosmt' has already complied with the above rule by Thomas's
patch. For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary
threads if nosmt=force")

But for nr_cpus option, the exposure to broadcast MCE is a little
complicated, and can be categorized into three cases.

-1. boot up by BIOS. Since no one set CR4.MCE=1, nr_cpus risks rebooting by
broadcast MCE.

-2. boot up by "kexec -p nr_cpus=".  Since the 1st kernel has all cpus'
CR4.MCE=1 set before kexec -p, nr_cpus is free of rebooting by broadcast
MCE. Furthermore, the crashed kernel's wreckage, including page table and
text, is not touched by capture kernel. Hence if MCE event happens on
capped cpu, do_machine_check->__mc_check_crashing_cpu() runs smoothly and
returns immediately, the capped cpu is still pinned on "halt".

-3. boot up by "kexec -l nr_cpus=". As "kexec -p", it is free of rebooting
by broadcast MCE. But the 1st kernel's wreckage is discarded and changed.
when capped cpus execute do_machine_check(), they may crack the new kernel.
But this is not related with broadcast MCE, and need an extra fix.

In a word, only case 1 suffers from unexpected rebooting due to broadcast
MCE.

*** Solution ***

When fixing case 1, "nr_cpus" can not follow the same way as "nosmt".
Because nr_cpus limits the allocation of percpu area and some other kthread
memory, which is critical to cpu hotplug framework.

Instead, developing a dedicated SIPI callback make_capped_cpu_stable() for
capped cpu, which does not lean on percpu area to work.

BTW this patch has side effect to suppress case 3. It brings capped cpu to
make_capped_cpu_stable() in the 2nd kernel's context, instead of leaving
them with the 1st kernel's context.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/include/asm/apic.h  |  1 +
 arch/x86/include/asm/smp.h   |  1 +
 arch/x86/kernel/apic/apic.c  |  2 +-
 arch/x86/kernel/cpu/common.c |  3 ++
 arch/x86/kernel/smpboot.c    | 85 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/smp.c                 |  6 ++++
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e647aa0..02232e3 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -49,6 +49,7 @@ static inline void generic_apic_probe(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
+extern int cpuid_to_apicid[];
 extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 5f63399..f67ce77 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -197,6 +197,7 @@ extern void nmi_selftest(void);
 #endif
 
 extern struct cpumask *cpu_capped_mask;
+extern struct cpumask *cpu_capped_done_mask;
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6a57bad3..b86c9e6 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2244,7 +2244,7 @@ static int nr_logical_cpuids = 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-static int cpuid_to_apicid[] = {
+int cpuid_to_apicid[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b95721e..7b8539f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -69,6 +69,8 @@ cpumask_var_t cpu_callin_mask;
 /* size of NR_CPUS is required. */
 static struct cpumask __cpu_capped_mask __initdata;
 struct cpumask *cpu_capped_mask;
+static struct cpumask __cpu_capped_done_mask __initdata;
+struct cpumask *cpu_capped_done_mask;
 
 /* representing cpus for which sibling maps can be computed */
 cpumask_var_t cpu_sibling_setup_mask;
@@ -88,6 +90,7 @@ void __init setup_cpu_local_masks(void)
 	alloc_bootmem_cpumask_var(&cpu_callout_mask);
 	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
 	cpu_capped_mask = &__cpu_capped_mask;
+	cpu_capped_done_mask = &__cpu_capped_done_mask;
 }
 
 static void default_init(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fdbd47c..219d12f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1014,6 +1014,91 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+/* SIPI callback for the capped cpu */
+static void notrace make_capped_cpu_stable(void *unused)
+{
+	unsigned int apic_id;
+	int i, cpu = -1;
+
+	/* protect against MCE broadcast */
+	native_write_cr4(X86_CR4_MCE);
+	x2apic_setup();
+	apic_id = read_apic_id();
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpuid_to_apicid[i] == apic_id) {
+			cpu = i;
+			break;
+		}
+
+	/* trampoline_*.S has loaded idt with 0, 0 */
+
+	/* No response to any interrupt */
+	disable_local_APIC();
+	/* Done with the temporary stack, signal the master to go ahead */
+	if (cpu != -1) {
+		cpumask_clear_cpu(cpu, cpu_capped_mask);
+		cpumask_set_cpu(cpu, cpu_capped_done_mask);
+	}
+
+	/* run without stack and can not have the __init attribute */
+	do {
+		asm volatile("hlt" : : : "memory");
+	} while (true);
+}
+
+static void __init do_stable_cpu(int cpu)
+{
+	static char capped_tmp_stack[512];
+	int cpu0_nmi_registered = 0, apicid = cpuid_to_apicid[cpu];
+	unsigned long start_ip = real_mode_header->trampoline_start;
+	unsigned long timeout, boot_error = 0;
+
+#ifdef x86_64
+	/* invalid percpu area */
+	initial_gs = 0;
+#endif
+	/*
+	 * Borrow the value of cpu 0. Since capped cpu segment shadow register
+	 * can cache the content, and keep it unchanged.
+	 */
+	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(0);
+	initial_code = (unsigned long)make_capped_cpu_stable;
+	initial_stack  = (unsigned long)&capped_tmp_stack;
+
+	if (apic->wakeup_secondary_cpu)
+		boot_error = apic->wakeup_secondary_cpu(apicid, start_ip);
+	else
+		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
+						     &cpu0_nmi_registered);
+	if (cpu0_nmi_registered)
+		unregister_nmi_handler(NMI_LOCAL, "wake_cpu0");
+
+	if (!boot_error) {
+		/* Wait 10s total for first sign of life from capped cpu */
+		boot_error = -1;
+		timeout = jiffies + 10*HZ;
+		while (time_before(jiffies, timeout)) {
+			if (cpumask_test_cpu(cpu, cpu_capped_done_mask))
+				break;
+			schedule();
+		}
+	}
+}
+
+void __init bring_capped_cpu_stable(void)
+{
+	int cpu;
+
+	/* Guest does not suffer from MCE broadcast */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+
+	for_each_cpu(cpu, cpu_capped_mask)
+		do_stable_cpu(cpu);
+	cpu_capped_mask = NULL;
+	cpu_capped_done_mask = NULL;
+}
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb40..de528b7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -574,6 +574,10 @@ void __init setup_nr_cpu_ids(void)
 	nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
 }
 
+void __weak __init bring_capped_cpu_stable(void)
+{
+}
+
 /* Called by boot processor to activate the rest. */
 void __init smp_init(void)
 {
@@ -593,6 +597,8 @@ void __init smp_init(void)
 			cpu_up(cpu);
 	}
 
+	/* force cpus capped by nr_cpus option into stable state */
+	bring_capped_cpu_stable();
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
 	pr_info("Brought up %d node%s, %d CPU%s\n",
-- 
2.7.5

