Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC75FD5D59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfJNIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 04:25:15 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:33389 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfJNIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:25:15 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdad77f3ab5ac14014b179c@ACLMS1.advantech.com.tw>;
 Mon, 14 Oct 2019 16:25:10 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask & tcpu_mask & temp_mode in nct7904_data struct.
Date:   Mon, 14 Oct 2019 16:24:51 +0800
Message-ID: <20191014082451.2895-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.68]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

Voltage sensors overlap with external temperature sensors. Detect
the multi-function of voltage, thermal diode, thermistor and
reserved from register VT_ADC_MD_REG to set value of vsen_mask &
tcpu_mask & temp_mode in nct7904_data struct. If the value is
reserved, needs to disable the vsen_mask & tcpu_mask.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index b26419dbe840..281c81edabc6 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -82,6 +82,10 @@
 #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
 #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
 
+#define VOLT_MONITOR_MODE	0x0
+#define THERMAL_DIODE_MODE	0x1
+#define THERMISTOR_MODE		0x3
+
 #define ENABLE_TSI	BIT(1)
 
 static const unsigned short normal_i2c[] = {
@@ -935,11 +939,16 @@ static int nct7904_probe(struct i2c_client *client,
 	for (i = 0; i < 4; i++) {
 		val = (ret >> (i * 2)) & 0x03;
 		bit = (1 << i);
-		if (val == 0) {
+		if (val == VOLT_MONITOR_MODE) {
 			data->tcpu_mask &= ~bit;
+		} else if (val == THERMAL_DIODE_MODE && i < 2) {
+			data->temp_mode |= bit;
+			data->vsen_mask &= ~(0x06 << (i * 2));
+		} else if (val == THERMISTOR_MODE) {
+			data->vsen_mask &= ~(0x02 << (i * 2));
 		} else {
-			if (val == 0x1 || val == 0x2)
-				data->temp_mode |= bit;
+			/* Reserved */
+			data->tcpu_mask &= ~bit;
 			data->vsen_mask &= ~(0x06 << (i * 2));
 		}
 	}
-- 
2.17.1

