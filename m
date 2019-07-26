Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA77A76704
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGZNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:14:46 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36352 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfGZNOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:14:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E1017FB03;
        Fri, 26 Jul 2019 15:14:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u1mgCVL2meXc; Fri, 26 Jul 2019 15:14:43 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2ADC346AA2; Fri, 26 Jul 2019 15:14:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
Date:   Fri, 26 Jul 2019 15:14:38 +0200
Message-Id: <6b237a570cb368dc4471fb8feb3a0441813cd576.1564146727.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564146727.git.agx@sigxcpu.org>
References: <cover.1564146727.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of them had these already but two mere missing. This eases
debugging.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index fed24c51d48b..1037a201b4bb 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -127,7 +127,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
+		DRM_DEV_ERROR(dev, "Failed to exit sleep mode: %d\n", ret);
 		return ret;
 	}
 	/* Panel is operational 120 msec after reset */
@@ -351,7 +351,9 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?\n");
+		DRM_DEV_ERROR(dev,
+			      "mipi_dsi_attach failed (%d). Is host ready?\n",
+			      ret);
 		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
-- 
2.20.1

