Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFE70916
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfGVS62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:58:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38040 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbfGVS5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:02 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUa-0002Ok-ED; Mon, 22 Jul 2019 20:57:00 +0200
Message-Id: <20190722105219.252225936@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 05/25] x86/apic: Move IPI inlines into ipi.c
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in having them in an header file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/ipi.h |   19 -------------------
 arch/x86/kernel/apic/ipi.c |   16 +++++++++++++---
 2 files changed, 13 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/ipi.h
+++ b/arch/x86/include/asm/ipi.h
@@ -71,27 +71,8 @@ extern void default_send_IPI_mask_sequen
 extern void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
 							 int vector);
 
-/* Avoid include hell */
-#define NMI_VECTOR 0x02
-
 extern int no_broadcast;
 
-static inline void __default_local_send_IPI_allbutself(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector, apic->dest_logical);
-}
-
-static inline void __default_local_send_IPI_all(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector, apic->dest_logical);
-}
-
 #ifdef CONFIG_X86_32
 extern void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
 							 int vector);
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -198,15 +198,25 @@ void default_send_IPI_allbutself(int vec
 	 * if there are no other CPUs in the system then we get an APIC send
 	 * error if we try to broadcast, thus avoid sending IPIs in this case.
 	 */
-	if (!(num_online_cpus() > 1))
+	if (num_online_cpus() < 2)
 		return;
 
-	__default_local_send_IPI_allbutself(vector);
+	if (no_broadcast || vector == NMI_VECTOR) {
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+	} else {
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector,
+					    apic->dest_logical);
+	}
 }
 
 void default_send_IPI_all(int vector)
 {
-	__default_local_send_IPI_all(vector);
+	if (no_broadcast || vector == NMI_VECTOR) {
+		apic->send_IPI_mask(cpu_online_mask, vector);
+	} else {
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector,
+					    apic->dest_logical);
+	}
 }
 
 void default_send_IPI_self(int vector)


