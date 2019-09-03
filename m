Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC8A6816
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 14:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfICMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 08:07:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43780 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfICMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:07:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i57aY-0003nP-VT; Tue, 03 Sep 2019 12:07:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][usb-next] usb: cdns3: fix spelling mistake: "cnfiguration" -> "configuration"
Date:   Tue,  3 Sep 2019 13:07:10 +0100
Message-Id: <20190903120710.30128-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/cdns3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 3094ad65ffc9..acf2d4c6a68c 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2630,7 +2630,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 		readl(&priv_dev->regs->usb_cap6));
 	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
 		readl(&priv_dev->regs->usb_cap1));
-	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
+	dev_dbg(priv_dev->dev, "On-Chip memory configuration: %08x\n",
 		readl(&priv_dev->regs->usb_cap2));
 
 	priv_dev->dev_ver = GET_DEV_BASE_VERSION(priv_dev->dev_ver);
-- 
2.20.1

