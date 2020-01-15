Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3106513CFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 23:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgAOWA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 17:00:57 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44606 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgAOWA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579125637; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oi4tThBuGksudZcJhgPfDegJg+rUgBw/w8H281SWb+E=;
        b=tulUk7sZMgZ7EekU08yWMhNNs5Z/E6ip0NUVc3XM+e7RPK5M/J1zs5F+AgE8StvYWcS25i
        zpk9xs1g0JaBCvra7krM2q5/nzNHbLBr2rLHemP3HR97q7Yv+V0pltoV1NiSxjpHNKxvZO
        qJ6gnJH2tpVyV8fViOizXCKzDJFCXYw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] usb: musb: jz4740: Add support for the JZ4770
Date:   Wed, 15 Jan 2020 19:00:08 -0300
Message-Id: <20200115220008.91445-6-paul@crapouillou.net>
In-Reply-To: <20200115220008.91445-1-paul@crapouillou.net>
References: <20200115220008.91445-1-paul@crapouillou.net>
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
 drivers/usb/musb/jz4740.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index b6747bad4fb2..8c52a1fa6fbc 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -161,6 +161,33 @@ static const struct musb_hdrc_platform_data jz4740_musb_pdata = {
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
@@ -248,6 +275,7 @@ static int jz4740_remove(struct platform_device *pdev)
 
 static const struct of_device_id jz4740_musb_of_match[] = {
 	{ .compatible = "ingenic,jz4740-musb", .data = &jz4740_musb_pdata },
+	{ .compatible = "ingenic,jz4770-musb", .data = &jz4770_musb_pdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, jz4740_musb_of_match);
-- 
2.24.1

