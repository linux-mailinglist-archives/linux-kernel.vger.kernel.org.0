Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E87143ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 11:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgAUKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 05:19:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:56346 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgAUKTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:19:31 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itqcx-00069i-HK; Tue, 21 Jan 2020 13:19:19 +0300
Subject: [PATCH v3 7/7] loop: Add support for REQ_ALLOCATE
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com, ktkhai@virtuozzo.com
Date:   Tue, 21 Jan 2020 13:19:19 +0300
Message-ID: <157960195926.97730.10381261823009436482.stgit@localhost.localdomain>
In-Reply-To: <157960153921.97730.9973412459876396302.stgit@localhost.localdomain>
References: <157960153921.97730.9973412459876396302.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for new modifier of REQ_OP_WRITE_ZEROES command.
This results in allocation extents in backing file instead
of actual blocks zeroing.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/block/loop.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..bfe76d9adf09 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -581,6 +581,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return 0;
 }
 
+static unsigned int write_zeroes_to_fallocate_mode(unsigned int flags)
+{
+	if (flags & REQ_ALLOCATE)
+		return 0;
+	if (flags & REQ_NOUNMAP)
+		return FALLOC_FL_ZERO_RANGE;
+	return FALLOC_FL_PUNCH_HOLE;
+}
+
 static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
@@ -604,9 +613,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		 * write zeroes the range.  Otherwise, punch them out.
 		 */
 		return lo_fallocate(lo, rq, pos,
-			(rq->cmd_flags & REQ_NOUNMAP) ?
-				FALLOC_FL_ZERO_RANGE :
-				FALLOC_FL_PUNCH_HOLE);
+			write_zeroes_to_fallocate_mode(rq->cmd_flags));
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
@@ -877,6 +884,7 @@ static void loop_config_discard(struct loop_device *lo)
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
+		blk_queue_max_allocate_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 		return;
 	}
@@ -886,6 +894,7 @@ static void loop_config_discard(struct loop_device *lo)
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
 	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	blk_queue_max_allocate_sectors(q, UINT_MAX >> 9);
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 


