Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39118B888
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 15:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCSODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 10:03:23 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:6630 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgCSODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:03:23 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85e737b7eb0f-2c830; Thu, 19 Mar 2020 22:02:38 +0800 (CST)
X-RM-TRANSID: 2ee85e737b7eb0f-2c830
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.148.93])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e737b7ca46-7189b;
        Thu, 19 Mar 2020 22:02:38 +0800 (CST)
X-RM-TRANSID: 2ee25e737b7ca46-7189b
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] mailbox:armada-37xx-rwtm:remove duplicate print in armada_37xx_mbox_probe()
Date:   Thu, 19 Mar 2020 22:03:47 +0800
Message-Id: <20200319140347.19032-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function,we don't need dev_err() message because when something
goes wrong,platform_get_irq() and devm_platform_ioremap_resource() have
print an error message itself, so we should remove duplicate dev_err().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mailbox/armada-37xx-rwtm-mailbox.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
index 02b7b28e6..9f2ce7f03 100644
--- a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
+++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
@@ -156,16 +156,12 @@ static int armada_37xx_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mbox->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mbox->base)) {
-		dev_err(&pdev->dev, "ioremap failed\n");
+	if (IS_ERR(mbox->base))
 		return PTR_ERR(mbox->base);
-	}
 
 	mbox->irq = platform_get_irq(pdev, 0);
-	if (mbox->irq < 0) {
-		dev_err(&pdev->dev, "Cannot get irq\n");
+	if (mbox->irq < 0)
 		return mbox->irq;
-	}
 
 	mbox->dev = &pdev->dev;
 
-- 
2.20.1.windows.1



