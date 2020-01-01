Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCE12DFAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgAARWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 12:22:42 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:35309 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgAARWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:22:42 -0500
X-Greylist: delayed 3350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jan 2020 12:22:39 EST
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 001GQNNS001800;
        Wed, 1 Jan 2020 19:26:28 +0300
Received: from oak.local (unknown [188.123.231.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 07445106DD8;
        Wed,  1 Jan 2020 19:26:21 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 5/6] usb: musb: Introduce musb_start_urb()
Date:   Wed,  1 Jan 2020 19:26:09 +0300
Message-Id: <20200101162610.15819-6-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200101162610.15819-1-matwey@sai.msu.ru>
References: <20200101162610.15819-1-matwey@sai.msu.ru>
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function allows us to start arbitrary urb.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3a202a2a521d..ed99ecd4e63a 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -213,11 +213,10 @@ static struct musb_qh *musb_ep_get_qh(struct musb_hw_ep *ep, int is_in)
  * Context: controller locked, irqs blocked
  */
 static void
-musb_start_next_urb(struct musb *musb, int is_in, struct musb_qh *qh)
+musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh, struct urb *urb)
 {
 	u32			len;
 	void __iomem		*mbase =  musb->mregs;
-	struct urb		*urb = next_urb(qh);
 	void			*buf = urb->transfer_buffer;
 	u32			offset = 0;
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
@@ -293,6 +292,14 @@ musb_start_next_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	}
 }
 
+static void
+musb_start_next_urb(struct musb *musb, int is_in, struct musb_qh *qh)
+{
+	struct urb *urb = next_urb(qh);
+
+	musb_start_urb(musb, is_in, qh, urb);
+}
+
 /* Context: caller owns controller lock, IRQs are blocked */
 static void musb_giveback(struct musb *musb, struct urb *urb, int status)
 __releases(musb->lock)
-- 
2.16.4

