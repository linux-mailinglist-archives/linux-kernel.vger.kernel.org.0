Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834EA6EC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbfGSVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 17:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388706AbfGSVt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BC521882;
        Fri, 19 Jul 2019 21:49:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalI-00080F-Ib; Fri, 19 Jul 2019 17:49:56 -0400
Message-Id: <20190719214956.460034332@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 03/16] genirq: Handle missing work_struct in irq_set_affinity_notifier()
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit bbc4d2a7d6ff54ba923640d9a42c7bef7185fe98 ]

The backported stable commit
   59c39840f5abf ("genirq: Prevent use-after-free and work list corruption")

added cancel_work_sync() on a work_struct element which is not available
in RT.

Replace cancel_work_sync() with kthread_cancel_work_sync() on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/irq/manage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 381305c48a0a..b2736d7d863b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -385,8 +385,9 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-#ifndef CONFIG_PREEMPT_RT_BASE
-		/* Need to address this for PREEMPT_RT */
+#ifdef CONFIG_PREEMPT_RT_BASE
+		kthread_cancel_work_sync(&notify->work);
+#else
 		cancel_work_sync(&old_notify->work);
 #endif
 		kref_put(&old_notify->kref, old_notify->release);
-- 
2.20.1


