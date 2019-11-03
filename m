Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1FED40C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 18:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKCRpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 12:45:51 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:37720 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfKCRpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:45:51 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Nov 2019 12:45:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1572802729; bh=Og8hrI9utVhx1N3pErX30f/VxNKdJQESKQlfLupIS3s=;
        h=From:To:Cc:Subject:Date;
        b=F+JEUIxZmXeb4tOiff/vt0fAdcXZ0SEQiVImOJUNZ9VeUO4dvnyGdAcNT5cb7WTUO
         TSDg0MwcZfTVKN1f0PKyyKO4G1Kv5tFaoolbK5IZrUcSH7FAvhFjK5+8jx1FUBOWWb
         CJ8RNqKRmFBXsIJVIpyG0NMI/eWz59IjkbTuBTrQ=
From:   Drew DeVault <sir@cmpwn.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht
Subject: [PATCH] firmware loader: log path to loaded firmwares
Date:   Sun,  3 Nov 2019 12:38:38 -0500
Message-Id: <20191103173837.1861-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful for users who are trying to identify the firmwares in use
on their system.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 drivers/base/firmware_loader/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..139d40a2f423 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -34,6 +34,7 @@
 #include <linux/reboot.h>
 #include <linux/security.h>
 #include <linux/xz.h>
+#include <linux/kernel.h>
 
 #include <generated/utsrelease.h>
 
@@ -504,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					 path);
 			continue;
 		}
+		printk(KERN_INFO "Loading firmware from %s\n", path);
 		if (decompress) {
 			dev_dbg(device, "f/w decompressing %s\n",
 				fw_priv->fw_name);
-- 
2.23.0

