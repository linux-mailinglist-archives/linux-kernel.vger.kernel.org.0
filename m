Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751B29FE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfH1JNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:13:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25070 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726586AbfH1JMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:12:05 -0400
X-UUID: 43435760c789432d9cf932b76ae369fb-20190828
X-UUID: 43435760c789432d9cf932b76ae369fb-20190828
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 115752348; Wed, 28 Aug 2019 17:11:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 17:12:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 17:12:04 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v7 07/13] soc: mediatek: Refactor bus protection control
Date:   Wed, 28 Aug 2019 17:11:40 +0800
Message-ID: <1566983506-26598-8-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
References: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CECD0B24204F4528E02BAC5A3B092088CD14B0F68055E3EE39B9525D0F003D092000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put bus protection enable and disable control in separate functions.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 44 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ad0f619..fb2b027 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -274,6 +274,30 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
 			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
+static int scpsys_bus_protect_enable(struct scp_domain *scpd)
+{
+	struct scp *scp = scpd->scp;
+
+	if (!scpd->data->bus_prot_mask)
+		return 0;
+
+	return mtk_infracfg_set_bus_protection(scp->infracfg,
+			scpd->data->bus_prot_mask,
+			scp->bus_prot_reg_update);
+}
+
+static int scpsys_bus_protect_disable(struct scp_domain *scpd)
+{
+	struct scp *scp = scpd->scp;
+
+	if (!scpd->data->bus_prot_mask)
+		return 0;
+
+	return mtk_infracfg_clear_bus_protection(scp->infracfg,
+			scpd->data->bus_prot_mask,
+			scp->bus_prot_reg_update);
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
@@ -316,13 +340,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_pwr_ack;
 
-	if (scpd->data->bus_prot_mask) {
-		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
-				scpd->data->bus_prot_mask,
-				scp->bus_prot_reg_update);
-		if (ret)
-			goto err_pwr_ack;
-	}
+	ret = scpsys_bus_protect_disable(scpd);
+	if (ret < 0)
+		goto err_pwr_ack;
 
 	return 0;
 
@@ -344,13 +364,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	u32 val;
 	int ret, tmp;
 
-	if (scpd->data->bus_prot_mask) {
-		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
-				scpd->data->bus_prot_mask,
-				scp->bus_prot_reg_update);
-		if (ret)
-			goto out;
-	}
+	ret = scpsys_bus_protect_enable(scpd);
+	if (ret < 0)
+		goto out;
 
 	ret = scpsys_sram_disable(scpd, ctl_addr);
 	if (ret < 0)
-- 
1.8.1.1.dirty

