Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EDA14737F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 23:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAWWEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 17:04:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAWWEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:04:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so29915pff.13;
        Thu, 23 Jan 2020 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UyIKQITrO0oWF7hxsRux+qHlDrSK6oW0uL/e4R7PnzI=;
        b=KlPH26XLFlBW/VUiAnxOoQ2Fn2luRmmaxSOizRqo6F4XxxoxPWkiccfQ2E7SC9GRdn
         1RKNFcQcqxhqGgTIbaPaAhmm6L0HrZSxgTAAt5GONHnXwd1N/KFPcv0xeiTHGOMveT/a
         ArXwkA44LBwFymOHaPmlB3VMVwKrH/X9jKNf8HUZzSooucilvHGqPjLlVsG+6xXJVfd9
         ic4m4eVwLW0UM3BPPJS8AP3kR1aylGgBfg1L860eWXvvUgL4hF+HhmhYSpcPruBNHw5r
         F3XdPtZ595SZDcH8FkMoCeLygg98gV3Y97OCKctdLsQBroRxZY3Cg8P3AlKDYcgnW2zL
         HrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=UyIKQITrO0oWF7hxsRux+qHlDrSK6oW0uL/e4R7PnzI=;
        b=mwGrzQ/shjk2PavBXu86Z4+u1uZvWvJuHr9WoOkUtKLP7mhf7MXiniGCiQbox239LQ
         hfwaKcypmaDTDiTgs7pUn4e9+/tGvfTny+YxnG5Ptw+IMNWnu7+Dg50807PEC2SBXzb9
         v5bQ29cPxb2h851289SOIdMk8Sc2seWmAQEcU1IOC+LMnPeaH5O9gjc/zfiZRIBD7Aot
         d0LLLeIUZK1wmUeNAC8Fb62yMiMCNjG0wSFFJR2ujAZqEmZp38xRe57x62qNUce/X+DQ
         20KPdYNCIvks3O8bsX9zV/DsYrBWYrwsXGMW7QYSZizZj81IBpFZWtw9izzbYtG/J2wy
         i/lA==
X-Gm-Message-State: APjAAAUw7NuxJQWsE2yGha+n+kSpO15aemFZvd4zbTTxXYDn+gTtPkXx
        1i6kDxf1+mJ/Pty6ugmsrF7jRnvC
X-Google-Smtp-Source: APXvYqx7ndr87YrZCsK67u+RBUy1vUiYNmdwe8nONkI3gr4qcq3gFykCDJJatFethv9dL1piRhpmtQ==
X-Received: by 2002:aa7:948c:: with SMTP id z12mr351286pfk.156.1579817072964;
        Thu, 23 Jan 2020 14:04:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm3768326pff.59.2020.01.23.14.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 14:04:31 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Michael Larabel <michael@phoronix.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3] hwmon: (k10temp) Display up to eight sets of CCD temperatures
Date:   Thu, 23 Jan 2020 14:04:22 -0800
Message-Id: <20200123220422.30334-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In HWiNFO, we see support for Tccd1, Tccd3, Tccd5, and Tccd7 temperature
sensors on Zen2 based Threadripper CPUs. Checking register maps on
Threadripper 3970X confirms SMN register addresses and values for those
sensors.

Register values observed in an idle system:

0x059950: 00000000 00000abc 00000000 00000ad8
0x059960: 00000000 00000ade 00000000 00000ae4

Under load:

0x059950: 00000000 00000c02 00000000 00000c14
0x059960: 00000000 00000c30 00000000 00000c22

More analysis shows that EPYC CPUs support up to 8 CCD temperature
sensors.

On top of that, in thm_10_0_sh_mask.h in the Linux kernel, we find
definitions for THM_DIE{1-3}_TEMP__VALID_MASK, set to 0x00000800, as well
as matching SMN addresses. This lets us conclude that bit 11 of the
respective registers is a valid bit. With this assumption, the temperature
offset is now 49 degrees C. This conveniently matches the documented
temperature offset for Tdie, again suggesting that above registers indeed
report temperatures sensor values. Assume that bit 11 is indeed a valid
bit, and add support for the additional sensors.

With this patch applied, output from 3970X (idle) looks as follows:

k10temp-pci-00c3
Adapter: PCI adapter
Tdie:         +55.9°C
Tctl:         +55.9°C
Tccd1:        +39.8°C
Tccd3:        +43.8°C
Tccd5:        +43.8°C
Tccd7:        +44.8°C

Tested-by: Michael Larabel <michael@phoronix.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Increased number of supported CCD sensors to 8.
    Dropped note that functionality on high-end CPUs is not known,
    since that is no longer correct.

v2: Added additional sensors to k10temp_info[].

 drivers/hwmon/k10temp.c | 70 ++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5e3f43594084..1634cb6394f0 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -7,7 +7,7 @@
  * Copyright (c) 2020 Guenter Roeck <linux@roeck-us.net>
  *
  * Implementation notes:
- * - CCD1 and CCD2 register address information as well as the calculation to
+ * - CCD register address information as well as the calculation to
  *   convert raw register values is from https://github.com/ocerman/zenpower.
  *   The information is not confirmed from chip datasheets, but experiments
  *   suggest that it provides reasonable temperature values.
@@ -18,11 +18,6 @@
  *   normalized to report 1A/LSB for core current and and 0.25A/LSB for SoC
  *   current. Reported values can be adjusted using the sensors configuration
  *   file.
- * - It is unknown if the mechanism to read CCD1/CCD2 temperature as well as
- *   current and voltage information works on higher-end Ryzen CPUs.
- *   Information reported by Windows tools suggests that additional sensors
- *   (both temperature and voltage/current) are supported, but their register
- *   location is currently unknown.
  */
 
 #include <linux/bitops.h>
@@ -80,8 +75,10 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 /* F17h M01h Access througn SMN */
 #define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
-#define F17H_M70H_CCD1_TEMP			0x00059954
-#define F17H_M70H_CCD2_TEMP			0x00059958
+
+#define F17H_M70H_CCD_TEMP(x)			(0x00059954 + ((x) * 4))
+#define F17H_M70H_CCD_TEMP_VALID		BIT(11)
+#define F17H_M70H_CCD_TEMP_MASK			GENMASK(10, 0)
 
 #define F17H_M01H_SVI				0x0005A000
 #define F17H_M01H_SVI_TEL_PLANE0		(F17H_M01H_SVI + 0xc)
@@ -100,8 +97,7 @@ struct k10temp_data {
 	int temp_offset;
 	u32 temp_adjust_mask;
 	bool show_tdie;
-	bool show_tccd1;
-	bool show_tccd2;
+	u32 show_tccd;
 	u32 svi_addr[2];
 	bool show_current;
 	int cfactor[2];
@@ -188,6 +184,12 @@ const char *k10temp_temp_label[] = {
 	"Tctl",
 	"Tccd1",
 	"Tccd2",
+	"Tccd3",
+	"Tccd4",
+	"Tccd5",
+	"Tccd6",
+	"Tccd7",
+	"Tccd8",
 };
 
 const char *k10temp_in_label[] = {
@@ -277,15 +279,10 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			if (*val < 0)
 				*val = 0;
 			break;
-		case 2:		/* Tccd1 */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     F17H_M70H_CCD1_TEMP, &regval);
-			*val = (regval & 0xfff) * 125 - 305000;
-			break;
-		case 3:		/* Tccd2 */
+		case 2 ... 9:		/* Tccd{1-8} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     F17H_M70H_CCD2_TEMP, &regval);
-			*val = (regval & 0xfff) * 125 - 305000;
+				     F17H_M70H_CCD_TEMP(channel - 2), &regval);
+			*val = (regval & F17H_M70H_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
 			return -EOPNOTSUPP;
@@ -343,12 +340,8 @@ static umode_t k10temp_is_visible(const void *_data,
 				if (!data->show_tdie)
 					return 0;
 				break;
-			case 2:		/* Tccd1 */
-				if (!data->show_tccd1)
-					return 0;
-				break;
-			case 3:		/* Tccd2 */
-				if (!data->show_tccd2)
+			case 2 ... 9:		/* Tccd{1-8} */
+				if (!(data->show_tccd & BIT(channel - 2)))
 					return 0;
 				break;
 			default:
@@ -382,12 +375,8 @@ static umode_t k10temp_is_visible(const void *_data,
 			case 0:		/* Tdie */
 			case 1:		/* Tctl */
 				break;
-			case 2:		/* Tccd1 */
-				if (!data->show_tccd1)
-					return 0;
-				break;
-			case 3:		/* Tccd2 */
-				if (!data->show_tccd2)
+			case 2 ... 9:		/* Tccd{1-8} */
+				if (!(data->show_tccd & BIT(channel - 2)))
 					return 0;
 				break;
 			default:
@@ -520,6 +509,12 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
@@ -595,15 +590,12 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->cfactor[1] = CFACTOR_ISOC;
 			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
 			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
-			amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				     F17H_M70H_CCD1_TEMP, &regval);
-			if (regval & 0xfff)
-				data->show_tccd1 = true;
-
-			amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				     F17H_M70H_CCD2_TEMP, &regval);
-			if (regval & 0xfff)
-				data->show_tccd2 = true;
+			for (i = 0; i < 8; i++) {
+				amd_smn_read(amd_pci_dev_to_node_id(pdev),
+					     F17H_M70H_CCD_TEMP(i), &regval);
+				if (regval & F17H_M70H_CCD_TEMP_VALID)
+					data->show_tccd |= BIT(i);
+			}
 			break;
 		}
 	} else {
-- 
2.17.1

