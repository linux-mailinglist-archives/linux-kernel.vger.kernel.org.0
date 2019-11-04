Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B7EE1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfKDN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:58:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:36854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727891AbfKDN6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:58:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56D91B417;
        Mon,  4 Nov 2019 13:58:35 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH] xen/events: remove event handling recursion detection
Date:   Mon,  4 Nov 2019 14:58:12 +0100
Message-Id: <20191104135812.2314-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__xen_evtchn_do_upcall() contains guards against being called
recursively. This mechanism was introduced in the early pvops times
(kernel 2.6.26) when there were still Xen versions around not honoring
disabled interrupts for sending events to pv guests.

This was changed in Xen 3.0, which is much older than any Xen version
supported by the kernel, so the recursion detection can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6c8843968a52..33212c494afd 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1213,31 +1213,21 @@ void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
 	notify_remote_via_irq(irq);
 }
 
-static DEFINE_PER_CPU(unsigned, xed_nesting_count);
-
 static void __xen_evtchn_do_upcall(void)
 {
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
-	int cpu = get_cpu();
-	unsigned count;
+	int cpu = smp_processor_id();
 
 	do {
 		vcpu_info->evtchn_upcall_pending = 0;
 
-		if (__this_cpu_inc_return(xed_nesting_count) - 1)
-			goto out;
-
 		xen_evtchn_handle_events(cpu);
 
 		BUG_ON(!irqs_disabled());
 
-		count = __this_cpu_read(xed_nesting_count);
-		__this_cpu_write(xed_nesting_count, 0);
-	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
-
-out:
+		rmb(); /* Hypervisor can set upcall pending. */
 
-	put_cpu();
+	} while (vcpu_info->evtchn_upcall_pending);
 }
 
 void xen_evtchn_do_upcall(struct pt_regs *regs)
-- 
2.16.4

