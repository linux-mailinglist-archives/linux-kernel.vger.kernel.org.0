Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670DC190F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgCXNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:20:09 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7074 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgCXNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:20:04 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85e7a08d2db9-91b8d; Tue, 24 Mar 2020 21:19:14 +0800 (CST)
X-RM-TRANSID: 2ee85e7a08d2db9-91b8d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.174.174])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e7a08cfa0f-0ed6c;
        Tue, 24 Mar 2020 21:19:14 +0800 (CST)
X-RM-TRANSID: 2ee85e7a08cfa0f-0ed6c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     cernekee@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        sergei.shtylyov@cogentembedded.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]usb: gadget: bcm63xx_udc:remove redundant variable assignment
Date:   Tue, 24 Mar 2020 21:20:29 +0800
Message-Id: <20200324132029.16296-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v1------------------------------------
In this function, the variable 'rc' is assigned after this place,
so the definition is invalid.

--v2------------------------------------
In this function, the variable 'rc' will be assigned by the function
'usb_add_gadget_udc()',so the assignment here is redundant,we should
remove it.

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



