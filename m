Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A9E2C4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE1KtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 06:49:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfE1KtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:49:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A06B341;
        Tue, 28 May 2019 03:49:20 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BECD3F59C;
        Tue, 28 May 2019 03:49:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/7] sched/core: Fix preempt_schedule() interrupt return comment
Date:   Tue, 28 May 2019 11:48:42 +0100
Message-Id: <20190528104848.13160-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528104848.13160-1-valentin.schneider@arm.com>
References: <20190528104848.13160-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preempt_schedule_irq() is the one that should be called on return from
interrupt, clean up the comment to avoid any ambiguity.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..55ebc2cfb08c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3600,9 +3600,8 @@ static void __sched notrace preempt_schedule_common(void)
 
 #ifdef CONFIG_PREEMPT
 /*
- * this is the entry point to schedule() from in-kernel preemption
- * off of preempt_enable. Kernel preemptions off return from interrupt
- * occur there and call schedule directly.
+ * This is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.
  */
 asmlinkage __visible void __sched notrace preempt_schedule(void)
 {
@@ -3673,7 +3672,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #endif /* CONFIG_PREEMPT */
 
 /*
- * this is the entry point to schedule() from kernel preemption
+ * This is the entry point to schedule() from kernel preemption
  * off of irq context.
  * Note, that this is called and return with irqs disabled. This will
  * protect us against recursive calling from irq.
-- 
2.20.1

