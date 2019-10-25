Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB28E498D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410137AbfJYLNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:13:50 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:50448 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404433AbfJYLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:13:47 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HnDj210095USYZQ01nDj2M; Fri, 25 Oct 2019 13:13:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-Ob; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNvpi-0006IC-KD; Fri, 25 Oct 2019 11:24:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] drm/bridge: ti-tfp410: Update drm_connector_init_with_ddc() error message
Date:   Fri, 25 Oct 2019 11:24:33 +0200
Message-Id: <20191025092433.24138-1-geert+renesas@glider.be>
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
index aa3198dc9903cefb..5ca4c0417c186e6e 100644
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

