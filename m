Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87F1642D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 12:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBSLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 06:01:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgBSLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:01:43 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j4N6k-0002oa-27; Wed, 19 Feb 2020 12:01:34 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BB84F103A05; Wed, 19 Feb 2020 12:01:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen: Enable interrupts when calling _cond_resched()
Date:   Wed, 19 Feb 2020 12:01:33 +0100
Message-ID: <87tv3mq1rm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_maybe_preempt_hcall() is called from the exception entry point
xen_do_hypervisor_callback with interrupts disabled.

_cond_resched() evades the might_sleep() check in cond_resched() which
would have caught that and schedule_debug() unfortunately lacks a check
for irqs_disabled().

Enable interrupts around the call and use cond_resched() to catch future
issues.

Fixes: fdfd811ddde3 ("x86/xen: allow privcmd hypercalls to be preempted")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/xen/preempt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -33,8 +33,10 @@ asmlinkage __visible void xen_maybe_pree
 		 * cpu.
 		 */
 		__this_cpu_write(xen_in_preemptible_hcall, false);
-		_cond_resched();
+		local_irq_enable();
+		cond_resched();
 		__this_cpu_write(xen_in_preemptible_hcall, true);
+		local_irq_disable();
 	}
 }
 #endif /* CONFIG_PREEMPTION */
