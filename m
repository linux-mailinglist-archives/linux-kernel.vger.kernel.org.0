Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4261E1D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406288AbfJWOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 10:00:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfJWOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:00:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A41CF777CE33060F98F3;
        Wed, 23 Oct 2019 22:00:49 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 22:00:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <geert+renesas@glider.be>,
        <jroedel@suse.de>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iommu/ipmmu-vmsa: Remove dev_err() on platform_get_irq() failure
Date:   Wed, 23 Oct 2019 21:59:41 +0800
Message-ID: <20191023135941.15000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() will call dev_err() itself on failure,
so there is no need for the driver to also do this.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index a8b7957..5904c23 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1110,10 +1110,8 @@ static int ipmmu_probe(struct platform_device *pdev)
 	/* Root devices have mandatory IRQs */
 	if (ipmmu_is_root(mmu)) {
 		irq = platform_get_irq(pdev, 0);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "no IRQ found\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_irq(&pdev->dev, irq, ipmmu_irq, 0,
 				       dev_name(&pdev->dev), mmu);
-- 
2.7.4


