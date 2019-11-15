Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2135FFE071
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfKOOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 09:46:08 -0500
Received: from m15-114.126.com ([220.181.15.114]:50931 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfKOOqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BVY/ZDObYzZ2ji2Kqa
        KXTAijZRtGn5e8CHHyokkdP88=; b=XuZiQBj9w6OlPjwtBq/zZXDnyntw4MK52A
        rUdb6u31TMEKguXCKazax0bzVAwf4qlWBcI4EXxdz54hNRMTvzTxrGYzSYmYd5IA
        IeLewOaSfq+nxzv96fa2sBZ/s8DTOBFI/MZgL+Qz1L1mTBmqmoM4CQ6Ixx8RFTVR
        1Hpd0NXSY=
Received: from 192.168.137.245 (unknown [112.10.84.253])
        by smtp7 (Coremail) with SMTP id DsmowAAXfxNDuc5d7jmoAg--.19411S3;
        Fri, 15 Nov 2019 22:42:13 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix typo in function check_preempt_wakeup
Date:   Fri, 15 Nov 2019 09:42:13 -0500
Message-Id: <1573828933-24592-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAAXfxNDuc5d7jmoAg--.19411S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8WFWfJF4fXw4UZw4rGrg_yoW3Wrg_Ka
        15Zr43tw48tr1IvFyrW3yxtr1xK3y0ga4xuw4Uua4UZrsYqasxXr95AFn3GrZ3XF4UuFZ5
        uws0gFn0vr1xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0kb1UUUUUU==
X-Originating-IP: [112.10.84.253]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi7RtupFpD9MVpUgAAsv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo "prempt" to "preempt"

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754..9767eff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6667,7 +6667,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
-	 * unconditionally check_prempt_curr() after an enqueue (which may have
+	 * unconditionally check_preempt_curr() after an enqueue (which may have
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
-- 
1.8.3.1

