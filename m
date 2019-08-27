Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB99F1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfH0RfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:35:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbfH0RfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:35:00 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2fMv-0004Ep-71; Tue, 27 Aug 2019 17:34:57 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, bauer.chen@realtek.com,
        ricky_wu@realtek.com, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 2/2] USB: storage: ums-realtek: Whitelist auto-delink support
Date:   Wed, 28 Aug 2019 01:34:50 +0800
Message-Id: <20190827173450.13572-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827173450.13572-1-kai.heng.feng@canonical.com>
References: <20190827173450.13572-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-delink requires writing special registers to ums-realtek devices.
Unconditionally enable auto-delink may break newer devices.

So only enable auto-delink by default for the original three IDs,
0x0138, 0x0158 and 0x0159.

Realtek is working on a patch to properly support auto-delink for other
IDs.

BugLink: https://bugs.launchpad.net/bugs/1838886
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
- Whitelisting instead of adding new module parameter.
v2:
- Use auto_delink_support instead of auto_delink_enable.

 drivers/usb/storage/realtek_cr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index beaffac805af..1d9ce9cbc831 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -996,12 +996,15 @@ static int init_realtek_cr(struct us_data *us)
 			goto INIT_FAIL;
 	}
 
-	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
-	    CHECK_FW_VER(chip, 0x5901))
-		SET_AUTO_DELINK(chip);
-	if (STATUS_LEN(chip) == 16) {
-		if (SUPPORT_AUTO_DELINK(chip))
+	if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
+	    CHECK_PID(chip, 0x0159)) {
+		if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
+				CHECK_FW_VER(chip, 0x5901))
 			SET_AUTO_DELINK(chip);
+		if (STATUS_LEN(chip) == 16) {
+			if (SUPPORT_AUTO_DELINK(chip))
+				SET_AUTO_DELINK(chip);
+		}
 	}
 #ifdef CONFIG_REALTEK_AUTOPM
 	if (ss_en)
-- 
2.17.1

