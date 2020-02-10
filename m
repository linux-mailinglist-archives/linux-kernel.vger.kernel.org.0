Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F441571C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 04:34:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:59490 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbgBJJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:34:12 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j15Rx-0000Jj-9e; Mon, 10 Feb 2020 12:33:53 +0300
Subject: [PATCH v6 4/6] block: Add support for REQ_ALLOCATE flag
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Mon, 10 Feb 2020 12:33:53 +0300
Message-ID: <158132723311.239613.5269033996109738831.stgit@localhost.localdomain>
In-Reply-To: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for REQ_ALLOCATE extension of REQ_OP_WRITE_ZEROES
operation, which encourages a block device driver to just allocate
blocks (or mark them allocated) instead of actual blocks zeroing.
REQ_ALLOCATE is aimed to be used for network filesystems providing
a block device interface. Also, block devices, which map a file
on other filesystem (like loop), may use this for less fragmentation
and batching fallocate() requests. Hypervisors like QEMU may
introduce optimizations of clusters allocations based on this.

BLKDEV_ZERO_ALLOCATE is a new corresponding flag for
blkdev_issue_zeroout().

Stacking devices start from zero max_allocate_sectors limit for now,
and the support is going to be implemented separate for each device
in the future.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/blk-lib.c           |   17 ++++++++++-------
 block/blk-settings.c      |    4 ++++
 fs/block_dev.c            |    4 ++++
 include/linux/blk_types.h |    5 ++++-
 include/linux/blkdev.h    |   13 ++++++++++---
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3e38c93cfc53..9cd6f86523ba 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -214,7 +214,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		struct bio **biop, unsigned flags)
 {
 	struct bio *bio = *biop;
-	unsigned int max_write_zeroes_sectors;
+	unsigned int max_write_zeroes_sectors, req_flags = 0;
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	if (!q)
@@ -224,18 +224,21 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		return -EPERM;
 
 	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
-	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, 0);
+	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, flags);
 
 	if (max_write_zeroes_sectors == 0)
 		return -EOPNOTSUPP;
 
+	if (flags & BLKDEV_ZERO_NOUNMAP)
+		req_flags |= REQ_NOUNMAP;
+	if (flags & BLKDEV_ZERO_ALLOCATE)
+		req_flags |= REQ_ALLOCATE|REQ_NOUNMAP;
+
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
-		bio->bi_opf = REQ_OP_WRITE_ZEROES;
-		if (flags & BLKDEV_ZERO_NOUNMAP)
-			bio->bi_opf |= REQ_NOUNMAP;
+		bio->bi_opf = REQ_OP_WRITE_ZEROES | req_flags;
 
 		if (nr_sects > max_write_zeroes_sectors) {
 			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
@@ -362,7 +365,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	sector_t bs_mask;
 	struct bio *bio;
 	struct blk_plug plug;
-	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, 0);
+	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, flags);
 
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
@@ -391,7 +394,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			try_write_zeroes = false;
 			goto retry;
 		}
-		if (!bdev_write_zeroes_sectors(bdev, 0)) {
+		if (!bdev_write_zeroes_sectors(bdev, flags)) {
 			/*
 			 * Zeroing offload support was indicated, but the
 			 * device reported ILLEGAL REQUEST (for some devices
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..8d5df9d37239 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_allocate_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->discard_granularity = 0;
@@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_allocate_sectors = 0;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -506,6 +508,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_allocate_sectors = min(t->max_allocate_sectors,
+					b->max_allocate_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..1ffef894b3bd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2122,6 +2122,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
+	case FALLOC_FL_KEEP_SIZE:
+		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
+			GFP_KERNEL, BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
+		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..86accd2caa4e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -335,7 +335,9 @@ enum req_flag_bits {
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
-
+	__REQ_ALLOCATE,		/* only notify about allocated blocks,
+				 * and do not actually zero them
+				 */
 	__REQ_HIPRI,
 
 	/* for driver use */
@@ -362,6 +364,7 @@ enum req_flag_bits {
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
+#define REQ_ALLOCATE		(1ULL << __REQ_ALLOCATE)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 55a714161684..40707f980a2e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_allocate_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -990,6 +991,8 @@ static inline struct bio_vec req_bvec(struct request *rq)
 static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
 		struct request_queue *q, unsigned int op_flags)
 {
+	if (op_flags & REQ_ALLOCATE)
+		return q->limits.max_allocate_sectors;
 	return q->limits.max_write_zeroes_sectors;
 }
 
@@ -1226,6 +1229,7 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
+#define BLKDEV_ZERO_ALLOCATE	(1 << 2)  /* allocate range of blocks */
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
@@ -1430,10 +1434,13 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return q->limits.max_write_zeroes_sectors;
+	if (!q)
+		return 0;
 
-	return 0;
+	if (flags & BLKDEV_ZERO_ALLOCATE)
+		return q->limits.max_allocate_sectors;
+	else
+		return q->limits.max_write_zeroes_sectors;
 }
 
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)


