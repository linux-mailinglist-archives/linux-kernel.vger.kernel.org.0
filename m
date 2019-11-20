Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33D2103BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfKTNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbfKTNgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:39 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479B521939;
        Wed, 20 Nov 2019 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256999;
        bh=KQHLvaPBIFjocC8JrZjfJUy2MvGrWCgUpnuB0PzKb8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=xXjWHhibAsMZrP90j1ZQgMWY7T+2rmkTlBUNnofBO6Lrr/k7ndoDndJUWLXuaGOx6
         KA2uFOCS+rpCB8G1rfLvwucMYJ8BKEg5tsHESurVVfPp3EhgkOGEwQog4T/n+H7dp+
         5IVNgd7weM+11CwRUwwJQ0XkT5cxOMuOta1NaUi4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:34 +0800
Message-Id: <20191120133634.11601-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/bridge/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 34362976cd6f..176efa18e32c 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -60,10 +60,10 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	---help---
-          This is a driver for the display bridges of
-          GE B850v3 that convert dual channel LVDS
-          to DP++. This is used with the i.MX6 imx-ldb
-          driver. You are likely to say N here.
+	  This is a driver for the display bridges of
+	  GE B850v3 that convert dual channel LVDS
+	  to DP++. This is used with the i.MX6 imx-ldb
+	  driver. You are likely to say N here.
 
 config DRM_NXP_PTN3460
 	tristate "NXP PTN3460 DP/LVDS bridge"
-- 
2.17.1

