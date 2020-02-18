Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1371629CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBRPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 10:47:51 -0500
Received: from verein.lst.de ([213.95.11.211]:38838 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgBRPru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:47:50 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id 59E2D68C4E; Tue, 18 Feb 2020 16:47:48 +0100 (CET)
From:   Torsten Duwe <duwe@lst.de>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH] drm/bridge: analogix-anx6345: Avoid duplicate -supply suffix
Message-Id: <20200218154748.59E2D68C4E@verein.lst.de>
Date:   Tue, 18 Feb 2020 16:47:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_regulator() will unconditionally add "-supply" to form the
property name. This is documented in commit 69511a452e6dc ("map consumer
regulator based on device tree"). Remove the suffix from the requests.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
https://patchwork.freedesktop.org/patch/343005/
https://lists.freedesktop.org/archives/dri-devel/2020-January/253535.html

--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -712,14 +709,14 @@ static int anx6345_i2c_probe(struct i2c_client *client,
 		DRM_DEBUG("No panel found\n");
 
 	/* 1.2V digital core power regulator  */
-	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12-supply");
+	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
 	if (IS_ERR(anx6345->dvdd12)) {
 		DRM_ERROR("dvdd12-supply not found\n");
 		return PTR_ERR(anx6345->dvdd12);
 	}
 
 	/* 2.5V digital core power regulator  */
-	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
+	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
 	if (IS_ERR(anx6345->dvdd25)) {
 		DRM_ERROR("dvdd25-supply not found\n");
 		return PTR_ERR(anx6345->dvdd25);
