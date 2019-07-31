Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF87C1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfGaMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbfGaMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCEA32171F;
        Wed, 31 Jul 2019 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577063;
        bh=Fje3AeopR107kcdoqaZJYzJTIvkoN1dobGnTqwrXqOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CT0cwL2e/r+3RDaMoTK/tZK11LleUq09ZrKXH8NIp2+SsEkEBYsyzlWLf5H5DNx5r
         /r89HPJxOH8CfFqC/YUAjSDax2bl9UUKeEzY6rxSximoTLNC6+8muabt9MApGxY/2T
         lv4zTDtA7H5/27ELhezJ1UcxQQhuV0jZjk0zmZ1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 08/10] video: fbdev: wm8505fb: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:47 +0200
Message-Id: <20190731124349.4474-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a sysfs file.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/wm8505fb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index ff752635a31c..17c780315ca5 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -176,6 +176,12 @@ static ssize_t contrast_store(struct device *dev,
 
 static DEVICE_ATTR_RW(contrast);
 
+static struct attribute *wm8505fb_attrs[] = {
+	&dev_attr_contrast.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wm8505fb);
+
 static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
 {
 	chan &= 0xffff;
@@ -361,10 +367,6 @@ static int wm8505fb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = device_create_file(&pdev->dev, &dev_attr_contrast);
-	if (ret < 0)
-		fb_warn(&fbi->fb, "failed to register attributes (%d)\n", ret);
-
 	fb_info(&fbi->fb, "%s frame buffer at 0x%lx-0x%lx\n",
 		fbi->fb.fix.id, fbi->fb.fix.smem_start,
 		fbi->fb.fix.smem_start + fbi->fb.fix.smem_len - 1);
@@ -376,8 +378,6 @@ static int wm8505fb_remove(struct platform_device *pdev)
 {
 	struct wm8505fb_info *fbi = platform_get_drvdata(pdev);
 
-	device_remove_file(&pdev->dev, &dev_attr_contrast);
-
 	unregister_framebuffer(&fbi->fb);
 
 	writel(0, fbi->regbase);
@@ -399,6 +399,7 @@ static struct platform_driver wm8505fb_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = wmt_dt_ids,
+		.dev_groups	= wm8505fb_groups,
 	},
 };
 
-- 
2.22.0

