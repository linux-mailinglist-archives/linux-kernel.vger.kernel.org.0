Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F4CA5C56
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfIBSnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 14:43:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45894 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfIBSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:43:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i4rIc-0000PM-Os; Mon, 02 Sep 2019 18:43:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: cdns3: remove redundant assignment to ret on error exit path
Date:   Mon,  2 Sep 2019 19:43:34 +0100
Message-Id: <20190902184334.27406-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where an allocation fails for priv_ep ret is
assigned -ENOMEM and the code exits via the exit path 'err'.
The exit path returns -ENOMEM without using variable ret, so
the assingment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/cdns3/gadget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 0eb3022838d6..de0e14a4fb9f 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2447,10 +2447,8 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 
 		priv_ep = devm_kzalloc(priv_dev->dev, sizeof(*priv_ep),
 				       GFP_KERNEL);
-		if (!priv_ep) {
-			ret = -ENOMEM;
+		if (!priv_ep)
 			goto err;
-		}
 
 		/* set parent of endpoint object */
 		priv_ep->cdns3_dev = priv_dev;
-- 
2.20.1

