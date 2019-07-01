Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6451BC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfEMR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 13:56:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35345 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfEMR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:56:07 -0400
Received: by mail-io1-f67.google.com with SMTP id p2so10784927iol.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOJlVvk72P8k3dgBOfAuZ6psp1YU3jhKdn1gghNxATc=;
        b=lPXRNxMEfmEkBJ2JUsjOiFAB5IEvtszF9GsXLLMymQMTdTHjTPbfYklCtmKqqzsBsd
         lri1kvgtlPeYqK0uEdFt59OYdYa92ka9CGgkut/59X+m+eEkSgzRWRakGDjBllvStYuu
         JsxjEMd48GtJP9UCCx2xlye3dZGp2QpPbz1Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOJlVvk72P8k3dgBOfAuZ6psp1YU3jhKdn1gghNxATc=;
        b=jKcfsTlR2JsMRzdUo/6YihsSTKnW8X+iYmtWfQ/g8E35aTRUxaUDOfc4AOnKUwerlM
         35UvKKv4h9/1c1LsKUdZXxDz/WlP6HWoYAv1anCD8EU97M2O4fIvy9ojNJTgfIdQuh2G
         iAaQAYwN7/5wf7TAhY5BgnZA6FKfIY2YJMT5B6p/y25CD8Ikx4EbWY3+RLfyqFdBdKM3
         5p7kWhaEeR2cTQsETB/i+a7C5blFaUVegJ16bYDTIOsH49Caj+m54QBks3+wbb7s1TDv
         /PYNcMwfYVDrjG5gu2D1o2TstQBGEeHqk5Sz3LeKP89yrQ7CtT/fVgycQtVkMa0BBaWm
         6MWw==
X-Gm-Message-State: APjAAAVGhAjrCjPMX9Z+H+kDcQvIgPCIWgPRSa7NHi+0Xa/8MurowFx/
        0Nxf0/8D3JLF54q1JW74zba+TQ==
X-Google-Smtp-Source: APXvYqyjGAWAfDCCM4xTLO+p8nZzYQLlCZMDQSDHg94cFNw98HntOIFCUWAFBUlFJKi0x2U/1Ny1yw==
X-Received: by 2002:a6b:e618:: with SMTP id g24mr14509690ioh.138.1557770166634;
        Mon, 13 May 2019 10:56:06 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id l80sm78323ita.15.2019.05.13.10.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:56:06 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, Chris Boot <bootc@bootc.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [stable/4.14.y PATCH 1/3] mmc: block: Simplify cleaning up the queue
Date:   Mon, 13 May 2019 11:55:19 -0600
Message-Id: <20190513175521.84955-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190513175521.84955-1-rrangel@chromium.org>
References: <20190513175521.84955-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Use blk_cleanup_queue() to shutdown the queue when the driver is removed,
and instead get an extra reference to the queue to prevent the queue being
freed before the final mmc_blk_put().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
commit 41e3efd07d5a02c80f503e29d755aa1bbb4245de upstream.

 drivers/mmc/core/block.c | 17 ++++++++++++-----
 drivers/mmc/core/queue.c |  2 ++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce6dd49fbb98d..203038fb85111 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -161,7 +161,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
-		blk_cleanup_queue(md->queue.queue);
+		blk_put_queue(md->queue.queue);
 		ida_simple_remove(&mmc_blk_ida, devidx);
 		put_disk(md->disk);
 		kfree(md);
@@ -2122,6 +2122,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	md->queue.blkdata = md;
 
+	/*
+	 * Keep an extra reference to the queue so that we can shutdown the
+	 * queue (i.e. call blk_cleanup_queue()) while there are still
+	 * references to the 'md'. The corresponding blk_put_queue() is in
+	 * mmc_blk_put().
+	 */
+	if (!blk_get_queue(md->queue.queue)) {
+		mmc_cleanup_queue(&md->queue);
+		goto err_putdisk;
+	}
+
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->first_minor = devidx * perdev_minors;
 	md->disk->fops = &mmc_bdops;
@@ -2272,10 +2283,6 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * from being accepted.
 		 */
 		card = md->queue.card;
-		spin_lock_irq(md->queue.queue->queue_lock);
-		queue_flag_set(QUEUE_FLAG_BYPASS, md->queue.queue);
-		spin_unlock_irq(md->queue.queue->queue_lock);
-		blk_set_queue_dying(md->queue.queue);
 		mmc_cleanup_queue(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 0a4e77a5ba33f..d99fa4e63033c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -259,6 +259,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
+	blk_cleanup_queue(q);
+
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
-- 
2.21.0.1020.gf2820cf01a-goog

