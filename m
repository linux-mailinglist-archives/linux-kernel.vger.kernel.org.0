Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46016A9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbfGPN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 09:59:54 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:39016 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387782AbfGPN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:59:53 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:405a::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hnNzg-0000nK-29; Tue, 16 Jul 2019 09:59:50 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Horman <nhorman@tuxdriver.com>, djuran@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86: Add irq spillover warning
Date:   Tue, 16 Jul 2019 09:59:17 -0400
Message-Id: <20190716135917.15525-1-nhorman@tuxdriver.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel hardware, cpus are limited in the number of irqs they can
have affined to them (currently 240), based on section 10.5.2 of:
https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.pdf

If a cpu has more than this number of interrupts affined to it, they
will spill over to other cpus, which potentially may be outside of their
affinity mask.  Given that this might cause unexpected behavior on
performance sensitive systems, warn the user should this condition occur
so that corrective action can be taken

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Reported-by: djuran@redhat.com
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
---
 arch/x86/kernel/irq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9b68b5b00ac9..ac7ed32de3d5 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -244,6 +244,14 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 
 	desc = __this_cpu_read(vector_irq[vector]);
 
+	/*
+	 * Intel processors are limited in the number of irqs they can address. If we affine
+	 * too many irqs to a given cpu, they can silently spill to another cpu outside of
+	 * their affinity mask. Warn the user when this occurs
+	 */
+	if (unlikely(!cpumask_test_cpu(smp_processor_id(), &desc->irq_common_data.affinity)))
+		pr_emerg_ratelimited("%s: %d.%d handled outside of affinity mask\n");
+
 	if (!handle_irq(desc, regs)) {
 		ack_APIC_irq();
 
-- 
2.21.0

