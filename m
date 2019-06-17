Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AA47C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfFQIWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 04:22:20 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:40383 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:22:18 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td872a74337ac1401c810b8@ACLMS3.advantech.com.tw>;
 Mon, 17 Jun 2019 16:21:40 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 8/9] hwmon: (nct7904) Fix wrong attribute names for temperature.
Date:   Mon, 17 Jun 2019 08:20:38 +0000
Message-ID: <f499d63b7a62447fedf466399f1f924eea6f016a.1560756733.git.amy.shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
References: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.58]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

Emergency attributes without crit attributes are not acceptable.
In datasheet there are registers labeled "critical", and there is
no mention of "emergency". Thus, set the attribute names from
"temp[1-*]_emergency" and "temp[1-*]_emergency_hyst" to
"temp[1-*]_crit" and "temp[1-*]_crit_hyst".

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Fix wrong attribute names for temperature.

 drivers/hwmon/nct7904.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index c74f919c0181..fc145c73a4e7 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -407,12 +407,12 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 		reg2 = TEMP_CH1_CH_REG;
 		reg3 = DTS_T_CPU1_CH_REG;
 		break;
-	case hwmon_temp_emergency:
+	case hwmon_temp_crit:
 		reg1 = LTD_HV_LL_REG;
 		reg2 = TEMP_CH1_W_REG;
 		reg3 = DTS_T_CPU1_W_REG;
 		break;
-	case hwmon_temp_emergency_hyst:
+	case hwmon_temp_crit_hyst:
 		reg1 = LTD_LV_LL_REG;
 		reg2 = TEMP_CH1_WH_REG;
 		reg3 = DTS_T_CPU1_WH_REG;
@@ -454,8 +454,8 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
 		break;
 	case hwmon_temp_max:
 	case hwmon_temp_max_hyst:
-	case hwmon_temp_emergency:
-	case hwmon_temp_emergency_hyst:
+	case hwmon_temp_crit:
+	case hwmon_temp_crit_hyst:
 		if (channel < 5) {
 			if (data->tcpu_mask & BIT(channel))
 				return 0644;
@@ -516,12 +516,12 @@ static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
 		reg2 = TEMP_CH1_CH_REG;
 		reg3 = DTS_T_CPU1_CH_REG;
 		break;
-	case hwmon_temp_emergency:
+	case hwmon_temp_crit:
 		reg1 = LTD_HV_LL_REG;
 		reg2 = TEMP_CH1_W_REG;
 		reg3 = DTS_T_CPU1_W_REG;
 		break;
-	case hwmon_temp_emergency_hyst:
+	case hwmon_temp_crit_hyst:
 		reg1 = LTD_LV_LL_REG;
 		reg2 = TEMP_CH1_WH_REG;
 		reg3 = DTS_T_CPU1_WH_REG;
@@ -799,32 +799,32 @@ static const struct hwmon_channel_info *nct7904_info[] = {
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
-			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
-			   HWMON_T_EMERGENCY_HYST),
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST),
 	NULL
 };
 
-- 
2.17.1

