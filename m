Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA7A9704D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfHUD0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 23:26:38 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:25074 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfHUD0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:26:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ta17zIJ_1566357985;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ta17zIJ_1566357985)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Aug 2019 11:26:25 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Xing <kerneljasonxing@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v3] psi: get poll_work to run when calling poll syscall next time
Date:   Wed, 21 Aug 2019 11:26:25 +0800
Message-Id: <1566357985-97781-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Xing <kerneljasonxing@linux.alibaba.com>

Only when calling the poll syscall the first time can user
receive POLLPRI correctly. After that, user always fails to
acquire the event signal.

Reproduce case:
1. Get the monitor code in Documentation/accounting/psi.txt
2. Run it, and wait for the event triggered.
3. Kill and restart the process.

The question is why we can end up with poll_scheduled = 1 but the work
not running (which would reset it to 0). And the answer is because the
scheduling side sees group->poll_kworker under RCU protection and then
schedules it, but here we cancel the work and destroy the worker. The
cancel needs to pair with resetting the poll_scheduled flag.

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
Reviewed-by: Caspar Zhang <caspar@linux.alibaba.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
v3: Change the description as Johannes Weiner suggested.

 kernel/sched/psi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 23fbbcc..6e52b67 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1131,7 +1131,15 @@ static void psi_trigger_destroy(struct kref *ref)
 	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
 	 */
 	if (kworker_to_destroy) {
+		/*
+		 * After the RCU grace period has expired, the worker
+		 * can no longer be found through group->poll_kworker.
+		 * But it might have been already scheduled before
+		 * that - deschedule it cleanly before destroying it.
+		 */
 		kthread_cancel_delayed_work_sync(&group->poll_work);
+		atomic_set(&group->poll_scheduled, 0);
+
 		kthread_destroy_worker(kworker_to_destroy);
 	}
 	kfree(t);
-- 
1.8.3.1

