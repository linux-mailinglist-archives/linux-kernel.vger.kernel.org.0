Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B669118950C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 05:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCREpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 00:45:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60377 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbgCREpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 00:45:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584506708; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0eFB1VlZc93rqDDQYQs0Ze91zTgTIOMxR3L9uNrGImk=; b=ST6aOXwGKUcnxqF6WhQWJdyBmJD6t66gGBZz4xFVZpcNM3UGvh+5433Q6NsgfSR4posCT71H
 MVZ/smMdmQUkq/khneJKWSJ83R1VFT+UXBKxmgi2DdZLxkSJ8B4Ng7p6UalIvPcF6e5EBGVw
 D/3WCWlUz3co+zoUsZv6jBL67lE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e71a750.7fedda7507a0-smtp-out-n02;
 Wed, 18 Mar 2020 04:45:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C193C433BA; Wed, 18 Mar 2020 04:45:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 328DEC433D2;
        Wed, 18 Mar 2020 04:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 328DEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix long latency due to discard during umount
Date:   Wed, 18 Mar 2020 10:14:49 +0530
Message-Id: <1584506689-5041-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS already has a default timeout of 5 secs for discards that
can be issued during umount, but it can take more than the 5 sec
timeout if the underlying UFS device queue is already full and there
are no more available free tags to be used. In that case, submit_bio()
will wait for the already queued discard requests to complete to get
a free tag, which can potentially take way more than 5 sec.

Fix this by submitting the discard requests with REQ_NOWAIT
flags during umount. This will return -EAGAIN for UFS queue/tag full
scenario without waiting in the context of submit_bio(). The FS can
then handle these requests by retrying again within the stipulated
discard timeout period to avoid long latencies.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- Handle the case where a dc can have multiple bios associated with it

 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12a197e..67b8dcc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -340,6 +340,7 @@ struct discard_cmd_control {
 	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
 	struct list_head wait_list;		/* store on-flushing entries */
 	struct list_head fstrim_list;		/* in-flight discard from fstrim */
+	struct list_head retry_list;		/* list of cmds to retry */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	unsigned int discard_wake;		/* to wake up discard thread */
 	struct mutex cmd_lock;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fb3e531..4162c76 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1029,13 +1029,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
 	unsigned long flags;
 
-	dc->error = blk_status_to_errno(bio->bi_status);
-
 	spin_lock_irqsave(&dc->lock, flags);
+	if (!dc->error)
+		dc->error = blk_status_to_errno(bio->bi_status);
+
 	dc->bio_ref--;
-	if (!dc->bio_ref && dc->state == D_SUBMIT) {
-		dc->state = D_DONE;
-		complete_all(&dc->wait);
+	if (!dc->bio_ref) {
+		if (dc->error || dc->state == D_SUBMIT) {
+			dc->state = D_DONE;
+			complete_all(&dc->wait);
+		}
 	}
 	spin_unlock_irqrestore(&dc->lock, flags);
 	bio_put(bio);
@@ -1124,10 +1127,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	int flag = dpolicy->sync ? REQ_SYNC : 0;
-	block_t lstart, start, len, total_len;
+	int flag;
+	block_t lstart, start, len, total_len, orig_len;
 	int err = 0;
 
+	flag = dpolicy->sync ? REQ_SYNC : 0;
+	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
+
 	if (dc->state != D_PREP)
 		return 0;
 
@@ -1139,7 +1145,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	lstart = dc->lstart;
 	start = dc->start;
 	len = dc->len;
-	total_len = len;
+	orig_len = total_len = len;
 
 	dc->len = 0;
 
@@ -1203,6 +1209,14 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		bio->bi_end_io = f2fs_submit_discard_endio;
 		bio->bi_opf |= flag;
 		submit_bio(bio);
+		if (flag & REQ_NOWAIT) {
+			if (dc->error == -EAGAIN) {
+				dc->len = orig_len;
+				list_move(&dc->list, &dcc->retry_list);
+				err = dc->error;
+				break;
+			}
+		}
 
 		atomic_inc(&dcc->issued_discard);
 
@@ -1463,6 +1477,40 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 	return issued;
 }
 
+static bool __should_discard_retry(struct f2fs_sb_info *sbi,
+		struct discard_policy *dpolicy)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *dc, *tmp;
+	bool retry = false;
+	unsigned long flags;
+
+	if (dpolicy->type != DPOLICY_UMOUNT)
+		f2fs_bug_on(sbi, 1);
+
+	mutex_lock(&dcc->cmd_lock);
+	list_for_each_entry_safe(dc, tmp, &(dcc->retry_list), list) {
+		if (dpolicy->timeout != 0 &&
+			f2fs_time_over(sbi, dpolicy->timeout)) {
+			retry = false;
+			break;
+		}
+
+		spin_lock_irqsave(&dc->lock, flags);
+		if (!dc->bio_ref) {
+			dc->state = D_PREP;
+			dc->error = 0;
+			reinit_completion(&dc->wait);
+			__relocate_discard_cmd(dcc, dc);
+			retry = true;
+		}
+		spin_unlock_irqrestore(&dc->lock, flags);
+	}
+	mutex_unlock(&dcc->cmd_lock);
+
+	return retry;
+}
+
 static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy)
 {
@@ -1470,12 +1518,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int i, issued = 0;
+	int i, err, issued = 0;
 	bool io_interrupted = false;
 
 	if (dpolicy->timeout != 0)
 		f2fs_update_time(sbi, dpolicy->timeout);
 
+retry:
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (dpolicy->timeout != 0 &&
 				f2fs_time_over(sbi, dpolicy->timeout))
@@ -1509,7 +1558,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				break;
 			}
 
-			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
+			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
+			if (err == -EAGAIN)
+				congestion_wait(BLK_RW_ASYNC,
+						DEFAULT_IO_TIMEOUT);
 
 			if (issued >= dpolicy->max_requests)
 				break;
@@ -1522,6 +1574,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 	}
 
+	if (!list_empty(&dcc->retry_list) &&
+		__should_discard_retry(sbi, dpolicy))
+		goto retry;
+
 	if (!issued && io_interrupted)
 		issued = -1;
 
@@ -1613,6 +1669,12 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 		goto next;
 	}
 
+	if (dpolicy->type == DPOLICY_UMOUNT &&
+		!list_empty(&dcc->retry_list)) {
+		wait_list = &dcc->retry_list;
+		goto next;
+	}
+
 	return trimmed;
 }
 
@@ -2051,6 +2113,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	for (i = 0; i < MAX_PLIST_NUM; i++)
 		INIT_LIST_HEAD(&dcc->pend_list[i]);
 	INIT_LIST_HEAD(&dcc->wait_list);
+	INIT_LIST_HEAD(&dcc->retry_list);
 	INIT_LIST_HEAD(&dcc->fstrim_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
