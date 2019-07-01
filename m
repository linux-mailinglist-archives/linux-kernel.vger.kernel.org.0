Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A08371A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfFFK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 06:26:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfFFK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YysQtsiHp3GQiMLWL+ZAbOoDyfj/frTo6TaVBn3dezM=; b=o6mcBdTFiW502Dczi7lClv9XTl
        BszpMGAx15pQBMk9IUajJmwEi34qmLy0LWe9qkVnhZHE72YzWVC6yj1fU3h9HSLr3MoujsKWey5yQ
        XeYzhf+yQ9ayD58MW6aKTxNlx+7Vua285ygaI/cxyxoKUw5Q9WKjJuuZDG1FQqoPyJz7DOzI0WtQn
        eKt2F2wbfHSlMK2i6kIz1E1sjfbYI0QYx49yMWilIhriiCHPWucaL2dkXYuTtaQ1Qco/eteNHYDCx
        QrEEbyA/nSUvmnE/bGSKawpw/lPClVQVIjFwfBLgILibdXrro9JGaTgSQzeJCwAFHNRLogW9APjBN
        T7bjUCXw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbZ-0007ih-NM; Thu, 06 Jun 2019 10:26:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] block: rename CONFIG_DEBUG_BLK_CGROUP to CONFIG_BFQ_CGROUP_DEBUG
Date:   Thu,  6 Jun 2019 12:26:24 +0200
Message-Id: <20190606102624.3847-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is entirely bfq specific, give it an appropinquate name.

Also make it depend on CONFIG_BFQ_GROUP_IOSCHED in Kconfig, as all
the functionality already does so anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/bfq-iosched.txt          | 12 ++++-----
 Documentation/cgroup-v1/blkio-controller.txt | 12 ++++-----
 block/Kconfig.iosched                        |  7 +++++
 block/bfq-cgroup.c                           | 27 ++++++++++----------
 block/bfq-iosched.c                          |  8 +++---
 block/bfq-iosched.h                          |  4 +--
 init/Kconfig                                 |  8 ------
 7 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 1a0f2ac02eb6..f02163fabf80 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -38,13 +38,13 @@ stack). To give an idea of the limits with BFQ, on slow or average
 CPUs, here are, first, the limits of BFQ for three different CPUs, on,
 respectively, an average laptop, an old desktop, and a cheap embedded
 system, in case full hierarchical support is enabled (i.e.,
-CONFIG_BFQ_GROUP_IOSCHED is set), but CONFIG_DEBUG_BLK_CGROUP is not
+CONFIG_BFQ_GROUP_IOSCHED is set), but CONFIG_BFQ_CGROUP_DEBUG is not
 set (Section 4-2):
 - Intel i7-4850HQ: 400 KIOPS
 - AMD A8-3850: 250 KIOPS
 - ARM CortexTM-A53 Octa-core: 80 KIOPS
 
-If CONFIG_DEBUG_BLK_CGROUP is set (and of course full hierarchical
+If CONFIG_BFQ_CGROUP_DEBUG is set (and of course full hierarchical
 support is enabled), then the sustainable throughput with BFQ
 decreases, because all blkio.bfq* statistics are created and updated
 (Section 4-2). For BFQ, this leads to the following maximum
@@ -537,19 +537,19 @@ or io.bfq.weight.
 
 As for cgroups-v1 (blkio controller), the exact set of stat files
 created, and kept up-to-date by bfq, depends on whether
-CONFIG_DEBUG_BLK_CGROUP is set. If it is set, then bfq creates all
+CONFIG_BFQ_CGROUP_DEBUG is set. If it is set, then bfq creates all
 the stat files documented in
 Documentation/cgroup-v1/blkio-controller.txt. If, instead,
-CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files
+CONFIG_BFQ_CGROUP_DEBUG is not set, then bfq creates only the files
 blkio.bfq.io_service_bytes
 blkio.bfq.io_service_bytes_recursive
 blkio.bfq.io_serviced
 blkio.bfq.io_serviced_recursive
 
-The value of CONFIG_DEBUG_BLK_CGROUP greatly influences the maximum
+The value of CONFIG_BFQ_CGROUP_DEBUG greatly influences the maximum
 throughput sustainable with bfq, because updating the blkio.bfq.*
 stats is rather costly, especially for some of the stats enabled by
-CONFIG_DEBUG_BLK_CGROUP.
+CONFIG_BFQ_CGROUP_DEBUG.
 
 Parameters to set
 -----------------
diff --git a/Documentation/cgroup-v1/blkio-controller.txt b/Documentation/cgroup-v1/blkio-controller.txt
index 673dc34d3f78..47cf84102f88 100644
--- a/Documentation/cgroup-v1/blkio-controller.txt
+++ b/Documentation/cgroup-v1/blkio-controller.txt
@@ -126,7 +126,7 @@ Various user visible config options
 CONFIG_BLK_CGROUP
 	- Block IO controller.
 
-CONFIG_DEBUG_BLK_CGROUP
+CONFIG_BFQ_CGROUP_DEBUG
 	- Debug help. Right now some additional stats file show up in cgroup
 	  if this option is enabled.
 
@@ -246,13 +246,13 @@ Proportional weight policy files
 	  write, sync or async.
 
 - blkio.avg_queue_size
-	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=y.
+	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  The average queue size for this cgroup over the entire time of this
 	  cgroup's existence. Queue size samples are taken each time one of the
 	  queues of this cgroup gets a timeslice.
 
 - blkio.group_wait_time
-	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=y.
+	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  This is the amount of time the cgroup had to wait since it became busy
 	  (i.e., went from 0 to 1 request queued) to get a timeslice for one of
 	  its queues. This is different from the io_wait_time which is the
@@ -263,7 +263,7 @@ Proportional weight policy files
 	  got a timeslice and will not include the current delta.
 
 - blkio.empty_time
-	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=y.
+	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  This is the amount of time a cgroup spends without any pending
 	  requests when not being served, i.e., it does not include any time
 	  spent idling for one of the queues of the cgroup. This is in
@@ -272,7 +272,7 @@ Proportional weight policy files
 	  time it had a pending request and will not include the current delta.
 
 - blkio.idle_time
-	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=y.
+	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y.
 	  This is the amount of time spent by the IO scheduler idling for a
 	  given cgroup in anticipation of a better request than the existing ones
 	  from other queues/cgroups. This is in nanoseconds. If this is read
@@ -281,7 +281,7 @@ Proportional weight policy files
 	  the current delta.
 
 - blkio.dequeue
-	- Debugging aid only enabled if CONFIG_DEBUG_BLK_CGROUP=y. This
+	- Debugging aid only enabled if CONFIG_BFQ_CGROUP_DEBUG=y. This
 	  gives the statistics about how many a times a group was dequeued
 	  from service tree of the device. First two fields specify the major
 	  and minor number of the device and third field specifies the number
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 4626b88b2d5a..7a6b2f29a582 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -36,6 +36,13 @@ config BFQ_GROUP_IOSCHED
        Enable hierarchical scheduling in BFQ, using the blkio
        (cgroups-v1) or io (cgroups-v2) controller.
 
+config BFQ_CGROUP_DEBUG
+	bool "BFQ IO controller debugging"
+	depends on BFQ_GROUP_IOSCHED
+	---help---
+	Enable some debugging help. Currently it exports additional stat
+	files in a cgroup which can be useful for debugging.
+
 endmenu
 
 endif
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index d84302445e30..0f6cd688924f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -15,8 +15,7 @@
 
 #include "bfq-iosched.h"
 
-#if defined(CONFIG_BFQ_GROUP_IOSCHED) &&  defined(CONFIG_DEBUG_BLK_CGROUP)
-
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 static int bfq_stat_init(struct bfq_stat *stat, gfp_t gfp)
 {
 	int ret;
@@ -253,7 +252,7 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 				io_start_time_ns - start_time_ns);
 }
 
-#else /* CONFIG_BFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
+#else /* CONFIG_BFQ_CGROUP_DEBUG */
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 			      unsigned int op) { }
@@ -267,7 +266,7 @@ void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
 void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
 void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
 
-#endif /* CONFIG_BFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
+#endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 
@@ -351,7 +350,7 @@ void bfqg_and_blkg_put(struct bfq_group *bfqg)
 /* @stats = 0 */
 static void bfqg_stats_reset(struct bfqg_stats *stats)
 {
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	/* queued stats shouldn't be cleared */
 	blkg_rwstat_reset(&stats->merged);
 	blkg_rwstat_reset(&stats->service_time);
@@ -372,7 +371,7 @@ static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
 	if (!to || !from)
 		return;
 
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	/* queued stats shouldn't be cleared */
 	blkg_rwstat_add_aux(&to->merged, &from->merged);
 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
@@ -432,7 +431,7 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 
 static void bfqg_stats_exit(struct bfqg_stats *stats)
 {
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	blkg_rwstat_exit(&stats->merged);
 	blkg_rwstat_exit(&stats->service_time);
 	blkg_rwstat_exit(&stats->wait_time);
@@ -449,7 +448,7 @@ static void bfqg_stats_exit(struct bfqg_stats *stats)
 
 static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
 {
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	if (blkg_rwstat_init(&stats->merged, gfp) ||
 	    blkg_rwstat_init(&stats->service_time, gfp) ||
 	    blkg_rwstat_init(&stats->wait_time, gfp) ||
@@ -986,7 +985,7 @@ static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 static int bfqg_print_stat(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
@@ -1109,7 +1108,7 @@ static int bfqg_print_avg_queue_size(struct seq_file *sf, void *v)
 			  0, false);
 	return 0;
 }
-#endif /* CONFIG_DEBUG_BLK_CGROUP */
+#endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
@@ -1157,7 +1156,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_ios,
 	},
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
 		.name = "bfq.time",
 		.private = offsetof(struct bfq_group, stats.time),
@@ -1187,7 +1186,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show = bfqg_print_rwstat,
 	},
-#endif /* CONFIG_DEBUG_BLK_CGROUP */
+#endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 	/* the same statistics which cover the bfqg and its descendants */
 	{
@@ -1200,7 +1199,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_ios_recursive,
 	},
-#ifdef CONFIG_DEBUG_BLK_CGROUP
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
 		.name = "bfq.time_recursive",
 		.private = offsetof(struct bfq_group, stats.time),
@@ -1254,7 +1253,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 		.private = offsetof(struct bfq_group, stats.dequeue),
 		.seq_show = bfqg_print_stat,
 	},
-#endif	/* CONFIG_DEBUG_BLK_CGROUP */
+#endif	/* CONFIG_BFQ_CGROUP_DEBUG */
 	{ }	/* terminate */
 };
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f8d430f88d25..e9a587707d67 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4403,7 +4403,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 static void bfq_update_dispatch_stats(struct request_queue *q,
 				      struct request *rq,
 				      struct bfq_queue *in_serv_queue,
@@ -4453,7 +4453,7 @@ static inline void bfq_update_dispatch_stats(struct request_queue *q,
 					     struct request *rq,
 					     struct bfq_queue *in_serv_queue,
 					     bool idle_timer_disabled) {}
-#endif
+#endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
@@ -5007,7 +5007,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	return idle_timer_disabled;
 }
 
-#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 static void bfq_update_insert_stats(struct request_queue *q,
 				    struct bfq_queue *bfqq,
 				    bool idle_timer_disabled,
@@ -5037,7 +5037,7 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 					   struct bfq_queue *bfqq,
 					   bool idle_timer_disabled,
 					   unsigned int cmd_flags) {}
-#endif
+#endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			       bool at_head)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index aef4fa0046b8..584d3c9ed8ba 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -783,7 +783,7 @@ struct bfq_stat {
 };
 
 struct bfqg_stats {
-#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
 	/* number of ios merged */
 	struct blkg_rwstat		merged;
 	/* total time spent on device in ns, may not be accurate w/ queueing */
@@ -811,7 +811,7 @@ struct bfqg_stats {
 	u64				start_idle_time;
 	u64				start_empty_time;
 	uint16_t			flags;
-#endif	/* CONFIG_BFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
+#endif /* CONFIG_BFQ_CGROUP_DEBUG */
 };
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/init/Kconfig b/init/Kconfig
index 36894c9fb420..df9d36ba80e3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -800,14 +800,6 @@ config BLK_CGROUP
 
 	See Documentation/cgroup-v1/blkio-controller.txt for more information.
 
-config DEBUG_BLK_CGROUP
-	bool "IO controller debugging"
-	depends on BLK_CGROUP
-	default n
-	---help---
-	Enable some debugging help. Currently it exports additional stat
-	files in a cgroup which can be useful for debugging.
-
 config CGROUP_WRITEBACK
 	bool
 	depends on MEMCG && BLK_CGROUP
-- 
2.20.1

