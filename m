Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FBF2A69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbfKGJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:19:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46757 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKGJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:19:46 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iSdx7-0001zw-Do; Thu, 07 Nov 2019 10:19:41 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] hrtimer: Remove the comment about not used HRTIMER_SOFTIRQ
Date:   Thu,  7 Nov 2019 10:19:24 +0100
Message-Id: <20191107091924.13410-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softirq `HRTIMER_SOFTIRQ' was not used since commit
  c6eb3f70d448 ("hrtimer: Get rid of hrtimer softirq")

but then we started using it again, beginning with commit
  5da70160462e ("hrtimer: Implement support for softirq based hrtimers")

so the comment is not longer accurate.

Remove the comment saying that HRTIMER_SOFTIRQ not used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 89fc59dab57d2..963c3c695784f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -520,8 +520,7 @@ enum
 	IRQ_POLL_SOFTIRQ,
 	TASKLET_SOFTIRQ,
 	SCHED_SOFTIRQ,
-	HRTIMER_SOFTIRQ, /* Unused, but kept as tools rely on the
-			    numbering. Sigh! */
+	HRTIMER_SOFTIRQ,
 	RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */
=20
 	NR_SOFTIRQS
--=20
2.24.0

