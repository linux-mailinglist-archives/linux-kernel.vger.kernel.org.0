Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911BB11A46A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 07:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfLKGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 01:20:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34854 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfLKGUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:20:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so10241170pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6L+fh7OnQT1zXjxbAvo/8bLa08LP3Xh+NSarGpgTMs=;
        b=Z5oQQgTXY4M6w80jvS8rMzJy3iV0k0Ioluhy9WOof/EljqU5L25IBI5TrJiv2MPv2/
         ZAdWLRg5wfZCQvim6rfZTBj9z25P26KtH1s1AzSnzzPlTT6u+aYp+TS6Y+1Y5TFWyLde
         IhqEz3MP4XMcs0mI2gspvBvXTVdwI7XXk53Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6L+fh7OnQT1zXjxbAvo/8bLa08LP3Xh+NSarGpgTMs=;
        b=PXF9BeFDRx5Mj1BSLwpKsrF6Cx0fOy1XWWy1AFgGVQl0ZYMA2O/oE4GellVAAqjanZ
         DWumnEQy96c4K8aC58uRFp9/2Zol9jV3ySaCRU9blV8DWX56kMPwhdA1FgJSLdOaa4dI
         IMVJJzch2lvaAnUDijSIoKc+3p1j8elJJTVpAWTDbVpas9fQD82jfqp9PDV2eib4ZHov
         WWj+MWIQpgW7W7eNHtPqCu6jxPvQMvzC5JPieK7ZHOaAJxXKWAGu297NSvRh5M12Ux7x
         7sV+fWJ2OGOjAcckracgiGKQoi5oseVAxop6IY9qnJEp+V3tXyp9TU47JV4G111Cwyiy
         Ij1g==
X-Gm-Message-State: APjAAAUPFbnSfoyIVhvzpllxGFum93Y7JzKsoNBA3c/BTSbXmBkW5oGW
        ZNDMrpQ2XGmgiZXSUAxpp4L2lw==
X-Google-Smtp-Source: APXvYqzz1QtCUz1uFE8/wLLLXuMve6JE06CMZfgpamSZFnEjX9LIPf3aMha3XlLC6WjMVamquljU6Q==
X-Received: by 2002:a63:e0f:: with SMTP id d15mr2264222pgl.255.1576045200089;
        Tue, 10 Dec 2019 22:20:00 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id h5sm1225579pfk.30.2019.12.10.22.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 22:19:59 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RESEND 4/4] drm: bridge: Generic GPIO mux driver
Date:   Wed, 11 Dec 2019 14:19:11 +0800
Message-Id: <20191211061911.238393-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20191211061911.238393-1-hsinyi@chromium.org>
References: <20191211061911.238393-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

This driver supports single input, 2 output display mux (e.g.
HDMI mux), that provide its status via a GPIO.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/Kconfig            |  10 +
 drivers/gpu/drm/bridge/Makefile           |   1 +
 drivers/gpu/drm/bridge/generic-gpio-mux.c | 306 ++++++++++++++++++++++
 3 files changed, 317 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 1f3fc6bec842..4734f6993858 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -54,6 +54,16 @@ config DRM_DUMB_VGA_DAC
 	  Support for non-programmable RGB to VGA DAC bridges, such as ADI
 	  ADV7123, TI THS8134 and THS8135 or passive resistor ladder DACs.
 
+config DRM_GENERIC_GPIO_MUX
+	tristate "Generic GPIO-controlled mux"
+	depends on OF
+	select DRM_KMS_HELPER
+	---help---
+	  This bridge driver models a GPIO-controlled display mux with one
+	  input, 2 outputs (e.g. an HDMI mux). The hardware decides which output
+	  is active, reports it as a GPIO, and the driver redirects calls to the
+	  appropriate downstream bridge (if any).
+
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 7a1e0ec032e6..1c0c92667ac4 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_ANALOGIX_ANX7688) += analogix-anx7688.o
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
+obj-$(CONFIG_DRM_GENERIC_GPIO_MUX) += generic-gpio-mux.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
diff --git a/drivers/gpu/drm/bridge/generic-gpio-mux.c b/drivers/gpu/drm/bridge/generic-gpio-mux.c
new file mode 100644
index 000000000000..ba08321dcc17
--- /dev/null
+++ b/drivers/gpu/drm/bridge/generic-gpio-mux.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic gpio mux bridge driver
+ *
+ * Copyright 2016 Google LLC
+ */
+
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_graph.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
+
+struct gpio_display_mux {
+	struct device *dev;
+
+	struct gpio_desc *gpiod_detect;
+	int detect_irq;
+
+	struct drm_bridge bridge;
+
+	struct drm_bridge *next[2];
+};
+
+static inline struct gpio_display_mux *bridge_to_gpio_display_mux(
+		struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct gpio_display_mux, bridge);
+}
+
+static irqreturn_t gpio_display_mux_det_threaded_handler(int unused, void *data)
+{
+	struct gpio_display_mux *gpio_display_mux = data;
+	int active = gpiod_get_value(gpio_display_mux->gpiod_detect);
+
+	dev_dbg(gpio_display_mux->dev, "Interrupt %d!\n", active);
+
+	if (gpio_display_mux->bridge.dev)
+		drm_kms_helper_hotplug_event(gpio_display_mux->bridge.dev);
+
+	return IRQ_HANDLED;
+}
+
+static int gpio_display_mux_attach(struct drm_bridge *bridge)
+{
+	struct gpio_display_mux *gpio_display_mux =
+			bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
+		next = gpio_display_mux->next[i];
+		if (next)
+			next->encoder = bridge->encoder;
+	}
+
+	return 0;
+}
+
+static bool gpio_display_mux_mode_fixup(struct drm_bridge *bridge,
+				const struct drm_display_mode *mode,
+				struct drm_display_mode *adjusted_mode)
+{
+	struct gpio_display_mux *gpio_display_mux =
+		bridge_to_gpio_display_mux(bridge);
+	int active;
+	struct drm_bridge *next;
+
+	active = gpiod_get_value(gpio_display_mux->gpiod_detect);
+	next = gpio_display_mux->next[active];
+
+	if (next && next->funcs->mode_fixup)
+		return next->funcs->mode_fixup(next, mode, adjusted_mode);
+	else
+		return true;
+}
+
+static void gpio_display_mux_mode_set(struct drm_bridge *bridge,
+				struct drm_display_mode *mode,
+				struct drm_display_mode *adjusted_mode)
+{
+	struct gpio_display_mux *gpio_display_mux =
+		bridge_to_gpio_display_mux(bridge);
+	int active;
+	struct drm_bridge *next;
+
+	active = gpiod_get_value(gpio_display_mux->gpiod_detect);
+	next = gpio_display_mux->next[active];
+
+	if (next && next->funcs->mode_set)
+		next->funcs->mode_set(next, mode, adjusted_mode);
+}
+
+/**
+ * Since this driver _reacts_ to mux changes, we need to make sure all
+ * downstream bridges are pre-enabled.
+ */
+static void gpio_display_mux_pre_enable(struct drm_bridge *bridge)
+{
+	struct gpio_display_mux *gpio_display_mux =
+		bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
+		next = gpio_display_mux->next[i];
+		if (next && next->funcs->pre_enable)
+			next->funcs->pre_enable(next);
+	}
+}
+
+static void gpio_display_mux_post_disable(struct drm_bridge *bridge)
+{
+	struct gpio_display_mux *gpio_display_mux =
+		bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
+		next = gpio_display_mux->next[i];
+		if (next && next->funcs->post_disable)
+			next->funcs->post_disable(next);
+	}
+}
+
+/**
+ * In an ideal mux driver, only the currently selected bridge should be enabled.
+ * For the sake of simplicity, we just just enable/disable all downstream
+ * bridges at the same time.
+ */
+static void gpio_display_mux_enable(struct drm_bridge *bridge)
+{
+	struct gpio_display_mux *gpio_display_mux =
+		bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
+		next = gpio_display_mux->next[i];
+		if (next && next->funcs->enable)
+			next->funcs->enable(next);
+	}
+}
+
+static void gpio_display_mux_disable(struct drm_bridge *bridge)
+{
+	struct gpio_display_mux *gpio_display_mux =
+		bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
+		next = gpio_display_mux->next[i];
+		if (next && next->funcs->disable)
+			next->funcs->disable(next);
+	}
+}
+
+static const struct drm_bridge_funcs gpio_display_mux_bridge_funcs = {
+	.attach = gpio_display_mux_attach,
+	.mode_fixup = gpio_display_mux_mode_fixup,
+	.disable = gpio_display_mux_disable,
+	.post_disable = gpio_display_mux_post_disable,
+	.mode_set = gpio_display_mux_mode_set,
+	.pre_enable = gpio_display_mux_pre_enable,
+	.enable = gpio_display_mux_enable,
+};
+
+static int gpio_display_mux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_display_mux *gpio_display_mux;
+	struct device_node *port, *ep, *remote;
+	int ret;
+	u32 reg;
+
+	gpio_display_mux = devm_kzalloc(dev, sizeof(*gpio_display_mux),
+					GFP_KERNEL);
+	if (!gpio_display_mux)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, gpio_display_mux);
+	gpio_display_mux->dev = &pdev->dev;
+
+	gpio_display_mux->bridge.of_node = dev->of_node;
+
+	gpio_display_mux->gpiod_detect =
+		devm_gpiod_get(dev, "detect", GPIOD_IN);
+	if (IS_ERR(gpio_display_mux->gpiod_detect))
+		return PTR_ERR(gpio_display_mux->gpiod_detect);
+
+	gpio_display_mux->detect_irq =
+		gpiod_to_irq(gpio_display_mux->gpiod_detect);
+	if (gpio_display_mux->detect_irq < 0) {
+		dev_err(dev, "Failed to get output irq %d\n",
+			gpio_display_mux->detect_irq);
+		return -ENODEV;
+	}
+
+	port = of_graph_get_port_by_id(dev->of_node, 1);
+	if (!port) {
+		dev_err(dev, "Missing output port node\n");
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(port, ep) {
+		if (!ep->name || (of_node_cmp(ep->name, "endpoint") != 0)) {
+			of_node_put(ep);
+			continue;
+		}
+
+		if (of_property_read_u32(ep, "reg", &reg) < 0 ||
+				reg >= ARRAY_SIZE(gpio_display_mux->next)) {
+			dev_err(dev,
+			    "Missing/invalid reg property for endpoint %s\n",
+				ep->full_name);
+			of_node_put(ep);
+			of_node_put(port);
+			return -EINVAL;
+		}
+
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote) {
+			dev_err(dev,
+			    "Missing connector/bridge node for endpoint %s\n",
+				ep->full_name);
+			of_node_put(ep);
+			of_node_put(port);
+			return -EINVAL;
+		}
+		of_node_put(ep);
+
+		if (of_device_is_compatible(remote, "hdmi-connector")) {
+			of_node_put(remote);
+			continue;
+		}
+
+		gpio_display_mux->next[reg] = of_drm_find_bridge(remote);
+		if (!gpio_display_mux->next[reg]) {
+			dev_err(dev, "Waiting for external bridge %s\n",
+				remote->name);
+			of_node_put(remote);
+			of_node_put(port);
+			return -EPROBE_DEFER;
+		}
+
+		of_node_put(remote);
+	}
+	of_node_put(port);
+
+	gpio_display_mux->bridge.funcs = &gpio_display_mux_bridge_funcs;
+	drm_bridge_add(&gpio_display_mux->bridge);
+
+	ret = devm_request_threaded_irq(dev, gpio_display_mux->detect_irq,
+				NULL,
+				gpio_display_mux_det_threaded_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+				"gpio-display-mux-det", gpio_display_mux);
+	if (ret) {
+		dev_err(dev, "Failed to request MUX_DET threaded irq\n");
+		goto err_bridge_remove;
+	}
+
+	return 0;
+
+err_bridge_remove:
+	drm_bridge_remove(&gpio_display_mux->bridge);
+
+	return ret;
+}
+
+static int gpio_display_mux_remove(struct platform_device *pdev)
+{
+	struct gpio_display_mux *gpio_display_mux = platform_get_drvdata(pdev);
+
+	drm_bridge_remove(&gpio_display_mux->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id gpio_display_mux_match[] = {
+	{ .compatible = "gpio-display-mux", },
+	{},
+};
+
+struct platform_driver gpio_display_mux_driver = {
+	.probe = gpio_display_mux_probe,
+	.remove = gpio_display_mux_remove,
+	.driver = {
+		.name = "gpio-display-mux",
+		.of_match_table = gpio_display_mux_match,
+	},
+};
+
+module_platform_driver(gpio_display_mux_driver);
+
+MODULE_DESCRIPTION("GPIO-controlled display mux");
+MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.525.g8f36a354ae-goog

