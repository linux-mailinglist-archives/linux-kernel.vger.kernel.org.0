Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB39CE86EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfJ2L2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 07:28:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:60276 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJ2L2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572348530; bh=7CvZFllA5Lo3ke7W4E4r8AmPqCtcdtZ72Xnw6OysY14=;
        h=From:To:Cc:Subject:Date:From;
        b=rCaxpPR2UhHDsQQ7Z4TX360K5iP0YBo4qKopDd7yNu0zAFiRBG39FmQ9J+Htaednr
         +MeXaB5cGXQf1+HuM+Q9pUW0qPMz1zRzTeXAWk/vQpOEVEh39u8M7s7xZvekDuPRK7
         JItx9M4N6QwfjCvlpk8RdiZC3Ybj8/1oWHZE2rkc=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm: sun4i: Add support for suspending the display driver
Date:   Tue, 29 Oct 2019 12:28:46 +0100
Message-Id: <20191029112846.3604925-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shut down the display engine during suspend.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
Changes in v2:
- spaces -> tabs

 drivers/gpu/drm/sun4i/sun4i_drv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index a5757b11b730..c519d7cfcf43 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -346,6 +346,27 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	return count;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sun4i_drv_drm_sys_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_suspend(drm);
+}
+
+static int sun4i_drv_drm_sys_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_resume(drm);
+}
+#endif
+
+static const struct dev_pm_ops sun4i_drv_drm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sun4i_drv_drm_sys_suspend,
+				sun4i_drv_drm_sys_resume)
+};
+
 static int sun4i_drv_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
@@ -418,6 +439,7 @@ static struct platform_driver sun4i_drv_platform_driver = {
 	.driver		= {
 		.name		= "sun4i-drm",
 		.of_match_table	= sun4i_drv_of_table,
+		.pm = &sun4i_drv_drm_pm_ops,
 	},
 };
 module_platform_driver(sun4i_drv_platform_driver);
-- 
2.23.0

