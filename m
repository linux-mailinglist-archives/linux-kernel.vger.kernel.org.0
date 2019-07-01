Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4E3B57A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbfFJM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 08:57:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49139 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389517AbfFJM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:57:25 -0400
X-UUID: 41fd390c4ad648da8f5726511c9ed376-20190610
X-UUID: 41fd390c4ad648da8f5726511c9ed376-20190610
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2045054028; Mon, 10 Jun 2019 20:57:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 20:57:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 20:57:11 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>
Subject: [PATCH v2 10/12] iommu/mediatek: Use builtin_platform_driver
Date:   Mon, 10 Jun 2019 20:55:11 +0800
Message-ID: <1560171313-28299-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0B4467784B60C69D2AAF2FE86A910E03F9188BE23B7075579B2F4AFD6A43305B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU should wait for smi larb which need wait for the
power domain(mtk-scpsys.c) and the multimedia ccf who both are
module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
Switch to builtin_platform_driver.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 31 +------------------------------
 drivers/iommu/mtk_iommu_v1.c | 24 +-----------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7b70574..8459597 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -712,22 +712,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
-{
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-
-	iommu_device_sysfs_remove(&data->iommu);
-	iommu_device_unregister(&data->iommu);
-
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
-	clk_disable_unprepare(data->bclk);
-	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -808,23 +792,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init mtk_iommu_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&mtk_iommu_driver);
-	if (ret != 0)
-		pr_err("Failed to register MTK IOMMU driver\n");
-
-	return ret;
-}
-
-subsys_initcall(mtk_iommu_init)
+builtin_platform_driver(mtk_iommu_driver);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 845e20b..1c0fb82 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -650,22 +650,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
-{
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-
-	iommu_device_sysfs_remove(&data->iommu);
-	iommu_device_unregister(&data->iommu);
-
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
-	clk_disable_unprepare(data->bclk);
-	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -702,16 +686,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu-v1",
 		.of_match_table = mtk_iommu_of_ids,
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init m4u_init(void)
-{
-	return platform_driver_register(&mtk_iommu_driver);
-}
-subsys_initcall(m4u_init);
+builtin_platform_driver(mtk_iommu_driver);
-- 
1.9.1

