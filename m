Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2107276706
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGZNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:14:49 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36382 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfGZNOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:14:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D2B1FFB04;
        Fri, 26 Jul 2019 15:14:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yg1X5hpL5aQt; Fri, 26 Jul 2019 15:14:44 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3374D46AA4; Fri, 26 Jul 2019 15:14:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently
Date:   Fri, 26 Jul 2019 15:14:39 +0200
Message-Id: <a37dd5083462064f437ff62fd84e6576d8a7c8dc.1564146727.git.agx@sigxcpu.org>
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

We were already using the generic functions in our debugfs code, do the
same in jh057n_shutdown. This was suggested by Sam Ravnborg.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index 1037a201b4bb..b9109922397f 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -372,12 +372,12 @@ static void jh057n_shutdown(struct mipi_dsi_device *dsi)
 	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = jh057n_unprepare(&ctx->panel);
+	ret = drm_panel_unprepare(&ctx->panel);
 	if (ret < 0)
 		DRM_DEV_ERROR(&dsi->dev, "Failed to unprepare panel: %d\n",
 			      ret);
 
-	ret = jh057n_disable(&ctx->panel);
+	ret = drm_panel_disable(&ctx->panel);
 	if (ret < 0)
 		DRM_DEV_ERROR(&dsi->dev, "Failed to disable panel: %d\n",
 			      ret);
-- 
2.20.1

