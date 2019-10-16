Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E14D88F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390059AbfJPHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:08:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43297 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389625AbfJPHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so16504345lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QPPY5QkhHs1s3gG1LOJFEzZqvjc2ZvRcoQB2OFBw/A=;
        b=N2vjmg8AaJoiQv+VLipY4w6nIR0pNgfsja6KU+gNCTBpcw2zmSAJEXy7AUzdx0OWds
         slW5h5w0UhSs2/em7byNINrF77V3VxW9uV5tylfvkwjKJclhBupdwoL66lbHP2rJ94Lr
         5Udu3xPCtJlaXObW9pVXCZHq9PqYNDfZnwI9Sdmh5D1cSYWLux9K2niTwm9yd9EUk74I
         MVVJ8FXNWivmBKwcFP8lTczrd3AbFbIS3g1pp4rsah+5+liIyzhf7MsN32ATMfUtOC1X
         nspBc4SHGKktM4XGwJ9eUaYSVqfYcyNVQtN3c0T/iqUEgBi4A5uoAlP41U3IjfWtjbyt
         VYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QPPY5QkhHs1s3gG1LOJFEzZqvjc2ZvRcoQB2OFBw/A=;
        b=oxoOXnHvMVtjvC3U6ccNVHfCNy6Kc4Ko5H1wO0sOf6uKDi8JgOhiZPG3YyHwDarCxj
         nGxCZlf7Zw1et03FBYR5ZisbP0hWHkJTdfoys+XeDZV+6uh/h2xMmJHgMmiB9XLQLtZ3
         VO21FmeN3GIg7q6Gj9x1iSXJpg/AFMZL6Mmy/zQDS+OZLP6DxK3yEYTZosgt/CqLAA4N
         +ZJyQSiqHWulFZQdx9HyQ9yXxFbz/o9wp5wNtwGROCXZCmepuofaU9EdjRvzhDEcGYgY
         FkIOlTXb20iP09v0nNh9QPK5MNmZZJBpK6AhWtKy6rdoAINqWFCXsxdkNiU9EONGK/FE
         7NMg==
X-Gm-Message-State: APjAAAWJKCOQVRycvnqyK2aZKKhbXv3xgh69ZgXJhE/X/2+SX4c6D0VC
        cRjD8CMty9VZQGrAPvzNrt0=
X-Google-Smtp-Source: APXvYqzdrpCO5abAkLvtSv/rX+8MUteWRMXrfGnkFwMYSf/c7Hc56GuVD7cEvVo0JuJAt5X9rZ9rRg==
X-Received: by 2002:a19:655b:: with SMTP id c27mr515862lfj.122.1571209667788;
        Wed, 16 Oct 2019 00:07:47 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:47 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 4/7] ASoC: sun4i-i2s: Add functions for RX and TX channel selects
Date:   Wed, 16 Oct 2019 09:07:37 +0200
Message-Id: <20191016070740.121435-5-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016070740.121435-1-codekipper@gmail.com>
References: <20191016070740.121435-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Newer SoCs like the H6 have the channel select bits in a different
positions than what is on the H3. As we will eventually add multi-
channel support then create function calls as opposed to regmap
fields to add support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 68 ++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8d28a386872f..19988d61a085 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -120,6 +120,8 @@
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
+#define SUN8I_I2S_TX_CHAN_SEL_MASK		GENMASK(2, 0)
+#define SUN8I_I2S_TX_CHAN_SEL(chan)		(chan - 1)
 
 #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
 #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
@@ -161,6 +163,8 @@ struct sun4i_i2s_quirks {
 	void	(*set_rxchanoffset)(const struct sun4i_i2s *);
 	void	(*set_txchanen)(const struct sun4i_i2s *, int, int);
 	void	(*set_rxchanen)(const struct sun4i_i2s *, int);
+	void	(*set_txchansel)(const struct sun4i_i2s *, int, int);
+	void	(*set_rxchansel)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -405,12 +409,8 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
 
 	/* Configure the channels */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
-			   SUN4I_I2S_CHAN_SEL_MASK,
-			   SUN4I_I2S_CHAN_SEL(channels));
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_RX_CHAN_SEL_REG,
-			   SUN4I_I2S_CHAN_SEL_MASK,
-			   SUN4I_I2S_CHAN_SEL(channels));
+	i2s->variant->set_txchansel(i2s, 0, channels);
+	i2s->variant->set_rxchansel(i2s, channels);
 
 	return 0;
 }
@@ -430,12 +430,8 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
 
 	/* Configure the channels */
-	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-			   SUN4I_I2S_CHAN_SEL_MASK,
-			   SUN4I_I2S_CHAN_SEL(channels));
-	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
-			   SUN4I_I2S_CHAN_SEL_MASK,
-			   SUN4I_I2S_CHAN_SEL(channels));
+	i2s->variant->set_txchansel(i2s, 0, channels);
+	i2s->variant->set_rxchansel(i2s, channels);
 
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
 			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
@@ -504,6 +500,40 @@ static void sun8i_i2s_set_rxchanen(const struct sun4i_i2s *i2s, int channel)
 			   SUN8I_I2S_TX_CHAN_EN(channel));
 }
 
+static void sun4i_i2s_set_txchansel(const struct sun4i_i2s *i2s, int output,
+				    int channel)
+{
+	if (output == 0)
+		regmap_write(i2s->regmap,
+			     SUN4I_I2S_TX_CHAN_SEL_REG,
+			     SUN4I_I2S_CHAN_SEL(channel));
+}
+
+static void sun8i_i2s_set_txchansel(const struct sun4i_i2s *i2s, int output,
+				    int channel)
+{
+	if (output >= 0 && output < 4)
+		regmap_update_bits(i2s->regmap,
+				   SUN8I_I2S_TX_CHAN_SEL_REG + (output * 4),
+				   SUN8I_I2S_TX_CHAN_SEL_MASK,
+				   SUN8I_I2S_TX_CHAN_SEL(channel));
+}
+
+static void sun4i_i2s_set_rxchansel(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_write(i2s->regmap,
+		     SUN4I_I2S_RX_CHAN_SEL_REG,
+		     SUN4I_I2S_CHAN_SEL(channel));
+}
+
+static void sun8i_i2s_set_rxchansel(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_update_bits(i2s->regmap,
+			   SUN8I_I2S_RX_CHAN_SEL_REG,
+			   SUN8I_I2S_TX_CHAN_SEL_MASK,
+			   SUN8I_I2S_TX_CHAN_SEL(channel));
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -528,6 +558,10 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Configure the channels */
+	i2s->variant->set_txchansel(i2s, 0, channels);
+	i2s->variant->set_rxchansel(i2s, channels);
+
 	if (i2s->variant->set_txchanen)
 		i2s->variant->set_txchanen(i2s, 0, channels);
 
@@ -1118,6 +1152,8 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
+	.set_txchansel		= sun4i_i2s_set_txchansel,
+	.set_rxchansel		= sun4i_i2s_set_rxchansel,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
@@ -1136,6 +1172,8 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
+	.set_txchansel		= sun4i_i2s_set_txchansel,
+	.set_rxchansel		= sun4i_i2s_set_rxchansel,
 };
 
 /*
@@ -1159,6 +1197,8 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
+	.set_txchansel		= sun4i_i2s_set_txchansel,
+	.set_rxchansel		= sun4i_i2s_set_rxchansel,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
@@ -1181,6 +1221,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.set_rxchanoffset	= sun8i_i2s_set_rxchanoffset,
 	.set_txchanen		= sun8i_i2s_set_txchanen,
 	.set_rxchanen		= sun8i_i2s_set_rxchanen,
+	.set_txchansel		= sun8i_i2s_set_txchansel,
+	.set_rxchansel		= sun8i_i2s_set_rxchansel,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
@@ -1199,6 +1241,8 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
+	.set_txchansel		= sun4i_i2s_set_txchansel,
+	.set_rxchansel		= sun4i_i2s_set_rxchansel,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
-- 
2.23.0

