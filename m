Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46CC4A54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfJBJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 05:15:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35797 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfJBJPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:15:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so18765999wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxTpW7aIW5om1+0XG6oDJwJqyG3wGULVmcF8DWML2xE=;
        b=RU5ws+MORzbDEp2XaHiqix4PQvg9fmT5J77G5BWro6wxfGAYkc0FzpDOtws7wgP9ML
         WBVh+nhfR0eFPwrcV6d5tZ5joVF8AJLzkKVnqEPdVLWp+NMiCADYAsEbYAzIikn8LKO7
         pOnocyONoWp9zlU9k+kE5fnmsWWY1s+IB0tJSyoOa078NESUVmNwL0UaNCsj5OVSlD5A
         f63rLASv4M/Yv2NV2lPV/u6XBioWjU4MSi4qCerpflxIQ4VEfNxzozlJ9wXBM3HNwsGY
         uRXVSuIyzs8nOrNeZGwA8Wc/iMp/iVNvnrKwa2nBC5Q/4gY8DFtuQXW/7/dJIeYPjK7t
         37qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxTpW7aIW5om1+0XG6oDJwJqyG3wGULVmcF8DWML2xE=;
        b=WSYuSA9unC5UjwVA3tZeqO4uKMKDw11lGNYQBCedLo+KIzOpVNCz6gFtkMJu8BeOAk
         CwV6kOFMk2svxVv0lHov43CMfalqFaKVFvPdROL9CgKKss3v70b45gODBqX/a9byLQj3
         DmVL5KaYWAJRaN7LhUig/WoqjU/2jmb7qobZgBUJafEigyI0O9i+Co1XtJSxsrpw9dxT
         HkA5J+bBFI2uBuSjRgMWrcVQ4r4/yshLekEr2z9+svF4WxuYMHqE5l/ChHlh0jFDvZBL
         KPgNHcKHHO2BNKrAw/skaBjIm9zc866jtXm8JJQcs3u5/ADvT2f6NyfU56n9NSUoAkVP
         440w==
X-Gm-Message-State: APjAAAWpV7h8bGezZjJBcOfRk7fmv7nXIr7shj2g9pXZafcvcBvUcuOb
        80RvJkf7qPZTkmBYufpNLx/AXlfKyaU=
X-Google-Smtp-Source: APXvYqx1736herAPKKgE29GgqL3DpNmx24l6YALm4+02c9bj6oWnVE2UlupPUMbMxVvAYQUc0F9QDg==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr1926943wru.286.1570007738498;
        Wed, 02 Oct 2019 02:15:38 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r13sm32913737wrn.0.2019.10.02.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:15:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] clk: meson: axg-audio: provide clk top signal name
Date:   Wed,  2 Oct 2019 11:15:28 +0200
Message-Id: <20191002091529.17112-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002091529.17112-1-jbrunet@baylibre.com>
References: <20191002091529.17112-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The peripheral clock on the sm1 goes through some muxes
and dividers before reaching the audio gates. To model that,
without repeating our self too much, the "top" clock signal
is introduced and will serve as a the parent of the gates.

On the axg and g12a, the top clock is just a pass-through to
the audio peripheral clock provided by the main controller.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 18 +++++++++++++++---
 drivers/clk/meson/axg-audio.h |  3 ++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index ce8836776d1c..1a4c50a29ad7 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -74,9 +74,7 @@
 	.hw.init = &(struct clk_init_data) {				\
 		.name = "aud_"#_name,					\
 		.ops = &clk_regmap_gate_ops,				\
-		.parent_data = &(const struct clk_parent_data) {	\
-			.fw_name = "pclk",				\
-		},							\
+		.parent_names = (const char *[]){ "aud_top" },		\
 		.num_parents = 1,					\
 	},								\
 }
@@ -504,6 +502,18 @@ static struct clk_regmap tdmout_c_lrclk =
 	AUD_TDM_LRLCK(out_c, AUDIO_CLK_TDMOUT_C_CTRL);
 
 /* AXG/G12A Clocks */
+static struct clk_hw axg_aud_top = {
+	.init = &(struct clk_init_data) {
+		/* Provide aud_top signal name on axg and g12a */
+		.name = "aud_top",
+		.ops = &(const struct clk_ops) {},
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "pclk",
+		},
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap mst_a_mclk_sel =
 	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_MCLK_A_CTRL);
 static struct clk_regmap mst_b_mclk_sel =
@@ -691,6 +701,7 @@ static struct clk_hw_onecell_data axg_audio_hw_onecell_data = {
 		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
 		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
 		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
+		[AUD_CLKID_TOP]			= &axg_aud_top,
 		[NR_CLKS] = NULL,
 	},
 	.num = NR_CLKS,
@@ -835,6 +846,7 @@ static struct clk_hw_onecell_data g12a_audio_hw_onecell_data = {
 		[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
 		[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
 		[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
+		[AUD_CLKID_TOP]			= &axg_aud_top,
 		[NR_CLKS] = NULL,
 	},
 	.num = NR_CLKS,
diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
index c00e28b2e1a9..a4956837f597 100644
--- a/drivers/clk/meson/axg-audio.h
+++ b/drivers/clk/meson/axg-audio.h
@@ -116,9 +116,10 @@
 #define AUD_CLKID_SPDIFOUT_B_CLK_SEL	153
 #define AUD_CLKID_SPDIFOUT_B_CLK_DIV	154
 
+
 /* include the CLKIDs which are part of the DT bindings */
 #include <dt-bindings/clock/axg-audio-clkc.h>
 
-#define NR_CLKS	163
+#define NR_CLKS	164
 
 #endif /*__AXG_AUDIO_CLKC_H */
-- 
2.21.0

