Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3FD1438C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgAUIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:50:06 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35645 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729260AbgAUIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:50:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHXckC_1579596601;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXckC_1579596601)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:50:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Harald Welte <laforge@gnumonks.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia/cm4000: remove useless variable tmp
Date:   Tue, 21 Jan 2020 16:49:59 +0800
Message-Id: <1579596599-258299-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one care the value of 'tmp' in func cmm_write. better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harald Welte <laforge@gnumonks.org> 
Cc: Arnd Bergmann <arnd@arndb.de> 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: linux-kernel@vger.kernel.org 
---
 drivers/char/pcmcia/cm4000_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 15bf585af5d3..9be3917b6d6c 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1048,7 +1048,6 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	struct cm4000_dev *dev = filp->private_data;
 	unsigned int iobase = dev->p_dev->resource[0]->start;
 	unsigned short s;
-	unsigned char tmp;
 	unsigned char infolen;
 	unsigned char sendT0;
 	unsigned short nsend;
@@ -1146,7 +1145,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	set_cardparameter(dev);
 
 	/* dummy read, reset flag procedure received */
-	tmp = inb(REG_FLAGS1(iobase));
+	inb(REG_FLAGS1(iobase));
 
 	dev->flags1 = 0x20	/* T_Active */
 	    | (sendT0)
-- 
1.8.3.1

