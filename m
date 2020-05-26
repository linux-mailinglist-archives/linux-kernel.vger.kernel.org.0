Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17673198BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 07:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCaF3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 01:29:15 -0400
Received: from [58.211.163.100] ([58.211.163.100]:62245 "EHLO
        mail.advantech.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726236AbgCaF3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:29:15 -0400
Received: from ACNMB2.ACN.ADVANTECH.CORP (unverified [172.21.128.148]) by ACN-SWEEPER01.ACN.ADVANTECH.CORP
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tde3d30b370ac1580301704@ACN-SWEEPER01.ACN.ADVANTECH.CORP>;
 Tue, 31 Mar 2020 13:29:01 +0800
Received: from ADVANTECH.CORP (172.17.10.69) by ACNMB2.ACN.ADVANTECH.CORP
 (172.21.128.148) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 13:29:00 +0800
From:   <yuechao.zhao@advantech.com.cn>
To:     <345351830@qq.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, <shengkui.leng@advantech.com.cn>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>
Subject: [v4,1/1] hwmon: (nct7904) Add watchdog function
Date:   Tue, 31 Mar 2020 05:28:50 +0000
Message-ID: <20200331052850.5419-1-yuechao.zhao@advantech.com.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.69]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 ACNMB2.ACN.ADVANTECH.CORP (172.21.128.148)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

implement watchdong functionality into the "hwmon/nct7904.c"

Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
---
v4:
- Set "wdt->timeout" to actual timeout
- Modify nct7904_wdt_get_timeleft return value
- Remove code 'i2c_set_clientdata(client, data)'

v3:
- Delete useless message(noise).
- Delete useless variable 'ret'.
- Delete 'ping_timeout'.
- Use 'wdt->timeout' as basis for setting the chip timeout
- Implement a get_timeout function
- Use devm_watchdog_register_device() instead of watchdog_register_device().
- Use watchdog_stop_on_unregister() when driver remove.
- Delete nct7904_remove() function.
- Fix typos.

v2:
- Modify dependency of NC7904 into "drivers/hwmon/Kconfig".
---
 drivers/hwmon/Kconfig   |   6 ++-
 drivers/hwmon/nct7904.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 05a3083..cd0ae82 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1340,10 +1340,12 @@ config SENSORS_NCT7802
 
 config SENSORS_NCT7904
 	tristate "Nuvoton NCT7904"
-	depends on I2C
+	depends on I2C && WATCHDOG
+	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for the Nuvoton NCT7904
-	  hardware monitoring chip, including manual fan speed control.
+	  hardware monitoring chip, including manual fan speed control
+	  and support for the integrated watchdog.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nct7904.
diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 1f5743d..571a649 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -8,6 +8,9 @@
  * Copyright (c) 2019 Advantech
  * Author: Amy.Shih <amy.shih@advantech.com.tw>
  *
+ * Copyright (c) 2020 Advantech
+ * Author: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
+ *
  * Supports the following chips:
  *
  * Chip        #vin  #fan  #pwm  #temp  #dts  chip ID
@@ -20,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/hwmon.h>
+#include <linux/watchdog.h>
 
 #define VENDOR_ID_REG		0x7A	/* Any bank */
 #define NUVOTON_ID		0x50
@@ -87,18 +91,42 @@
 #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
 #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
 
+#define WDT_LOCK_REG		0xE0	/* W/O Lock Watchdog Register */
+#define WDT_EN_REG		0xE1	/* R/O Watchdog Enable Register */
+#define WDT_STS_REG		0xE2	/* R/O Watchdog Status Register */
+#define WDT_TIMER_REG		0xE3	/* R/W Watchdog Timer Register */
+#define WDT_SOFT_EN		0x55	/* Enable soft watchdog timer */
+#define WDT_SOFT_DIS		0xAA	/* Disable soft watchdog timer */
+
 #define VOLT_MONITOR_MODE	0x0
 #define THERMAL_DIODE_MODE	0x1
 #define THERMISTOR_MODE		0x3
 
 #define ENABLE_TSI	BIT(1)
 
+#define WATCHDOG_TIMEOUT	1	/* 1 minute default timeout */
+
+/*The timeout range is 1-255 minutes*/
+#define MIN_TIMEOUT		(1 * 60)
+#define MAX_TIMEOUT		(255 * 60)
+
+static int timeout = WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
+			__MODULE_STRING(WATCHODOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
 };
 
 struct nct7904_data {
 	struct i2c_client *client;
+	struct watchdog_device wdt;
 	struct mutex bank_lock;
 	int bank_sel;
 	u32 fanin_mask;
@@ -889,6 +917,95 @@ static int nct7904_detect(struct i2c_client *client,
 	.info = nct7904_info,
 };
 
+/*
+ * Watchdog Function
+ */
+static int nct7904_wdt_start(struct watchdog_device *wdt)
+{
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+
+	/* Enable soft watchdog timer */
+	return nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_EN);
+}
+
+static int nct7904_wdt_stop(struct watchdog_device *wdt)
+{
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+
+	return nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
+}
+
+static int nct7904_wdt_set_timeout(struct watchdog_device *wdt,
+				   unsigned int timeout)
+{
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+	/*
+	 * The NCT7904 is very special in watchdog function.
+	 * Its minimum unit is minutes. And wdt->timeout needs
+	 * to match the actual timeout selected. So, this needs
+	 * to be: wdt->timeout = timeout / 60 * 60.
+	 * For example, if the user configures a timeout of
+	 * 119 seconds, the actual timeout will be 60 seconds.
+	 * So, wdt->timeout must then be set to 60 seconds.
+	 */
+	wdt->timeout = timeout / 60 * 60;
+
+	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG,
+				 wdt->timeout / 60);
+}
+
+static int nct7904_wdt_ping(struct watchdog_device *wdt)
+{
+	/*
+	 * Note:
+	 * NCT7904 does not support refreshing WDT_TIMER_REG register when
+	 * the watchdog is active. Please disable watchdog before feeding
+	 * the watchdog and enable it again.
+	 */
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+	int ret;
+
+	/* Disable soft watchdog timer */
+	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
+	if (ret < 0)
+		return ret;
+
+	/* feed watchdog */
+	ret = nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, wdt->timeout / 60);
+	if (ret < 0)
+		return ret;
+
+	/* Enable soft watchdog timer */
+	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, WDT_SOFT_EN);
+}
+
+static unsigned int nct7904_wdt_get_timeleft(struct watchdog_device *wdt)
+{
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+	int ret;
+
+	ret = nct7904_read_reg(data, BANK_0, WDT_TIMER_REG);
+	if (ret < 0)
+		return 0;
+
+	return ret * 60;
+}
+
+static const struct watchdog_info nct7904_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+				WDIOF_MAGICCLOSE,
+	.identity	= "nct7904 watchdog",
+};
+
+static const struct watchdog_ops nct7904_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= nct7904_wdt_start,
+	.stop		= nct7904_wdt_stop,
+	.ping		= nct7904_wdt_ping,
+	.set_timeout	= nct7904_wdt_set_timeout,
+	.get_timeleft	= nct7904_wdt_get_timeleft,
+};
+
 static int nct7904_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1012,7 +1129,26 @@ static int nct7904_probe(struct i2c_client *client,
 	hwmon_dev =
 		devm_hwmon_device_register_with_info(dev, client->name, data,
 						     &nct7904_chip_info, NULL);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	ret = PTR_ERR_OR_ZERO(hwmon_dev);
+	if (ret)
+		return ret;
+
+	/* Watchdog initialization */
+	data->wdt.ops = &nct7904_wdt_ops;
+	data->wdt.info = &nct7904_wdt_info;
+
+	data->wdt.timeout = timeout * 60; /* in seconds */
+	data->wdt.min_timeout = MIN_TIMEOUT;
+	data->wdt.max_timeout = MAX_TIMEOUT;
+	data->wdt.parent = &client->dev;
+
+	watchdog_init_timeout(&data->wdt, timeout * 60, &client->dev);
+	watchdog_set_nowayout(&data->wdt, nowayout);
+	watchdog_set_drvdata(&data->wdt, data);
+
+	watchdog_stop_on_unregister(&data->wdt);
+
+	return devm_watchdog_register_device(dev, &data->wdt);
 }
 
 static const struct i2c_device_id nct7904_id[] = {
-- 
1.8.3.1

