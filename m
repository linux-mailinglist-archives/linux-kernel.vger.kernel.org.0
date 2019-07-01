Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067E3153A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfEFSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 14:30:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42246 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEFSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:30:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so6899726pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75ImqmVpanW8AKh7C/kPiDhvEBpTWl1hHz0h9oahWdQ=;
        b=jOTljehKIVus8IoCk4zjOIKvXA4Iu083yyGLr/wr8Q85XcBDv+41sy9cUBsBFsBi0K
         /ET0eL2OjJHV6JMTzGUnPOPBw6xj8b4pqb+U4ttdW5GLovyW3p/obSuuy77mXdjuCklR
         6b4A2cAyt6TpYEVknc5bGuMJ1YkZGhMUti1lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75ImqmVpanW8AKh7C/kPiDhvEBpTWl1hHz0h9oahWdQ=;
        b=SH5VceC68DXdXlQewZAoePu8Fv1yjenYuO9BKMUYIHPAQuayQdLzkQEPf35CQsOZ46
         NMsiTphH2DnUuNAauSMkKFQjQv0Vh9kmjEf77yusjgNTuAM56w7EYIeurbgSChYmFx/o
         /ODYrRxsHyR+8zPy9ubw9FOgoa/x/XqorJu+Yc2hYhZVObI78VEIL2UApF7qRAZ8nqpB
         3mmid7B2JXlxV9NVny5Q/ccgn8HMY5+TaYATE2trYsUNF+hBhLQKt0xLh9Z6p+yBmxAc
         mjE6dWpO+lYLIvCy2CzmoPiyjnF3QfhyV+ngjRuRVbGTndle5bM3kIwSyX4zqlw5C9c7
         Ja6Q==
X-Gm-Message-State: APjAAAWGj0WKvZxBkEOfUdcNXE1MEdE9PmTrrqijdiBd00CctawuFdeK
        pDDKOXd/5+Gav9EKcYYIesrijlczngg=
X-Google-Smtp-Source: APXvYqxMWTOAHjugYuVOigsWKSgA7rZBZkfNZ/VPfc8SAuWHM1L3BxZ3JoAB7ZjXo/Q0rTzygXIphQ==
X-Received: by 2002:a65:64ca:: with SMTP id t10mr34037891pgv.177.1557167425364;
        Mon, 06 May 2019 11:30:25 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o81sm18858033pfa.156.2019.05.06.11.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 11:30:24 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] loop: Better discard support for block devices
Date:   Mon,  6 May 2019 11:27:36 -0700
Message-Id: <20190506182736.21064-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506182736.21064-1-evgreen@chromium.org>
References: <20190506182736.21064-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the backing device for a loop device is a block device,
then mirror the "write zeroes" capabilities of the underlying
block device into the loop device. Copy this capability into both
max_write_zeroes_sectors and max_discard_sectors of the loop device.

The reason for this is that REQ_OP_DISCARD on a loop device translates
into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
presents a consistent interface for loop devices (that discarded data
is zeroed), regardless of the backing device type of the loop device.
There should be no behavior change for loop devices backed by regular
files.

While in there, differentiate between REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES, which are different for block devices,
but which the loop device had just been lumping together, since
they're largely the same for files.

This change fixes blktest block/003, and removes an extraneous
error print in block/013 when testing on a loop device backed
by a block device that does not support discard.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v5:
- Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)

Changes in v4:
- Mirror blkdev's write_zeroes into loopdev's discard_sectors.

Changes in v3:
- Updated commit description

Changes in v2: None

 drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bbf21ebeccd3..a147210ed009 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 	return ret;
 }
 
-static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
+static int lo_discard(struct loop_device *lo, struct request *rq,
+		int mode, loff_t pos)
 {
-	/*
-	 * We use punch hole to reclaim the free space used by the
-	 * image a.k.a. discard. However we do not support discard if
-	 * encryption is enabled, because it may give an attacker
-	 * useful information.
-	 */
 	struct file *file = lo->lo_backing_file;
-	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+	struct request_queue *q = lo->lo_queue;
 	int ret;
 
-	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
+	if (!blk_queue_discard(q)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
 	case REQ_OP_DISCARD:
+		return lo_discard(lo, rq,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
+
 	case REQ_OP_WRITE_ZEROES:
-		return lo_discard(lo, rq, pos);
+		return lo_discard(lo, rq,
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
+
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
@@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	struct request_queue *backingq;
+
+	/*
+	 * If the backing device is a block device, mirror its zeroing
+	 * capability. REQ_OP_DISCARD translates to a zero-out even when backed
+	 * by block devices to keep consistent behavior with file-backed loop
+	 * devices.
+	 */
+	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
+		backingq = bdev_get_queue(inode->i_bdev);
+		blk_queue_max_discard_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
+
+		blk_queue_max_write_zeroes_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -861,22 +876,24 @@ static void loop_config_discard(struct loop_device *lo)
 	 * encryption is enabled, because it may give an attacker
 	 * useful information.
 	 */
-	if ((!file->f_op->fallocate) ||
-	    lo->lo_encrypt_key_size) {
+	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
-		return;
-	}
 
-	q->limits.discard_granularity = inode->i_sb->s_blocksize;
-	q->limits.discard_alignment = 0;
+	} else {
+		q->limits.discard_granularity = inode->i_sb->s_blocksize;
+		q->limits.discard_alignment = 0;
+
+		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
+		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	}
 
-	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	if (q->limits.max_write_zeroes_sectors)
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)
-- 
2.20.1

