Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC70411F4C7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLNWLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:11:47 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54940 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLNWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576361492; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQw0ApAkaWKDscKzdmhZ/9zupaUBgI74oe8/g48qF8I=;
        b=v+ekk9zCzZ6OUip8IqnTxVmI6a3oxA7nnc48CwQrPx1LpAUfPsBujSxPfabC4yUH2Dsx6H
        35GMTeDZ7tpiMphY5vGeso+MQI8r6Bdr9BbGUn+HsdvUqk6lmo6o/sqySHWxGPF5HKWUOx
        SVIwdPpqqgyns/FhJsHpX9BPvq1u1Ss=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/6] usb: musb: jz4740: Constify jz4740_musb_pdata struct
Date:   Sat, 14 Dec 2019 23:11:23 +0100
Message-Id: <20191214221126.93116-3-paul@crapouillou.net>
In-Reply-To: <20191214221126.93116-1-paul@crapouillou.net>
References: <20191214221126.93116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By moving around the jz4740_musb_pdata structure, we can have the
.platform_ops field initialized, so that we don't have to initialize it
manually in the probe function. Therefore, the struct can be const now.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index b31b028e5ee7..3410e6b01bac 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -72,11 +72,6 @@ static const struct musb_hdrc_config jz4740_musb_config = {
 	.fifo_cfg_size = ARRAY_SIZE(jz4740_musb_fifo_cfg),
 };
 
-static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
-	.mode   = MUSB_PERIPHERAL,
-	.config = &jz4740_musb_config,
-};
-
 static int jz4740_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller->parent;
@@ -114,10 +109,16 @@ static const struct musb_platform_ops jz4740_musb_ops = {
 #endif
 };
 
+static const struct musb_hdrc_platform_data jz4740_musb_pdata = {
+	.mode		= MUSB_PERIPHERAL,
+	.config		= &jz4740_musb_config,
+	.platform_ops	= &jz4740_musb_ops,
+};
+
 static int jz4740_probe(struct platform_device *pdev)
 {
 	struct device			*dev = &pdev->dev;
-	struct musb_hdrc_platform_data	*pdata = &jz4740_musb_platform_data;
+	const struct musb_hdrc_platform_data *pdata = &jz4740_musb_pdata;
 	struct platform_device		*musb;
 	struct jz4740_glue		*glue;
 	struct clk                      *clk;
@@ -153,8 +154,6 @@ static int jz4740_probe(struct platform_device *pdev)
 	glue->musb			= musb;
 	glue->clk			= clk;
 
-	pdata->platform_ops		= &jz4740_musb_ops;
-
 	platform_set_drvdata(pdev, glue);
 
 	ret = platform_device_add_resources(musb, pdev->resource,
-- 
2.24.0

