Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFAE9F1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfH0Re5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:34:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44083 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfH0Re5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:34:57 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2fMr-0004Ed-NJ; Tue, 27 Aug 2019 17:34:54 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, bauer.chen@realtek.com,
        ricky_wu@realtek.com, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 1/2] USB: storage: ums-realtek: Update module parameter description for auto_delink_en
Date:   Wed, 28 Aug 2019 01:34:49 +0800
Message-Id: <20190827173450.13572-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option named "auto_delink_en" is a bit misleading, as setting it to
false doesn't really disable auto-delink but let auto-delink be firmware
controlled.

Update the description to reflect the real usage of this parameter.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Only update module parameter description.

 drivers/usb/storage/realtek_cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index cc794e25a0b6..beaffac805af 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -38,7 +38,7 @@ MODULE_LICENSE("GPL");
 
 static int auto_delink_en = 1;
 module_param(auto_delink_en, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(auto_delink_en, "enable auto delink");
+MODULE_PARM_DESC(auto_delink_en, "auto delink mode (0=firmware, 1=software [default])");
 
 #ifdef CONFIG_REALTEK_AUTOPM
 static int ss_en = 1;
-- 
2.17.1

