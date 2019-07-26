Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52176EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfGZQVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 12:21:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfGZQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CDmsKUeZGn1D8KwlufMKB5RJ+CDZZpPbNNWkaiBDRls=; b=N52mABe7kwWqGu8cvCdGY6cjWt
        dH8z8M3wkAOFWX59bcGC+5S62JR3khpQRjt/uogVNRD/zyTcRlDvYUZ2TIWwRQyH1yZRFQNDyuCpf
        IM7vr3HQCfxD7siGMIETYMX+TGHB71emwLajm4zPRXvAiHMS5alkwsezHtlgirN49vYxbXqkifMY/
        9qsrqJvSM1rNExdinREgzE+IDjbQMyDlLtPxhfeyaiPJRo4disNT1OXTlzLQvRYY1h3iTHydtXDU0
        0A3reH8PvSQeTbmjmUF9IruWQt5h47MisOVwLDTU1uDEJWsl/j270rUhrmae/zPlYmSWUtZP5P2zc
        E3xsCFjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wx-0006a6-Fn; Fri, 26 Jul 2019 16:20:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 480F12022974F; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.521859143@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 03/13] sched: Fix kerneldoc comment for ia64_set_curr_task
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6702,7 +6702,7 @@ struct task_struct *curr_task(int cpu)
 
 #ifdef CONFIG_IA64
 /**
- * set_curr_task - set the current task for a given CPU.
+ * ia64_set_curr_task - set the current task for a given CPU.
  * @cpu: the processor in question.
  * @p: the task pointer to set.
  *


