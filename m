Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD486ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404442AbfHHTxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404353AbfHHTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:14 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F413218A2;
        Thu,  8 Aug 2019 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293993;
        bh=n/d8YBsjQqJ6w0oyoxIbnrSObuMo5tHZG4trAepJn3U=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=i2blnW+hwOBLPEHL4sOHkP6ZbXOH5XzaCQwV/NlsjBbIuOHPvxOwlL1MDoJfEu64N
         ycZpNnKnmFKDnq8Xv0HvYe2UhKp3bGthdiHhFhzKobtkRDX1r1U0KBbOHEenR4F9Tl
         RQMpiRyNpBx0pcE1ycY2lKs2TIXvI3KPspVDTdiE=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 04/19] genirq: Handle missing work_struct in irq_set_affinity_notifier()
Date:   Thu,  8 Aug 2019 14:52:32 -0500
Message-Id: <908d86a902fda96976e4eb568e9ce86aa8cee750.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit bbc4d2a7d6ff54ba923640d9a42c7bef7185fe98 ]

The backported stable commit
   59c39840f5abf ("genirq: Prevent use-after-free and work list corruption")

added cancel_work_sync() on a work_struct element which is not available
in RT.

Replace cancel_work_sync() with kthread_cancel_work_sync() on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/irq/manage.c
---
 kernel/irq/manage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3d5b33fe874b..071691963f7b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -352,7 +352,9 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-#ifndef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_BASE
+		kthread_cancel_work_sync(&notify->work);
+#else
 		cancel_work_sync(&old_notify->work);
 #endif
 		kref_put(&old_notify->kref, old_notify->release);
-- 
2.14.1

