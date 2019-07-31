Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59347D13B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 00:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGaWjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 18:39:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54979 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfGaWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:39:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hsxFd-0000Hh-Ps; Wed, 31 Jul 2019 22:39:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: remove redundant assignment to variable ret
Date:   Wed, 31 Jul 2019 23:39:17 +0100
Message-Id: <20190731223917.16532-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is being initialized with a value that is never read
and ret is being re-assigned a little later on. The assignment is
redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9f5a4819a744..2bc55e0ceace 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1721,7 +1721,7 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct musb *musb = dev_to_musb(dev);
 	unsigned long flags;
-	int ret = -EINVAL;
+	int ret;
 
 	spin_lock_irqsave(&musb->lock, flags);
 	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
-- 
2.20.1

