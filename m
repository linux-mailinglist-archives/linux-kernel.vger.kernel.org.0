Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8C74A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfGYJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 05:49:20 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2516 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:49:20 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d397b00d89-2a41c; Thu, 25 Jul 2019 17:48:48 +0800 (CST)
X-RM-TRANSID: 2ee55d397b00d89-2a41c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d397aff457-45244;
        Thu, 25 Jul 2019 17:48:48 +0800 (CST)
X-RM-TRANSID: 2ee65d397aff457-45244
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: remove redundant dev_err message
Date:   Thu, 25 Jul 2019 17:48:38 +0800
Message-Id: <1564048118-8593-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/nvmem/bcm-ocotp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a809751..460a220 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -271,10 +271,8 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 	/* Get OTP base address register. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->base)) {
-		dev_err(dev, "unable to map I/O memory\n");
+	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
-	}
 
 	/* Enable CPU access to OTPC. */
 	writel(readl(priv->base + OTPC_MODE_REG_OFFSET) |
-- 
1.9.1



