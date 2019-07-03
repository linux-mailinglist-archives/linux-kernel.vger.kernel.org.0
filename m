Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0FD5D39D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfGBPxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 11:53:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47407 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGBPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:53:40 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hiL68-0006AV-Fv; Tue, 02 Jul 2019 17:53:36 +0200
Date:   Tue, 2 Jul 2019 17:53:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] stacktrace: Use PF_KTHREAD to check for kernel threads
Message-ID: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

!current->mm is not a reliable indicator for kernel threads as they might
temporarily use a user mm. Check for PF_KTHREAD instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -228,7 +228,7 @@ unsigned int stack_trace_save_user(unsig
 	};
 
 	/* Trace user stack if not a kernel thread */
-	if (!current->mm)
+	if (current->flags & PF_KTHREAD)
 		return 0;
 
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
