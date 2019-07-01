Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A173122C87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfETHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 03:06:13 -0400
Received: from skyboo.net ([94.40.87.198]:51496 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETHGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:06:12 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hScN7-0005pH-VF; Mon, 20 May 2019 09:06:10 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Mon, 20 May 2019 09:05:56 +0200
Message-Id: <20190520070558.20142-2-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190520070558.20142-1-manio@skyboo.net>
References: <20190520070558.20142-1-manio@skyboo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on nemesis.skyboo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.1
Subject: [PATCH 2/4] w1: ds2413: add retry support to state_read()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state_read() was calling PIO_ACCESS_READ once and bail out if it
failed for this first time.
This commit is improving this to trying more times before it give up,
similarly as the write call is currently doing.

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
 drivers/w1/slaves/w1_ds2413.c | 37 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index cd3763df69ac..d63778c70568 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -30,6 +30,9 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 			  size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	unsigned int retries = W1_F3A_RETRIES;
+	ssize_t bytes_read = -EIO;
+
 	dev_dbg(&sl->dev,
 		"Reading %s kobj: %p, off: %0#10x, count: %zu, buff addr: %p",
 		bin_attr->attr.name, kobj, (unsigned int)off, count, buf);
@@ -42,22 +45,30 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 	mutex_lock(&sl->master->bus_mutex);
 	dev_dbg(&sl->dev, "mutex locked");
 
-	if (w1_reset_select_slave(sl)) {
-		mutex_unlock(&sl->master->bus_mutex);
-		return -EIO;
-	}
+	if (w1_reset_select_slave(sl))
+		goto out;
 
-	w1_write_8(sl->master, W1_F3A_FUNC_PIO_ACCESS_READ);
-	*buf = w1_read_8(sl->master);
+	while (retries--) {
+		w1_write_8(sl->master, W1_F3A_FUNC_PIO_ACCESS_READ);
 
-	mutex_unlock(&sl->master->bus_mutex);
-	dev_dbg(&sl->dev, "mutex unlocked");
+		*buf = w1_read_8(sl->master);
+		/* check for correct complement */
+		if ((*buf & 0x0F) == ((~*buf >> 4) & 0x0F)) {
+			bytes_read = 1;
+			goto out;
+		}
 
-	/* check for correct complement */
-	if ((*buf & 0x0F) != ((~*buf >> 4) & 0x0F))
-		return -EIO;
-	else
-		return 1;
+		if (w1_reset_resume_command(sl->master))
+			goto out; /* unrecoverable error */
+
+		dev_warn(&sl->dev, "PIO_ACCESS_READ error, retries left: %d\n", retries);
+	}
+
+out:
+	mutex_unlock(&sl->master->bus_mutex);
+	dev_dbg(&sl->dev, "%s, mutex unlocked, retries: %d\n",
+		(bytes_read > 0) ? "succeeded" : "error", retries);
+	return bytes_read;
 }
 
 static BIN_ATTR_RO(state, 1);
-- 
2.19.0.rc1

