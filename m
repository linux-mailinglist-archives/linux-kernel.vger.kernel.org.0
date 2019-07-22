Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80F170907
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfGVS5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:57:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbfGVS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUj-0002Rj-Ec; Mon, 22 Jul 2019 20:57:09 +0200
Message-Id: <20190722105220.492691679@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 18/25] x86/apic: Provide and use helper for
 send_IPI_allbutself()
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support IPI shorthands wrap invocations of apic->send_IPI_allbutself()
in a helper function, so the static key controlling the shorthand mode is
only in one place.

Fixup all callers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/apic.h |    2 ++
 arch/x86/kernel/apic/ipi.c  |   12 ++++++++++++
 arch/x86/kernel/kgdb.c      |    2 +-
 arch/x86/kernel/reboot.c    |    7 +------
 arch/x86/kernel/smp.c       |    4 ++--
 5 files changed, 18 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -177,6 +177,8 @@ extern void lapic_online(void);
 extern void lapic_offline(void);
 extern bool apic_needs_pit(void);
 
+extern void apic_send_IPI_allbutself(unsigned int vector);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -50,6 +50,18 @@ void apic_smt_update(void)
 		static_branch_enable(&apic_use_ipi_shorthand);
 	}
 }
+
+void apic_send_IPI_allbutself(unsigned int vector)
+{
+	if (num_online_cpus() < 2)
+		return;
+
+	if (static_branch_likely(&apic_use_ipi_shorthand))
+		apic->send_IPI_allbutself(vector);
+	else
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+}
+
 #endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -416,7 +416,7 @@ static void kgdb_disable_hw_debug(struct
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(NMI_VECTOR);
+	apic_send_IPI_allbutself(NMI_VECTOR);
 }
 #endif
 
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -828,11 +828,6 @@ static int crash_nmi_callback(unsigned i
 	return NMI_HANDLED;
 }
 
-static void smp_send_nmi_allbutself(void)
-{
-	apic->send_IPI_allbutself(NMI_VECTOR);
-}
-
 /*
  * Halt all other CPUs, calling the specified function on each of them
  *
@@ -861,7 +856,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb
 	 */
 	wmb();
 
-	smp_send_nmi_allbutself();
+	apic_send_IPI_allbutself(NMI_VECTOR);
 
 	/* Kick CPUs looping in NMI context. */
 	WRITE_ONCE(crash_ipi_issued, 1);
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -209,7 +209,7 @@ static void native_stop_other_cpus(int w
 		/* sync above data before sending IRQ */
 		wmb();
 
-		apic->send_IPI_allbutself(REBOOT_VECTOR);
+		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
 		 * Don't wait longer than a second if the caller
@@ -233,7 +233,7 @@ static void native_stop_other_cpus(int w
 
 		pr_emerg("Shutting down cpus with NMI\n");
 
-		apic->send_IPI_allbutself(NMI_VECTOR);
+		apic_send_IPI_allbutself(NMI_VECTOR);
 
 		/*
 		 * Don't wait longer than a 10 ms if the caller


