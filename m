Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8107AA18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfG3Nso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 09:48:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58121 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfG3Nsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:48:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C95521EAF;
        Tue, 30 Jul 2019 09:48:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:subject:to:cc:in-reply-to:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm3; bh=ZUN4WlSNVg81h
        50XgF8Wl4n4uHgRmbn/BqZIeD1F8q8=; b=Sg9UmiD+9k49CGdAYIJzDZ+LRWly+
        U4JYxGmmUfsBt+b/HSSZf1uku7nD53ra3pp9v37b/RKaz0dNMFrEz1B9Ad7N6CGo
        V/QfBFxaeVgkjTY9crWbD0PQplGfnpEsaEwT2x0LIjzvFSFAk7PADE/MWLSbrN7I
        xSGlT8CccxT792/wlWKo4TIVMZ4H2WDWARfl75UTIwDqHwfjMkgRsCB50z9qHb+B
        WMkOGB1bBvDlGFtGnXWQ23xcWyOreKmRMVtRylPkTNIw8a4LCXbbngNtj3612v0/
        qsSU6FZJRCdlYp5ibhaHbFQnzJhSmyO1CSeJlNKX/8XmEah6ls02oUHFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZUN4WlSNVg81h50XgF8Wl4n4uHgRmbn/BqZIeD1F8q8=; b=vAQXVp8J
        Cxn9sL/c+SlhjO3qtChxEA2RBCpM4A1oXdREQpi+L96769R/8fGP5OeLIm+tYzfR
        Drlnud/8SHLlDFcbDozqdHIDijl3pFpPEXmO7G30YPOJo3gypPwcc9g6djZJfwu8
        9unTyjm+n7gs/B9cULABbl4Z0H9wP4sKhU/RqMwHBQn1U0AN7KVGm+merqoxCUkt
        Da8ioJ3BEWd8opxCl6y9ydyc3dlcMcFZF1791pn/zD5m4ANGdWXvUefq3OovGIdi
        Rrqh9DE+piFp2PIpWPhWge3jpt4w1DAbJ9dkJWERyuIBD20QiQCIn3lqNNWq9CbX
        I/Bp+0eJmadeIw==
X-ME-Sender: <xms:t0pAXZZcgI6Y6tIotpIt4U1QO_2TrTWLv8Ur7JHek_UcW7uH_RqZzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvjgfkffgfgggtgfesthekredttdefjeenucfhrhhomheplfgrnhgpufgv
    sggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenucffoh
    hmrghinhepvgdqphgrphgvrhdqughishhplhgrhidrtghomhdpfigrvhgvshhhrghrvgdr
    tghomhenucfkphepiedtrdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomh
    eplhhinhhugiesjhgrshgvghdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:t0pAXToogDuiYnKTt-qT9YRp7c_yCpkYFq1ub-3oM7m-B3Xqk3G0IA>
    <xmx:t0pAXTcZUF-jVoFBTvZA-EVWLSYXWjHBhjuBEfSMBSzuIC-LDDz_OA>
    <xmx:t0pAXVQ5i35FWdsr4F4S3WBy_nQpmOphrRn4x2pBwxTGWkJhnv8b9A>
    <xmx:t0pAXbxTqPcrl0lHEHjR1lo6YbxvSwujj9dZm6fLFl3bcc0fURGTfw>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F93580059;
        Tue, 30 Jul 2019 09:48:37 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Subject: [PATCH 6/6] drm: tiny: gdepaper: add driver for 2/3 color epaper
 displays
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Message-ID: <95b64347-fbc8-ba3d-79da-9de2557ff95e@jaseg.net>
Date:   Tue, 30 Jul 2019 22:48:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ePaper displays are made in b/w, b/w/red and b/w/yellow variations
by Good Display (www.e-paper-display.com) and sold on breakout boards by
waveshare (waveshare.com).

This driver was tested against a 2.7" b/w/r display (IL91874 driver) as
well as 4.2" b/w/r display (IL0389 driver) but can probably be
configured for other displays using only a single COG driver die (i.e.
any model except for their largest 12.5" model).

Through tinydrm this driver presents a standard XRGB8888 or RGB565
framebuffer device to userspace and internally converts RGB colors to
the epaper's colors. RGB565 support is provided for compatibility with
anything expecting a small-size TFT LCD whose drivers often support
RGB565.

For userspace, the most notable difference between these epaper displays
and more traditional TFT LCDs besides their limited color space is their
enormously long refresh times-about 5s for a b/w display and >15s for
b/w/r and b/w/y.

This driver uses the display's "4-line SPI" interface (~CS, SCK, MOSI,
BUSY) and does not support the bi-directional "3-line SPI" interface
since target support for bidirectional SPI is going to be patchy. This
means it can't read the display drivers factory-programmed ROM to
automatically recognize the display's model, resolution or color
configuration. This information must be provided from the device tree,
either with a compatible="" section containing the display's model or
through manual configuration of its various parameters. See the device
tree doc file for details.

We name this driver "gdepaper" instead of naming it after the driver
IC's part number since Good Display seems to be using a large number of
mutually compatible distinct variations of the same driver IC, named
using several different numbering schemes. Our plan is to add this
generic driver, and to provide support for individual chips' quirks as
they are discovered.

This driver uses four ioctls:
* Force full display refresh, which may be needed since some epaper
  displays need to be refreshed periodically (every few minutes to
  hours) or the image degrades. This ioctl allows a user program to
  trigger this hardware refresh from the epapers internal frame buffer
  without need for a full redraw.
* Get/set refresh params, which controls the display's waveform LUTs and
  voltage levels.  This is necessary in case a user wants to tune paint/
  refresh performance to their particular content and temperature.  In
  particular for acceptable-quality partial refresh on BWR/BWY panels
  this is essential.
* Enable partial mode, which enables partial update and refresh on fb
  updates. By default this is disabled since careful LUT tuning is
  required for this to not look terrible. Also not all content is suited
  to this mode of operation.

Tested-by: Jan Sebastian Götte <linux@jaseg.net>
Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
---
 drivers/gpu/drm/tinydrm/gdepaper.c        | 1262 +++++++++++++++++++++
 drivers/gpu/drm/tinydrm/gdepaper_models.h |  157 +++
 2 files changed, 1419 insertions(+)
 create mode 100644 drivers/gpu/drm/tinydrm/gdepaper.c
 create mode 100644 drivers/gpu/drm/tinydrm/gdepaper_models.h

diff --git a/drivers/gpu/drm/tinydrm/gdepaper.c b/drivers/gpu/drm/tinydrm/gdepaper.c
new file mode 100644
index 000000000000..68ac1282bbde
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/gdepaper.c
@@ -0,0 +1,1262 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DRM driver for Good Display black/white and black/white/red epaper panels
+ *
+ * Copyright 2019 Jan Sebastian Goette
+ *
+ * Some code copied from ili9225.c
+ * Copyright 2017 David Lechner
+ * Copyright 2016 Noralf Trønnes
+ */
+
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/sched/clock.h>
+#include <linux/spi/spi.h>
+#include <linux/thermal.h>
+#include <linux/delay.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_rect.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/tinydrm/tinydrm-helpers.h>
+
+#include <uapi/drm/gdepaper_drm.h>
+
+#include <dt-bindings/display/gdepaper.h>
+
+
+enum gdepaper_cmd {
+	GDEP_CMD_PANEL_SETUP = 0x00,
+	GDEP_CMD_PWR_SET = 0x01,
+	GDEP_CMD_PWR_OFF = 0x02,
+	GDEP_CMD_PWR_SEQ_SET = 0x03,
+	GDEP_CMD_PWR_ON = 0x04,
+	GDEP_CMD_PWR_MEAS = 0x05,
+	GDEP_CMD_BST_SOFT_START = 0x06,
+	GDEP_CMD_DEEP_SLEEP = 0x07,
+	GDEP_CMD_DATA_START_TX_COL1 = 0x10,
+	GDEP_CMD_DATA_STOP = 0x11,
+	GDEP_CMD_DISP_RF = 0x12,
+	GDEP_CMD_DATA_START_TX_COL2 = 0x13,
+	GDEP_CMD_PD_START_TX_COL1 = 0x14,
+	GDEP_CMD_PD_START_TX_COL2 = 0x15,
+	GDEP_CMD_PART_DISP_RF = 0x16,
+	GDEP_CMD_LUT_VCOM_DC = 0x20,
+	GDEP_CMD_LUT_WW = 0x21,
+	GDEP_CMD_LUT_BW = 0x22,
+	GDEP_CMD_LUT_WB = 0x23,
+	GDEP_CMD_LUT_BB = 0x24,
+	GDEP_CMD_PLL_CTRL = 0x30,
+	GDEP_CMD_TEMP_SENS_CMD = 0x40,
+	GDEP_CMD_TEMP_CAL = 0x41,
+	GDEP_CMD_TEMP_SENS_WR = 0x42,
+	GDEP_CMD_TEMP_SENS_RD = 0x43,
+	GDEP_CMD_VCOM_DIVL_SET = 0x50,
+	GDEP_CMD_LOW_PWR_DET = 0x51,
+	GDEP_CMD_TCON_SET = 0x60,
+	GDEP_CMD_TCON_RES = 0x61,
+	GDEP_CMD_SRC_GATE_SET = 0x62,
+	GDEP_CMD_GET_STATUS = 0x71,
+	GDEP_CMD_VCOM_AUTO_MEAS = 0x80,
+	GDEP_CMD_VCOM_VAL = 0x81,
+	GDEP_CMD_VDC_SET = 0x82,
+	GDEP_CMD_PROG_MODE = 0xa0,
+	GDEP_CMD_ACT_PROG  = 0xa1,
+	GDEP_CMD_READ_OTP = 0xa2,
+	GDEP_CMD_MAGIC1 = 0xf8,
+};
+
+enum gdepaper_psr {
+	GDEP_PSR_OTP_LUT = 0<<5,
+	GDEP_PSR_REG_LUT = 1<<5,
+	GDEP_PSR_COLOR_BWR = 0<<4,
+	GDEP_PSR_COLOR_BW = 1<<4,
+	GDEP_PSR_SCAN_DOWN = 0<<3,
+	GDEP_PSR_SCAN_UP = 1<<3,
+	GDEP_PSR_SH_LEFT = 0<<2,
+	GDEP_PSR_SH_RIGHT = 1<<2,
+	GDEP_PSR_BOOST_OFF = 0<<1,
+	GDEP_PSR_BOOST_ON = 1<<1,
+	GDEP_PSR_SOFT_RST = 1<<0,
+};
+
+enum gdepaper_col_ch {
+	GDEP_CH_BLACK = 0x0,
+	GDEP_CH_RED_YELLOW = 0x4,
+};
+
+
+struct gdepaper {
+	struct drm_device drm;
+	struct drm_simple_display_pipe pipe;
+	struct spi_device *spi;
+
+	struct gpio_desc *reset;
+	struct gpio_desc *dc;
+	struct gpio_desc *busy;
+
+	u8 *tx_buf; /* FIXME initialize this */
+	bool enabled;
+	struct mutex cmdlock;
+	u8 psr; /* Panel setup byte */
+	u32 spi_speed_hz;
+	bool partial_update_en;
+	enum gdepaper_color_type display_colors;
+	bool mirror_x, mirror_y;
+	u32 pll_div; /* 1, 2, 4, 8 */
+	u32 framerate_mHz; /* 20220 - 197610 */
+	enum gdepaper_controller_res controller_res;
+	bool vds_en; /* Internal source voltage enable */
+	bool vdg_en;  /* Internal gate voltage enable */
+	u8 ss_param[3]; /* boost converter soft start parameter */
+	bool is_powered_on;
+	struct gdepaper_refresh_params rfp;
+};
+
+struct gdepaper_type_descriptor {
+	enum gdepaper_color_type colors;
+	int w_mm, h_mm;
+	int w_px, h_px;
+};
+
+
+
+static inline struct gdepaper *drm_to_gdepaper(struct drm_device *drm)
+{
+	return container_of(drm, struct gdepaper, drm);
+}
+
+static int gdepaper_spi_transfer_cstoggle(struct gdepaper *epap, u8 *data,
+					  size_t len)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < len; i++) {
+		ret = tinydrm_spi_transfer(epap->spi, epap->spi_speed_hz,
+					   NULL, 8, &data[i], 1);
+		if (ret)
+			return ret;
+		udelay(1); /* FIXME necessary? */
+	}
+
+	return ret;
+}
+
+static int gdepaper_command(struct gdepaper *epap, u8 cmd,
+				   u8 *par, size_t num)
+{
+	int ret;
+	u8 cmd_buf = cmd;
+
+	dev_dbg(epap->drm.dev, "tx: cmd=0x%x len=%zu buf=%*ph\n",
+		cmd, num, (int)num, par);
+
+	gpiod_set_value_cansleep(epap->dc, 0);
+	ret = tinydrm_spi_transfer(epap->spi, epap->spi_speed_hz, NULL, 8,
+				   &cmd_buf, 1);
+	if (ret || !num)
+		return ret;
+
+	gpiod_set_value_cansleep(epap->dc, 1);
+	udelay(10); /* FIXME needed? */
+
+	ret = gdepaper_spi_transfer_cstoggle(epap, par, num);
+	udelay(10); /* FIXME needed? */
+
+	return ret;
+}
+
+static int gdepaper_wait_busy(struct gdepaper *epap)
+{
+	int i = 18000;
+
+	dev_dbg(epap->drm.dev, "waiting for busy line\n");
+	while (i--) {
+		if (!gpiod_get_value_cansleep(epap->busy))
+			return 0;
+
+		usleep_range(1000, 10000);
+	}
+	return -EBUSY;
+}
+
+static int gdepaper_update_luts(struct gdepaper *epap)
+{
+	int ret;
+
+	dev_dbg(epap->drm.dev, "updating LUTs\n");
+
+	ret = gdepaper_command(epap, GDEP_CMD_LUT_VCOM_DC,
+			       epap->rfp.lut_vcom_dc,
+			       sizeof(epap->rfp.lut_vcom_dc));
+	if (ret)
+		return ret;
+	ret = gdepaper_command(epap, GDEP_CMD_LUT_WW,
+			       epap->rfp.lut_ww,
+			       sizeof(epap->rfp.lut_ww));
+	if (ret)
+		return ret;
+	ret = gdepaper_command(epap, GDEP_CMD_LUT_BW,
+			       epap->rfp.lut_bw,
+			       sizeof(epap->rfp.lut_bw));
+	if (ret)
+		return ret;
+	ret = gdepaper_command(epap, GDEP_CMD_LUT_WB,
+			       epap->rfp.lut_wb,
+			       sizeof(epap->rfp.lut_wb));
+	if (ret)
+		return ret;
+	ret = gdepaper_command(epap, GDEP_CMD_LUT_BB,
+			       epap->rfp.lut_bb,
+			       sizeof(epap->rfp.lut_bb));
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+/* Power off the boost regulators. This must be done as soon as the display is
+ * updated to avoid burn-in damage if powered on over a long time.
+ */
+static int gdepaper_power_off(struct gdepaper *epap)
+{
+	epap->is_powered_on = false;
+	dev_dbg(epap->drm.dev, "display power off\n");
+	return gdepaper_command(epap, GDEP_CMD_PWR_OFF, NULL, 0);
+}
+
+/* Enter deep sleep mode. Deep sleep mode can only be exited with a reset. */
+static int gdepaper_enter_deep_sleep(struct gdepaper *epap)
+{
+	u8 param = 0xa5;
+
+	epap->is_powered_on = false;
+	dev_dbg(epap->drm.dev, "display deep sleep\n");
+	return gdepaper_command(epap, GDEP_CMD_DEEP_SLEEP,
+				    &param, sizeof(param));
+}
+
+static int gdepaper_power_on(struct gdepaper *epap)
+{
+	struct device *dev = epap->drm.dev;
+	int ret = gdepaper_command(epap, GDEP_CMD_PWR_ON, NULL, 0);
+
+	if (ret)
+		return ret;
+
+	ret = gdepaper_wait_busy(epap);
+	if (ret)
+		dev_err(dev, "Timeout on power on cmd\n");
+
+	epap->is_powered_on = true;
+	return ret;
+}
+
+static void gdepaper_reset(struct gdepaper *epap)
+{
+	gpiod_set_value_cansleep(epap->reset, 0);
+	usleep_range(10000, 20000);
+	gpiod_set_value_cansleep(epap->reset, 1);
+	msleep(200);
+}
+
+/* len must be divisible by 8 */
+static void gdepaper_line_rgb565_to_1bpp(u16 *src, u8 *dst, size_t len,
+					    enum gdepaper_col_ch col)
+{
+	size_t i;
+	int j, bits;
+	u8 out;
+
+	for (i = 0; i < len; i += 8) {
+		out = 0;
+		for (j = 0; j < 8; j++) {
+			bits = (src[i+j] >> (15-2))
+			     | (src[i+j] >> (10-1))
+			     | (src[i+j] >> (4-0));
+			out |= (bits == col) << (7-j);
+		}
+		dst[i/8] = out;
+	}
+}
+
+static void gdepaper_line_xrgb8888_to_1bpp(u32 *src, u8 *dst, size_t len,
+					    enum gdepaper_col_ch col)
+{
+	/* TODO what is the endianness of this buffer? */
+	size_t i;
+	int j, bits;
+	u8 out;
+
+	for (i = 0; i < len; i += 8) {
+		out = 0;
+		for (j = 0; j < 8; j++) {
+			bits = !!(src[i+j] & (1<<23)) << 2
+			     | !!(src[i+j] & (1<<15)) << 1
+			     | !!(src[i+j] & (1<<7)) << 0;
+			out |= (bits == col) << (7-j);
+		}
+		dst[i/8] = out;
+	}
+}
+
+/* Pack a framebuffer into 1bpp msb-first format. clip must be 8-bit aligned in
+ * x1 and x2.
+ */
+static int gdepaper_txbuf_pack(u8 *dst,
+				struct drm_framebuffer *fb,
+				struct drm_rect *clip,
+				enum gdepaper_col_ch col)
+{
+	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
+	struct dma_buf_attachment *import_attach = cma_obj->base.import_attach;
+	struct drm_format_name_buf format_name;
+	int ret = 0;
+	void *vaddr = cma_obj->vaddr;
+	size_t len = (clip->x2 - clip->x1);
+	unsigned int y, lines = clip->y2 - clip->y1;
+
+	if (import_attach) {
+		ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
+					       DMA_FROM_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+	vaddr += clip->y1 * fb->pitches[0] +
+		clip->x1 * drm_format_plane_cpp(fb->format->format, 0);
+
+	switch (fb->format->format) {
+	case DRM_FORMAT_RGB565:
+		for (y = 0; y < lines; y++) {
+			gdepaper_line_rgb565_to_1bpp(vaddr, dst, len, col);
+			vaddr += fb->pitches[0];
+			dst += len/8;
+		}
+		break;
+
+	case DRM_FORMAT_XRGB8888:
+		for (y = 0; y < lines; y++) {
+			gdepaper_line_xrgb8888_to_1bpp(vaddr, dst, len, col);
+			vaddr += fb->pitches[0];
+			dst += len/8;
+		}
+		break;
+
+	default:
+		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
+			     drm_get_format_name(fb->format->format,
+						 &format_name));
+		return -EINVAL;
+	}
+
+	if (import_attach) {
+		ret = dma_buf_end_cpu_access(import_attach->dmabuf,
+					     DMA_FROM_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+	return len*lines/8;
+}
+
+static int gdepaper_partial_cmd(struct gdepaper *epap, struct drm_rect *rect,
+				u8 cmd, u8 *buf, size_t len)
+{
+	int ret;
+	struct {
+		u16 x, y, w, l;
+	} __packed param = {
+		.x = rect->x1,
+		.w = rect->x2 - rect->x1,
+		.y = rect->y1,
+		.l = rect->y2 - rect->y1
+	};
+	dev_dbg(epap->drm.dev, "Running partial command 0x%x on rect %d(0x%x),%d(0x%x) +%d(0x%x),%d(0x%x)\n",
+			       cmd, param.x, param.x, param.y, param.y,
+			       param.w, param.w, param.l, param.l);
+
+	param.x = cpu_to_be16(param.x);
+	param.w = cpu_to_be16(param.w);
+	param.y = cpu_to_be16(param.y);
+	param.l = cpu_to_be16(param.l);
+
+	if (rect->x1 & 7 || rect->x2 & 7)
+		return -EINVAL;
+
+	ret = gdepaper_command(epap, cmd, (u8 *)&param, sizeof(param));
+	if (ret)
+		return ret;
+
+	dev_dbg(epap->drm.dev, "partial payload: len=%zu buf=%*ph\n",
+		len, (int)len, buf);
+	return gdepaper_spi_transfer_cstoggle(epap, buf, len);
+}
+
+int gdepaper_config_refresh(struct gdepaper *epap)
+{
+	struct device *dev = epap->drm.dev;
+	int ret = 0;
+	u8 param;
+	struct {
+		u8 vdg_en:1, vds_en:1, _pad1:6;
+		u8 vg_lv:2, vcom_hv:1, _pad2:5;
+		u8 vdh;
+		u8 vdl;
+		u8 vdhr;
+	} __packed gdep_cmd_pwr_set_param = {
+		.vds_en = epap->vds_en, .vdg_en = epap->vdg_en,
+		.vcom_hv = !!epap->rfp.vcom_sel, .vg_lv = epap->rfp.vg_lv,
+		.vdh = (epap->rfp.vdh_bw_mv-2400)/200,
+		.vdl = (epap->rfp.vdl_mv-2400)/200,
+		.vdhr = (epap->rfp.vdh_col_mv-2400)/200,
+	};
+
+	/* Re-configure PSR to set OTP LUT flag */
+	if (epap->rfp.use_otp_luts_flag)
+		epap->psr &= ~GDEP_PSR_REG_LUT;
+	else
+		epap->psr |= GDEP_PSR_REG_LUT;
+	ret = gdepaper_command(epap, GDEP_CMD_PANEL_SETUP,
+				   &epap->psr, sizeof(epap->psr));
+
+	/* set voltage levels */
+	if (epap->rfp.vg_lv < 0 || epap->rfp.vg_lv > 3) {
+		dev_err_once(dev, "Invalid vg_lv value %d\n", epap->rfp.vg_lv);
+		goto err_out;
+	}
+	if (epap->rfp.vdh_bw_mv < 2400 || epap->rfp.vdh_bw_mv > 11000) {
+		dev_err_once(dev, "vdh_bw=%d out of range (2.4V - 11.0V)\n",
+			     epap->rfp.vdh_bw_mv);
+		goto err_out;
+	}
+	if (epap->rfp.vdl_mv < 2400 || epap->rfp.vdl_mv > 11000) {
+		dev_err_once(dev, "vdl_mv=%d out of range (-11.0V - -2.4V)\n",
+			     epap->rfp.vdl_mv);
+		goto err_out;
+	}
+	if (epap->rfp.vdh_col_mv < 2400 || epap->rfp.vdh_col_mv > 11000) {
+		dev_err_once(dev, "vdh_col_mv=%d out of range (2.4V - 11.0V)\n",
+			     epap->rfp.vdh_col_mv);
+		goto err_out;
+	}
+	ret = gdepaper_command(epap, GDEP_CMD_PWR_SET,
+				   (u8 *)&gdep_cmd_pwr_set_param,
+				   sizeof(gdep_cmd_pwr_set_param));
+	if (ret)
+		goto err_out;
+
+	/* VCOM DC setup */
+	param = (epap->rfp.vcom_dc_mv - 100) / 50;
+	ret = gdepaper_command(epap, GDEP_CMD_VDC_SET, &param, sizeof(param));
+	if (ret)
+		goto err_out;
+
+	/* VCOM and data interval setup */
+	if (epap->rfp.vcom_data_ivl_hsync < 2 ||
+	    epap->rfp.vcom_data_ivl_hsync > 17) {
+		dev_err_once(dev, "Invalid vcom/data ivl setting %d (should be 2-17)\n",
+				  epap->rfp.vcom_data_ivl_hsync);
+		goto err_out;
+	}
+	if (epap->rfp.border_data_sel < 0 || epap->rfp.border_data_sel > 3) {
+		dev_err_once(dev, "Invalid border_data_sel (vbd) setting %d\n",
+				  epap->rfp.border_data_sel);
+		goto err_out;
+	}
+	if (epap->rfp.data_polarity < 0 || epap->rfp.data_polarity > 3) {
+		dev_err_once(dev, "Invalid data polarity (ddx) setting %d\n",
+				  epap->rfp.border_data_sel);
+		goto err_out;
+	}
+	param = epap->rfp.border_data_sel<<6 | epap->rfp.data_polarity<<4;
+	param |= epap->rfp.vcom_data_ivl_hsync;
+	ret = gdepaper_command(epap, GDEP_CMD_VCOM_DIVL_SET,
+			&param, sizeof(param));
+	if (ret)
+		goto err_out;
+
+	/* Upload RAM LUTs */
+	if (!epap->rfp.use_otp_luts_flag)
+		ret = gdepaper_update_luts(epap);
+err_out:
+	return ret;
+}
+
+static void gdepaper_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect)
+{
+	struct gdepaper *epap = drm_to_gdepaper(fb->dev);
+	struct device *dev = epap->drm.dev;
+	unsigned int w, h;
+	struct drm_rect rect_aligned;
+	int idx, ret = 0;
+
+	dev_dbg(dev, "fbdirty\n");
+
+	if (!epap->partial_update_en) {
+		*rect = (struct drm_rect) {
+			.x1 = 0,
+			.x2 = fb->width,
+			.y1 = 0,
+			.y2 = fb->height,
+		};
+	}
+	w = rect->x2 - rect->x1;
+	h = rect->y2 - rect->y1;
+
+	if (!epap->enabled) {
+		dev_dbg(dev, "panel is disabled, returning\n");
+		return;
+	}
+
+	if (!drm_dev_enter(fb->dev, &idx)) {
+		dev_dbg(dev, "can't acquire drm dev lock\n");
+		return;
+	}
+
+	dev_dbg(dev, "Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id,
+		      DRM_RECT_ARG(rect));
+
+	ret = gdepaper_power_on(epap);
+	if (ret)
+		goto err_out;
+
+	if (w == fb->width && h == fb->height) { /* full refresh */
+		/* black */
+		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, rect,
+					  GDEP_CH_BLACK);
+
+		dev_dbg(dev, "Sending %d byte full framebuf\n", ret);
+		ret = gdepaper_command(epap, GDEP_CMD_DATA_START_TX_COL1,
+			(u8 *)epap->tx_buf, ret);
+		if (ret)
+			goto err_out;
+
+		/* red/yellow */
+		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, rect,
+					  GDEP_CH_RED_YELLOW);
+
+		ret = gdepaper_command(epap, GDEP_CMD_DATA_START_TX_COL2,
+			(u8 *)epap->tx_buf, ret);
+		if (ret)
+			goto err_out;
+
+		ret = gdepaper_command(epap, GDEP_CMD_DATA_STOP, NULL, 0);
+		if (ret)
+			goto err_out;
+
+		ret = gdepaper_command(epap, GDEP_CMD_DISP_RF, NULL, 0);
+		if (ret)
+			goto err_out;
+
+	} else {
+		rect_aligned.x1 = rect->x1 & (~7U);
+		rect_aligned.y1 = rect->y1;
+		rect_aligned.y2 = rect->y2;
+		rect_aligned.x2 = rect_aligned.x1 +
+			  ((rect->x2 - rect_aligned.x1 + 7) & (~7U));
+
+		/* black */
+		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, &rect_aligned,
+					  GDEP_CH_BLACK);
+		dev_dbg(dev, "Sending %d byte partial framebuf\n", ret);
+		if (ret < 0)
+			goto err_out;
+		ret = gdepaper_partial_cmd(epap, &rect_aligned,
+			GDEP_CMD_PD_START_TX_COL1, (u8 *)epap->tx_buf, ret);
+		if (ret)
+			goto err_out;
+
+		/* red/yellow */
+		ret = gdepaper_txbuf_pack((u8 *)epap->tx_buf, fb, &rect_aligned,
+					  GDEP_CH_RED_YELLOW);
+		if (ret < 0)
+			goto err_out;
+		ret = gdepaper_partial_cmd(epap, &rect_aligned,
+			GDEP_CMD_PD_START_TX_COL2, (u8 *)epap->tx_buf,
+			ret);
+		if (ret)
+			goto err_out;
+		ret = gdepaper_command(epap, GDEP_CMD_DATA_STOP, NULL, 0);
+		if (ret)
+			goto err_out;
+		ret = gdepaper_partial_cmd(epap, rect, GDEP_CMD_PART_DISP_RF,
+			NULL, 0);
+		if (ret)
+			goto err_out;
+	}
+
+	if (gdepaper_wait_busy(epap)) {
+		dev_err(dev, "Timeout on partial refresh cmd\n");
+		goto err_out;
+	}
+
+	ret = gdepaper_power_off(epap);
+	if (ret)
+		goto err_out;
+
+	drm_dev_exit(idx);
+	return;
+
+err_out:
+	/* Try to power off anyway */
+	gdepaper_power_off(epap);
+
+	dev_err(fb->dev->dev, "Failed to update display %d\n", ret);
+	drm_dev_exit(idx);
+}
+
+static void gdepaper_pipe_enable(struct drm_simple_display_pipe *pipe,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_plane_state *plane_state)
+{
+	struct gdepaper *epap = drm_to_gdepaper(pipe->crtc.dev);
+	struct device *dev = epap->drm.dev;
+
+	u16 pwr_opt[5] = {0x60a5, 0x89a5, 0x9000, 0x932a, 0x7341};
+	int idx, ret, i, foo;
+	int fps_min, fps_max;
+	u8 param;
+	int step = 0;
+
+	dev_dbg(dev, "Enabling gdepaper pipe\n");
+	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+		return;
+
+	/* Reset and power on */
+	gdepaper_reset(epap);
+	ret = gdepaper_power_on(epap);
+	if (ret)
+		goto err_out;
+	usleep_range(1000, 20000); /* FIXME time this */
+
+	/* Basic controller setup (PSR) */
+	step = 1;
+	if (epap->controller_res < 0 ||
+	    epap->controller_res > 3) {
+		dev_err_once(dev, "Invalid controller resolution %d\n",
+				epap->controller_res);
+		goto err_out;
+	}
+	epap->psr = epap->controller_res<<6;
+	if (epap->display_colors == GDEPAPER_COL_BW)
+		epap->psr |= GDEP_PSR_COLOR_BW;
+
+	if (!epap->mirror_x)
+		epap->psr |= GDEP_PSR_SH_RIGHT;
+	if (!epap->mirror_y)
+		epap->psr |= GDEP_PSR_SCAN_UP;
+	epap->psr |= GDEP_PSR_BOOST_ON | GDEP_PSR_SOFT_RST;
+	ret = gdepaper_command(epap, GDEP_CMD_PANEL_SETUP,
+				   &epap->psr, sizeof(epap->psr));
+	if (ret)
+		goto err_out;
+
+	/* PLL setup */
+	step = 2;
+	/* The min/max values below were taken from the datasheet's PLL
+	 * coefficient table.
+	 */
+	switch (epap->pll_div) {
+	case 1:
+		param = 0;
+		fps_min = 68010;
+		fps_max = 197610;
+		break;
+	case 2:
+		param = 1;
+		fps_min = 34010;
+		fps_max = 120860;
+		break;
+	case 4:
+		param = 2;
+		fps_min = 20450;
+		fps_max = 60430;
+		break;
+	case 8:
+		param = 3;
+		fps_min = 20220;
+		fps_max = 30220;
+		break;
+	default:
+		dev_err_once(dev, "Invalid pll_div %d\n", epap->pll_div);
+		goto err_out;
+	}
+	if (epap->framerate_mHz < fps_min || epap->framerate_mHz > fps_max) {
+		dev_err_once(dev, "Framerate %d out of range for pll_div %d (%d-%d)\n",
+			     epap->framerate_mHz, epap->pll_div,
+			     fps_min, fps_max);
+		goto err_out;
+	}
+	/* The magic values below have been calculated through linear regression
+	 * on the framerate/PLL coefficient table from the controller datasheet.
+	 */
+	foo = (epap->framerate_mHz*1000 - (68014451 / epap->pll_div))
+		/ (2757368 * epap->pll_div);
+	if (foo < 0 || foo > 63) {
+		dev_err_once(dev, "PLL multiplier for framerate %d and pll_div %d out of range\n",
+				   epap->framerate_mHz, epap->pll_div);
+		goto err_out;
+	}
+	if (foo < 32)
+		foo = 63 - foo;
+	else
+		foo = foo - 32;
+	param |= foo;
+	ret = gdepaper_command(epap, GDEP_CMD_PLL_CTRL,
+				   &param, sizeof(param));
+	if (ret)
+		goto err_out;
+
+	/* Booster soft start configuration */
+	step = 3;
+	ret = gdepaper_command(epap, GDEP_CMD_BST_SOFT_START, epap->ss_param,
+		      sizeof(epap->ss_param));
+	if (ret)
+		goto err_out;
+
+	/* Undocumented "power optimization" command from reference code */
+	step = 4;
+	for (i = 0; i < ARRAY_SIZE(pwr_opt); i++) {
+		/* FIXME check in pulseview this endianness conversion works as
+		 * intended
+		 */
+		pwr_opt[i] = cpu_to_be16(pwr_opt[i]);
+		ret = gdepaper_command(epap, GDEP_CMD_MAGIC1,
+				       (u8 *)&pwr_opt[i], sizeof(pwr_opt[i]));
+		if (ret)
+			goto err_out;
+	}
+
+	/* Configure refresh-related parameters (LUTs, voltages, timings etc.)*/
+	step = 5;
+	ret = gdepaper_config_refresh(epap);
+	if (ret)
+		goto err_out;
+
+	/* Mysterious partial refresh call to finalize config */
+	step = 6;
+	/* This one-byte parameter format is used in the example code by
+	 * good display, but does not match the datasheet.
+	 */
+	param = 0x00;
+	ret = gdepaper_command(epap, GDEP_CMD_PART_DISP_RF,
+				   &param, sizeof(param));
+	if (ret)
+		goto err_out;
+
+	epap->enabled = true;
+
+	/* We need to make sure to power off the display to avoid damage */
+	ret = gdepaper_power_off(epap);
+	if (ret)
+		dev_err(dev, "Can't power off display, %d\n", ret);
+	drm_dev_exit(idx);
+	return;
+
+err_out:
+	dev_err(dev, "Error on pipe enable; ret=%d, step=%d\n", ret, step);
+	/* Try to turn off anyway */
+	gdepaper_power_off(epap);
+	drm_dev_exit(idx);
+}
+
+static void gdepaper_pipe_disable(struct drm_simple_display_pipe *pipe)
+{
+	struct gdepaper *epap = drm_to_gdepaper(pipe->crtc.dev);
+
+	dev_dbg(epap->drm.dev, "Disabling gdepaper pipe\n");
+	/* This callback is not protected by drm_dev_enter/exit since we want to
+	 * turn off the display on regular driver unload. It's highly unlikely
+	 * that the underlying SPI controller is gone should this be called
+	 * after unplug.
+	 */
+
+	if (!epap->enabled)
+		return;
+
+	/* Ignore errors */
+	gdepaper_power_off(epap);
+	gdepaper_enter_deep_sleep(epap);
+	epap->enabled = false;
+}
+
+static void gdepaper_pipe_update(struct drm_simple_display_pipe *pipe,
+				struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_rect rect;
+
+	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+		gdepaper_fb_dirty(state->fb, &rect);
+
+	if (crtc->state->event) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+		crtc->state->event = NULL;
+	}
+}
+
+/* This function accepts if either all or no LUTs are given. */
+static int gdepaper_of_read_luts(struct gdepaper *epap, struct device_node *np,
+				 struct device *dev)
+{
+	int ret[5];
+
+	ret[0] = of_property_read_u8_array(np, "lut_vcom_dc",
+		epap->rfp.lut_vcom_dc, sizeof(epap->rfp.lut_vcom_dc));
+	ret[1] = of_property_read_u8_array(np, "lut_ww",
+		epap->rfp.lut_ww, sizeof(epap->rfp.lut_ww));
+	ret[2] = of_property_read_u8_array(np, "lut_wb",
+		epap->rfp.lut_wb, sizeof(epap->rfp.lut_wb));
+	ret[3] = of_property_read_u8_array(np, "lut_bw",
+		epap->rfp.lut_bw, sizeof(epap->rfp.lut_bw));
+	ret[4] = of_property_read_u8_array(np, "lut_bb",
+			epap->rfp.lut_bb, sizeof(epap->rfp.lut_bb));
+
+	/* All LUTs are given */
+	if (!ret[0] && !ret[1] && !ret[2] & !ret[3] && !ret[4]) {
+		epap->rfp.use_otp_luts_flag = 0;
+		return 0;
+	}
+
+	/* No LUTs are given */
+	if (ret[0] == -EINVAL && ret[1] == -EINVAL && ret[2] == -EINVAL &&
+			ret[3] == -EINVAL && ret[4] == -EINVAL) {
+		epap->rfp.use_otp_luts_flag = 1;
+		return 0;
+	}
+
+	dev_err(dev, "couldn't parse some LUTs - using to OTP LUTs: vcom_dc=%d ww=%d wb=%d bw=%d bb=%d\n",
+			ret[0], ret[1], ret[2], ret[3], ret[4]);
+	return -EINVAL;
+}
+
+static struct drm_display_mode *gdepaper_of_read_mode(
+	const struct gdepaper_type_descriptor *type,
+	struct device_node *np,
+	struct device *dev)
+{
+	u32 dims[4];
+	int ret1, ret2;
+	struct drm_display_mode *mode =
+		kzalloc(sizeof(struct drm_display_mode), GFP_KERNEL);
+	if (!mode)
+		return ERR_PTR(-ENOMEM);
+
+	ret1 = of_property_read_u32_array(np, "dimensions-px", &dims[0], 2);
+	ret2 = of_property_read_u32_array(np, "dimensions-mm", &dims[2], 2);
+
+	if (!ret1 && !ret2) {
+		*mode = (struct drm_display_mode){
+			DRM_SIMPLE_MODE(dims[0], dims[1], dims[2], dims[3]),
+		};
+
+	} else if (ret1 == -EINVAL && ret2 == -EINVAL) {
+		if (type) {
+			*mode = (struct drm_display_mode){
+				DRM_SIMPLE_MODE(type->w_px, type->h_px,
+						type->w_mm, type->h_mm)
+			};
+
+		} else {
+			DRM_DEV_ERROR(dev, "dimensions must be given\n");
+			kfree(mode);
+			return ERR_PTR(-EINVAL);
+		}
+
+	} else {
+		DRM_DEV_ERROR(dev, "invalid dimensions: %d/%d\n", ret1, ret2);
+		kfree(mode);
+		return ERR_PTR(ret1 || ret2);
+	}
+
+	return mode;
+}
+
+static const struct drm_simple_display_pipe_funcs gdepaper_pipe_funcs = {
+	.enable		= gdepaper_pipe_enable,
+	.disable	= gdepaper_pipe_disable,
+	.update		= gdepaper_pipe_update,
+	.prepare_fb	= drm_gem_fb_simple_display_pipe_prepare_fb,
+};
+
+DEFINE_DRM_GEM_CMA_FOPS(gdepaper_fops);
+
+int gdepaper_force_full_refresh_ioctl(struct drm_device *drm_dev, void *data,
+		struct drm_file *file)
+{
+	struct gdepaper *epap = drm_to_gdepaper(drm_dev);
+	int ret, idx;
+	/* FIXME same as below in update luts. locks? */
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		/* FIXME is this the correct return code? Should we retry? */
+		return -EBUSY;
+
+	ret = gdepaper_wait_busy(epap);
+	if (ret)
+		goto out;
+
+	/* FIXME should we lock to sync against update here? */
+	ret = gdepaper_command(epap, GDEP_CMD_DISP_RF, NULL, 0);
+
+out:
+	drm_dev_exit(idx);
+	return ret;
+}
+
+int gdepaper_get_refresh_params_ioctl(struct drm_device *drm_dev, void *data,
+		struct drm_file *file)
+{
+	struct gdepaper *epap = drm_to_gdepaper(drm_dev);
+
+	return copy_to_user(data, &epap->rfp, sizeof(epap->rfp));
+}
+
+int gdepaper_set_refresh_params_ioctl(struct drm_device *drm_dev, void *data,
+		struct drm_file *file)
+{
+	struct gdepaper *epap = drm_to_gdepaper(drm_dev);
+	int ret, idx;
+
+	if (!drm_dev_enter(drm_dev, &idx)) {
+		/* FIXME is this the correct return code? Should we retry? */
+		ret = -EBUSY;
+		goto err_out;
+	}
+
+	if (copy_from_user(&epap->rfp, data, sizeof(epap->rfp))) {
+		ret = -EFAULT;
+		goto err_out;
+	}
+
+	ret = gdepaper_wait_busy(epap);
+	if (ret)
+		goto err_out;
+
+	/* FIXME should we lock to sync against update here? */
+	ret = gdepaper_config_refresh(epap);
+err_out:
+	drm_dev_exit(idx);
+	return ret;
+}
+
+int gdepaper_set_partial_update_en_ioctl(struct drm_device *drm_dev,
+		void *data, struct drm_file *file)
+{
+	struct gdepaper *epap = drm_to_gdepaper(drm_dev);
+	u32 *param = data;
+
+	epap->partial_update_en = *param;
+	return 0;
+}
+
+static const struct drm_ioctl_desc gdepaper_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(GDEPAPER_FORCE_FULL_REFRESH,
+			gdepaper_force_full_refresh_ioctl,
+			DRM_AUTH),
+	DRM_IOCTL_DEF_DRV(GDEPAPER_SET_REFRESH_PARAMS,
+			gdepaper_set_refresh_params_ioctl,
+			DRM_AUTH | DRM_ROOT_ONLY),
+	DRM_IOCTL_DEF_DRV(GDEPAPER_GET_REFRESH_PARAMS,
+			gdepaper_get_refresh_params_ioctl,
+			DRM_AUTH),
+	DRM_IOCTL_DEF_DRV(GDEPAPER_SET_PARTIAL_UPDATE_EN,
+			gdepaper_set_partial_update_en_ioctl,
+			DRM_AUTH | DRM_ROOT_ONLY),
+};
+
+static void gdepaper_release(struct drm_device *drm)
+{
+	struct gdepaper *epap = drm_to_gdepaper(drm);
+
+	drm_mode_config_cleanup(drm);
+	drm_dev_fini(drm);
+	kfree(epap);
+}
+
+static struct drm_driver gdepaper_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
+				  DRIVER_ATOMIC,
+	.fops			= &gdepaper_fops,
+	.release		= gdepaper_release,
+	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	.name			= "gdepaper",
+	.desc			= "Good Display ePaper panel",
+	.date			= "20190715",
+	.major			= 1,
+	.minor			= 0,
+	.ioctls			= gdepaper_ioctls,
+	.num_ioctls		= ARRAY_SIZE(gdepaper_ioctls),
+};
+
+static const uint32_t gdepaper_formats[] = {
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB8888,
+};
+
+static const struct drm_mode_config_funcs gdepaper_dbi_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+#include "gdepaper_models.h"
+MODULE_DEVICE_TABLE(of, gdepaper_of_match);
+
+static const struct spi_device_id gdepaper_spi_id[] = {
+	{"epaper", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, gdepaper_spi_id);
+
+static int gdepaper_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct device_node *np = dev->of_node;
+	const struct of_device_id *of_id;
+	struct drm_device *drm;
+	struct drm_display_mode *mode;
+	struct gdepaper *epap;
+	const struct gdepaper_type_descriptor *type_desc;
+	int ret;
+	size_t bufsize;
+
+	of_id = of_match_node(gdepaper_of_match, np);
+	if (WARN_ON(of_id == NULL)) {
+		dev_warn(dev, "dt node didn't match, aborting probe\n");
+		return -EINVAL;
+	}
+	type_desc = of_id->data;
+
+	dev_dbg(dev, "Probing gdepaper module\n");
+	epap = kzalloc(sizeof(*epap), GFP_KERNEL);
+	if (!epap)
+		return -ENOMEM;
+
+	epap->enabled = false;
+	mutex_init(&epap->cmdlock);
+	epap->tx_buf = NULL;
+	epap->spi = spi;
+
+	drm = &epap->drm;
+	ret = devm_drm_dev_init(dev, drm, &gdepaper_driver);
+	if (ret) {
+		dev_warn(dev, "failed to init drm dev\n");
+		goto err_free;
+	}
+
+	drm_mode_config_init(drm);
+
+	epap->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(epap->reset)) {
+		dev_err(dev, "Failed to get reset GPIO\n");
+		ret = PTR_ERR(epap->reset);
+		goto err_free;
+	}
+
+	epap->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
+	if (IS_ERR(epap->busy)) {
+		dev_err(dev, "Failed to get busy GPIO\n");
+		ret = PTR_ERR(epap->busy);
+		goto err_free;
+	}
+
+	epap->dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(epap->dc)) {
+		dev_err(dev, "Failed to get dc GPIO\n");
+		ret = PTR_ERR(epap->dc);
+		goto err_free;
+	}
+
+	epap->spi_speed_hz = 2000000;
+	epap->pll_div = 1;
+	epap->framerate_mHz = 81850;
+	epap->rfp.vg_lv = GDEP_PWR_VGHL_16V;
+	epap->rfp.vcom_sel = 0;
+	epap->rfp.vdh_bw_mv = 11000; /* drive high level, b/w pixel */
+	epap->rfp.vdh_col_mv = 4200; /* drive high level, red/yellow pixel */
+	epap->rfp.vdl_mv = -11000; /* drive low level */
+	epap->rfp.border_data_sel = 2; /* "vbd" */
+	epap->rfp.data_polarity = 0; /* "ddx" */
+	epap->rfp.vcom_dc_mv = -1000;
+	epap->rfp.vcom_data_ivl_hsync = 10; /* hsync periods */
+	epap->rfp.use_otp_luts_flag = 1;
+	epap->ss_param[0] = 0x07;
+	epap->ss_param[1] = 0x07;
+	epap->ss_param[2] = 0x17;
+	epap->controller_res = GDEP_CTRL_RES_320X300;
+
+	ret = gdepaper_of_read_luts(epap, np, dev);
+	if (ret) {
+		dev_warn(dev, "can't read LUTs from dt\n");
+		goto err_free;
+	}
+
+	of_property_read_u32(np, "controller-resolution",
+			&epap->controller_res);
+	of_property_read_u32(np, "spi-speed-hz", &epap->spi_speed_hz);
+	epap->partial_update_en = of_property_read_bool(np, "partial-update");
+	ret = of_property_read_u32(np, "colors", &epap->display_colors);
+	if (ret == -EINVAL) {
+		if (type_desc) {
+			epap->display_colors = type_desc->colors;
+
+		} else {
+			dev_err(dev, "colors must be set in dt\n");
+			ret = -EINVAL;
+			goto err_free;
+		}
+	} else if (ret) {
+		dev_err(dev, "Invalid dt colors property\n");
+		goto err_free;
+	}
+	if (epap->display_colors < 0 ||
+			epap->display_colors >= GDEPAPER_COL_END) {
+		dev_err(dev, "invalid colors value\n");
+		ret = -EINVAL;
+		goto err_free;
+	}
+	epap->mirror_x = of_property_read_bool(np, "mirror-x");
+	epap->mirror_y = of_property_read_bool(np, "mirror-y");
+	of_property_read_u32(np, "pll-div", &epap->pll_div);
+	of_property_read_u32(np, "fps-millihertz", &epap->framerate_mHz);
+	of_property_read_u32(np, "vghl-level", &epap->rfp.vg_lv);
+	epap->vds_en = !of_property_read_bool(np, "vds-external");
+	epap->vdg_en = !of_property_read_bool(np, "vdg-external");
+	of_property_read_u32(np, "vcom", &epap->rfp.vcom_sel);
+	of_property_read_u32(np, "vdh-bw-millivolts", &epap->rfp.vdh_bw_mv);
+	of_property_read_u32(np, "vdh-color-millivolts", &epap->rfp.vdh_col_mv);
+	of_property_read_u32(np, "vdl-millivolts", &epap->rfp.vdl_mv);
+	of_property_read_u32(np, "border-data", &epap->rfp.border_data_sel);
+	of_property_read_u32(np, "data-polarity", &epap->rfp.data_polarity);
+	ret = of_property_read_u8_array(np, "boost-soft-start",
+			(u8 *)&epap->ss_param, sizeof(epap->ss_param));
+	if (ret && ret != -EINVAL)
+		dev_err(dev, "invalid boost-soft-start value, ignoring\n");
+	of_property_read_u32(np, "vcom-data-interval-periods",
+			&epap->rfp.vcom_data_ivl_hsync);
+
+	/* Accept both positive and negative notation */
+	if (epap->rfp.vdl_mv < 0)
+		epap->rfp.vdl_mv = -epap->rfp.vdl_mv;
+	if (epap->rfp.vcom_dc_mv < 0)
+		epap->rfp.vcom_dc_mv = -epap->rfp.vcom_dc_mv;
+
+	/* (from mipi-dbi.c:)
+	 * Even though it's not the SPI device that does DMA (the master does),
+	 * the dma mask is necessary for the dma_alloc_wc() in
+	 * drm_gem_cma_create(). The dma_addr returned will be a physical
+	 * address which might be different from the bus address, but this is
+	 * not a problem since the address will not be used.
+	 * The virtual address is used in the transfer and the SPI core
+	 * re-maps it on the SPI master device using the DMA streaming API
+	 * (spi_map_buf()).
+	 */
+	if (!dev->coherent_dma_mask) {
+		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_warn(dev, "Failed to set dma mask %d\n", ret);
+			goto err_free;
+		}
+	}
+
+	mode = gdepaper_of_read_mode(type_desc, np, dev);
+	if (IS_ERR(mode)) {
+		dev_warn(dev, "Failed to read mode: %ld\n", PTR_ERR(mode));
+		ret = PTR_ERR(mode);
+		goto err_free;
+	}
+
+	/* 8 pixels per byte, bit-packed */
+	bufsize = (mode->vdisplay * mode->hdisplay + 7)/8;
+	epap->tx_buf = devm_kmalloc(drm->dev, bufsize, GFP_KERNEL);
+	if (!epap->tx_buf) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	/* TODO rotation support? */
+	ret = tinydrm_display_pipe_init(drm, &epap->pipe, &gdepaper_pipe_funcs,
+					DRM_MODE_CONNECTOR_VIRTUAL,
+					gdepaper_formats,
+					ARRAY_SIZE(gdepaper_formats), mode, 0);
+	if (ret) {
+		dev_warn(dev, "Failed to initialize display pipe: %d\n", ret);
+		goto err_free;
+	}
+
+	drm->mode_config.funcs = &gdepaper_dbi_mode_config_funcs;
+	drm->mode_config.preferred_depth = 32;
+	drm_plane_enable_fb_damage_clips(&epap->pipe.plane);
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret) {
+		dev_warn(dev, "Failed to register drm device: %d\n", ret);
+		goto err_free;
+	}
+
+	spi_set_drvdata(spi, drm);
+	drm_fbdev_generic_setup(drm, 0);
+
+	dev_dbg(dev, "Probed gdepaper module\n");
+	return 0;
+err_free:
+	kfree(epap);
+	return ret;
+}
+
+static int gdepaper_remove(struct spi_device *spi)
+{
+	struct drm_device *drm = spi_get_drvdata(spi);
+
+	dev_dbg(drm->dev, "Removing gdepaper module\n");
+	drm_dev_unplug(drm);
+	drm_atomic_helper_shutdown(drm);
+
+	return 0;
+}
+
+static void gdepaper_shutdown(struct spi_device *spi)
+{
+	struct drm_device *drm = spi_get_drvdata(spi);
+
+	dev_dbg(drm->dev, "Shutting down gdepaper module\n");
+	drm_atomic_helper_shutdown(spi_get_drvdata(spi));
+}
+
+static struct spi_driver gdepaper_spi_driver = {
+	.driver = {
+		.name = "gdepaper",
+		.owner = THIS_MODULE,
+		.of_match_table = gdepaper_of_match,
+	},
+	.id_table = gdepaper_spi_id,
+	.probe = gdepaper_probe,
+	.remove = gdepaper_remove,
+	.shutdown = gdepaper_shutdown,
+};
+module_spi_driver(gdepaper_spi_driver);
+
+MODULE_DESCRIPTION("Good Display epaper panel driver");
+MODULE_AUTHOR("Jan Sebastian Götte <linux@jaseg.net>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tinydrm/gdepaper_models.h b/drivers/gpu/drm/tinydrm/gdepaper_models.h
new file mode 100644
index 000000000000..1b9125d711de
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/gdepaper_models.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This file contains a list of Good Display epaper display model numbers
+ * listing their color mode (B/W, B/W/Red, B/W/Yellow) as well as their physical
+ * dimensions and resolution.
+ *
+ * This data was manually extracted from the displays' specifications pages on
+ * the mfg website.
+ *
+ * The following displays use third-party driver chips with command sets this
+ * driver can't handle:
+ *   GDEH0154D67
+ *   GDEH0213B73
+ *   GDE060B3
+ *   GDE060F3
+ *   GDE060BA, GDE060BAT, GDE060BAFL GDE060BAFLT
+ *
+ * To add a display, insert the appropriate descriptor line below, then link it
+ * into the table at the bottom of this file. This driver should handle any
+ * Good Display driver chip (IL*, GD*) with minor modifications.
+ *
+ * Copyright 2019 Jan Sebastian Goette
+ */
+
+#define DEF_EPD_TYPE(type, col, w_mm, h_mm, w_px, h_px) \
+	static const struct gdepaper_type_descriptor gddsp_ ## type ## _data = \
+	{col, w_mm, h_mm, w_px, h_px}
+
+DEF_EPD_TYPE(gdew0154z04t,    GDEPAPER_COL_BW_RED,     28,  28,  200, 200); /*    1.54"    b/w/r  IL0376F     */
+DEF_EPD_TYPE(gdew0154z04fl,   GDEPAPER_COL_BW_RED,     28,  28,  200, 200); /*    1.54"    b/w/r  IL0376F     */
+DEF_EPD_TYPE(gdew0154z04,     GDEPAPER_COL_BW_RED,     28,  28,  200, 200); /*    1.54"    b/w/r  IL0376F     */
+DEF_EPD_TYPE(gdewl0154z17fl,  GDEPAPER_COL_BW_RED,     28,  28,  152, 152); /*    1.54"    b/w/r  IL0373      */
+DEF_EPD_TYPE(gdew0154z17,     GDEPAPER_COL_BW_RED,     28,  28,  152, 152); /*    1.54"    b/w/r  IL0373      */
+DEF_EPD_TYPE(gdew0154c39fl,   GDEPAPER_COL_BW_YELLOW,  28,  28,  152, 152); /*    1.54"    b/w/y              */
+DEF_EPD_TYPE(gdew0154c39,     GDEPAPER_COL_BW_YELLOW,  28,  28,  152, 152); /*    1.54"    b/w/y              */
+DEF_EPD_TYPE(gdew0213z16,     GDEPAPER_COL_BW_RED,     49,  24,  212, 104); /*    2.13"    b/w/r  IL0373      */
+DEF_EPD_TYPE(gdew0213c38,     GDEPAPER_COL_BW_YELLOW,  49,  24,  212, 104); /*    2.13"    b/w/y  IL0373      */
+DEF_EPD_TYPE(gdew026z39,      GDEPAPER_COL_BW_RED,     60,  31,  296, 152); /*    2.6"     b/w/r  IL0373      */
+DEF_EPD_TYPE(gdew027c44t,     GDEPAPER_COL_BW_RED,     57,  38,  264, 176); /*    2.7"     b/w/r  IL91874     */
+DEF_EPD_TYPE(gdew027c44,      GDEPAPER_COL_BW_RED,     57,  38,  264, 176); /*    2.7"     b/w/r  IL91874     */
+DEF_EPD_TYPE(gdew029z10,      GDEPAPER_COL_BW_RED,     67,  29,  296, 128); /*    2.9"     b/w/r  IL0373      */
+DEF_EPD_TYPE(gdew029c32,      GDEPAPER_COL_BW_YELLOW,  67,  29,  296, 128); /*    2.9"     b/w/y  IL0373      */
+DEF_EPD_TYPE(gdew0371z80,     GDEPAPER_COL_BW_RED,     82,  47,  416, 240); /*    3.71"    b/w/r  GD8102      */
+DEF_EPD_TYPE(gdew042z15,      GDEPAPER_COL_BW_RED,     85,  64,  400, 300); /*    4.2"     b/w/r  IL0398      */
+DEF_EPD_TYPE(gdew042c37,      GDEPAPER_COL_BW_YELLOW,  85,  64,  400, 300); /*    4.2"     b/w/y  IL0398      */
+DEF_EPD_TYPE(gdew0583c64,     GDEPAPER_COL_BW_YELLOW, 119,  88,  600, 448); /*    5.83"    b/w/y  IL0371      */
+DEF_EPD_TYPE(gdew0583z21,     GDEPAPER_COL_BW_RED,    119,  88,  600, 448); /*    5.83"    b/w/r  IL0371      */
+DEF_EPD_TYPE(gdew075z08,      GDEPAPER_COL_BW_RED,    163,  98,  800, 480); /*    7.5"     b/w/r  GD7965      */
+DEF_EPD_TYPE(gdew075z09,      GDEPAPER_COL_BW_RED,    163,  98,  640, 384); /*    7.5"     b/w/r  IL0371      */
+DEF_EPD_TYPE(gdew075c21,      GDEPAPER_COL_BW_YELLOW, 163,  98,  640, 384); /*    7.5"     b/w/y  IL0371      */
+/* These are not yet supported since they use multiple driver chips in cascade mode */
+/* DEF_EPD_TYPE(gdew1248z95,     GDEPAPER_COL_BW_RED,    253, 191, 1304, 984); */ /*   12.48"    b/w/r  IL0326 (4x) */
+/* DEF_EPD_TYPE(gdew1248c63,     GDEPAPER_COL_BW_YELLOW, 253, 191, 1304, 984); */ /*   12.48"    b/w/y  IL0326 (4x) */
+/* DEF_EPD_TYPE(gdew1248t3,      GDEPAPER_COL_BW,        253, 191, 1304, 984); */ /*   12.48"    b/w    IL0326 (4x) */
+DEF_EPD_TYPE(gdew0102i4f,     GDEPAPER_COL_BW,         22,  14,  128,  80); /*    1.02"    b/w    IL0323      */
+DEF_EPD_TYPE(gdew0102i4fc,    GDEPAPER_COL_BW,         22,  14,  128,  80); /*    1.02"    b/w                */
+DEF_EPD_TYPE(gdep014tt1,      GDEPAPER_COL_BW,         14,  33,  128, 296); /*    1.43"    b/w                */
+DEF_EPD_TYPE(gdep015oc1,      GDEPAPER_COL_BW,         28,  28,  200, 200); /*    1.54"    b/w    IL3829      */
+DEF_EPD_TYPE(gdew0154t8t,     GDEPAPER_COL_BW,         28,  28,  152, 152); /*    1.54"    b/w    IL0373      */
+DEF_EPD_TYPE(gdew0154t8fl,    GDEPAPER_COL_BW,         28,  28,  152, 152); /*    1.54"    b/w    IL0373      */
+DEF_EPD_TYPE(gdew0154t8,      GDEPAPER_COL_BW,         28,  28,  152, 152); /*    1.54"    b/w    IL0373      */
+DEF_EPD_TYPE(gdeh0154d27t,    GDEPAPER_COL_BW,         28,  28,  200, 200); /*    1.54"    b/w                */
+DEF_EPD_TYPE(gdem0154e97lt,   GDEPAPER_COL_BW,         28,  28,  152, 152); /*    1.54"    b/w    IL3895      */
+DEF_EPD_TYPE(gdew0154i9f,     GDEPAPER_COL_BW,         28,  28,  152, 152); /*    1.54"    b/w                */
+DEF_EPD_TYPE(gdew0213t5,      GDEPAPER_COL_BW,         24,  49,  212, 104); /*    2.13"    b/w    IL0373      */
+DEF_EPD_TYPE(gdew0213i5f,     GDEPAPER_COL_BW,         49,  24,  212, 104); /*    2.13"    b/w                */
+DEF_EPD_TYPE(gdeh0213d30lt,   GDEPAPER_COL_BW,         23,  48,  212, 104); /*    2.13"    b/w    IL3820      */
+DEF_EPD_TYPE(gdew0213v7lt,    GDEPAPER_COL_BW,         24,  49,  212, 104); /*    2.13"    b/w    IL0373      */
+DEF_EPD_TYPE(gdth0213zhft34,  GDEPAPER_COL_BW,         24,  49,  250, 122); /*    2.13"    b/w                */
+DEF_EPD_TYPE(gdew026t0,       GDEPAPER_COL_BW,         60,  31,  296, 152); /*    2.6"     b/w    IL0373      */
+DEF_EPD_TYPE(gdew027w3t,      GDEPAPER_COL_BW,         57,  38,  264, 176); /*    2.7"     b/w    IL91874     */
+DEF_EPD_TYPE(gdew027w3,       GDEPAPER_COL_BW,         57,  38,  264, 176); /*    2.7"     b/w    IL91874     */
+DEF_EPD_TYPE(gdeh029a1,       GDEPAPER_COL_BW,         67,  29,  296, 128); /*    2.9"     b/w    IL3820      */
+DEF_EPD_TYPE(gdew029t5,       GDEPAPER_COL_BW,         67,  29,  296, 128); /*    2.9"     b/w    IL0373      */
+DEF_EPD_TYPE(gdeh029d56lt,    GDEPAPER_COL_BW,         67,  29,  296, 128); /*    2.9"     b/w                */
+DEF_EPD_TYPE(gdew029i6f,      GDEPAPER_COL_BW,         67,  29,  296, 128); /*    2.9"     b/w                */
+DEF_EPD_TYPE(gdew0371w7,      GDEPAPER_COL_BW,         82,  47,  416, 240); /*    3.71"    b/w    GP8102      */
+DEF_EPD_TYPE(gdew042t2,       GDEPAPER_COL_BW,         83,  64,  400, 300); /*    4.2"     b/w    IL0398      */
+DEF_EPD_TYPE(gdep043zf3,      GDEPAPER_COL_BW,         56,  94,  800, 480); /*    4.3"     b/w                */
+DEF_EPD_TYPE(gde043a2t,       GDEPAPER_COL_BW,         88,  66,  800, 600); /*    4.3"     b/w                */
+DEF_EPD_TYPE(gde043a2,        GDEPAPER_COL_BW,         88,  66,  800, 600); /*    4.3"     b/w                */
+DEF_EPD_TYPE(gdew0583t7,      GDEPAPER_COL_BW,        119,  88,  600, 448); /*    5.83"    b/w    IL0371      */
+DEF_EPD_TYPE(gdew075t8,       GDEPAPER_COL_BW,        163,  98,  640, 384); /*    7.5"     b/w    IL0371      */
+DEF_EPD_TYPE(gdew075t7,       GDEPAPER_COL_BW,        163,  98,  800, 480); /*    7.5"     b/w    GD7965      */
+DEF_EPD_TYPE(gdew080t5,       GDEPAPER_COL_BW,        122, 163, 1024, 768); /*    8"       b/w                */
+DEF_EPD_TYPE(gdep097tc2,      GDEPAPER_COL_BW,        203, 139, 1200, 825); /*    9.7"     b/w                */
+
+#undef DEF_EPD_TYPE
+
+#define EPD_OF_ENTRY(type) \
+	{ .compatible = "gooddisplay," #type, .data = &gddsp_ ## type ## _data }
+
+static const struct of_device_id gdepaper_of_match[] = {
+	{ .compatible = "gooddisplay,generic_epaper",	.data = NULL },
+	EPD_OF_ENTRY(gdew0154z04t),
+	EPD_OF_ENTRY(gdew0154z04fl),
+	EPD_OF_ENTRY(gdew0154z04),
+	EPD_OF_ENTRY(gdewl0154z17fl),
+	EPD_OF_ENTRY(gdew0154z17),
+	EPD_OF_ENTRY(gdew0154c39fl),
+	EPD_OF_ENTRY(gdew0154c39),
+	EPD_OF_ENTRY(gdew0213z16),
+	EPD_OF_ENTRY(gdew0213c38),
+	EPD_OF_ENTRY(gdew026z39),
+	EPD_OF_ENTRY(gdew027c44t),
+	EPD_OF_ENTRY(gdew027c44),
+	EPD_OF_ENTRY(gdew029z10),
+	EPD_OF_ENTRY(gdew029c32),
+	EPD_OF_ENTRY(gdew0371z80),
+	EPD_OF_ENTRY(gdew042z15),
+	EPD_OF_ENTRY(gdew042c37),
+	EPD_OF_ENTRY(gdew0583c64),
+	EPD_OF_ENTRY(gdew0583z21),
+	EPD_OF_ENTRY(gdew075z08),
+	EPD_OF_ENTRY(gdew075z09),
+	EPD_OF_ENTRY(gdew075c21),
+	/* see comment above. */
+	/* EPD_OF_ENTRY(gdew1248z95), */
+	/* EPD_OF_ENTRY(gdew1248c63), */
+	/* EPD_OF_ENTRY(gdew1248t3), */
+	EPD_OF_ENTRY(gdew0102i4f),
+	EPD_OF_ENTRY(gdew0102i4fc),
+	EPD_OF_ENTRY(gdep014tt1),
+	EPD_OF_ENTRY(gdep015oc1),
+	EPD_OF_ENTRY(gdew0154t8t),
+	EPD_OF_ENTRY(gdew0154t8fl),
+	EPD_OF_ENTRY(gdew0154t8),
+	EPD_OF_ENTRY(gdeh0154d27t),
+	EPD_OF_ENTRY(gdem0154e97lt),
+	EPD_OF_ENTRY(gdew0154i9f),
+	EPD_OF_ENTRY(gdew0213t5),
+	EPD_OF_ENTRY(gdew0213i5f),
+	EPD_OF_ENTRY(gdeh0213d30lt),
+	EPD_OF_ENTRY(gdew0213v7lt),
+	EPD_OF_ENTRY(gdth0213zhft34),
+	EPD_OF_ENTRY(gdew026t0),
+	EPD_OF_ENTRY(gdew027w3t),
+	EPD_OF_ENTRY(gdew027w3),
+	EPD_OF_ENTRY(gdeh029a1),
+	EPD_OF_ENTRY(gdew029t5),
+	EPD_OF_ENTRY(gdeh029d56lt),
+	EPD_OF_ENTRY(gdew029i6f),
+	EPD_OF_ENTRY(gdew0371w7),
+	EPD_OF_ENTRY(gdew042t2),
+	EPD_OF_ENTRY(gdep043zf3),
+	EPD_OF_ENTRY(gde043a2t),
+	EPD_OF_ENTRY(gde043a2),
+	EPD_OF_ENTRY(gdew0583t7),
+	EPD_OF_ENTRY(gdew075t8),
+	EPD_OF_ENTRY(gdew075t7),
+	EPD_OF_ENTRY(gdew080t5),
+	EPD_OF_ENTRY(gdep097tc2),
+	{}
+};
+
+#undef EPD_OF_ENTRY
+
-- 
2.21.0

