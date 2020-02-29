Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE217480D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 17:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgB2QbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 11:31:10 -0500
Received: from mailoutvs5.siol.net ([185.57.226.196]:46091 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbgB2QbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:31:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 88FF25235E3;
        Sat, 29 Feb 2020 17:31:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ug3nAeh9AHRw; Sat, 29 Feb 2020 17:31:06 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 3DB97523546;
        Sat, 29 Feb 2020 17:31:06 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id B66655235E3;
        Sat, 29 Feb 2020 17:31:03 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/bridge: dw-hdmi: Fix color space conversion detection
Date:   Sat, 29 Feb 2020 17:30:41 +0100
Message-Id: <20200229163043.158262-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200229163043.158262-1-jernej.skrabec@siol.net>
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, is_color_space_conversion() compares not only color spaces
but also formats. For example, function would return true if YCbCr 4:4:4
and YCbCr 4:2:2 would be set. Obviously in that case color spaces are
the same.

Fix that by comparing if both values represent RGB color space.

Fixes: b21f4b658df8 ("drm: imx: imx-hdmi: move imx-hdmi to bridge/dw_hdmi=
")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index 24965e53d351..9d7bfb1cb213 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -956,7 +956,8 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
=20
 static int is_color_space_conversion(struct dw_hdmi *hdmi)
 {
-	return hdmi->hdmi_data.enc_in_bus_format !=3D hdmi->hdmi_data.enc_out_b=
us_format;
+	return hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) !=3D
+		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format);
 }
=20
 static int is_color_space_decimation(struct dw_hdmi *hdmi)
--=20
2.25.1

