Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA6179D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 02:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCEBiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 20:38:04 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3533 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgCEBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:38:03 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e6057de450-eefeb; Thu, 05 Mar 2020 09:37:34 +0800 (CST)
X-RM-TRANSID: 2ee55e6057de450-eefeb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.44])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e6057da021-e0544;
        Thu, 05 Mar 2020 09:37:34 +0800 (CST)
X-RM-TRANSID: 2ee45e6057da021-e0544
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     jslaby@suse.com
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]tty:serial:mvebu-uart:fix a wrong return
Date:   Thu,  5 Mar 2020 09:38:23 +0800
Message-Id: <20200305013823.20976-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v1------------------------------------
in this place,the right return should be
return PTR_ERR(),not return -PTR_ERR()

--v2------------------------------------
in this place, the function should return a
negative value and the PTR_ERR already returns
a negative,so return -PTR_ERR() is wrong.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index c12a12556..4e9a59071 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -851,7 +851,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 
 	port->membase = devm_ioremap_resource(&pdev->dev, reg);
 	if (IS_ERR(port->membase))
-		return -PTR_ERR(port->membase);
+		return PTR_ERR(port->membase);
 
 	mvuart = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_uart),
 			      GFP_KERNEL);
-- 
2.20.1.windows.1



