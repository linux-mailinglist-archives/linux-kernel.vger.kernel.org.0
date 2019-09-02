Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984B5A5399
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfIBKGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 06:06:21 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:19842 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbfIBKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:06:20 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td9ff90b8f0ac14014b177c@ACLMS1.advantech.com.tw>;
 Mon, 2 Sep 2019 18:06:17 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, <jia.sui@advantech.com.cn>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v6,1/1] hwmon: (nct7904) Fix incorrect temperature limitation register setting of LTD.
Date:   Mon, 18 Jun 2085 15:57:19 +0000
Message-ID: <20850618155720.24857-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.63]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

According to kernel hwmon sysfs-interface documentation, temperature
critical max value, typically greater than corresponding temp_max values.
Thus, reads the LTD_HV_HL (LTD HIGH VALUE HIGH LIMITATION) and LTD_LV_HL
(LTD LOW VALUE HIGH LIMITATION) for case hwmon_temp_crit and
hwmon_temp_crit_hyst. Reads the LTD_HV_LL (HIGH VALUE LOW LIMITATION)
and LTD_LV_LL (LOW VALUE LOW LIMITATION) for case hwmon_temp_max
and hwmon_temp_max_hyst.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---

Changes in v6:
- Fix incorrect temperature limitation register setting of LTD.
Changes in v5:
- Squashed subsequent fixes of three patches into one patch.
Changes in v4:
- Fix the incorrect return value of case hwmon_fan_min in function "nct7904_write_fan".
- Fix the confused calculation of case hwmon_fan_min in function
Changes in v3:
- Squashed subsequent fixes of patches into one patch.

-- Fix bad fallthrough in various switch statements.
-- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
-- Fix incorrect register setting of voltage.
-- Fix incorrect register bit mapping of temperature alarm.
-- Fix wrong return code 0x1fff in function nct7904_write_fan.
-- Delete wrong comment in function nct7904_write_in.
-- Fix wrong attribute names for temperature.
-- Fix wrong registers setting for temperature.

Changes in v2:
- Fix bad fallthrough in various switch statements.
- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
---
 drivers/hwmon/nct7904.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 76372f20d71a..ce688ab4fce2 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -398,22 +398,22 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 		}
 		return 0;
 	case hwmon_temp_max:
-		reg1 = LTD_HV_HL_REG;
+		reg1 = LTD_HV_LL_REG;
 		reg2 = TEMP_CH1_W_REG;
 		reg3 = DTS_T_CPU1_W_REG;
 		break;
 	case hwmon_temp_max_hyst:
-		reg1 = LTD_LV_HL_REG;
+		reg1 = LTD_LV_LL_REG;
 		reg2 = TEMP_CH1_WH_REG;
 		reg3 = DTS_T_CPU1_WH_REG;
 		break;
 	case hwmon_temp_crit:
-		reg1 = LTD_HV_LL_REG;
+		reg1 = LTD_HV_HL_REG;
 		reg2 = TEMP_CH1_C_REG;
 		reg3 = DTS_T_CPU1_C_REG;
 		break;
 	case hwmon_temp_crit_hyst:
-		reg1 = LTD_LV_LL_REG;
+		reg1 = LTD_LV_HL_REG;
 		reg2 = TEMP_CH1_CH_REG;
 		reg3 = DTS_T_CPU1_CH_REG;
 		break;
@@ -507,22 +507,22 @@ static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_temp_max:
-		reg1 = LTD_HV_HL_REG;
+		reg1 = LTD_HV_LL_REG;
 		reg2 = TEMP_CH1_W_REG;
 		reg3 = DTS_T_CPU1_W_REG;
 		break;
 	case hwmon_temp_max_hyst:
-		reg1 = LTD_LV_HL_REG;
+		reg1 = LTD_LV_LL_REG;
 		reg2 = TEMP_CH1_WH_REG;
 		reg3 = DTS_T_CPU1_WH_REG;
 		break;
 	case hwmon_temp_crit:
-		reg1 = LTD_HV_LL_REG;
+		reg1 = LTD_HV_HL_REG;
 		reg2 = TEMP_CH1_C_REG;
 		reg3 = DTS_T_CPU1_C_REG;
 		break;
 	case hwmon_temp_crit_hyst:
-		reg1 = LTD_LV_LL_REG;
+		reg1 = LTD_LV_HL_REG;
 		reg2 = TEMP_CH1_CH_REG;
 		reg3 = DTS_T_CPU1_CH_REG;
 		break;
-- 
2.17.1

