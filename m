Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCA3B572
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfFJM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 08:57:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3862 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388373AbfFJM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:57:14 -0400
X-UUID: ddc05db4a7c44543ba247842f14a4c3d-20190610
X-UUID: ddc05db4a7c44543ba247842f14a4c3d-20190610
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 215481242; Mon, 10 Jun 2019 20:57:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 20:57:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 20:57:03 +0800
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
Subject: [PATCH v2 09/12] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
Date:   Mon, 10 Jun 2019 20:55:10 +0800
Message-ID: <1560171313-28299-10-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding device_link between the iommu consumer and smi-larb,
the pm_runtime_get(_sync) of smi-larb and smi-common will be called
automatically. we can get rid of mtk_smi_larb_get/put.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/memory/mtk-smi.c   | 14 --------------
 include/soc/mediatek/smi.h | 20 --------------------
 2 files changed, 34 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 98b1180..11d99b7 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -123,20 +123,6 @@ static void mtk_smi_clk_disable(const struct mtk_smi *smi)
 	clk_disable_unprepare(smi->clk_apb);
 }
 
-int mtk_smi_larb_get(struct device *larbdev)
-{
-	int ret = pm_runtime_get_sync(larbdev);
-
-	return (ret < 0) ? ret : 0;
-}
-EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
-
-void mtk_smi_larb_put(struct device *larbdev)
-{
-	pm_runtime_put_sync(larbdev);
-}
-EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
-
 static int
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 {
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 7a8d870..609397d 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -24,26 +24,6 @@ struct mtk_smi_iommu {
 	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
 };
 
-/*
- * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
- *                   It also initialize some basic setting(like iommu).
- * mtk_smi_larb_put: Disable the power domain and clocks for this local arbiter.
- * Both should be called in non-atomic context.
- *
- * Returns 0 if successful, negative on failure.
- */
-int mtk_smi_larb_get(struct device *larbdev);
-void mtk_smi_larb_put(struct device *larbdev);
-
-#else
-
-static inline int mtk_smi_larb_get(struct device *larbdev)
-{
-	return 0;
-}
-
-static inline void mtk_smi_larb_put(struct device *larbdev) { }
-
 #endif
 
 #endif
-- 
1.9.1

