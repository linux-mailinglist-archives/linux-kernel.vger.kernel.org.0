Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9216A5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfGPJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 05:54:45 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2532 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPJyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:54:45 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95d2d9ec7b16-70d88; Tue, 16 Jul 2019 17:54:15 +0800 (CST)
X-RM-TRANSID: 2ee95d2d9ec7b16-70d88
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d2d9ec64dd-4d454;
        Tue, 16 Jul 2019 17:54:15 +0800 (CST)
X-RM-TRANSID: 2ee15d2d9ec64dd-4d454
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     hdegoede@redhat.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libahci_platform: remove redundant dev_err message
Date:   Tue, 16 Jul 2019 17:54:08 +0800
Message-Id: <1563270848-11223-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/ata/libahci_platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 72312ad..3a36e76 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -408,7 +408,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	hpriv->mmio = devm_ioremap_resource(dev,
 			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
 	if (IS_ERR(hpriv->mmio)) {
-		dev_err(dev, "no mmio space\n");
 		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
 	}
-- 
1.9.1



