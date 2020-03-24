Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC11905BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 07:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCXG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 02:28:54 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:4880 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXG2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:28:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e79a88206c-87f20; Tue, 24 Mar 2020 14:28:19 +0800 (CST)
X-RM-TRANSID: 2eea5e79a88206c-87f20
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e79a88069e-da2b2;
        Tue, 24 Mar 2020 14:28:18 +0800 (CST)
X-RM-TRANSID: 2ee15e79a88069e-da2b2
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     cernekee@gmail.com, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] usb: gadget: bcm63xx_udc:remove useless variable definition
Date:   Tue, 24 Mar 2020 14:29:32 +0800
Message-Id: <20200324062932.8364-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, the variable 'rc' is assigned after this place,
so the definition is invalid.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/bcm63xx_udc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 54501814d..a7afa8c35 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2321,8 +2321,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = -ENXIO;
-
 	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.20.1.windows.1



