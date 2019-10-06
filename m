Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8CDCD35E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJFQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 12:04:38 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47383 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJFQEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:04:38 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 44C978289D;
        Sun,  6 Oct 2019 16:04:33 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 2/3] drm/sun4i: dsi: fix the overhead of the horizontal front porch
Date:   Mon,  7 Oct 2019 00:03:01 +0800
Message-Id: <20191006160303.24413-3-icenowy@aosc.io>
In-Reply-To: <20191006160303.24413-1-icenowy@aosc.io>
References: <20191006160303.24413-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The formula in the BSP kernel indicates that a 16-byte overhead is used
when sending the HFP. However, this value is currently set to 6 in the
sun6i_mipi_dsi driver, which makes some panels flashing.

Fix this overhead value.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b8a0d0501ca7..8fe8051c34e6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -569,11 +569,12 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 			  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 		/*
-		 * The frontporch is set using a blanking packet (4
-		 * bytes + payload + 2 bytes). Its minimal size is
-		 * therefore 6 bytes
+		 * The frontporch is set using a sync event (4 bytes)
+		 * and two blanking packets (each one is 4 bytes +
+		 * payload + 2 bytes). Its minimal size is therefore
+		 * 16 bytes
 		 */
-#define HFP_PACKET_OVERHEAD	6
+#define HFP_PACKET_OVERHEAD	16
 		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
 			  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
 
-- 
2.21.0

