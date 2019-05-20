Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665402385E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfETNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 09:38:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32852 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfETNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:38:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so1697279wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wgz8PuMWuN+4Z5p71iE5tvMWtrysycjZtvpJoHqTb8=;
        b=MFzRgLfcO1fE8BtJGYgW7dy78r2oMlQTupaOww9NPc63xJJu1uJDO3pVnYO+xYi1fm
         IEktfJOgOtkUh7m4wKGu7QyFGM7h5ks522Wb8RsUs2ZP3ynI4Rlu2utFvcl6h28xhY88
         yE7PXh3P7VjWbRnm1Bg1d+Q7Bkry3ejtzGRmh2gqDX+JDqMKH1hBbaABemGHiM5f40wN
         Rs7yW57OsSCERyHB71BCV/zQNMfNpq+vxuLWLeVnh4bsTs3MpwyW19NDFaSpLgv+UBNT
         fjJmwwNh083bMesydSKFwRKq5XVXvEWdJLhfsHIAMMWAaxJ+sDEhYfbFpDrFTu3Q91qH
         L1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wgz8PuMWuN+4Z5p71iE5tvMWtrysycjZtvpJoHqTb8=;
        b=JmNyAgB9ErKw0nNepUkSNbPss2QSEeMoBihPY+axx5Og94OehLd0Ah3mz6eAlpBZxO
         Bbf0c4MHYz9mZAYs3MlaQMBZhKjfPsJLKkjnDcFKaiweMcBkiFVrVW+AXywZ0xmLisNU
         rz7y7CFEDsOqm/3RWObjZI0Y0hbOyUSeye9ZvNaMrg7JvBeIU0NFFJnrlmtpifjj6rgB
         Bylo8oMC8cB0TVp4sDKg9e+8nj9bEiRUHNyIS3cwVSPpuk4YTLu1yaF65R/Jz2L2dKNZ
         rUjfSkJJIafowlkZ0m9LziLn1KWfXiOMhfQpUuHvZ5lTmcak56ST2J/l39Nbtk3VdFux
         IZRw==
X-Gm-Message-State: APjAAAUL4Rt3yhcJQQ/0kZvnwWcAKLnJz4IeSjGU7xv1ZqcGmErniJ+b
        j8rUTV+XGyUKk3MwSwDJcQQUew==
X-Google-Smtp-Source: APXvYqwFVGiliaIe2yHIHUvGdrFvbFinbVKbndUVa7UC/xbova7lvQo1At2nx2PcoZC9tcvPyp3rjQ==
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr18078192wrs.103.1558359481967;
        Mon, 20 May 2019 06:38:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t19sm12167059wmi.42.2019.05.20.06.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:38:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, hverkuil@xs4all.nl,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/meson: Output in YUV444 if sink supports it
Date:   Mon, 20 May 2019 15:37:53 +0200
Message-Id: <20190520133753.23871-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520133753.23871-1-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the YUV420 handling, we can dynamically setup the HDMI output
pixel format depending on the mode and connector info.
So now, we can output in YUV444, which is the native video pipeline
format, directly to the HDMI Sink if it's supported without
necessarily involving the HDMI Controller CSC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5d67e2beba58..8bf9db7f39a4 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -723,12 +723,23 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = &crtc_state->mode;
 	bool is_hdmi2_sink =
 		conn_state->connector->display_info.hdmi.scdc.supported;
+	bool specify_out_format = false;
+	u32 out_format;
 
 	if (drm_mode_is_420_only(info, mode) ||
 	    (!is_hdmi2_sink && drm_mode_is_420_also(info, mode)))
 		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
-	else
+	else {
 		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444) {
+			out_format = MEDIA_BUS_FMT_YUV8_1X24;
+			specify_out_format = true;
+		}
+	}
+
+	/* Set a connector bus format if required */
+	drm_display_info_set_bus_formats(info, &out_format,
+					 (specify_out_format ? 1 : 0));
 
 	/* Specify the encoder output format to the bridge */
 	if (!drm_bridge_format_set(encoder->bridge,
-- 
2.21.0

