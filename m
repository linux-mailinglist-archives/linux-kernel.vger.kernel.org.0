Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E118EB229
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfJaOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:09:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfJaOJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:09:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F04048B2847776E73F45;
        Thu, 31 Oct 2019 22:08:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 22:08:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <agross@kernel.org>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: smp2p: remove redundant print message.
Date:   Thu, 31 Oct 2019 22:05:02 +0800
Message-ID: <1572530702-27364-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() fails to get the irq, it will print an error.
hence it is no need to print an error again after platform_get_irq() return.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/soc/qcom/smp2p.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d5..07183d7 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		goto report_read_failure;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	smp2p->mbox_client.dev = &pdev->dev;
 	smp2p->mbox_client.knows_txdone = true;
-- 
1.7.12.4

