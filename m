Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF76D5F4D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfGDIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 04:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfGDIrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:47:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A113F218A6;
        Thu,  4 Jul 2019 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230027;
        bh=9kr+WquUsx/ezUvWIT9JMoBqrRGzTuebO01ejx6/NRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TR1gRN+oqWdeQDSWJvCKh7HzTKLd6dE8gajijp4mu1AYkPuXfIlFWNHNkf3Fk426
         XcZJ74dIURrNuzD004fFCALLfWCZSt8ElpRqi2KKTRbXuYF/9pufzkJtKve9vg8odo
         +w5WYKJKuOX7MVh4ZmcbYP+gZkbz3XTG2rLVlNeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/11] video: fbdev: sm501fb: convert platform driver to use dev_groups
Date:   Thu,  4 Jul 2019 10:46:15 +0200
Message-Id: <20190704084617.3602-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a bunch of sysfs files.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/sm501fb.c | 37 +++++++++--------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index dde52d027416..c633ee76a73d 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1274,6 +1274,14 @@ static ssize_t sm501fb_debug_show_pnl(struct device *dev,
 
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
@@ -2016,33 +2024,9 @@ static int sm501fb_probe(struct platform_device *pdev)
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
@@ -2072,10 +2056,6 @@ static int sm501fb_remove(struct platform_device *pdev)
 	struct fb_info	   *fbinfo_crt = info->fb[0];
 	struct fb_info	   *fbinfo_pnl = info->fb[1];
 
-	device_remove_file(&pdev->dev, &dev_attr_fbregs_crt);
-	device_remove_file(&pdev->dev, &dev_attr_fbregs_pnl);
-	device_remove_file(&pdev->dev, &dev_attr_crt_src);
-
 	sm501_free_init_fb(info, HEAD_CRT);
 	sm501_free_init_fb(info, HEAD_PANEL);
 
@@ -2233,6 +2213,7 @@ static int sm501fb_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver sm501fb_driver = {
+	.dev_groups	= sm501fb_groups,
 	.probe		= sm501fb_probe,
 	.remove		= sm501fb_remove,
 	.suspend	= sm501fb_suspend,
-- 
2.22.0

