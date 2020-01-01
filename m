Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9345212DFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 18:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgAARWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 12:22:40 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:35309 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgAARWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:22:40 -0500
X-Greylist: delayed 3350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jan 2020 12:22:39 EST
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 001GQIrU001781;
        Wed, 1 Jan 2020 19:26:23 +0300
Received: from oak.local (unknown [188.123.231.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id DD9457FDE6;
        Wed,  1 Jan 2020 19:26:19 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/6] usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
Date:   Wed,  1 Jan 2020 19:26:05 +0300
Message-Id: <20200101162610.15819-2-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200101162610.15819-1-matwey@sai.msu.ru>
References: <20200101162610.15819-1-matwey@sai.msu.ru>
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use USB_DIR_IN instead of 1 when calling musb_advance_schedule().
This is consistent with the rest of musb_host.c code and impoves
the readability.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index eb308ec35c66..3ffea6a5e022 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1195,7 +1195,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 
 	/* call completion handler if done */
 	if (complete)
-		musb_advance_schedule(musb, urb, hw_ep, 1);
+		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_IN);
 done:
 	return retval;
 }
-- 
2.16.4

