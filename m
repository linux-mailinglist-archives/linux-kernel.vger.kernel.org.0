Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D522F818
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfE3Hvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:51:31 -0400
Received: from skyboo.net ([94.40.87.198]:50428 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfE3Hvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:51:31 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hWFqR-0007Bw-Sv; Thu, 30 May 2019 09:51:28 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 30 May 2019 09:51:25 +0200
Message-Id: <20190530075125.27379-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on nemesis.skyboo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.1
Subject: [PATCH] w1: ds2413: fix state byte comparision
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is fixing a smatch warning:
drivers/w1/slaves/w1_ds2413.c:61 state_read() warn: impossible condition '(*buf == 255) => ((-128)-127 == 255)'
by creating additional u8 variable for the bus reading and comparision

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 3856032a0628 ("w1: ds2413: when the slave is not responding during read, select it again")
Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
 drivers/w1/slaves/w1_ds2413.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index 21f08ac8a4e0..3364ad276b15 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -33,6 +33,7 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	unsigned int retries = W1_F3A_RETRIES;
 	ssize_t bytes_read = -EIO;
+	u8 state;
 
 	dev_dbg(&sl->dev,
 		"Reading %s kobj: %p, off: %0#10x, count: %zu, buff addr: %p",
@@ -53,12 +54,13 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 	while (retries--) {
 		w1_write_8(sl->master, W1_F3A_FUNC_PIO_ACCESS_READ);
 
-		*buf = w1_read_8(sl->master);
-		if ((*buf & 0x0F) == ((~*buf >> 4) & 0x0F)) {
+		state = w1_read_8(sl->master);
+		if ((state & 0x0F) == ((~state >> 4) & 0x0F)) {
 			/* complement is correct */
+			*buf = state;
 			bytes_read = 1;
 			goto out;
-		} else if (*buf == W1_F3A_INVALID_PIO_STATE) {
+		} else if (state == W1_F3A_INVALID_PIO_STATE) {
 			/* slave didn't respond, try to select it again */
 			dev_warn(&sl->dev, "slave device did not respond to PIO_ACCESS_READ, " \
 					    "reselecting, retries left: %d\n", retries);
-- 
2.19.0.rc1

