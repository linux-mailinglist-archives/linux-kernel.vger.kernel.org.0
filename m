Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B782E2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfD2MiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 08:38:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbfD2MiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:38:02 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4FF3A2625511BE6A939F;
        Mon, 29 Apr 2019 20:37:59 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.190) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 29 Apr 2019 20:37:49 +0800
From:   ChenGang <cg.chen@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>, <jiangqi903@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, <joseph.qi@linux.alibaba.com>,
        ChenGang <cg.chen@huawei.com>
Subject: Re: [PATCH] fs: ocfs: fix spelling mistake "hearbeating" -> "heartbeat"
Date:   Mon, 29 Apr 2019 20:41:40 +0800
Message-ID: <1556541700-35237-1-git-send-email-cg.chen@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.190]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,
Thanks for your advice, and I folded the four patches into one.

On 19/4/28 20:22, Joseph Qi wrote:
>Hi ChenGang,
>Could you please fold these four patches into one?

>Thanks,
>Joseph

>On 19/4/27 20:22, ChenGang wrote:
>> There is a spelling mistake in o2hb_do_disk_heartbeat debug message.Fix it.
>> 
>> Signed-off-by: ChenGang <cg.chen@huawei.com>
>> ---
>>  fs/ocfs2/cluster/heartbeat.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/ocfs2/cluster/heartbeat.c 
>> b/fs/ocfs2/cluster/heartbeat.c index f3c20b2..e4e7df1 100644
>> --- a/fs/ocfs2/cluster/heartbeat.c
>> +++ b/fs/ocfs2/cluster/heartbeat.c
>> @@ -1198,7 +1198,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
>>  	if (atomic_read(&reg->hr_steady_iterations) != 0) {
>>  		if (atomic_dec_and_test(&reg->hr_unsteady_iterations)) {
>>  			printk(KERN_NOTICE "o2hb: Unable to stabilize "
>> -			       "heartbeart on region %s (%s)\n",
>> +			       "heartbeat on region %s (%s)\n",
>>  			       config_item_name(&reg->hr_item),
>>  			       reg->hr_dev_name);
>> 			atomic_set(&reg->hr_steady_iterations, 0);
>>


Signed-off-by: ChenGang <cg.chen@huawei.com>
---
 fs/ocfs2/cluster/heartbeat.c | 2 +-
 fs/ocfs2/cluster/quorum.c    | 2 +-
 fs/ocfs2/cluster/tcp.c       | 2 +-
 fs/ocfs2/dlm/dlmmaster.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index f3c20b2..e4e7df1 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1198,7 +1198,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 	if (atomic_read(&reg->hr_steady_iterations) != 0) {
 		if (atomic_dec_and_test(&reg->hr_unsteady_iterations)) {
 			printk(KERN_NOTICE "o2hb: Unable to stabilize "
-			       "heartbeart on region %s (%s)\n",
+			       "heartbeat on region %s (%s)\n",
 			       config_item_name(&reg->hr_item),
 			       reg->hr_dev_name);
 			atomic_set(&reg->hr_steady_iterations, 0);
diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index af2e747..792132f 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -89,7 +89,7 @@ static void o2quo_fence_self(void)
 	};
 }
 
-/* Indicate that a timeout occurred on a hearbeat region write. The
+/* Indicate that a timeout occurred on a heartbeat region write. The
  * other nodes in the cluster may consider us dead at that time so we
  * want to "fence" ourselves so that we don't scribble on the disk
  * after they think they've recovered us. This can't solve all
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index e9f236a..7a43c04 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1776,7 +1776,7 @@ static void o2net_hb_node_up_cb(struct o2nm_node *node, int node_num,
 		(msecs_to_jiffies(o2net_reconnect_delay()) + 1);
 
 	if (node_num != o2nm_this_node()) {
-		/* believe it or not, accept and node hearbeating testing
+		/* believe it or not, accept and node heartbeating testing
 		 * can succeed for this node before we got here.. so
 		 * only use set_nn_state to clear the persistent error
 		 * if that hasn't already happened */
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 826f056..41b80d5 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2176,7 +2176,7 @@ static void dlm_assert_master_worker(struct dlm_work_item *item, void *data)
  * think that $RECOVERY is currently mastered by a dead node.  If so,
  * we wait a short time to allow that node to get notified by its own
  * heartbeat stack, then check again.  All $RECOVERY lock resources
- * mastered by dead nodes are purged when the hearbeat callback is
+ * mastered by dead nodes are purged when the heartbeat callback is
  * fired, so we can know for sure that it is safe to continue once
  * the node returns a live node or no node.  */
 static int dlm_pre_master_reco_lockres(struct dlm_ctxt *dlm,
-- 
1.8.5.6

