Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910F45FBE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGDQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 12:35:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfGDQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gO-0005gR-LO; Thu, 04 Jul 2019 18:34:04 +0200
Message-Id: <20190704155609.745010819@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 15/25] x86/apic: Add NMI_VECTOR wait to IPI shorthand
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support NMI shorthand broadcasts add the safe wait for ICR idle for NMI
vector delivery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/ipi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -30,7 +30,10 @@ void __default_send_IPI_shortcut(unsigne
 	/*
 	 * Wait for idle.
 	 */
-	__xapic_wait_icr_idle();
+	if (unlikely(vector == NMI_VECTOR))
+		safe_apic_wait_icr_idle();
+	else
+		__xapic_wait_icr_idle();
 
 	/*
 	 * No need to touch the target chip field. Also the destination


