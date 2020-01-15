Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16ED13C213
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 13:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgAOM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 07:56:57 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:50658 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgAOM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:56:57 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id qcwv210015USYZQ01cwvsp; Wed, 15 Jan 2020 13:56:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iriEA-00049r-T4; Wed, 15 Jan 2020 13:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iriEA-0001Ry-Qq; Wed, 15 Jan 2020 13:56:54 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend/trivial] drm/bridge: ti-tfp410: Update drm_connector_init_with_ddc() error message
Date:   Wed, 15 Jan 2020 13:56:53 +0100
Message-Id: <20200115125653.5519-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was changed to call drm_connector_init_with_ddc() instead of
drm_connector_init(), but the corresponding error message was not
updated.

Fixes: cfb444552926989f ("drm/bridge: ti-tfp410: Provide ddc symlink in connector sysfs directory")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 6f6d6d1e60ae9162..f195a4732e0badac 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -140,7 +140,8 @@ static int tfp410_attach(struct drm_bridge *bridge)
 					  dvi->connector_type,
 					  dvi->ddc);
 	if (ret) {
-		dev_err(dvi->dev, "drm_connector_init() failed: %d\n", ret);
+		dev_err(dvi->dev, "drm_connector_init_with_ddc() failed: %d\n",
+			ret);
 		return ret;
 	}
 
-- 
2.17.1

