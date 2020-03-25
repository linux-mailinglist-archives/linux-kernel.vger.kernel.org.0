Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC01926B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCYLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 07:06:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCYLGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uERmO8yYGTQ+JS1lkRQH5yYDtjFwmBCMnVE7mgY4RZM=; b=tzItUC0jRvv0WWxwbZ5kn+GwUX
        hf5h8gkZFPF8HKGQbvMlwmPzsm6g4dDegTy45ltWL+wyzDiTRq1683485gTXoCnM2xCH8i/orLwjC
        Y08sMvys+86lNocyvrtONaf+r0euPYweQ4eXTsE9SJjBD+nmMhFuR4oQ6SgyEhG9mma2KV4DVGnJ3
        TQlaaakqY9QVB7ppO4ue7QT6n+Ko1dF7KXWfg95RQk5rEwhPUg1V6lVi5bwK4NsH1havT4yiUdHff
        khUXKpRzhxTv4RItrjOQbXbAfGVUmuXB+WJzyeWPfXtd26j/dm6ry7TGEoUbrLCxYJD3Ajun6YlFE
        CZdlb/aA==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rT-0003AH-33; Wed, 25 Mar 2020 11:06:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] block: move the part_stat* helpers from genhd.h to a new header
Date:   Wed, 25 Mar 2020 12:03:38 +0100
Message-Id: <20200325110338.1029232-9-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are just used by a few files.  Move them out of genhd.h,
which is included everywhere into a new standalone header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h                        |   1 +
 drivers/block/drbd/drbd_receiver.c |   1 +
 drivers/block/drbd/drbd_worker.c   |   1 +
 drivers/block/zram/zram_drv.c      |   1 +
 drivers/md/dm.c                    |   1 +
 drivers/md/md.c                    |   1 +
 drivers/nvme/target/admin-cmd.c    |   1 +
 fs/ext4/super.c                    |   2 +-
 fs/ext4/sysfs.c                    |   1 +
 fs/f2fs/f2fs.h                     |   1 +
 fs/f2fs/super.c                    |   1 +
 include/linux/genhd.h              | 111 ---------------------------
 include/linux/part_stat.h          | 118 +++++++++++++++++++++++++++++
 13 files changed, 129 insertions(+), 112 deletions(-)
 create mode 100644 include/linux/part_stat.h

diff --git a/block/blk.h b/block/blk.h
index 224340be4c7a..c95adf72846a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
+#include <linux/part_stat.h>
 #include <xen/xen.h>
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 79e216446030..c15e7083b13a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -33,6 +33,7 @@
 #include <linux/random.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
+#include <linux/part_stat.h>
 #include "drbd_int.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index b7f605c6e231..0dc019da1f8d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -22,6 +22,7 @@
 #include <linux/random.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
+#include <linux/part_stat.h>
 
 #include "drbd_int.h"
 #include "drbd_protocol.h"
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bdb5793842b..76e75097e9ab 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/sysfs.h>
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
+#include <linux/part_stat.h>
 
 #include "zram_drv.h"
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0413018c8305..0d881cfa160b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -25,6 +25,7 @@
 #include <linux/wait.h>
 #include <linux/pr.h>
 #include <linux/refcount.h>
+#include <linux/part_stat.h>
 
 #define DM_MSG_PREFIX "core"
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1c7193715f07..f6cf3b53f6c1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -61,6 +61,7 @@
 #include <linux/raid/detect.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
+#include <linux/part_stat.h>
 
 #include <trace/events/block.h>
 #include "md.h"
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 72a7e41f3018..cca759c918a4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/rculist.h>
+#include <linux/part_stat.h>
 
 #include <generated/utsrelease.h>
 #include <asm/unaligned.h>
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4cbd1cc34dfa..c8dff4c68141 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -43,7 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
-
+#include <linux/part_stat.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d218ebdafa4a..04bfaf63752c 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
+#include <linux/part_stat.h>
 
 #include "ext4.h"
 #include "ext4_jbd2.h"
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5355be6b6755..088c3e7a1080 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -22,6 +22,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
+#include <linux/part_stat.h>
 #include <crypto/hash.h>
 
 #include <linux/fscrypt.h>
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 65a7a432dfee..d398b2d90c6c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -24,6 +24,7 @@
 #include <linux/sysfs.h>
 #include <linux/quota.h>
 #include <linux/unicode.h>
+#include <linux/part_stat.h>
 
 #include "f2fs.h"
 #include "node.h"
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8156cb35ff1f..f4d6cc29ddcc 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -299,117 +299,6 @@ extern void disk_part_iter_init(struct disk_part_iter *piter,
 extern struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter);
 extern void disk_part_iter_exit(struct disk_part_iter *piter);
 
-/*
- * Macros to operate on percpu disk statistics:
- *
- * {disk|part|all}_stat_{add|sub|inc|dec}() modify the stat counters
- * and should be called between disk_stat_lock() and
- * disk_stat_unlock().
- *
- * part_stat_read() can be called at any time.
- *
- * part_stat_{add|set_all}() and {init|free}_part_stats are for
- * internal use only.
- */
-#ifdef	CONFIG_SMP
-#define part_stat_lock()	({ rcu_read_lock(); get_cpu(); })
-#define part_stat_unlock()	do { put_cpu(); rcu_read_unlock(); } while (0)
-
-#define part_stat_get_cpu(part, field, cpu)					\
-	(per_cpu_ptr((part)->dkstats, (cpu))->field)
-
-#define part_stat_get(part, field)					\
-	part_stat_get_cpu(part, field, smp_processor_id())
-
-#define part_stat_read(part, field)					\
-({									\
-	typeof((part)->dkstats->field) res = 0;				\
-	unsigned int _cpu;						\
-	for_each_possible_cpu(_cpu)					\
-		res += per_cpu_ptr((part)->dkstats, _cpu)->field;	\
-	res;								\
-})
-
-static inline void part_stat_set_all(struct hd_struct *part, int value)
-{
-	int i;
-
-	for_each_possible_cpu(i)
-		memset(per_cpu_ptr(part->dkstats, i), value,
-				sizeof(struct disk_stats));
-}
-
-static inline int init_part_stats(struct hd_struct *part)
-{
-	part->dkstats = alloc_percpu(struct disk_stats);
-	if (!part->dkstats)
-		return 0;
-	return 1;
-}
-
-static inline void free_part_stats(struct hd_struct *part)
-{
-	free_percpu(part->dkstats);
-}
-
-#else /* !CONFIG_SMP */
-#define part_stat_lock()	({ rcu_read_lock(); 0; })
-#define part_stat_unlock()	rcu_read_unlock()
-
-#define part_stat_get(part, field)		((part)->dkstats.field)
-#define part_stat_get_cpu(part, field, cpu)	part_stat_get(part, field)
-#define part_stat_read(part, field)		part_stat_get(part, field)
-
-static inline void part_stat_set_all(struct hd_struct *part, int value)
-{
-	memset(&part->dkstats, value, sizeof(struct disk_stats));
-}
-
-static inline int init_part_stats(struct hd_struct *part)
-{
-	return 1;
-}
-
-static inline void free_part_stats(struct hd_struct *part)
-{
-}
-
-#endif /* CONFIG_SMP */
-
-#define part_stat_read_msecs(part, which)				\
-	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
-
-#define part_stat_read_accum(part, field)				\
-	(part_stat_read(part, field[STAT_READ]) +			\
-	 part_stat_read(part, field[STAT_WRITE]) +			\
-	 part_stat_read(part, field[STAT_DISCARD]))
-
-#define __part_stat_add(part, field, addnd)				\
-	(part_stat_get(part, field) += (addnd))
-
-#define part_stat_add(part, field, addnd)	do {			\
-	__part_stat_add((part), field, addnd);				\
-	if ((part)->partno)						\
-		__part_stat_add(&part_to_disk((part))->part0,		\
-				field, addnd);				\
-} while (0)
-
-#define part_stat_dec(gendiskp, field)					\
-	part_stat_add(gendiskp, field, -1)
-#define part_stat_inc(gendiskp, field)					\
-	part_stat_add(gendiskp, field, 1)
-#define part_stat_sub(gendiskp, field, subnd)				\
-	part_stat_add(gendiskp, field, -subnd)
-
-#define part_stat_local_dec(gendiskp, field)				\
-	local_dec(&(part_stat_get(gendiskp, field)))
-#define part_stat_local_inc(gendiskp, field)				\
-	local_inc(&(part_stat_get(gendiskp, field)))
-#define part_stat_local_read(gendiskp, field)				\
-	local_read(&(part_stat_get(gendiskp, field)))
-#define part_stat_local_read_cpu(gendiskp, field, cpu)			\
-	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
-
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,
 			    const struct attribute_group **groups);
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
new file mode 100644
index 000000000000..23226d8d063f
--- /dev/null
+++ b/include/linux/part_stat.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PART_STAT_H
+#define _LINUX_PART_STAT_H
+
+#include <linux/genhd.h>
+
+/*
+ * Macros to operate on percpu disk statistics:
+ *
+ * {disk|part|all}_stat_{add|sub|inc|dec}() modify the stat counters
+ * and should be called between disk_stat_lock() and
+ * disk_stat_unlock().
+ *
+ * part_stat_read() can be called at any time.
+ *
+ * part_stat_{add|set_all}() and {init|free}_part_stats are for
+ * internal use only.
+ */
+#ifdef	CONFIG_SMP
+#define part_stat_lock()	({ rcu_read_lock(); get_cpu(); })
+#define part_stat_unlock()	do { put_cpu(); rcu_read_unlock(); } while (0)
+
+#define part_stat_get_cpu(part, field, cpu)				\
+	(per_cpu_ptr((part)->dkstats, (cpu))->field)
+
+#define part_stat_get(part, field)					\
+	part_stat_get_cpu(part, field, smp_processor_id())
+
+#define part_stat_read(part, field)					\
+({									\
+	typeof((part)->dkstats->field) res = 0;				\
+	unsigned int _cpu;						\
+	for_each_possible_cpu(_cpu)					\
+		res += per_cpu_ptr((part)->dkstats, _cpu)->field;	\
+	res;								\
+})
+
+static inline void part_stat_set_all(struct hd_struct *part, int value)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		memset(per_cpu_ptr(part->dkstats, i), value,
+				sizeof(struct disk_stats));
+}
+
+static inline int init_part_stats(struct hd_struct *part)
+{
+	part->dkstats = alloc_percpu(struct disk_stats);
+	if (!part->dkstats)
+		return 0;
+	return 1;
+}
+
+static inline void free_part_stats(struct hd_struct *part)
+{
+	free_percpu(part->dkstats);
+}
+
+#else /* !CONFIG_SMP */
+#define part_stat_lock()	({ rcu_read_lock(); 0; })
+#define part_stat_unlock()	rcu_read_unlock()
+
+#define part_stat_get(part, field)		((part)->dkstats.field)
+#define part_stat_get_cpu(part, field, cpu)	part_stat_get(part, field)
+#define part_stat_read(part, field)		part_stat_get(part, field)
+
+static inline void part_stat_set_all(struct hd_struct *part, int value)
+{
+	memset(&part->dkstats, value, sizeof(struct disk_stats));
+}
+
+static inline int init_part_stats(struct hd_struct *part)
+{
+	return 1;
+}
+
+static inline void free_part_stats(struct hd_struct *part)
+{
+}
+
+#endif /* CONFIG_SMP */
+
+#define part_stat_read_msecs(part, which)				\
+	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
+
+#define part_stat_read_accum(part, field)				\
+	(part_stat_read(part, field[STAT_READ]) +			\
+	 part_stat_read(part, field[STAT_WRITE]) +			\
+	 part_stat_read(part, field[STAT_DISCARD]))
+
+#define __part_stat_add(part, field, addnd)				\
+	(part_stat_get(part, field) += (addnd))
+
+#define part_stat_add(part, field, addnd)	do {			\
+	__part_stat_add((part), field, addnd);				\
+	if ((part)->partno)						\
+		__part_stat_add(&part_to_disk((part))->part0,		\
+				field, addnd);				\
+} while (0)
+
+#define part_stat_dec(gendiskp, field)					\
+	part_stat_add(gendiskp, field, -1)
+#define part_stat_inc(gendiskp, field)					\
+	part_stat_add(gendiskp, field, 1)
+#define part_stat_sub(gendiskp, field, subnd)				\
+	part_stat_add(gendiskp, field, -subnd)
+
+#define part_stat_local_dec(gendiskp, field)				\
+	local_dec(&(part_stat_get(gendiskp, field)))
+#define part_stat_local_inc(gendiskp, field)				\
+	local_inc(&(part_stat_get(gendiskp, field)))
+#define part_stat_local_read(gendiskp, field)				\
+	local_read(&(part_stat_get(gendiskp, field)))
+#define part_stat_local_read_cpu(gendiskp, field, cpu)			\
+	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
+
+#endif /* _LINUX_PART_STAT_H */
-- 
2.25.1

