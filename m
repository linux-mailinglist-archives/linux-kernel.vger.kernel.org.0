Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F0947BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFQIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 04:09:14 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:52260 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:09:14 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td8729bcfeeac14014b1070@ACLMS1.advantech.com.tw>;
 Mon, 17 Jun 2019 16:09:09 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 1/9] hwmon: (nct7904) Add error handling in probe function.
Date:   Mon, 17 Jun 2019 08:08:50 +0000
Message-ID: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
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

When register read and write operations return errors, needs to add
error handling.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Check for errors on register read and write operations.

 drivers/hwmon/nct7904.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 5708171197e7..401ed4a4a576 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -506,6 +506,8 @@ static int nct7904_probe(struct i2c_client *client,
 
 	/* CPU_TEMP attributes */
 	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
+	if (ret < 0)
+		return ret;
 
 	if ((ret & 0x6) == 0x6)
 		data->tcpu_mask |= 1; /* TR1 */
@@ -518,11 +520,15 @@ static int nct7904_probe(struct i2c_client *client,
 
 	/* LTD */
 	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
+	if (ret < 0)
+		return ret;
 	if ((ret & 0x02) == 0x02)
 		data->tcpu_mask |= 0x10;
 
 	/* Multi-Function detecting for Volt and TR/TD */
 	ret = nct7904_read_reg(data, BANK_0, VT_ADC_MD_REG);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < 4; i++) {
 		val = (ret & (0x03 << i)) >> (i * 2);
@@ -533,22 +539,29 @@ static int nct7904_probe(struct i2c_client *client,
 
 	/* PECI */
 	ret = nct7904_read_reg(data, BANK_2, PFE_REG);
+	if (ret < 0)
+		return ret;
 	if (ret & 0x80) {
 		data->enable_dts = 1; //Enable DTS & PECI
 	} else {
 		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
+		if (ret < 0)
+			return ret;
 		if (ret & 0x80)
 			data->enable_dts = 0x3; //Enable DTS & TSI
 	}
 
 	/* Check DTS enable status */
 	if (data->enable_dts) {
-		data->has_dts =
-			nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
+		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG);
+		if (ret < 0)
+			return ret;
+		data->has_dts = ret & 0xF;
 		if (data->enable_dts & 0x2) {
-			data->has_dts |=
-			(nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG) & 0xF)
-								<< 4;
+			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
+			if (ret < 0)
+				return ret;
+			data->has_dts |= (ret & 0xF) << 4;
 		}
 	}
 
-- 
2.17.1

