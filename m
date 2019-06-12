Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA141FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfFLIyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:54:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13071 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730954AbfFLIx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:53:59 -0400
X-UUID: 5b91f0e68ff242ffaa6748a79f7b38fc-20190612
X-UUID: 5b91f0e68ff242ffaa6748a79f7b38fc-20190612
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1714576682; Wed, 12 Jun 2019 16:53:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 16:53:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 16:53:52 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v8 08/12] soc: mediatek: cmdq: change the type of input parameter
Date:   Wed, 12 Jun 2019 16:53:45 +0800
Message-ID: <20190612085349.21243-9-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190612085349.21243-1-bibby.hsieh@mediatek.com>
References: <20190612085349.21243-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the cmdq hardware design, the subsys is u8,
the offset is u16 and the event id is u16.
This patch changes the type of subsys, offset and event id
to the correct type.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 10 +++++-----
 include/linux/soc/mediatek/mtk-cmdq.h  | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 082b8978651e..7aa0517ff2f3 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -136,7 +136,7 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
 	return 0;
 }
 
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value)
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
 	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
 		    (subsys << CMDQ_SUBSYS_SHIFT);
@@ -145,8 +145,8 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value)
 }
 EXPORT_SYMBOL(cmdq_pkt_write);
 
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
-			u32 offset, u32 value, u32 mask)
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
+			u16 offset, u32 value, u32 mask)
 {
 	u32 offset_mask = offset;
 	int err = 0;
@@ -161,7 +161,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
 }
 EXPORT_SYMBOL(cmdq_pkt_write_mask);
 
-int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
 {
 	u32 arg_b;
 
@@ -181,7 +181,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
 }
 EXPORT_SYMBOL(cmdq_pkt_wfe);
 
-int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 {
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 39d813dde4b4..9618debb9ceb 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -66,7 +66,7 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value);
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
 
 /**
  * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
@@ -78,8 +78,8 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value);
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
-			u32 offset, u32 value, u32 mask);
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
+			u16 offset, u32 value, u32 mask);
 
 /**
  * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
@@ -88,7 +88,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
 
 /**
  * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
@@ -97,7 +97,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
 
 /**
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
-- 
2.18.0

