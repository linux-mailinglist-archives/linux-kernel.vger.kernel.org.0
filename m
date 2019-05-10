Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31F19D62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEJMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 08:43:36 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53393 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfEJMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:43:36 -0400
X-Originating-IP: 109.213.220.252
Received: from localhost (alyon-652-1-77-252.w109-213.abo.wanadoo.fr [109.213.220.252])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6E4DEFF80B;
        Fri, 10 May 2019 12:43:33 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <james.grant@jci.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
Date:   Fri, 10 May 2019 14:42:48 +0200
Message-Id: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gadget drivers may queue request in interrupt context. This would lead to
a descriptor allocation in that context. In that case we would hit
BUG_ON(in_interrupt()) in __get_vm_area_node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index d8f1c60793ed..b706d9c85a35 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -938,7 +938,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
 	struct lpc32xx_usbd_dd_gad	*dd;
 
 	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
-			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
+			udc->dd_cache, (GFP_ATOMIC | GFP_DMA), &dma);
 	if (dd)
 		dd->this_dma = dma;
 
-- 
2.21.0

