Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E95114077
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 13:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfLEMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 07:02:59 -0500
Received: from jax4mhfb02.myregisteredsite.com ([64.69.218.95]:57714 "EHLO
        jax4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729378AbfLEMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:02:59 -0500
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 07:02:57 EST
Received: from jax4mhob16.registeredsite.com (jax4mhob16.registeredsite.com [64.69.218.104])
        by jax4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id xB5BvgxG012484
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 06:57:42 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by jax4mhob16.registeredsite.com (8.14.4/8.14.4) with ESMTP id xB5BvdNB122792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 06:57:39 -0500
Received: (qmail 15626 invoked by uid 0); 5 Dec 2019 11:57:39 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 5 Dec 2019 11:57:39 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk, clk-si5341: Support multiple input ports
Date:   Thu,  5 Dec 2019 12:57:34 +0100
Message-Id: <20191205115734.6987-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Si5341 and Si5340 have multiple input clock options. So far, the driver
only supported the XTAL input, this adds support for the three external
clock inputs as well.

If the clock chip is't programmed at boot, the driver will default to the
XTAL input as before. If there is no "xtal" clock input available, it will
pick the first connected input (e.g. "in0") as the input clock for the PLL.
One can use clock-assigned-parents to select a particular clock as input.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-si5341.c | 213 +++++++++++++++++++++++++++++++++++----
 1 file changed, 196 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 6e780c2a9e6b..f7dba7698083 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2019 Topic Embedded Products
  * Author: Mike Looijmans <mike.looijmans@topic.nl>
  */
-
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -16,6 +15,8 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
+#define SI5341_NUM_INPUTS 4
+
 #define SI5341_MAX_NUM_OUTPUTS 10
 #define SI5340_MAX_NUM_OUTPUTS 4
 
@@ -56,8 +57,8 @@ struct clk_si5341 {
 	struct i2c_client *i2c_client;
 	struct clk_si5341_synth synth[SI5341_NUM_SYNTH];
 	struct clk_si5341_output clk[SI5341_MAX_NUM_OUTPUTS];
-	struct clk *pxtal;
-	const char *pxtal_name;
+	struct clk *input_clk[SI5341_NUM_INPUTS];
+	const char *input_clk_name[SI5341_NUM_INPUTS];
 	const u16 *reg_output_offset;
 	const u16 *reg_rdiv_offset;
 	u64 freq_vco; /* 13500–14256 MHz */
@@ -78,10 +79,25 @@ struct clk_si5341_output_config {
 #define SI5341_DEVICE_REV	0x0005
 #define SI5341_STATUS		0x000C
 #define SI5341_SOFT_RST		0x001C
+#define SI5341_IN_SEL		0x0021
+#define SI5341_XAXB_CFG		0x090E
+#define SI5341_IN_EN		0x0949
+#define SI5341_INX_TO_PFD_EN	0x094A
+
+/* Input selection */
+#define SI5341_IN_SEL_MASK	0x06
+#define SI5341_IN_SEL_SHIFT	1
+#define SI5341_IN_SEL_REGCTRL	0x01
+#define SI5341_INX_TO_PFD_SHIFT	4
+
+/* XTAL config bits */
+#define SI5341_XAXB_CFG_EXTCLK_EN	BIT(0)
+#define SI5341_XAXB_CFG_PDNB		BIT(1)
 
 /* Input dividers (48-bit) */
 #define SI5341_IN_PDIV(x)	(0x0208 + ((x) * 10))
 #define SI5341_IN_PSET(x)	(0x020E + ((x) * 10))
+#define SI5341_PX_UPD		0x0230
 
 /* PLL configuration */
 #define SI5341_PLL_M_NUM	0x0235
@@ -120,6 +136,10 @@ struct si5341_reg_default {
 	u8 value;
 };
 
+static const char * const si5341_input_clock_names[] = {
+	"in0", "in1", "in2", "xtal"
+};
+
 /* Output configuration registers 0..9 are not quite logically organized */
 static const u16 si5341_reg_output_offset[] = {
 	0x0108,
@@ -390,7 +410,112 @@ static unsigned long si5341_clk_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)res;
 }
 
+static int si5341_clk_get_selected_input(struct clk_si5341 *data)
+{
+	int err;
+	u32 val;
+
+	err = regmap_read(data->regmap, SI5341_IN_SEL, &val);
+	if (err < 0)
+		return err;
+
+	return (val & SI5341_IN_SEL_MASK) >> SI5341_IN_SEL_SHIFT;
+}
+
+static unsigned char si5341_clk_get_parent(struct clk_hw *hw)
+{
+	struct clk_si5341 *data = to_clk_si5341(hw);
+	int res = si5341_clk_get_selected_input(data);
+
+	if (res < 0)
+		return 0; /* Apparently we cannot report errors */
+
+	return res;
+}
+
+static int si5341_clk_reparent(struct clk_si5341 *data, u8 index)
+{
+	int err;
+	u8 val;
+
+	val = (index << SI5341_IN_SEL_SHIFT) & SI5341_IN_SEL_MASK;
+	/* Enable register-based input selection */
+	val |= SI5341_IN_SEL_REGCTRL;
+
+	err = regmap_update_bits(data->regmap,
+		SI5341_IN_SEL, SI5341_IN_SEL_REGCTRL | SI5341_IN_SEL_MASK, val);
+	if (err < 0)
+		return err;
+
+	if (index < 3) {
+		/* Enable input buffer for selected input */
+		err = regmap_update_bits(data->regmap,
+				SI5341_IN_EN, 0x07, BIT(index));
+		if (err < 0)
+			return err;
+
+		/* Enables the input to phase detector */
+		err = regmap_update_bits(data->regmap, SI5341_INX_TO_PFD_EN,
+				0x7 << SI5341_INX_TO_PFD_SHIFT,
+				BIT(index + SI5341_INX_TO_PFD_SHIFT));
+		if (err < 0)
+			return err;
+
+		/* Power down XTAL oscillator and buffer */
+		err = regmap_update_bits(data->regmap, SI5341_XAXB_CFG,
+				SI5341_XAXB_CFG_PDNB, 0);
+		if (err < 0)
+			return err;
+
+		/*
+		 * Set the P divider to "1". There's no explanation in the
+		 * datasheet of these registers, but the clockbuilder software
+		 * programs a "1" when the input is being used.
+		 */
+		err = regmap_write(data->regmap, SI5341_IN_PDIV(index), 1);
+		if (err < 0)
+			return err;
+
+		err = regmap_write(data->regmap, SI5341_IN_PSET(index), 1);
+		if (err < 0)
+			return err;
+
+		/* Set update PDIV bit */
+		err = regmap_write(data->regmap, SI5341_PX_UPD, BIT(index));
+		if (err < 0)
+			return err;
+	} else {
+		/* Disable all input buffers */
+		err = regmap_update_bits(data->regmap, SI5341_IN_EN, 0x07, 0);
+		if (err < 0)
+			return err;
+
+		/* Disable input to phase detector */
+		err = regmap_update_bits(data->regmap, SI5341_INX_TO_PFD_EN,
+				0x7 << SI5341_INX_TO_PFD_SHIFT, 0);
+		if (err < 0)
+			return err;
+
+		/* Power up XTAL oscillator and buffer */
+		err = regmap_update_bits(data->regmap, SI5341_XAXB_CFG,
+				SI5341_XAXB_CFG_PDNB, SI5341_XAXB_CFG_PDNB);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int si5341_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_si5341 *data = to_clk_si5341(hw);
+
+	return si5341_clk_reparent(data, index);
+}
+
 static const struct clk_ops si5341_clk_ops = {
+	.set_parent = si5341_clk_set_parent,
+	.get_parent = si5341_clk_get_parent,
 	.recalc_rate = si5341_clk_recalc_rate,
 };
 
@@ -985,7 +1110,8 @@ static const struct regmap_range si5341_regmap_volatile_range[] = {
 	regmap_reg_range(0x000C, 0x0012), /* Status */
 	regmap_reg_range(0x001C, 0x001E), /* reset, finc/fdec */
 	regmap_reg_range(0x00E2, 0x00FE), /* NVM, interrupts, device ready */
-	/* Update bits for synth config */
+	/* Update bits for P divider and synth config */
+	regmap_reg_range(SI5341_PX_UPD, SI5341_PX_UPD),
 	regmap_reg_range(SI5341_SYNTH_N_UPD(0), SI5341_SYNTH_N_UPD(0)),
 	regmap_reg_range(SI5341_SYNTH_N_UPD(1), SI5341_SYNTH_N_UPD(1)),
 	regmap_reg_range(SI5341_SYNTH_N_UPD(2), SI5341_SYNTH_N_UPD(2)),
@@ -1122,6 +1248,7 @@ static int si5341_initialize_pll(struct clk_si5341 *data)
 	struct device_node *np = data->i2c_client->dev.of_node;
 	u32 m_num = 0;
 	u32 m_den = 0;
+	int sel;
 
 	if (of_property_read_u32(np, "silabs,pll-m-num", &m_num)) {
 		dev_err(&data->i2c_client->dev,
@@ -1135,7 +1262,11 @@ static int si5341_initialize_pll(struct clk_si5341 *data)
 	if (!m_num || !m_den) {
 		dev_err(&data->i2c_client->dev,
 			"PLL configuration invalid, assume 14GHz\n");
-		m_den = clk_get_rate(data->pxtal) / 10;
+		sel = si5341_clk_get_selected_input(data);
+		if (sel < 0)
+			return sel;
+
+		m_den = clk_get_rate(data->input_clk[sel]) / 10;
 		m_num = 1400000000;
 	}
 
@@ -1143,11 +1274,52 @@ static int si5341_initialize_pll(struct clk_si5341 *data)
 			SI5341_PLL_M_NUM, m_num, m_den);
 }
 
+static int si5341_clk_select_active_input(struct clk_si5341 *data)
+{
+	int res;
+	int err;
+	int i;
+
+	res = si5341_clk_get_selected_input(data);
+	if (res < 0)
+		return res;
+
+	/* If the current register setting is invalid, pick the first input */
+	if (!data->input_clk[res]) {
+		dev_dbg(&data->i2c_client->dev,
+			"Input %d not connected, rerouting\n", res);
+		res = -ENODEV;
+		for (i = 0; i < SI5341_NUM_INPUTS; ++i) {
+			if (data->input_clk[i]) {
+				res = i;
+				break;
+			}
+		}
+		if (res < 0) {
+			dev_err(&data->i2c_client->dev,
+				"No clock input available\n");
+			return res;
+		}
+	}
+
+	/* Make sure the selected clock is also enabled and routed */
+	err = si5341_clk_reparent(data, res);
+	if (err < 0)
+		return err;
+
+	err = clk_prepare_enable(data->input_clk[res]);
+	if (err < 0)
+		return err;
+
+	return res;
+}
+
 static int si5341_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct clk_si5341 *data;
 	struct clk_init_data init;
+	struct clk *input;
 	const char *root_clock_name;
 	const char *synth_clock_names[SI5341_NUM_SYNTH];
 	int err;
@@ -1161,12 +1333,16 @@ static int si5341_probe(struct i2c_client *client,
 
 	data->i2c_client = client;
 
-	data->pxtal = devm_clk_get(&client->dev, "xtal");
-	if (IS_ERR(data->pxtal)) {
-		if (PTR_ERR(data->pxtal) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(&client->dev, "Missing xtal clock input\n");
+	for (i = 0; i < SI5341_NUM_INPUTS; ++i) {
+		input = devm_clk_get(&client->dev, si5341_input_clock_names[i]);
+		if (IS_ERR(input)) {
+			if (PTR_ERR(input) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			data->input_clk_name[i] = si5341_input_clock_names[i];
+		} else {
+			data->input_clk[i] = input;
+			data->input_clk_name[i] = __clk_get_name(input);
+		}
 	}
 
 	err = si5341_dt_parse_dt(client, config);
@@ -1188,9 +1364,6 @@ static int si5341_probe(struct i2c_client *client,
 	if (err < 0)
 		return err;
 
-	/* "Activate" the xtal (usually a fixed clock) */
-	clk_prepare_enable(data->pxtal);
-
 	if (of_property_read_bool(client->dev.of_node, "silabs,reprogram")) {
 		initialization_required = true;
 	} else {
@@ -1223,7 +1396,14 @@ static int si5341_probe(struct i2c_client *client,
 					ARRAY_SIZE(si5341_reg_defaults));
 		if (err < 0)
 			return err;
+	}
+
+	/* Input must be up and running at this point */
+	err = si5341_clk_select_active_input(data);
+	if (err < 0)
+		return err;
 
+	if (initialization_required) {
 		/* PLL configuration is required */
 		err = si5341_initialize_pll(data);
 		if (err < 0)
@@ -1231,9 +1411,8 @@ static int si5341_probe(struct i2c_client *client,
 	}
 
 	/* Register the PLL */
-	data->pxtal_name = __clk_get_name(data->pxtal);
-	init.parent_names = &data->pxtal_name;
-	init.num_parents = 1; /* For now, only XTAL input supported */
+	init.parent_names = data->input_clk_name;
+	init.num_parents = SI5341_NUM_INPUTS;
 	init.ops = &si5341_clk_ops;
 	init.flags = 0;
 	data->hw.init = &init;
-- 
2.17.1

