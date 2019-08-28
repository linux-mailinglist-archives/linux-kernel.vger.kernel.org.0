Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151409FE58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfH1JVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:21:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfH1JVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:21:46 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3658594782EB051B2335;
        Wed, 28 Aug 2019 17:21:42 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 17:21:32 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yang Guo <guoyang2@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH v2] ext4: use percpu_counters for extent_status cache hits/misses
Date:   Wed, 28 Aug 2019 17:19:17 +0800
Message-ID: <1566983957-6608-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guo <guoyang2@huawei.com>

@es_stats_cache_hits and @es_stats_cache_misses are accessed frequently in
ext4_es_lookup_extent function, it would influence the ext4 read/write
performance in NUMA system. Let's optimize it using percpu_counter,
it is profitable for the performance.

The test command is as below:
fio -name=randwrite -numjobs=8 -filename=/mnt/test1 -rw=randwrite
-ioengine=libaio -direct=1 -iodepth=64 -sync=0 -norandommap
-group_reporting -runtime=120 -time_based -bs=4k -size=5G

And the result is better 10% than the initial implement:
without the patch，IOPS=197k, BW=770MiB/s (808MB/s)(90.3GiB/120002msec)
with the patch,  IOPS=218k, BW=852MiB/s (894MB/s)(99.9GiB/120002msec)

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Yang Guo <guoyang2@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
ChangeLog:
    Fix the issue that there is no percpu_counter_destroy() for the new
 percpu counters.

 fs/ext4/extents_status.c | 37 ++++++++++++++++++++++++-------------
 fs/ext4/extents_status.h |  4 ++--
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7521de2dcf3a..3c03062a8d6a 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -947,9 +947,9 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 		es->es_pblk = es1->es_pblk;
 		if (!ext4_es_is_referenced(es1))
 			ext4_es_set_referenced(es1);
-		stats->es_stats_cache_hits++;
+		percpu_counter_inc(&stats->es_stats_cache_hits);
 	} else {
-		stats->es_stats_cache_misses++;
+		percpu_counter_inc(&stats->es_stats_cache_misses);
 	}
 
 	read_unlock(&EXT4_I(inode)->i_es_lock);
@@ -1235,9 +1235,9 @@ int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "stats:\n  %lld objects\n  %lld reclaimable objects\n",
 		   percpu_counter_sum_positive(&es_stats->es_stats_all_cnt),
 		   percpu_counter_sum_positive(&es_stats->es_stats_shk_cnt));
-	seq_printf(seq, "  %lu/%lu cache hits/misses\n",
-		   es_stats->es_stats_cache_hits,
-		   es_stats->es_stats_cache_misses);
+	seq_printf(seq, "  %lld/%lld cache hits/misses\n",
+		   percpu_counter_sum_positive(&es_stats->es_stats_cache_hits),
+		   percpu_counter_sum_positive(&es_stats->es_stats_cache_misses));
 	if (inode_cnt)
 		seq_printf(seq, "  %d inodes on list\n", inode_cnt);
 
@@ -1264,35 +1264,46 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 	sbi->s_es_nr_inode = 0;
 	spin_lock_init(&sbi->s_es_lock);
 	sbi->s_es_stats.es_stats_shrunk = 0;
-	sbi->s_es_stats.es_stats_cache_hits = 0;
-	sbi->s_es_stats.es_stats_cache_misses = 0;
+	err = percpu_counter_init(&sbi->s_es_stats.es_stats_cache_hits, 0,
+				  GFP_KERNEL);
+	if (err)
+		return err;
+	err = percpu_counter_init(&sbi->s_es_stats.es_stats_cache_misses, 0,
+				  GFP_KERNEL);
+	if (err)
+		goto err1;
 	sbi->s_es_stats.es_stats_scan_time = 0;
 	sbi->s_es_stats.es_stats_max_scan_time = 0;
 	err = percpu_counter_init(&sbi->s_es_stats.es_stats_all_cnt, 0, GFP_KERNEL);
 	if (err)
-		return err;
+		goto err2;
 	err = percpu_counter_init(&sbi->s_es_stats.es_stats_shk_cnt, 0, GFP_KERNEL);
 	if (err)
-		goto err1;
+		goto err3;
 
 	sbi->s_es_shrinker.scan_objects = ext4_es_scan;
 	sbi->s_es_shrinker.count_objects = ext4_es_count;
 	sbi->s_es_shrinker.seeks = DEFAULT_SEEKS;
 	err = register_shrinker(&sbi->s_es_shrinker);
 	if (err)
-		goto err2;
+		goto err4;
 
 	return 0;
-
-err2:
+err4:
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
-err1:
+err3:
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
+err2:
+	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
+err1:
+	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_hits);
 	return err;
 }
 
 void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi)
 {
+	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_hits);
+	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
 	unregister_shrinker(&sbi->s_es_shrinker);
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 131a8b7df265..e722dd9bd06e 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -70,8 +70,8 @@ struct ext4_es_tree {
 
 struct ext4_es_stats {
 	unsigned long es_stats_shrunk;
-	unsigned long es_stats_cache_hits;
-	unsigned long es_stats_cache_misses;
+	struct percpu_counter es_stats_cache_hits;
+	struct percpu_counter es_stats_cache_misses;
 	u64 es_stats_scan_time;
 	u64 es_stats_max_scan_time;
 	struct percpu_counter es_stats_all_cnt;
-- 
2.7.4

