Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801566605B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfGKUFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 16:05:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50853 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGKUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:05:16 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlfJa-0005RY-II; Thu, 11 Jul 2019 22:05:14 +0200
Date:   Thu, 11 Jul 2019 20:02:36 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for 5.3-rc1
Message-ID: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

up to:  7e8e6816c649: stacktrace: Use PF_KTHREAD to check for kernel threads

Fix yet another instance of kernel thread check which ignores that kernel
threads can call use_mm().

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      stacktrace: Use PF_KTHREAD to check for kernel threads


 kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 36139de0a3c4..c8d0f05721a1 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -228,7 +228,7 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	};
 
 	/* Trace user stack if not a kernel thread */
-	if (!current->mm)
+	if (current->flags & PF_KTHREAD)
 		return 0;
 
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));

