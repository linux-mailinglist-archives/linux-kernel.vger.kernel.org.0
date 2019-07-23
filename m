Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCE71213
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfGWGp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 02:45:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46436 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732590AbfGWGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:45:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=kerneljasonxing@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TXbisZS_1563864339;
Received: from localhost(mailfrom:kerneljasonxing@linux.alibaba.com fp:SMTPD_---0TXbisZS_1563864339)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 14:45:54 +0800
From:   Jason Xing <kerneljasonxing@linux.alibaba.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org
Cc:     dennis@kernel.org, axboe@kernel.dk, lizefan@huawei.com,
        tj@kernel.org, kerneljasonxing@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] psi: get poll_work to run when calling poll syscall next time
Date:   Tue, 23 Jul 2019 14:45:39 +0800
Message-Id: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only when calling the poll syscall the first time can user
receive POLLPRI correctly. After that, user always fails to
acquire the event signal.

Reproduce case:
1. Get the monitor code in Documentation/accounting/psi.txt
2. Run it, and wait for the event triggered.
3. Kill and restart the process.

If the user doesn't kill the monitor process, it seems the
poll_work works fine. After killing and restarting the monitor,
the poll_work in kernel will never run again due to the wrong
value of poll_scheduled. Therefore, we should reset the value
as group_init() does after the last trigger is destroyed.

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
---
 kernel/sched/psi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7acc632..66f4385 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1133,6 +1133,12 @@ static void psi_trigger_destroy(struct kref *ref)
 	if (kworker_to_destroy) {
 		kthread_cancel_delayed_work_sync(&group->poll_work);
 		kthread_destroy_worker(kworker_to_destroy);
+		/*
+		 * The poll_work should have the chance to be put into the
+		 * kthread queue when calling poll syscall next time. So
+		 * reset poll_scheduled to zero as group_init() does
+		 */
+		atomic_set(&group->poll_scheduled, 0);
 	}
 	kfree(t);
 }
-- 
1.8.3.1

