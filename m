Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A967A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfGMMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 08:04:03 -0400
Received: from mailoutvs7.siol.net ([185.57.226.198]:35153 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727739AbfGMMEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 08:04:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 5CF29520E52;
        Sat, 13 Jul 2019 14:03:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bZRhldBXFahl; Sat, 13 Jul 2019 14:03:59 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 0566252059A;
        Sat, 13 Jul 2019 14:03:59 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id AC240520778;
        Sat, 13 Jul 2019 14:03:56 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/3] drm/sun4i: Introduce color encoding and range properties
Date:   Sat, 13 Jul 2019 14:03:44 +0200
Message-Id: <20190713120346.30349-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190713120346.30349-1-jernej.skrabec@siol.net>
References: <20190713120346.30349-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to correctly convert YUV color space to RGB, we have to know
color encoding and range.

Introduce these two properties using helper method.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index bd0e6a52d1d8..240a800217df 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -441,6 +441,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct=
 drm_device *drm,
 					       struct sun8i_mixer *mixer,
 					       int index)
 {
+	u32 supported_encodings, supported_ranges;
 	struct sun8i_vi_layer *layer;
 	unsigned int plane_cnt;
 	int ret;
@@ -469,6 +470,22 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struc=
t drm_device *drm,
 		return ERR_PTR(ret);
 	}
=20
+	supported_encodings =3D BIT(DRM_COLOR_YCBCR_BT601) |
+			      BIT(DRM_COLOR_YCBCR_BT709);
+
+	supported_ranges =3D BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+			   BIT(DRM_COLOR_YCBCR_FULL_RANGE);
+
+	ret =3D drm_plane_create_color_properties(&layer->plane,
+						supported_encodings,
+						supported_ranges,
+						DRM_COLOR_YCBCR_BT709,
+						DRM_COLOR_YCBCR_LIMITED_RANGE);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't add encoding and range properties!\n");
+		return ERR_PTR(ret);
+	}
+
 	drm_plane_helper_add(&layer->plane, &sun8i_vi_layer_helper_funcs);
 	layer->mixer =3D mixer;
 	layer->channel =3D index;
--=20
2.22.0

