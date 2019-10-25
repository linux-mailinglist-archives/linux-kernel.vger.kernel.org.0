Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10712E4A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503617AbfJYLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:47:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56260 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502216AbfJYLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572004040; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LZRPjTaNqgAPsZFTi/ag+L9T2zf0Gi9U0ItR3Ud6R4=;
        b=B02mlFO54gTbqc/s+dk8ch5UrJ8fvqLpEOWRuzlscmxYYz8vKQUqE5IVUW9H41OryJlH8Y
        x8c6Asu3Br0KUl4v/7k0gksf8XUiXRmaGXgD4spbBHx1zXlRqwMc4e97/zxu7ywVc7ICew
        kRS/NHVYaX8/5JJ3xw1VFXsQBuNVeAw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 3/6] usb: musb: jz4740: Add support for DMA
Date:   Fri, 25 Oct 2019 13:47:07 +0200
Message-Id: <20191025114710.13222-3-paul@crapouillou.net>
In-Reply-To: <20191025114710.13222-1-paul@crapouillou.net>
References: <20191025114710.13222-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using the DMA channels built into the Inventra IP.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Rebase on 4.5-rc4

 drivers/usb/musb/Kconfig  |  2 +-
 drivers/usb/musb/jz4740.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 52f8e2b57ad5..210e4844c92a 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -142,7 +142,7 @@ config USB_UX500_DMA
 
 config USB_INVENTRA_DMA
 	bool 'Inventra'
-	depends on USB_MUSB_OMAP2PLUS
+	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_JZ4740
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 5261f8dfedec..bbecfdee6ea1 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -25,11 +25,14 @@ struct jz4740_glue {
 static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 {
 	unsigned long   flags;
-	irqreturn_t     retval = IRQ_NONE;
+	irqreturn_t     retval = IRQ_NONE, retval_dma = IRQ_NONE;
 	struct musb     *musb = __hci;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
+	if (IS_ENABLED(CONFIG_USB_INVENTRA_DMA) && musb->dma_controller)
+		retval_dma = musbhs_dma_controller_irq(musb->dma_controller);
+
 	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
 	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
 	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
@@ -47,7 +50,10 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	return retval;
+	if (retval == IRQ_HANDLED || retval_dma == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
 }
 
 static struct musb_fifo_cfg jz4740_musb_fifo_cfg[] = {
@@ -91,18 +97,19 @@ static int jz4740_musb_init(struct musb *musb)
 	musb->dyn_fifo = true;
 
 	musb->isr = jz4740_musb_interrupt;
+	musb->dma_share_usb_irq = true;
 
 	return 0;
 }
 
-/*
- * DMA has not been confirmed to work with CONFIG_USB_INVENTRA_DMA,
- * so let's not set up the dma function pointers yet.
- */
 static const struct musb_platform_ops jz4740_musb_ops = {
 	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.fifo_mode	= 2,
 	.init		= jz4740_musb_init,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init	= musbhs_dma_controller_create,
+	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
 };
 
 static int jz4740_probe(struct platform_device *pdev)
@@ -137,6 +144,8 @@ static int jz4740_probe(struct platform_device *pdev)
 	}
 
 	musb->dev.parent		= &pdev->dev;
+	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
+	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-- 
2.23.0

