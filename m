Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0819A371
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 04:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgDACJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 22:09:09 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37505 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgDACJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:09:09 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75e83f79c2de-353e5; Wed, 01 Apr 2020 10:08:28 +0800 (CST)
X-RM-TRANSID: 2ee75e83f79c2de-353e5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e83f799e2e-cf1a8;
        Wed, 01 Apr 2020 10:08:28 +0800 (CST)
X-RM-TRANSID: 2ee75e83f799e2e-cf1a8
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ipmi:bt-bcm:use platform_get_irq_optional() to simplify code
Date:   Wed,  1 Apr 2020 10:09:54 +0800
Message-Id: <20200401020954.14568-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function's reference function 'bt_bmc_probe()',there are
judgments of print message about 'bt_bmc->irq',so use
platform_get_irq_optional() instead of platform_get_irq() to avoid
redundant dev_err() message.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/char/ipmi/bt-bmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 890ad55aa..766e0e5bf 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -399,7 +399,7 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 	struct device *dev = &pdev->dev;
 	int rc;
 
-	bt_bmc->irq = platform_get_irq(pdev, 0);
+	bt_bmc->irq = platform_get_irq_optional(pdev, 0);
 	if (!bt_bmc->irq)
 		return -ENODEV;
 
-- 
2.20.1.windows.1



