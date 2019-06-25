Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D602A52959
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfFYKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 06:24:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56404 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFYKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:24:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 5B0F2288E52
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     kernel@collabora.com, m.szyprowski@samsung.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 2/2] drm/exynos: Provide ddc symlink in connector's sysfs
Date:   Tue, 25 Jun 2019 12:24:41 +0200
Message-Id: <c8cc4ab32a4470576f9188c148a65c59c048d58a.1561458051.git.andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1561458051.git.andrzej.p@collabora.com>
References: <20190625101655.n246vbwtupb4eoyz@shell.armlinux.org.uk>
 <cover.1561458051.git.andrzej.p@collabora.com>
In-Reply-To: <cover.1561458051.git.andrzej.p@collabora.com>
References: <cover.1561458051.git.andrzej.p@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the ddc provided by the generic connector.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 894a99793633..6816e37861b7 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -126,7 +126,6 @@ struct hdmi_context {
 	void __iomem			*regs;
 	void __iomem			*regs_hdmiphy;
 	struct i2c_client		*hdmiphy_port;
-	struct i2c_adapter		*ddc_adpt;
 	struct gpio_desc		*hpd_gpio;
 	int				irq;
 	struct regmap			*pmureg;
@@ -872,10 +871,10 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	if (!hdata->ddc_adpt)
+	if (!connector->ddc)
 		return -ENODEV;
 
-	edid = drm_get_edid(connector, hdata->ddc_adpt);
+	edid = drm_get_edid(connector, connector->ddc);
 	if (!edid)
 		return -ENODEV;
 
@@ -1893,7 +1892,7 @@ static int hdmi_get_ddc_adapter(struct hdmi_context *hdata)
 		return -EPROBE_DEFER;
 	}
 
-	hdata->ddc_adpt = adpt;
+	hdata->connector.ddc = adpt;
 
 	return 0;
 }
@@ -2045,7 +2044,7 @@ static int hdmi_probe(struct platform_device *pdev)
 	if (hdata->regs_hdmiphy)
 		iounmap(hdata->regs_hdmiphy);
 err_ddc:
-	put_device(&hdata->ddc_adpt->dev);
+	put_device(&hdata->connector.ddc->dev);
 
 	return ret;
 }
@@ -2072,7 +2071,7 @@ static int hdmi_remove(struct platform_device *pdev)
 	if (hdata->regs_hdmiphy)
 		iounmap(hdata->regs_hdmiphy);
 
-	put_device(&hdata->ddc_adpt->dev);
+	put_device(&hdata->connector.ddc->dev);
 
 	mutex_destroy(&hdata->mutex);
 
-- 
2.17.1

