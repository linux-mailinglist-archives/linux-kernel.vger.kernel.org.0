Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F658AF230
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfIJUJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 16:09:16 -0400
Received: from cyberdimension.org ([80.67.179.20]:40988 "EHLO
        gnutoo.cyberdimension.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIJUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:09:16 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 16:09:14 EDT
Received: from gnutoo.cyberdimension.org (localhost [127.0.0.1])
        by cyberdimension.org (OpenSMTPD) with ESMTP id f0d39e6a;
        Tue, 10 Sep 2019 19:59:29 +0000 (UTC)
Received: from primarylaptop.localdomain (localhost.localdomain [IPv6:::1])
        by gnutoo.cyberdimension.org (OpenSMTPD) with ESMTP id 1dac50d3;
        Tue, 10 Sep 2019 19:59:28 +0000 (UTC)
From:   Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
To:     Chanwoo@gnutoo.cyberdimension.org, Choi@gnutoo.cyberdimension.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
        Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: [PATCH 2/2] power_supply: max77693: Listen for cable events and enable charging
Date:   Tue, 10 Sep 2019 22:02:33 +0200
Message-Id: <20190910200233.3195-2-GNUtoo@cyberdimension.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910200233.3195-1-GNUtoo@cyberdimension.org>
References: <20190910200233.3195-1-GNUtoo@cyberdimension.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

This patch adds a listener for extcon cable events and enables
charging if an USB cable is connected. It recognizes SDP and DCP cable
types and treats them the same (same input current and fast charge
current). The maximum input current is set before the charger is
enabled and before the charger gets disabled, the maximum input
current is set to zero. The listener is inspired by the listener
implementation that was used for the AXP288 Charger driver.

The patch also adds support for the CURRENT_NOW property. It reads the
fast charge current that gets set before the charger is enabled or
disabled.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
GNUtoo@cyberdimension.org: small fixes
Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
---
 drivers/power/supply/Kconfig            |   2 +-
 drivers/power/supply/max77693_charger.c | 176 ++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 5d91b5160b41..5cd06b1b145e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -534,7 +534,7 @@ config CHARGER_MAX77650
 
 config CHARGER_MAX77693
 	tristate "Maxim MAX77693 battery charger driver"
-	depends on MFD_MAX77693
+	depends on MFD_MAX77693 && REGULATOR_MAX77693
 	help
 	  Say Y to enable support for the Maxim MAX77693 battery charger.
 
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index a2c5c9858639..b19490cb4a8f 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -12,8 +12,11 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/extcon.h>
+#include <linux/regulator/consumer.h>
 
 #define MAX77693_CHARGER_NAME				"max77693-charger"
+#define MAX77693_EXTCON_DEV_NAME			"max77693-muic"
 static const char *max77693_charger_model		= "MAX77693";
 static const char *max77693_charger_manufacturer	= "Maxim Integrated";
 
@@ -21,12 +24,21 @@ struct max77693_charger {
 	struct device		*dev;
 	struct max77693_dev	*max77693;
 	struct power_supply	*charger;
+	struct regulator	*regu;
 
 	u32 constant_volt;
 	u32 min_system_volt;
 	u32 thermal_regulation_temp;
 	u32 batttery_overcurrent;
 	u32 charge_input_threshold_volt;
+
+	/* SDP/DCP USB charging cable notifications */
+	struct {
+		struct extcon_dev *edev;
+		bool connected;
+		struct notifier_block nb;
+		struct work_struct work;
+	} cable;
 };
 
 static int max77693_get_charger_state(struct regmap *regmap, int *val)
@@ -197,12 +209,28 @@ static int max77693_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+int max77693_get_charge_current(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_02, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= CHG_CNFG_02_CC_MASK;
+	*val = data * 333 / 10; /* 3 steps/0.1A */
+
+	return 0;
+}
+
 static enum power_supply_property max77693_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -231,6 +259,9 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = max77693_get_online(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = max77693_get_charge_current(regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77693_charger_model;
 		break;
@@ -285,6 +316,7 @@ static ssize_t fast_charge_timer_show(struct device *dev,
 
 	data &= CHG_CNFG_01_FCHGTIME_MASK;
 	data >>= CHG_CNFG_01_FCHGTIME_SHIFT;
+
 	switch (data) {
 	case 0x1 ... 0x7:
 		/* Starting from 4 hours, step by 2 hours */
@@ -573,6 +605,102 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 			CHG_CNFG_12_VCHGINREG_MASK, data);
 }
 
+static int max77693_enable_charger(struct max77693_charger *chg, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		ret = regulator_set_current_limit(
+			chg->regu,
+			CHG_CNFG_09_CHGIN_ILIM_500_MIN,
+			CHG_CNFG_09_CHGIN_ILIM_500_MAX);
+
+		if (ret < 0)
+			return ret;
+
+		ret = regulator_enable(chg->regu);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* sets fast charge current to zero */
+		ret = regulator_set_current_limit(chg->regu,
+						  CHG_CNFG_09_CHGIN_ILIM_0_MIN,
+						  CHG_CNFG_09_CHGIN_ILIM_0_MAX);
+		if (ret < 0)
+			return ret;
+
+		ret = regulator_disable(chg->regu);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static void max77693_extcon_evt_worker(struct work_struct *work)
+{
+	struct max77693_charger *chg = container_of(work,
+						    struct max77693_charger,
+						    cable.work);
+	bool changed = false;
+	struct extcon_dev *edev = chg->cable.edev;
+	bool old_connected = chg->cable.connected;
+	bool is_charger_enabled;
+	int ret;
+
+	/* Determine cable/charger type */
+	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) ||
+	    extcon_get_state(edev, EXTCON_CHG_USB_DCP)) {
+		dev_dbg(chg->dev, "USB charger is connected");
+		chg->cable.connected = true;
+	} else {
+		if (old_connected)
+			dev_dbg(chg->dev, "USB charger disconnected");
+		chg->cable.connected = false;
+	}
+
+	/* Cable status changed */
+	if (old_connected != chg->cable.connected)
+		changed = true;
+
+	if (!changed)
+		return;
+
+	if (regulator_is_enabled(chg->regu))
+		is_charger_enabled = true;
+	else
+		is_charger_enabled = false;
+
+	if (is_charger_enabled && !chg->cable.connected) {
+		ret = max77693_enable_charger(chg, false);
+		if (ret < 0) {
+			dev_err(chg->dev,
+				"failed to disable charger (%d)", ret);
+		}
+	} else if (!is_charger_enabled && chg->cable.connected) {
+		ret = max77693_enable_charger(chg, true);
+		if (ret < 0) {
+			dev_err(chg->dev,
+				"cannot enable charger (%d)", ret);
+		}
+	}
+
+	if (changed)
+		power_supply_changed(chg->charger);
+}
+
+static int max77693_handle_cable_evt(struct notifier_block *nb,
+				unsigned long event, void *param)
+{
+	struct max77693_charger *chg = container_of(nb,
+						    struct max77693_charger,
+						    cable.nb);
+
+	schedule_work(&chg->cable.work);
+
+	return NOTIFY_OK;
+}
+
 /*
  * Sets charger registers to proper and safe default values.
  */
@@ -684,6 +812,45 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	chg->regu = devm_regulator_get(chg->dev, "CHARGER");
+	if (IS_ERR(chg->regu)) {
+		ret = PTR_ERR(chg->regu);
+		dev_err(&pdev->dev,
+			"failed to get charger regulator %d\n", ret);
+		return ret;
+	}
+
+	chg->cable.edev = extcon_get_extcon_dev(MAX77693_EXTCON_DEV_NAME);
+	if (chg->cable.edev == NULL) {
+		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
+			MAX77693_EXTCON_DEV_NAME);
+		return -EPROBE_DEFER;
+	}
+
+	/* set initial value */
+	chg->cable.connected = false;
+
+	/* Register for extcon notification */
+	INIT_WORK(&chg->cable.work, max77693_extcon_evt_worker);
+	chg->cable.nb.notifier_call = max77693_handle_cable_evt;
+	ret = extcon_register_notifier(chg->cable.edev, EXTCON_CHG_USB_SDP,
+				       &chg->cable.nb);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register extcon notifier for SDP %d\n", ret);
+		return ret;
+	}
+
+	ret = extcon_register_notifier(chg->cable.edev, EXTCON_CHG_USB_DCP,
+				       &chg->cable.nb);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register extcon notifier for DCP %d\n", ret);
+		extcon_unregister_notifier(chg->cable.edev,
+					   EXTCON_CHG_USB_SDP, &chg->cable.nb);
+		return ret;
+	}
+
 	ret = max77693_reg_init(chg);
 	if (ret)
 		return ret;
@@ -724,6 +891,10 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_SDP,
+				   &chg->cable.nb);
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_DCP,
+				   &chg->cable.nb);
 
 	return ret;
 }
@@ -736,6 +907,11 @@ static int max77693_charger_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
 
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_SDP,
+				   &chg->cable.nb);
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_DCP,
+				   &chg->cable.nb);
+
 	power_supply_unregister(chg->charger);
 
 	return 0;
-- 
2.23.0

