Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DC86AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404395AbfHHTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404271AbfHHTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:11 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 826532189D;
        Thu,  8 Aug 2019 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293991;
        bh=cprIz4EcR1+indvbehlpEArn0qQr/BOY96ETBrplakw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RR20w0sgsSpExHnmRegf6H6NJ/N0wB+tTU8fMFn+idf693IXdUonAV+PDeF24sdAN
         IsM4S1JjGJdx1ZEnLMi6f3N4tAo+TohI0lEKeTNFVp3n4QXYtnTWhQC1MKdAN8Ypsg
         afcaM2g2qUo7U+o4pkb/bK4j+SQ5WmVwfd6AQ2z4=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 02/19] kthread: add a global worker thread.
Date:   Thu,  8 Aug 2019 14:52:30 -0500
Message-Id: <d09ae14cce43fa3b7f3d93aada149d6d611e6dfb.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 0532e87d9d44795221aa921ba7024bde689cc894 ]

Add kthread_schedule_work() which uses a global kthread for all its
jobs.
Split the cgroup include to avoid recussive includes from interrupt.h.
Fixup everything that fails to build (and did not include all header).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	include/linux/blk-cgroup.h
	include/linux/kthread.h
	kernel/kthread.c
---
 drivers/block/loop.c           |  2 +-
 drivers/spi/spi-rockchip.c     |  1 +
 include/linux/blk-cgroup.h     |  1 +
 include/linux/kthread-cgroup.h | 17 +++++++++++++++++
 include/linux/kthread.h        |  8 ++++++++
 init/main.c                    |  1 +
 kernel/kthread.c               | 13 +++++++++++++
 7 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kthread-cgroup.h

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bd447de4a5b8..2a07dfc9b3ae 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,7 +70,7 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread.h>
+#include <linux/kthread-cgroup.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..b56619418cea 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
+#include <linux/interrupt.h>
 
 #define DRIVER_NAME "rockchip-spi"
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 8bbc3716507a..a9454ad4de06 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -20,6 +20,7 @@
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
 #include <linux/atomic.h>
+#include <linux/kthread-cgroup.h>
 
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
diff --git a/include/linux/kthread-cgroup.h b/include/linux/kthread-cgroup.h
new file mode 100644
index 000000000000..53d34bca9d72
--- /dev/null
+++ b/include/linux/kthread-cgroup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KTHREAD_CGROUP_H
+#define _LINUX_KTHREAD_CGROUP_H
+#include <linux/kthread.h>
+#include <linux/cgroup.h>
+
+#ifdef CONFIG_BLK_CGROUP
+void kthread_associate_blkcg(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *kthread_blkcg(void);
+#else
+static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
+static inline struct cgroup_subsys_state *kthread_blkcg(void)
+{
+	return NULL;
+}
+#endif
+#endif
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4e663f407bd7..59b85b01fb8b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -199,4 +199,12 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+extern struct kthread_worker kthread_global_worker;
+void kthread_init_global_worker(void);
+
+static inline bool kthread_schedule_work(struct kthread_work *work)
+{
+	return kthread_queue_work(&kthread_global_worker, work);
+}
+
 #endif /* _LINUX_KTHREAD_H */
diff --git a/init/main.c b/init/main.c
index f32aebb5ce54..18c1297b2889 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1059,6 +1059,7 @@ static noinline void __init kernel_init_freeable(void)
 	smp_prepare_cpus(setup_max_cpus);
 
 	workqueue_init();
+	kthread_init_global_worker();
 
 	init_mm_internals();
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 430fd79cd3fe..44498522e5d5 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1161,3 +1161,16 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	kfree(worker);
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
+
+DEFINE_KTHREAD_WORKER(kthread_global_worker);
+EXPORT_SYMBOL(kthread_global_worker);
+
+__init void kthread_init_global_worker(void)
+{
+	kthread_global_worker.task = kthread_create(kthread_worker_fn,
+						    &kthread_global_worker,
+						    "kswork");
+	if (WARN_ON(IS_ERR(kthread_global_worker.task)))
+		return;
+	wake_up_process(kthread_global_worker.task);
+}
-- 
2.14.1

