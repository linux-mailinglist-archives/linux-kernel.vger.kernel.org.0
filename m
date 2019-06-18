Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C660E49DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfFRJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 05:57:53 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2497 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:57:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d08b5840db-7b1a6; Tue, 18 Jun 2019 17:57:24 +0800 (CST)
X-RM-TRANSID: 2ee55d08b5840db-7b1a6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d08b583eb7-6d771;
        Tue, 18 Jun 2019 17:57:24 +0800 (CST)
X-RM-TRANSID: 2ee65d08b583eb7-6d771
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     srinivas.kandagatla@linaro.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: remove redundant dev_err message
Date:   Tue, 18 Jun 2019 17:56:29 +0800
Message-Id: <1560851789-12228-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ad3e2e23..a444badd 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -528,10 +528,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
-	if (IS_ERR(ctrl->base)) {
-		dev_err(&pdev->dev, "IOremap failed\n");
+	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
-	}
 
 	sctrl->set_laddr = qcom_set_laddr;
 	sctrl->xfer_msg = qcom_xfer_msg;
-- 
1.9.1



