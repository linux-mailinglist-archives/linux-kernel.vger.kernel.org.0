Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A513181A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 14:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgCKNwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 09:52:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36828 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgCKNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583934707; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoA7xlA0w+953l1MsfjjT/sDgjQ3qpKDYEH1X6p3aGM=;
        b=pVx/8nb2vj09o7vHt4BFglowN4kDvaJ6k60RGK2hCHqrjcKZNz1bsht2S6R1PmGq3rAjxl
        U3qfUgX1HbnKZKQEv//SK6KGjG8CHW9iJ1ouf8lj7GMXLj6sNMcmHbxL8EIXPHaSY9sf3n
        6wa8JDIBqYyecZKyBYwhDqU6PHYipg4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 5/5] usb: musb: jz4740: Add support for the JZ4770
Date:   Wed, 11 Mar 2020 14:51:33 +0100
Message-Id: <20200311135133.16392-5-paul@crapouillou.net>
In-Reply-To: <20200311135133.16392-1-paul@crapouillou.net>
References: <20200311135133.16392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the jz4740-musb driver on the JZ4770 SoC.

The USB IP in the JZ4770 works the same Inventra IP as for the JZ4740,
but it features more endpoints, and officially supports OTG.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2-v3: No change

 drivers/usb/musb/jz4740.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 22eebe43ae1e..e64dd30e80e7 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -163,6 +163,33 @@ static const struct musb_hdrc_platform_data jz4740_musb_pdata = {
 	.platform_ops	= &jz4740_musb_ops,
 };
 
+static struct musb_fifo_cfg jz4770_musb_fifo_cfg[] = {
+	{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 3, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 3, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 4, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 4, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 5, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 5, .style = FIFO_RX, .maxpacket = 512, },
+};
+
+static struct musb_hdrc_config jz4770_musb_config = {
+	.multipoint	= 1,
+	.num_eps	= 11,
+	.ram_bits	= 11,
+	.fifo_cfg	= jz4770_musb_fifo_cfg,
+	.fifo_cfg_size	= ARRAY_SIZE(jz4770_musb_fifo_cfg),
+};
+
+static const struct musb_hdrc_platform_data jz4770_musb_pdata = {
+	.mode		= MUSB_PERIPHERAL, /* TODO: support OTG */
+	.config		= &jz4770_musb_config,
+	.platform_ops	= &jz4740_musb_ops,
+};
+
 static int jz4740_probe(struct platform_device *pdev)
 {
 	struct device			*dev = &pdev->dev;
@@ -250,6 +277,7 @@ static int jz4740_remove(struct platform_device *pdev)
 
 static const struct of_device_id jz4740_musb_of_match[] = {
 	{ .compatible = "ingenic,jz4740-musb", .data = &jz4740_musb_pdata },
+	{ .compatible = "ingenic,jz4770-musb", .data = &jz4770_musb_pdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, jz4740_musb_of_match);
-- 
2.25.1

