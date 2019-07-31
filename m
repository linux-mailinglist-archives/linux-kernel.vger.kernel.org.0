Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFC7C1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbfGaMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387466AbfGaMoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CD6208E3;
        Wed, 31 Jul 2019 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577045;
        bh=dOauvtVe9yCPSP0ChARSYwAi6eemkfSk00etuTmxP94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDjo31Gp98T2gFdLY039cbiyj4PAacUBKvstkRQIB1ZAszuZ1lLwgJ4RrJkSdwedK
         d8bygUyV0zt4ievvAetFIsLr45vONXfpE6cNuMsj1/U+1gbVbvEBKFFUFaOlfvJR9x
         E8ronTcaI/nWIQomapLDtcVwHuImfvVG+Qvtqmtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 10/10] video: fbdev: sm501fb: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:49 +0200
Message-Id: <20190731124349.4474-11-gregkh@linuxfoundation.org>
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
and do not register "by hand" a bunch of sysfs files.

Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/sm501fb.c | 37 +++++++++--------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 6edb4492e675..3dd1b1d76e98 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1271,6 +1271,14 @@ static ssize_t sm501fb_debug_show_pnl(struct device *dev,
 
 static DEVICE_ATTR(fbregs_pnl, 0444, sm501fb_debug_show_pnl, NULL);
 
+static struct attribute *sm501fb_attrs[] = {
+	&dev_attr_crt_src.attr,
+	&dev_attr_fbregs_pnl.attr,
+	&dev_attr_fbregs_crt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sm501fb);
+
 /* acceleration operations */
 static int sm501fb_sync(struct fb_info *info)
 {
@@ -2011,33 +2019,9 @@ static int sm501fb_probe(struct platform_device *pdev)
 		goto err_started_crt;
 	}
 
-	/* create device files */
-
-	ret = device_create_file(dev, &dev_attr_crt_src);
-	if (ret)
-		goto err_started_panel;
-
-	ret = device_create_file(dev, &dev_attr_fbregs_pnl);
-	if (ret)
-		goto err_attached_crtsrc_file;
-
-	ret = device_create_file(dev, &dev_attr_fbregs_crt);
-	if (ret)
-		goto err_attached_pnlregs_file;
-
 	/* we registered, return ok */
 	return 0;
 
-err_attached_pnlregs_file:
-	device_remove_file(dev, &dev_attr_fbregs_pnl);
-
-err_attached_crtsrc_file:
-	device_remove_file(dev, &dev_attr_crt_src);
-
-err_started_panel:
-	unregister_framebuffer(info->fb[HEAD_PANEL]);
-	sm501_free_init_fb(info, HEAD_PANEL);
-
 err_started_crt:
 	unregister_framebuffer(info->fb[HEAD_CRT]);
 	sm501_free_init_fb(info, HEAD_CRT);
@@ -2067,10 +2051,6 @@ static int sm501fb_remove(struct platform_device *pdev)
 	struct fb_info	   *fbinfo_crt = info->fb[0];
 	struct fb_info	   *fbinfo_pnl = info->fb[1];
 
-	device_remove_file(&pdev->dev, &dev_attr_fbregs_crt);
-	device_remove_file(&pdev->dev, &dev_attr_fbregs_pnl);
-	device_remove_file(&pdev->dev, &dev_attr_crt_src);
-
 	sm501_free_init_fb(info, HEAD_CRT);
 	sm501_free_init_fb(info, HEAD_PANEL);
 
@@ -2234,6 +2214,7 @@ static struct platform_driver sm501fb_driver = {
 	.resume		= sm501fb_resume,
 	.driver		= {
 		.name	= "sm501-fb",
+		.dev_groups	= sm501fb_groups,
 	},
 };
 
-- 
2.22.0

