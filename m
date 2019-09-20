Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A797B9680
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfITR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 13:29:28 -0400
Received: from vps.xff.cz ([195.181.215.36]:40652 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfITR32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1569000566; bh=yFh3SHDAWhDFWZ5U5l/Fjokt0AcfkOIyuWq4AwQu/1I=;
        h=From:To:Cc:Subject:Date:From;
        b=BurnvNZgHpqgi/eynnP37W8qjm5smxV9mFxNb/P2HCRa1yCfRpDl/aVWnCjBqF1xT
         7VrjpaRFq8lr99bIywaCbc875zzJoqbP65yjBYuwuKPx/BQYfhLNzvY05CbKN8U96U
         ykzSiij1086wXyyLCickKTAEqPUclG7xSWCH74Do=
From:   megous@megous.com
To:     dri-devel@lists.freedesktop.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: Remove redundant of_device_is_available check
Date:   Fri, 20 Sep 2019 19:29:14 +0200
Message-Id: <20190920172914.4015180-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This check is already performed by of_graph_get_remote_node. No
need to repeat it immediately after the call.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/drm_of.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 43d89dd59c6b..0ca58803ba46 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -247,17 +247,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 		*panel = NULL;
 
 	remote = of_graph_get_remote_node(np, port, endpoint);
 	if (!remote)
 		return -ENODEV;
 
-	if (!of_device_is_available(remote)) {
-		of_node_put(remote);
-		return -ENODEV;
-	}
-
 	if (panel) {
 		*panel = of_drm_find_panel(remote);
 		if (!IS_ERR(*panel))
 			ret = 0;
 		else
 			*panel = NULL;
-- 
2.23.0

