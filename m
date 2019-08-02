Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F847F58F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbfHBKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:55:23 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44694 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHBKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:55:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9ED5EFB03;
        Fri,  2 Aug 2019 12:55:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8ugkm27Dqmsp; Fri,  2 Aug 2019 12:55:18 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4DE9A47246; Fri,  2 Aug 2019 12:55:18 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: Drop unused imx-ipuv3-crtc.o build
Date:   Fri,  2 Aug 2019 12:55:18 +0200
Message-Id: <e5484fa33bffec220fd0590b502a962da17c9c72.1564743270.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since

commit 3d1df96ad468 ("drm/imx: merge imx-drm-core and ipuv3-crtc in one module")

imx-ipuv3-crtc.o is built via imxdrm-objs. So there's no need to keep an
extra entry with a non existing config value (CONFIG_DRM_IMX_IPUV3).

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/imx/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
index ab6c83caceb7..21cdcc2faabc 100644
--- a/drivers/gpu/drm/imx/Makefile
+++ b/drivers/gpu/drm/imx/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_DRM_IMX_PARALLEL_DISPLAY) += parallel-display.o
 obj-$(CONFIG_DRM_IMX_TVE) += imx-tve.o
 obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
 
-obj-$(CONFIG_DRM_IMX_IPUV3)	+= imx-ipuv3-crtc.o
 obj-$(CONFIG_DRM_IMX_HDMI) += dw_hdmi-imx.o
-- 
2.20.1

