Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB59B163
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405730AbfHWNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 09:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390343AbfHWNzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:55:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94DE1300157A;
        Fri, 23 Aug 2019 13:55:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B36DF19C77;
        Fri, 23 Aug 2019 13:55:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x7NDtQpQ002147;
        Fri, 23 Aug 2019 09:55:26 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x7NDtQo9002143;
        Fri, 23 Aug 2019 09:55:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 23 Aug 2019 09:55:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Zhang Tao <kontais@zoho.com>
cc:     agk@redhat.com, snitzer@redhat.com,
        Zhang Tao <zhangtao27@lenovo.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dm: make dm_table_find_target return NULL
In-Reply-To: <alpine.LRH.2.02.1908230705510.5296@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.1908230954190.22174@file01.intranet.prod.int.rdu2.redhat.com>
References: <1566351211-13280-1-git-send-email-kontais@zoho.com> <alpine.LRH.2.02.1908230705510.5296@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 23 Aug 2019 13:55:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if we pass too high sector number to dm_table_find_target, it
returns zeroed dm_target structure and callers test if the structure is
zeroed with the macro dm_target_is_valid.

However, returning NULL is common practice to indicate errors.

This patch refactors the dm code, so that dm_table_find_target returns
NULL and its callers test the returned value for NULL. The macro
dm_target_is_valid is deleted. In alloc_targets, we no longer allocate an
extra zeroed target.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-ioctl.c |    2 +-
 drivers/md/dm-table.c |    8 +++-----
 drivers/md/dm.c       |    8 ++++----
 drivers/md/dm.h       |    5 -----
 4 files changed, 8 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/md/dm.c
===================================================================
--- linux-2.6.orig/drivers/md/dm.c	2019-08-23 15:45:46.000000000 +0200
+++ linux-2.6/drivers/md/dm.c	2019-08-23 15:45:46.000000000 +0200
@@ -457,7 +457,7 @@ static int dm_blk_report_zones(struct ge
 		return -EIO;
 
 	tgt = dm_table_find_target(map, sector);
-	if (!dm_target_is_valid(tgt)) {
+	if (!tgt) {
 		ret = -EIO;
 		goto out;
 	}
@@ -1072,7 +1072,7 @@ static struct dm_target *dm_dax_get_live
 		return NULL;
 
 	ti = dm_table_find_target(map, sector);
-	if (!dm_target_is_valid(ti))
+	if (!ti)
 		return NULL;
 
 	return ti;
@@ -1572,7 +1572,7 @@ static int __split_and_process_non_flush
 	int r;
 
 	ti = dm_table_find_target(ci->map, ci->sector);
-	if (!dm_target_is_valid(ti))
+	if (!ti)
 		return -EIO;
 
 	if (__process_abnormal_io(ci, ti, &r))
@@ -1748,7 +1748,7 @@ static blk_qc_t dm_process_bio(struct ma
 
 	if (!ti) {
 		ti = dm_table_find_target(map, bio->bi_iter.bi_sector);
-		if (unlikely(!ti || !dm_target_is_valid(ti))) {
+		if (unlikely(!ti)) {
 			bio_io_error(bio);
 			return ret;
 		}
Index: linux-2.6/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-ioctl.c	2019-08-23 15:45:46.000000000 +0200
+++ linux-2.6/drivers/md/dm-ioctl.c	2019-08-23 15:45:46.000000000 +0200
@@ -1592,7 +1592,7 @@ static int target_message(struct file *f
 	}
 
 	ti = dm_table_find_target(table, tmsg->sector);
-	if (!dm_target_is_valid(ti)) {
+	if (!ti) {
 		DMWARN("Target message sector outside device.");
 		r = -EINVAL;
 	} else if (ti->type->message)
Index: linux-2.6/drivers/md/dm-table.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-table.c	2019-08-23 15:45:46.000000000 +0200
+++ linux-2.6/drivers/md/dm-table.c	2019-08-23 15:47:18.000000000 +0200
@@ -163,10 +163,8 @@ static int alloc_targets(struct dm_table
 
 	/*
 	 * Allocate both the target array and offset array at once.
-	 * Append an empty entry to catch sectors beyond the end of
-	 * the device.
 	 */
-	n_highs = (sector_t *) dm_vcalloc(num + 1, sizeof(struct dm_target) +
+	n_highs = (sector_t *) dm_vcalloc(num, sizeof(struct dm_target) +
 					  sizeof(sector_t));
 	if (!n_highs)
 		return -ENOMEM;
@@ -1359,7 +1357,7 @@ struct dm_target *dm_table_get_target(st
 /*
  * Search the btree for the correct target.
  *
- * Caller should check returned pointer with dm_target_is_valid()
+ * Caller should check returned pointer for NULL
  * to trap I/O beyond end of device.
  */
 struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
@@ -1368,7 +1366,7 @@ struct dm_target *dm_table_find_target(s
 	sector_t *node;
 
 	if (unlikely(sector >= dm_table_get_size(t)))
-		return &t->targets[t->num_targets];
+		return NULL;
 
 	for (l = 0; l < t->depth; l++) {
 		n = get_child(n, k);
Index: linux-2.6/drivers/md/dm.h
===================================================================
--- linux-2.6.orig/drivers/md/dm.h	2019-08-23 15:45:46.000000000 +0200
+++ linux-2.6/drivers/md/dm.h	2019-08-23 15:45:46.000000000 +0200
@@ -86,11 +86,6 @@ struct target_type *dm_get_immutable_tar
 int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
 
 /*
- * To check the return value from dm_table_find_target().
- */
-#define dm_target_is_valid(t) ((t)->table)
-
-/*
  * To check whether the target type is bio-based or not (request-based).
  */
 #define dm_target_bio_based(t) ((t)->type->map != NULL)

