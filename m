Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD61406BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAQJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 04:45:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgAQJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:45:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1isNyO-00063G-H6; Fri, 17 Jan 2020 09:31:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: musb: fix spelling mistake: "periperal" -> "peripheral"
Date:   Fri, 17 Jan 2020 09:31:24 +0000
Message-Id: <20200117093124.97965-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 71691a1f8ae3..f616fb489542 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -540,7 +540,7 @@ int musb_set_peripheral(struct musb *musb)
 				   devctl & MUSB_DEVCTL_BDEVICE, 5000,
 				   1000000);
 	if (error) {
-		dev_err(musb->controller, "%s: could not set periperal: %02x\n",
+		dev_err(musb->controller, "%s: could not set peripheral: %02x\n",
 			__func__, devctl);
 
 		return error;
-- 
2.24.0

