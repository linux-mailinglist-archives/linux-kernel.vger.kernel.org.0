Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C911224597
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfEUBX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 21:23:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4238 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbfEUBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 21:23:28 -0400
X-UUID: 1c8d6806af134c0285e8ff60eea06faf-20190521
X-UUID: 1c8d6806af134c0285e8ff60eea06faf-20190521
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2084700008; Tue, 21 May 2019 09:23:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 09:23:23 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 09:23:23 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
CC:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v7 09/12] soc: mediatek: cmdq: define the instruction struct
Date:   Tue, 21 May 2019 09:23:22 +0800
Message-ID: <20190521012322.45723-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define an instruction structure for gce driver to append command.
This structure can make the client's code more readability.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 103 +++++++++++++++--------
 include/linux/mailbox/mtk-cmdq-mailbox.h |   2 +
 2 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 7aa0517ff2f3..0886c4967ca4 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -9,12 +9,24 @@
 #include <linux/mailbox_controller.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
-#define CMDQ_ARG_A_WRITE_MASK	0xffff
 #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
 				<< 32 | CMDQ_EOC_IRQ_EN)
 
+struct cmdq_instruction {
+	union {
+		u32 value;
+		u32 mask;
+	};
+	union {
+		u16 offset;
+		u16 event;
+	};
+	u8 subsys;
+	u8 op;
+};
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
@@ -110,10 +122,8 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_destroy);
 
-static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
-				   u32 arg_a, u32 arg_b)
+static struct cmdq_instruction *cmdq_pkt_append_command(struct cmdq_pkt *pkt)
 {
-	u64 *cmd_ptr;
 
 	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
 		/*
@@ -127,81 +137,108 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
 		pkt->cmd_buf_size += CMDQ_INST_SIZE;
 		WARN_ONCE(1, "%s: buffer size %u is too small !\n",
 			__func__, (u32)pkt->buf_size);
-		return -ENOMEM;
+		return NULL;
 	}
-	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
-	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
+
 	pkt->cmd_buf_size += CMDQ_INST_SIZE;
 
-	return 0;
+	return pkt->va_base + pkt->cmd_buf_size - CMDQ_INST_SIZE;
 }
 
 int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
-	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
-		    (subsys << CMDQ_SUBSYS_SHIFT);
+	struct cmdq_instruction *inst;
+
+	inst = cmdq_pkt_append_command(pkt);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->op = CMDQ_CODE_WRITE;
+	inst->value = value;
+	inst->offset = offset;
+	inst->subsys = subsys;
 
-	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
+	return 0;
 }
 EXPORT_SYMBOL(cmdq_pkt_write);
 
 int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
 			u16 offset, u32 value, u32 mask)
 {
+	struct cmdq_instruction *inst;
 	u32 offset_mask = offset;
-	int err = 0;
 
 	if (mask != 0xffffffff) {
-		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
+		inst = cmdq_pkt_append_command(pkt);
+		if (!inst)
+			return -ENOMEM;
+
+		inst->op = CMDQ_CODE_MASK;
+		inst->mask = ~mask;
 		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
 	}
-	err |= cmdq_pkt_write(pkt, value, subsys, offset_mask);
 
-	return err;
+	return cmdq_pkt_write(pkt, subsys, offset_mask, value);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_mask);
 
 int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
 {
-	u32 arg_b;
+	struct cmdq_instruction *inst;
 
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	/*
-	 * WFE arg_b
-	 * bit 0-11: wait value
-	 * bit 15: 1 - wait, 0 - no wait
-	 * bit 16-27: update value
-	 * bit 31: 1 - update, 0 - no update
-	 */
-	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
+	inst = cmdq_pkt_append_command(pkt);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->op = CMDQ_CODE_WFE;
+	inst->value = CMDQ_WFE_OPTION;
+	inst->event = event;
 
-	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
+	return 0;
 }
 EXPORT_SYMBOL(cmdq_pkt_wfe);
 
 int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 {
+	struct cmdq_instruction *inst;
+
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
-				       CMDQ_WFE_UPDATE);
+	inst = cmdq_pkt_append_command(pkt);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->op = CMDQ_CODE_WFE;
+	inst->value = CMDQ_WFE_UPDATE;
+	inst->event = event;
+
+	return 0;
 }
 EXPORT_SYMBOL(cmdq_pkt_clear_event);
 
 static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
-	int err;
+	struct cmdq_instruction *inst;
+
+	inst = cmdq_pkt_append_command(pkt);
+	if (!inst)
+		return -ENOMEM;
 
-	/* insert EOC and generate IRQ for each command iteration */
-	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
+	inst->op = CMDQ_CODE_EOC;
+	inst->value = CMDQ_EOC_IRQ_EN;
 
-	/* JUMP to end */
-	err |= cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
+	inst = cmdq_pkt_append_command(pkt);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->op = CMDQ_CODE_JUMP;
+	inst->value = CMDQ_JUMP_PASS;
 
-	return err;
+	return 0;
 }
 
 static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 911475da7a53..c8adedefaf42 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -19,6 +19,8 @@
 #define CMDQ_WFE_UPDATE			BIT(31)
 #define CMDQ_WFE_WAIT			BIT(15)
 #define CMDQ_WFE_WAIT_VALUE		0x1
+#define CMDQ_WFE_OPTION			(CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | \
+					CMDQ_WFE_WAIT_VALUE)
 /** cmdq event maximum */
 #define CMDQ_MAX_EVENT			0x3ff
 
-- 
2.18.0

