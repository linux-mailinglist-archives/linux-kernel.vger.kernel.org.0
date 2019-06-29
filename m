Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE17F5A842
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 04:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfF2CMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 22:12:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4531 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726682AbfF2CMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 22:12:08 -0400
X-UUID: f94d49c2242045cb898b39913da939f8-20190629
X-UUID: f94d49c2242045cb898b39913da939f8-20190629
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2085313190; Sat, 29 Jun 2019 10:12:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Jun 2019 10:12:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Jun 2019 10:12:01 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v8 09/21] iommu/mediatek: Add larb-id remapped support
Date:   Sat, 29 Jun 2019 10:09:15 +0800
Message-ID: <1561774167-24141-10-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The larb-id may be remapped in the smi-common, this means the
larb-id reported in the mtk_iommu_isr isn't the real larb-id,

Take mt8183 as a example:
                       M4U
                        |
---------------------------------------------
|               SMI common                  |
-0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
 |     |     |     |     |     |      |     |
larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
disp  vdec  img   cam   venc  img    cam
As above, larb0 connects with the id 0 in smi-common.
          larb1 connects with the id 7 in smi-common.
          ...
If the larb-id reported in the isr is 7, actually it's larb1(vdec).
In order to output the right larb-id in the isr, we add a larb-id
remapping relationship in this patch.

If there is no this larb-id remapping in some SoCs, use the linear
mapping array instead.

This also is a preparing patch for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 4 ++++
 drivers/iommu/mtk_iommu.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0482bee..a915c25 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -234,6 +234,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
 	fault_port = F_MMU0_INT_ID_PORT_ID(regval);
 
+	fault_larb = data->plat_data->larbid_remap[fault_larb];
+
 	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
@@ -764,12 +766,14 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	.m4u_plat     = M4U_MT2712,
 	.has_4gb_mode = true,
 	.has_bclk     = true,
+	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
 	.has_bclk     = true,
+	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 63e235e..61fd5d6 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -46,6 +46,8 @@ struct mtk_iommu_plat_data {
 
 	/* HW will use the EMI clock if there isn't the "bclk". */
 	bool                has_bclk;
+
+	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
 };
 
 struct mtk_iommu_domain;
-- 
1.9.1

