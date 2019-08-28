Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6A9FDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfH1JHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:07:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726273AbfH1JHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:07:23 -0400
X-UUID: c78317828a0b4ae18c00e6d6b0cc0b2d-20190828
X-UUID: c78317828a0b4ae18c00e6d6b0cc0b2d-20190828
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1799987658; Wed, 28 Aug 2019 17:07:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 17:07:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 17:07:24 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        yong mao <yong.mao@mediatek.com>
Subject: [PATCH] mmc: mediatek: enable SDIO IRQ low level trigger function
Date:   Wed, 28 Aug 2019 17:07:10 +0800
Message-ID: <1566983230-22481-1-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong mao <yong.mao@mediatek.com>

SDIO IRQ is not defaultly triggered by low level,
but by falling edge. It needs to set related register
to enable SDIO IRQ low level trigger function.
Otherwise the SDIO IRQ may be lost in some specail condition.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b63..2444268 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -192,6 +192,7 @@
 #define SDC_STS_CMDBUSY         (0x1 << 1)	/* RW */
 #define SDC_STS_SWR_COMPL       (0x1 << 31)	/* RW */
 
+#define SDC_DAT1_IRQ_TRIGGER	(0x1 << 20)	/* RW */
 /* SDC_ADV_CFG0 mask */
 #define SDC_RX_ENHANCE_EN	(0x1 << 20)	/* RW */
 
@@ -1568,6 +1569,7 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	/* Config SDIO device detect interrupt function */
 	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
 
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
-- 
1.9.1

