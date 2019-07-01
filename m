Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4722FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfETJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:08:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44501 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfETJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:08:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so6397719pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sJQDWzqf6+kvBieyTTKW4hSHxAIvKsqSqX7fldZgo8=;
        b=EUXAqPD+zMUvEbG7428ww5mAsFGnQByCmuG6Qa/la8dfjS5+9P56gMC7p6dIcNnXF3
         6wr1O4HDG01ShRzEo5mu9H399aUjZNZmcXVWTlHF1tlCB04vNwzyayniUsGNTbOubN08
         lqmrhOo8mzww4VOUtAwgtay505OjXpm5afyco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sJQDWzqf6+kvBieyTTKW4hSHxAIvKsqSqX7fldZgo8=;
        b=SiL571RI1Sw6pziD0PeIx1Ky60SVleDYa31/bxzyctsK8txHbC6Vq9LKPpT3VttJ9c
         vHC4wAvcENm7D/8D+hl6PI949nscS8BROpDjI0qH5J/xmDR2DQLItCn24Vj4Cp+S7yhw
         cOr31pgkqfUHDxKqo6d63wT+AVr44vFzSFlLMuRtEZaJgc/SgR9QlXXzD4jhHZVy/FGY
         nO96fY7QCTwml/dx823AJk6dsDI1UyeZbIzPjAnp8jTCW9oIIFZjrCiYvWvKc/yelA4H
         +liBkn3o00qdH/MGPANk8Gx9fyFvnyV/XJbUhZvlgBtSepLbvxdWWfQenTkcPOoidWnZ
         tNeA==
X-Gm-Message-State: APjAAAWgQs9Zsg2cO66Me2iHr5mH6OhflyifR9zZcL3rsaIuZByFwo+0
        AgxMGL/iWCTt4+0E9mzMNehmPQ==
X-Google-Smtp-Source: APXvYqzoTzd5ibMnHOKs8QSmQ9ECHVoQtC6hvpcTGyZOav8pazdUE2AYu0ii2mIN7SWHvV1sThnX0Q==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr928736pls.112.1558343284692;
        Mon, 20 May 2019 02:08:04 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:08:04 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v10 10/11] drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
Date:   Mon, 20 May 2019 14:33:17 +0530
Message-Id: <20190520090318.27570-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge
panel which can be used to connect via DSI port on BPI-M64 board,
so add a driver for it.

The same panel PCB comes with parallel RBG which is supported via
panel-simple driver with "bananapi,s070wv20-ct16" compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 293 ++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e36dbb4df867..d0cb2fa3e721 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -17,6 +17,15 @@ config DRM_PANEL_ARM_VERSATILE
 	  reference designs. The panel is detected using special registers
 	  in the Versatile family syscon registers.
 
+config DRM_PANEL_BANANAPI_S070WV20_ICN6211
+	tristate "Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Bananapi S070WV20-CT16 MIPI-DSI controller.
+
 config DRM_PANEL_LVDS
 	tristate "Generic LVDS panel driver"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 78e3dc376bdd..a68e990a4a73 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
+obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
 obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
diff --git a/drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c b/drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
new file mode 100644
index 000000000000..52a5b60278af
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct s070wv20 {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device	*backlight;
+	struct regulator	*vdd;
+	struct gpio_desc	*enable_gpio;
+	struct gpio_desc	*reset_gpio;
+};
+
+static inline struct s070wv20 *panel_to_s070wv20(struct drm_panel *panel)
+{
+	return container_of(panel, struct s070wv20, panel);
+}
+
+struct s070wv20_init_cmd {
+	size_t len;
+	const char *data;
+};
+
+#define S070WV20_INIT_CMD(...) { \
+	.len = sizeof((char[]){__VA_ARGS__}), \
+	.data = (char[]){__VA_ARGS__} }
+
+static const struct s070wv20_init_cmd s070wv20_init_cmds[] = {
+	S070WV20_INIT_CMD(0x7A, 0xC1),
+	S070WV20_INIT_CMD(0x20, 0x20),
+	S070WV20_INIT_CMD(0x21, 0xE0),
+	S070WV20_INIT_CMD(0x22, 0x13),
+	S070WV20_INIT_CMD(0x23, 0x28),
+	S070WV20_INIT_CMD(0x24, 0x30),
+	S070WV20_INIT_CMD(0x25, 0x28),
+	S070WV20_INIT_CMD(0x26, 0x00),
+	S070WV20_INIT_CMD(0x27, 0x0D),
+	S070WV20_INIT_CMD(0x28, 0x03),
+	S070WV20_INIT_CMD(0x29, 0x1D),
+	S070WV20_INIT_CMD(0x34, 0x80),
+	S070WV20_INIT_CMD(0x36, 0x28),
+	S070WV20_INIT_CMD(0xB5, 0xA0),
+	S070WV20_INIT_CMD(0x5C, 0xFF),
+	S070WV20_INIT_CMD(0x2A, 0x01),
+	S070WV20_INIT_CMD(0x56, 0x92),
+	S070WV20_INIT_CMD(0x6B, 0x71),
+	S070WV20_INIT_CMD(0x69, 0x2B),
+	S070WV20_INIT_CMD(0x10, 0x40),
+	S070WV20_INIT_CMD(0x11, 0x98),
+	S070WV20_INIT_CMD(0xB6, 0x20),
+	S070WV20_INIT_CMD(0x51, 0x20),
+	S070WV20_INIT_CMD(0x09, 0x10),
+};
+
+static int s070wv20_prepare(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	unsigned int i;
+	int ret;
+
+	ret = regulator_enable(ctx->vdd);
+	if (ret)
+		return ret;
+
+	msleep(50);
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+	msleep(50);
+
+	gpiod_set_value(ctx->enable_gpio, 1);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+	msleep(20);
+
+	for (i = 0; i < ARRAY_SIZE(s070wv20_init_cmds); i++) {
+		const struct s070wv20_init_cmd *cmd = &s070wv20_init_cmds[i];
+
+		ret = mipi_dsi_generic_write(dsi, cmd->data, cmd->len);
+		if (ret < 0)
+			return ret;
+
+		msleep(10);
+	}
+
+	return 0;
+}
+
+static int s070wv20_enable(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+
+	msleep(120);
+
+	mipi_dsi_dcs_set_display_on(ctx->dsi);
+	backlight_enable(ctx->backlight);
+
+	return 0;
+}
+
+static int s070wv20_disable(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+
+	backlight_disable(ctx->backlight);
+	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+}
+
+static int s070wv20_unprepare(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+
+	msleep(100);
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	gpiod_set_value(ctx->enable_gpio, 0);
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+
+	regulator_disable(ctx->vdd);
+
+	return 0;
+}
+
+static const struct drm_display_mode s070wv20_default_mode = {
+	.clock = 30000,
+	.vrefresh = 60,
+
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 40,
+
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 29,
+
+	.width_mm	= 86,
+	.height_mm	= 154,
+};
+
+static int s070wv20_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &s070wv20_default_mode);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			s070wv20_default_mode.hdisplay,
+			s070wv20_default_mode.vdisplay,
+			s070wv20_default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	panel->connector->display_info.width_mm = mode->width_mm;
+	panel->connector->display_info.height_mm = mode->height_mm;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs s070wv20_funcs = {
+	.disable = s070wv20_disable,
+	.unprepare = s070wv20_unprepare,
+	.prepare = s070wv20_prepare,
+	.enable = s070wv20_enable,
+	.get_modes = s070wv20_get_modes,
+};
+
+static int s070wv20_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device_node *np;
+	struct s070wv20 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = &dsi->dev;
+	ctx->panel.funcs = &s070wv20_funcs;
+
+	ctx->vdd = devm_regulator_get(&dsi->dev, "vdd");
+	if (IS_ERR(ctx->vdd)) {
+		dev_err(&dsi->dev, "Couldn't get vdd regulator\n");
+		return PTR_ERR(ctx->vdd);
+	}
+
+	ctx->enable_gpio = devm_gpiod_get(&dsi->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->enable_gpio)) {
+		dev_err(&dsi->dev, "Couldn't get our enable GPIO\n");
+		return PTR_ERR(ctx->enable_gpio);
+	}
+
+	ctx->reset_gpio = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(ctx->reset_gpio);
+	}
+
+	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
+	if (np) {
+		ctx->backlight = of_find_backlight_by_node(np);
+		of_node_put(np);
+
+		if (!ctx->backlight)
+			return -EPROBE_DEFER;
+	}
+
+	ret = drm_panel_add(&ctx->panel);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int s070wv20_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct s070wv20 *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+
+	if (ctx->backlight)
+		put_device(&ctx->backlight->dev);
+
+	return 0;
+}
+
+static const struct of_device_id s070wv20_of_match[] = {
+	{ .compatible = "bananapi,s070wv20-ct16-icn6211", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s070wv20_of_match);
+
+static struct mipi_dsi_driver s070wv20_driver = {
+	.probe = s070wv20_dsi_probe,
+	.remove = s070wv20_dsi_remove,
+	.driver = {
+		.name = "bananapi-s070wv20-ct16-icn6211",
+		.of_match_table = s070wv20_of_match,
+	},
+};
+module_mipi_dsi_driver(s070wv20_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.321.gffc6fa0e3

