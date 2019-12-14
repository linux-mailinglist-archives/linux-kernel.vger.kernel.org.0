Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4829811F4C8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLNWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:11:54 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54978 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLNWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576361493; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMX6UIY9bmRWjVAt92xIir5wDSF3AxsXg4z8MhqUuq4=;
        b=GZqvKpLNRWx3uwt3Efv+uWssqlsHWaddDgk17heOYSl9UawFPhihp7ZdMEAgGDbIR65Ti6
        6+qcUwNNqr5j2NBPaIVk3leUw5ocUGw6oSV8k3QKi+tl2HMymKBpgLdyf6DdFnBasLT/Kq
        S4hW6iz6o2xfZhTmM2KUOHYCQ47p/wM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/6] usb: musb: jz4740: Rename platform_device field in priv struct
Date:   Sat, 14 Dec 2019 23:11:24 +0100
Message-Id: <20191214221126.93116-4-paul@crapouillou.net>
In-Reply-To: <20191214221126.93116-1-paul@crapouillou.net>
References: <20191214221126.93116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the platform_device pointer 'pdev' instead of 'musb'. Since the
driver also deal with pointers to 'struct musb', it can be very
confusing to have a pointer named after this struct but with a different
type.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 3410e6b01bac..e2baa1b6bad6 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -17,7 +17,7 @@
 #include "musb_core.h"
 
 struct jz4740_glue {
-	struct platform_device  *musb;
+	struct platform_device	*pdev;
 	struct clk		*clk;
 };
 
@@ -151,7 +151,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
 
-	glue->musb			= musb;
+	glue->pdev			= musb;
 	glue->clk			= clk;
 
 	platform_set_drvdata(pdev, glue);
@@ -188,7 +188,7 @@ static int jz4740_remove(struct platform_device *pdev)
 {
 	struct jz4740_glue	*glue = platform_get_drvdata(pdev);
 
-	platform_device_unregister(glue->musb);
+	platform_device_unregister(glue->pdev);
 	clk_disable_unprepare(glue->clk);
 
 	return 0;
-- 
2.24.0

