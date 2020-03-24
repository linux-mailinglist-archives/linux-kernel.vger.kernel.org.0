Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635F8191018
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgCXNZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:25:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728543AbgCXNZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:25:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1DA525CE02A283122618;
        Tue, 24 Mar 2020 21:24:41 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 21:24:32 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH V3] block: rename 'q->debugfs_dir' and 'q->blk_trace->dir' in blk_unregister_queue()
Date:   Tue, 24 Mar 2020 21:23:15 +0800
Message-ID: <20200324132315.22133-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting use after free bug in debugfs_remove[1].

This is because in request_queue, 'q->debugfs_dir' and
'q->blk_trace->dir' could be the same dir. And in __blk_release_queue(),
blk_mq_debugfs_unregister() will remove everything inside the dir.

With futher investigation of the reporduce repro, the problem can be
reporduced by following procedure:

1. LOOP_CTL_ADD, create a request_queue q1, blk_mq_debugfs_register() will
create the dir.
2. LOOP_CTL_REMOVE, blk_release_queue() will add q1 to release queue.
3. LOOP_CTL_ADD, create another request_queue q2,blk_mq_debugfs_register()
will fail because the dir aready exist.
4. BLKTRACESETUP, create two files(msg and dropped) inside the dir.
5. call __blk_release_queue() for q1, debugfs_remove_recursive() will
delete the files created in step 4.
6. LOOP_CTL_REMOVE, blk_release_queue() will add q2 to release queue.
And when __blk_release_queue() is called for q2, blk_trace_shutdown() will
try to release the two files created in step 4, wich are aready released
in step 5.

thread1		         |kworker                   |thread2
 ----------------------- | ------------------------ | --------------------
loop_control_ioctl       |                          |
 loop_add                |                          |
  blk_mq_debugfs_register|                          |
   debugfs_create_dir    |                          |
loop_control_ioctl       |                          |
 loop_remove		 |                          |
  blk_release_queue      |                          |
   schedule_work         |                          |
                         |                          |loop_control_ioctl
                         |                          | loop_add
                         |                          |  ...
                         |                          |blk_trace_ioctl
                         |                          | __blk_trace_setup
                         |                          |   debugfs_create_file
                         |__blk_release_queue       |
                         | blk_mq_debugfs_unregister|
                         |  debugfs_remove_recursive|
                         |                          |loop_control_ioctl
                         |                          | loop_remove
                         |                          |  ...
                         |__blk_release_queue       |
                         | blk_trace_shutdown       |
                         |  debugfs_remove          |

commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") pushed the
final release of request_queue to a workqueue, so, when loop_add() is
called again(step 3), __blk_release_queue() might not been called yet,
which causes the problem.

Fix the problem by renaming 'q->debugfs_dir' or 'q->blk_trace->dir'
in blk_unregister_queue() if they exist.

[1] https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
References: CVE-2019-19770
Fixes: commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
Reported-by: syzbot <syz...@syzkaller.appspotmail.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
Changes in V2:
 add device name to the new dir name
 fix compile err when 'CONFIG_BLK_DEBUG_FS' is not enabled
 add treatment of 'q->blk_trace->dir'
Changes in V3:
 handle 'q->debugfs-dir' and 'q->blk_trace->dir' respectivly
 remove dev name to avoid memory leek when dev name is too long
 warn_on when debugfs_rename failed, don't keep trying in a loop

 block/blk-sysfs.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..8cd124117e29 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,8 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
+#include <linux/atomic.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -1011,6 +1013,53 @@ int blk_register_queue(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
 
+#ifdef CONFIG_DEBUG_FS
+
+void blk_rename_debugfs_dir(struct dentry **old)
+{
+	static atomic_t i = ATOMIC_INIT(0);
+	struct dentry *new;
+	char name[DNAME_INLINE_LEN];
+	u32 index = atomic_fetch_inc(&i);
+
+	snprintf(name, sizeof(name), "ready_to_remove_%u", index);
+	new = debugfs_lookup(name, blk_debugfs_root);
+	if (WARN_ON(new)) {
+		dput(new);
+		return;
+	}
+	new = debugfs_rename(blk_debugfs_root, *old, blk_debugfs_root, name);
+	if (WARN_ON(!new))
+		return;
+	*old = new;
+}
+/*
+ * blk_prepare_release_queue - rename q->debugfs_dir and q->blk_trace->dir
+ * @q: request_queue of which the dir to be renamed belong to.
+ *
+ * Because the final release of request_queue is in a workqueue, the
+ * cleanup might not been finished yet while the same device start to
+ * create. It's not correct if q->debugfs_dir still exist while trying
+ * to create a new one.
+ */
+static void blk_prepare_release_queue(struct request_queue *q)
+{
+#ifdef CONFIG_BLK_DEBUG_FS
+	if (!IS_ERR_OR_NULL(q->debugfs_dir))
+		blk_rename_debugfs_dir(&q->debugfs_dir);
+
+#endif
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	mutex_lock(&q->blk_trace_mutex);
+	if (q->blk_trace && !IS_ERR_OR_NULL(q->blk_trace->dir))
+		blk_rename_debugfs_dir(&q->blk_trace->dir);
+	mutex_unlock(&q->blk_trace_mutex);
+#endif
+}
+#else
+#define blk_prepare_release_queue(q)		do { } while (0)
+#endif
+
 /**
  * blk_unregister_queue - counterpart of blk_register_queue()
  * @disk: Disk of which the request queue should be unregistered from sysfs.
@@ -1039,6 +1088,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 
 	mutex_lock(&q->sysfs_dir_lock);
+	blk_prepare_release_queue(q);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
-- 
2.17.2

