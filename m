Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1041C18961F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 08:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCRHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 03:07:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRHHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:07:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8CCD929360F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, icenowy@aosc.io,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        megous@megous.com, kbuild test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Gleixner <tglx@linutronix.de>,
        Torsten Duwe <duwe@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 4/4] drm/bridge: anx7688: Add ANX7688 bridge driver support
Date:   Wed, 18 Mar 2020 08:07:30 +0100
Message-Id: <20200318070730.4012371-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318070730.4012371-1-enric.balletbo@collabora.com>
References: <20200318070730.4012371-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

This driver adds support for the ANX7688 HDMI to DP converter block of the
ANX7688 multi-function device.

For our use case, the only reason the Linux kernel driver is necessary is
to reject resolutions that require more bandwidth than what is available
on the DP side. DP bandwidth and lane count are reported by the bridge via
2 registers and, as far as we know, only for chips that have a firmware
version greather than 0.85 supports these two registers.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
[The driver is OF only so should depends on CONFIG_OF]
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4:
- Fix build issue reported by kbuild test robot

Changes in v3:
- Convert to a child of ANX7688 multi-function device.

Changes in v2:
- Move driver to drivers/gpu/drm/bridge/analogix.
- Make the driver OF only so we can reduce the ifdefs.
- Update the Copyright to 2020.
- Use probe_new so we can get rid of the i2c_device_id table.

 drivers/gpu/drm/bridge/analogix/Kconfig       |  10 ++
 drivers/gpu/drm/bridge/analogix/Makefile      |   1 +
 .../drm/bridge/analogix/analogix-anx7688.c    | 135 ++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx7688.c

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index e1fa7d820373..1f096055c036 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -11,6 +11,16 @@ config DRM_ANALOGIX_ANX6345
 	  ANX6345 transforms the LVTTL RGB output of an
 	  application processor to eDP or DisplayPort.
 
+config DRM_ANALOGIX_ANX7688
+	tristate "Analogix ANX7688 bridge"
+	depends on OF
+	select DRM_KMS_HELPER
+	select MFD_ANX7688
+	help
+	  ANX7688 is an ultra-low power 4k Ultra-HD (4096x2160p60)
+	  mobile HD transmitter designed for portable devices. The
+	  ANX7688 converts HDMI 2.0 to DisplayPort 1.3 Ultra-HD.
+
 config DRM_ANALOGIX_ANX78XX
 	tristate "Analogix ANX78XX bridge"
 	select DRM_ANALOGIX_DP
diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
index 97669b374098..27cd73635c8c 100644
--- a/drivers/gpu/drm/bridge/analogix/Makefile
+++ b/drivers/gpu/drm/bridge/analogix/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o analogix-i2c-dptx.o
 obj-$(CONFIG_DRM_ANALOGIX_ANX6345) += analogix-anx6345.o
+obj-$(CONFIG_DRM_ANALOGIX_ANX7688) += analogix-anx7688.o
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c b/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
new file mode 100644
index 000000000000..81b950ecde27
--- /dev/null
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ANX7688 HDMI->DP bridge driver
+ *
+ * Copyright 2020 Google LLC
+ */
+
+#include <linux/mfd/anx7688.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_print.h>
+
+struct anx7688_bridge_data {
+	struct drm_bridge bridge;
+	struct regmap *regmap;
+
+	bool filter;
+};
+
+static inline struct anx7688_bridge_data *
+bridge_to_anx7688(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct anx7688_bridge_data, bridge);
+}
+
+static bool anx7688_bridge_mode_fixup(struct drm_bridge *bridge,
+				      const struct drm_display_mode *mode,
+				      struct drm_display_mode *adjusted_mode)
+{
+	struct anx7688_bridge_data *data = bridge_to_anx7688(bridge);
+	int totalbw, requiredbw;
+	u8 dpbw, lanecount;
+	u8 regs[2];
+	int ret;
+
+	if (!data->filter)
+		return true;
+
+	/* Read both regs 0x85 (bandwidth) and 0x86 (lane count). */
+	ret = regmap_bulk_read(data->regmap, ANX7688_DP_BANDWIDTH_REG, regs,
+			       2);
+	if (ret < 0) {
+		DRM_ERROR("Failed to read bandwidth/lane count\n");
+		return false;
+	}
+	dpbw = regs[0];
+	lanecount = regs[1];
+
+	/* Maximum 0x19 bandwidth (6.75 Gbps Turbo mode), 2 lanes */
+	if (dpbw > 0x19 || lanecount > 2) {
+		DRM_ERROR("Invalid bandwidth/lane count (%02x/%d)\n", dpbw,
+			  lanecount);
+		return false;
+	}
+
+	/* Compute available bandwidth (kHz) */
+	totalbw = dpbw * lanecount * 270000 * 8 / 10;
+
+	/* Required bandwidth (8 bpc, kHz) */
+	requiredbw = mode->clock * 8 * 3;
+
+	DRM_DEBUG_KMS("DP bandwidth: %d kHz (%02x/%d); mode requires %d Khz\n",
+		      totalbw, dpbw, lanecount, requiredbw);
+
+	if (totalbw == 0) {
+		DRM_ERROR("Bandwidth/lane count are 0, not rejecting modes\n");
+		return true;
+	}
+
+	return totalbw >= requiredbw;
+}
+
+static const struct drm_bridge_funcs anx7688_bridge_funcs = {
+	.mode_fixup = anx7688_bridge_mode_fixup,
+};
+
+static int anx7688_bridge_probe(struct platform_device *pdev)
+{
+	struct anx7688 *anx7688 = dev_get_drvdata(pdev->dev.parent);
+	struct anx7688_bridge_data *data;
+	struct device *dev = &pdev->dev;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->bridge.of_node = dev->of_node;
+	data->regmap = anx7688->regmap;
+
+	/* FW version >= 0.85 supports bandwidth/lane count registers */
+	if (anx7688->fw_version >= ANX7688_MINIMUM_FW_VERSION)
+		data->filter = true;
+	else
+		/* Warn, but not fail, for backwards compatibility */
+		DRM_WARN("Old ANX7688 FW version (0x%04x), not filtering\n",
+			 anx7688->fw_version);
+
+	data->bridge.funcs = &anx7688_bridge_funcs;
+	drm_bridge_add(&data->bridge);
+
+	return 0;
+}
+
+static int anx7688_bridge_remove(struct platform_device *pdev)
+{
+	struct anx7688_bridge_data *data = dev_get_drvdata(&pdev->dev);
+
+	drm_bridge_remove(&data->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id anx7688_bridge_match_table[] = {
+	{ .compatible = "analogix,anx7688-bridge", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, anx7688_bridge_match_table);
+
+static struct platform_driver anx7688_bridge_driver = {
+	.probe = anx7688_bridge_probe,
+	.remove = anx7688_bridge_remove,
+	.driver = {
+		.name = "anx7688-bridge",
+		.of_match_table = anx7688_bridge_match_table,
+	},
+};
+
+module_platform_driver(anx7688_bridge_driver);
+
+MODULE_DESCRIPTION("ANX7688 HDMI->DP bridge driver");
+MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
+MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

