Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF12ABB6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501955AbfIWOhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:37:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394205AbfIWOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1586F15AB;
        Mon, 23 Sep 2019 07:36:44 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59A913F59C;
        Mon, 23 Sep 2019 07:36:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH v2 4/9] h8300: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:15 +0100
Message-Id: <20190923143620.29334-5-valentin.schneider@arm.com>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
 arch/h8300/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
index 4ade5f8299ba..6bde028e7d4a 100644
--- a/arch/h8300/kernel/entry.S
+++ b/arch/h8300/kernel/entry.S
@@ -323,7 +323,6 @@ restore_all:
 resume_kernel:
 	mov.l	@(TI_PRE_COUNT:16,er4),er0
 	bne	restore_all:8
-need_resched:
 	mov.l	@(TI_FLAGS:16,er4),er0
 	btst	#TIF_NEED_RESCHED,r0l
 	beq	restore_all:8
@@ -332,7 +331,7 @@ need_resched:
 	mov.l	sp,er0
 	jsr	@set_esp0
 	jsr	@preempt_schedule_irq
-	bra	need_resched:8
+	bra	restore_all:8
 #endif
 
 ret_from_fork:
-- 
2.22.0

