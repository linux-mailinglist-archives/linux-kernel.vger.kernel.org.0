Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82844F7E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfKKTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 14:01:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33696 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfKKSuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:50:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so11302177pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWH4ZBjmP1PLAL/11yQZ4HO6sSk47LP135Lp1gszF60=;
        b=Ltf7PulmhFtdy+4C35b3m8AnAibdIVdG9rTbvR7cbDuEbGdhOKRneKymSPq0DAbF2P
         maHgL/z8DJu2qQV0vvSm3XtBmBJrKI+eMcta7SlWYg/aqvN+Y9/y3NwvkGJeEBSmABe8
         rQiwgf1hFz93afRB9aodrG/W+hMaRkxPDy9is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWH4ZBjmP1PLAL/11yQZ4HO6sSk47LP135Lp1gszF60=;
        b=fVpA6r4aRWRiejtDRuzoagoodSq9tId1HC0gdORFXxV6cEfOX453Gb8J6Ye7kpGC/e
         neU3SZKoCPmpud6EyfCND9rcWJr3kf4Vr0SiIKeivvPvUNDpgzYBHINYCauW37v+o8KP
         rXF0p0W4uAazs9OaQ55gk7aeoN4OSKnaBnfIs7Wj7jgf1wP3NPTme2mkoL89S2pXwMqO
         Y3XxFWUVDA/HqInsd5/+GujPZ6X04fiyXO61rd3YTbgOF9PJ+/luPsrjphvmwHxADbFq
         LgToDda1TI06/lEdCnanWQoNcTYKA8MfJDsErE06XD7iv44UanXu/Zej8Dhmbfmlblj/
         RKlA==
X-Gm-Message-State: APjAAAVYjTyEho6iA9pUwTmsF1M9SO7mvOlnr6CpeUYAM1+LU5+49/ik
        HQDiHgr4M9bcqFeRNlXUEnQDnA==
X-Google-Smtp-Source: APXvYqxtRavfXUUC2pTJnOwgb19bdqqa3Gl+jyiZglHZKNr8qmKJMQreuU4dtR7TNV2atvAU1AlW/w==
X-Received: by 2002:a62:1c8:: with SMTP id 191mr31885384pfb.152.1573498250075;
        Mon, 11 Nov 2019 10:50:50 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v63sm15220971pfb.181.2019.11.11.10.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Nov 2019 10:50:49 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Evan Green <evgreen@chromium.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] loop: Better discard support for block devices
Date:   Mon, 11 Nov 2019 10:50:30 -0800
Message-Id: <20191111185030.215451-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111185030.215451-1-evgreen@chromium.org>
References: <20191111185030.215451-1-evgreen@chromium.org>
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
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

Changes in v6: None
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
index d749156a3d88..236f6deb0772 100644
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
2.21.0

