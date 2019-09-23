Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C558BB654
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407710AbfIWOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:14:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56720 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732495AbfIWOOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:14:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 79E4D1A02F0;
        Mon, 23 Sep 2019 16:14:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CD471A0262;
        Mon, 23 Sep 2019 16:14:20 +0200 (CEST)
Received: from fsr-ub1664-121.ea.freescale.net (fsr-ub1664-121.ea.freescale.net [10.171.82.171])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E01CB20613;
        Mon, 23 Sep 2019 16:14:19 +0200 (CEST)
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     agx@sigxcpu.org, l.stach@pengutronix.de, linux-imx@nxp.com,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/imx: compile imx directory by default
Date:   Mon, 23 Sep 2019 17:13:16 +0300
Message-Id: <1569248002-2485-3-git-send-email-laurentiu.palcu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the drm/imx/ directory is compiled only if DRM_IMX is set. Adding a
new IMX related IP in the same directory would need DRM_IMX to be set, which would
bring in also IPUv3 core driver...

The current patch would allow adding new IPs in the imx/ directory without needing
to set DRM_IMX.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 drivers/gpu/drm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 82ff826..a6191f8 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_DRM_MSM) += msm/
 obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-$(CONFIG_DRM_STM) += stm/
 obj-$(CONFIG_DRM_STI) += sti/
-obj-$(CONFIG_DRM_IMX) += imx/
+obj-y 			+= imx/
 obj-$(CONFIG_DRM_INGENIC) += ingenic/
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek/
 obj-$(CONFIG_DRM_MESON)	+= meson/
-- 
2.7.4

