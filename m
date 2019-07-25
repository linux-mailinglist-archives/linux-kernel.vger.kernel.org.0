Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7475142
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfGYOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:33:52 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36643 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbfGYOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:33:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TXn-kBY_1564065224;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TXn-kBY_1564065224)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jul 2019 22:33:46 +0800
Date:   Thu, 25 Jul 2019 22:33:44 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] temp hack to make tick based schedule happen
Message-ID: <20190725143344.GD992@aaronlu>
References: <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725143003.GA992@aaronlu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a hyperthread is forced idle and the other hyperthread has a single
CPU intensive task running, the running task can occupy the hyperthread
for a long time with no scheduling point and starve the other
hyperthread.

Fix this temporarily by always checking if the task has exceed its
timeslice and if so, do a schedule.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43babc2a12a5..730c9359e9c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4093,6 +4093,9 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		return;
 	}
 
+	if (cfs_rq->nr_running <= 1)
+		return;
+
 	/*
 	 * Ensure that a task that missed wakeup preemption by a
 	 * narrow margin doesn't have to wait for a full slice.
@@ -4261,8 +4264,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
-		check_preempt_tick(cfs_rq, curr);
+	check_preempt_tick(cfs_rq, curr);
 }
 
 
-- 
2.19.1.3.ge56e4f7

