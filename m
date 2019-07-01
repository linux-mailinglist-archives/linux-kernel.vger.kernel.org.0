Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1493024821
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfEUGfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 02:35:34 -0400
Received: from olimex.com ([184.105.72.32]:39401 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfEUGfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:35:33 -0400
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:25:27 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 1/2] mfd: rk808: Check pm_power_off pointer
Date:   Tue, 21 May 2019 09:24:48 +0300
Message-Id: <20190521062449.29410-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521062449.29410-1-stefan@olimex.com>
References: <20190521062449.29410-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function pointer pm_power_off may point to function from other
module (PSCI for example). If rk808 is removed, pm_power_off is
overwritten to NULL and the system cannot be powered off.

This patch checks if pm_power_off points to a module function.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
Changes in v2:
 - Initial release actually

 drivers/mfd/rk808.c       | 13 +++++++------
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 94377782d208..c0b179792bbf 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -438,7 +438,6 @@ static int rk808_probe(struct i2c_client *client,
 	struct rk808 *rk808;
 	const struct rk808_reg_data *pre_init_reg;
 	const struct mfd_cell *cells;
-	void (*pm_pwroff_fn)(void);
 	int nr_pre_init_regs;
 	int nr_cells;
 	int pm_off = 0, msb, lsb;
@@ -475,7 +474,7 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
-		pm_pwroff_fn = rk805_device_shutdown;
+		rk808->pm_pwroff_fn = rk805_device_shutdown;
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
@@ -484,7 +483,7 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
-		pm_pwroff_fn = rk808_device_shutdown;
+		rk808->pm_pwroff_fn = rk808_device_shutdown;
 		break;
 	case RK818_ID:
 		rk808->regmap_cfg = &rk818_regmap_config;
@@ -493,7 +492,7 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
 		cells = rk818s;
 		nr_cells = ARRAY_SIZE(rk818s);
-		pm_pwroff_fn = rk818_device_shutdown;
+		rk808->pm_pwroff_fn = rk818_device_shutdown;
 		break;
 	default:
 		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
@@ -548,7 +547,7 @@ static int rk808_probe(struct i2c_client *client,
 				"rockchip,system-power-controller");
 	if (pm_off && !pm_power_off) {
 		rk808_i2c_client = client;
-		pm_power_off = pm_pwroff_fn;
+		pm_power_off = rk808->pm_pwroff_fn;
 	}
 
 	return 0;
@@ -563,7 +562,9 @@ static int rk808_remove(struct i2c_client *client)
 	struct rk808 *rk808 = i2c_get_clientdata(client);
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
-	pm_power_off = NULL;
+
+	if (rk808->pm_pwroff_fn && pm_power_off == rk808->pm_pwroff_fn)
+		pm_power_off = NULL;
 
 	return 0;
 }
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index d3156594674c..8b5d68a7bb9c 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -453,5 +453,6 @@ struct rk808 {
 	long				variant;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
+	void				(*pm_pwroff_fn)(void);
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.17.1

