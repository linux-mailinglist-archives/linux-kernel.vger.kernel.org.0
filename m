Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44D5FBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGDQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 12:35:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfGDQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gO-0005gH-16; Thu, 04 Jul 2019 18:34:04 +0200
Message-Id: <20190704155609.652485496@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 14/25] x86/apic: Remove dest argument from
 __default_send_IPI_shortcut()
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM states:

  "The destination shorthand field of the ICR allows the delivery mode to be
   by-passed in favor of broadcasting the IPI to all the processors on the
   system bus and/or back to itself (see Section 10.6.1, Interrupt Command
   Register (ICR)). Three destination shorthands are supported: self, all
   excluding self, and all including self. The destination mode is ignored
   when a destination shorthand is used."

So there is no point to supply the destination mode to the shorthand
delivery function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic_flat_64.c |    6 ++----
 arch/x86/kernel/apic/ipi.c          |   15 +++++++--------
 arch/x86/kernel/apic/local.h        |    2 +-
 arch/x86/kernel/apic/probe_64.c     |    2 +-
 4 files changed, 11 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -90,8 +90,7 @@ static void flat_send_IPI_allbutself(int
 			_flat_send_IPI_mask(mask, vector);
 		}
 	} else if (num_online_cpus() > 1) {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT,
-					    vector, apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 	}
 }
 
@@ -100,8 +99,7 @@ static void flat_send_IPI_all(int vector
 	if (vector == NMI_VECTOR) {
 		flat_send_IPI_mask(cpu_online_mask, vector);
 	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC,
-					    vector, apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
 	}
 }
 
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -16,7 +16,7 @@ static inline void __xapic_wait_icr_idle
 		cpu_relax();
 }
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
 	 * Subtle. In the case of the 'never do double writes' workaround
@@ -33,9 +33,10 @@ void __default_send_IPI_shortcut(unsigne
 	__xapic_wait_icr_idle();
 
 	/*
-	 * No need to touch the target chip field
+	 * No need to touch the target chip field. Also the destination
+	 * mode is ignored when a shorthand is used.
 	 */
-	cfg = __prepare_ICR(shortcut, vector, dest);
+	cfg = __prepare_ICR(shortcut, vector, 0);
 
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
@@ -202,8 +203,7 @@ void default_send_IPI_allbutself(int vec
 	if (no_broadcast || vector == NMI_VECTOR) {
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector,
-					    apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 	}
 }
 
@@ -212,14 +212,13 @@ void default_send_IPI_all(int vector)
 	if (no_broadcast || vector == NMI_VECTOR) {
 		apic->send_IPI_mask(cpu_online_mask, vector);
 	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector,
-					    apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
 	}
 }
 
 void default_send_IPI_self(int vector)
 {
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector, apic->dest_logical);
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
 /* must come after the send_IPI functions above for inlining */
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -38,7 +38,7 @@ static inline unsigned int __prepare_ICR
 	return icr;
 }
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest);
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
 
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -40,7 +40,7 @@ void __init default_setup_apic_routing(v
 
 void apic_send_IPI_self(int vector)
 {
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector, APIC_DEST_PHYSICAL);
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)


