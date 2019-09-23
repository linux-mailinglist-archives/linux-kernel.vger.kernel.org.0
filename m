Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96041BB6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394402AbfIWOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:37:04 -0400
Received: from foss.arm.com ([217.140.110.172]:43456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439970AbfIWOgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8071597;
        Mon, 23 Sep 2019 07:36:46 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2630B3F59C;
        Mon, 23 Sep 2019 07:36:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v2 7/9] sh: entry: Remove unneeded need_resched() loop
Date:   Mon, 23 Sep 2019 15:36:18 +0100
Message-Id: <20190923143620.29334-8-valentin.schneider@arm.com>
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
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/entry-common.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d31f66e82ce5..65a105de52a0 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -93,7 +93,7 @@ ENTRY(resume_kernel)
 	mov.l	@(TI_PRE_COUNT,r8), r0	! current_thread_info->preempt_count
 	tst	r0, r0
 	bf	noresched
-need_resched:
+
 	mov.l	@(TI_FLAGS,r8), r0	! current_thread_info->flags
 	tst	#_TIF_NEED_RESCHED, r0	! need_resched set?
 	bt	noresched
@@ -107,8 +107,6 @@ need_resched:
 	mov.l	1f, r0
 	jsr	@r0			! call preempt_schedule_irq
 	 nop
-	bra	need_resched
-	 nop
 
 noresched:
 	bra	__restore_all
-- 
2.22.0

