Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA65BB6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439989AbfIWOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:36:49 -0400
Received: from foss.arm.com ([217.140.110.172]:43444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439696AbfIWOgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB1A61597;
        Mon, 23 Sep 2019 07:36:44 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47E473F59C;
        Mon, 23 Sep 2019 07:36:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>
Subject: [PATCH v2 5/9] microblaze: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:16 +0100
Message-Id: <20190923143620.29334-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190923143620.29334-1-valentin.schneider@arm.com>
References: <20190923143620.29334-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/entry.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 4e1b567becd6..de7083bd1d24 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -738,14 +738,9 @@ no_intr_resched:
 	andi	r5, r5, _TIF_NEED_RESCHED;
 	beqi	r5, restore /* if zero jump over */
 
-preempt:
 	/* interrupts are off that's why I am calling preempt_chedule_irq */
 	bralid	r15, preempt_schedule_irq
 	nop
-	lwi	r11, CURRENT_TASK, TS_THREAD_INFO;	/* get thread info */
-	lwi	r5, r11, TI_FLAGS;		/* get flags in thread info */
-	andi	r5, r5, _TIF_NEED_RESCHED;
-	bnei	r5, preempt /* if non zero jump to resched */
 restore:
 #endif
 	VM_OFF /* MS: turn off MMU */
-- 
2.22.0

