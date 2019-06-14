Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A006D46492
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFNQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:43:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45235 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfFNQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:43:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so1839501pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEKdnhKR+/dWWRVZjYYO+x5HGCPCoPobrZ4wln/DJzY=;
        b=pt+MCQrYrr1z9usf53hpmCyEdhtX35GU4v450sx+7ngZfUg9lOUJdWuFI9JOxl8RTp
         CHUPQOKAzK2NXpws6xY7rj+PcC18JYJtjwgryLTh5NTOOLOBJcHS6zygGc3tgYy1fJyE
         efXaUwOts0I1GtXTgS8qdMApryCG8QaDzqmMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEKdnhKR+/dWWRVZjYYO+x5HGCPCoPobrZ4wln/DJzY=;
        b=quLOyyo6V5OOe6m2mtamFDyeUgv4hFVbyDpHAykxsAlpZil/3+o0q5KKtQKMPAkSVn
         yYUMcAzrg/oXwjFl2H7QvZns4GlYFwx4KKdFePtdHpqmJzSXFVBj6p2dl9s0v0K2u7+A
         fwOcBwz+OJyRq5BoPEgEcGdpjqd3NIXQNd30GC0e/HBY8MfTxFjdii9x7tMbptQdexwc
         mgQp1BeHdmJoLifUI84Kz+LHWZjKBiEbdXrFtBzXfCQsAQG26ykYQEkdNgvDuy47tmed
         w1kAPP43QJ7doR+N/M1akbWRfP2hqoz8krlCuolIZ28og8rNAkdt3yHIwnGvDpSfefsf
         I+zg==
X-Gm-Message-State: APjAAAWu/c0NRa2CjKU8bzqARVE15qIhsrKt6EtnyOv9bNsCmzHF2x6R
        17mwcdK+eZPZlkD0VkRwcV5WXg==
X-Google-Smtp-Source: APXvYqxVZ/VBMdd1plRYRlRdBu2PAEOFwSdXMjHmnSt33jJGhQ4n+lhUW7eRWumCYAU2L0kC+eo4hA==
X-Received: by 2002:a63:6881:: with SMTP id d123mr11058424pgc.201.1560530628964;
        Fri, 14 Jun 2019 09:43:48 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:43:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/9] drm/sun4i: tcon: Add TCON LCD support for R40
Date:   Fri, 14 Jun 2019 22:13:17 +0530
Message-Id: <20190614164324.9427-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON LCD0, LCD1 in allwinner R40, are used for managing
LCD interfaces like RGB, LVDS and DSI.

Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
tcon top.

Add support for it, in tcon driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9e9d08ee8387..9838913305a0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1471,6 +1471,13 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
 	.has_channel_1		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
+	.supports_lvds		= true,
+	.has_channel_0		= true,
+	/* TODO Need to support TCON output muxing via GPIO pins */
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks = {
 	.has_channel_1		= true,
 	.set_mux		= sun8i_r40_tcon_tv_set_mux,
@@ -1501,6 +1508,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-lcd", .data = &sun8i_r40_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-r40-tcon-tv", .data = &sun8i_r40_tv_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
-- 
2.18.0.321.gffc6fa0e3

