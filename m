Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB05F36F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFFJAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:00:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49384 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbfFFJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:00:14 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x568wuNJ029675;
        Thu, 6 Jun 2019 04:00:06 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sunsre8k8-1;
        Thu, 06 Jun 2019 04:00:06 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail2.cirrus.com (Postfix) with ESMTP id 0E334605DBF0;
        Thu,  6 Jun 2019 04:00:06 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 6 Jun
 2019 10:00:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 6 Jun 2019 10:00:05 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 146232A1;
        Thu,  6 Jun 2019 10:00:05 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/4] mfd: madera: Remove some unused registers and fix some defaults
Date:   Thu, 6 Jun 2019 10:00:02 +0100
Message-ID: <20190606090004.12748-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606090004.12748-1-ckeepax@opensource.cirrus.com>
References: <20190606090004.12748-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=966 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v1 of the series.

Thanks,
Charles

 drivers/mfd/cs47l35-tables.c |  54 +------------------
 drivers/mfd/cs47l85-tables.c | 122 ++-----------------------------------------
 drivers/mfd/cs47l90-tables.c |  76 ---------------------------
 3 files changed, 6 insertions(+), 246 deletions(-)

diff --git a/drivers/mfd/cs47l35-tables.c b/drivers/mfd/cs47l35-tables.c
index 338b825127f13..fe838cbc2a7ee 100644
--- a/drivers/mfd/cs47l35-tables.c
+++ b/drivers/mfd/cs47l35-tables.c
@@ -109,9 +109,8 @@ static const struct reg_default cs47l35_reg_default[] = {
 	{ 0x00000174, 0x007d }, /* R372 (0x174) - FLL1 Control 4 */
 	{ 0x00000175, 0x0000 }, /* R373 (0x175) - FLL1 Control 5 */
 	{ 0x00000176, 0x0000 }, /* R374 (0x176) - FLL1 Control 6 */
-	{ 0x00000177, 0x0281 }, /* R375 (0x177) - FLL1 Loop Filter Test 1 */
 	{ 0x00000179, 0x0000 }, /* R377 (0x179) - FLL1 Control 7 */
-	{ 0x0000017a, 0x0b06 }, /* R378 (0x17a) - FLL1 EFS2 */
+	{ 0x0000017a, 0x2906 }, /* R378 (0x17a) - FLL1 EFS2 */
 	{ 0x0000017f, 0x0000 }, /* R383 (0x17f) - FLL1 Synchroniser 1 */
 	{ 0x00000180, 0x0000 }, /* R384 (0x180) - FLL1 Synchroniser 2 */
 	{ 0x00000181, 0x0000 }, /* R385 (0x181) - FLL1 Synchroniser 3 */
@@ -174,9 +173,6 @@ static const struct reg_default cs47l35_reg_default[] = {
 	{ 0x00000434, 0x0000 }, /* R1076 (0x434) - Output Path Config 5R */
 	{ 0x00000435, 0x0180 }, /* R1077 (0x435) - DAC Digital Volume 5R */
 	{ 0x00000437, 0x0200 }, /* R1079 (0x437) - Noise Gate Select 5R */
-	{ 0x00000440, 0x0003 }, /* R1088 (0x440) - DRE Enable */
-	{ 0x00000448, 0x0a83 }, /* R1096 (0x448) - eDRE Enable */
-	{ 0x0000044a, 0x0000 }, /* R1098 (0x44a) - eDRE Manual */
 	{ 0x00000450, 0x0000 }, /* R1104 (0x450) - DAC AEC Control 1 */
 	{ 0x00000451, 0x0000 }, /* R1105 (0x451) - DAC AEC Control 2 */
 	{ 0x00000458, 0x0000 }, /* R1112 (0x458) - Noise Gate Control */
@@ -720,28 +716,6 @@ static const struct reg_default cs47l35_reg_default[] = {
 	{ 0x00000ef3, 0x0000 }, /* R3827 (0xef3) - ISRC 2 CTRL 1 */
 	{ 0x00000ef4, 0x0001 }, /* R3828 (0xef4) - ISRC 2 CTRL 2 */
 	{ 0x00000ef5, 0x0000 }, /* R3829 (0xef5) - ISRC 2 CTRL 3 */
-	{ 0x00001300, 0x0000 }, /* R4864 (0x1300) - DAC Comp 1 */
-	{ 0x00001302, 0x0000 }, /* R4866 (0x1302) - DAC Comp 2 */
-	{ 0x00001380, 0x0000 }, /* R4992 (0x1380) - FRF Coefficient 1L 1 */
-	{ 0x00001381, 0x0000 }, /* R4993 (0x1381) - FRF Coefficient 1L 2 */
-	{ 0x00001382, 0x0000 }, /* R4994 (0x1382) - FRF Coefficient 1L 3 */
-	{ 0x00001383, 0x0000 }, /* R4995 (0x1383) - FRF Coefficient 1L 4 */
-	{ 0x00001390, 0x0000 }, /* R5008 (0x1390) - FRF Coefficient 1R 1 */
-	{ 0x00001391, 0x0000 }, /* R5009 (0x1391) - FRF Coefficient 1R 2 */
-	{ 0x00001392, 0x0000 }, /* R5010 (0x1392) - FRF Coefficient 1R 3 */
-	{ 0x00001393, 0x0000 }, /* R5011 (0x1393) - FRF Coefficient 1R 4 */
-	{ 0x000013a0, 0x0000 }, /* R5024 (0x13a0) - FRF Coefficient 4L 1 */
-	{ 0x000013a1, 0x0000 }, /* R5025 (0x13a1) - FRF Coefficient 4L 2 */
-	{ 0x000013a2, 0x0000 }, /* R5026 (0x13a2) - FRF Coefficient 4L 3 */
-	{ 0x000013a3, 0x0000 }, /* R5027 (0x13a3) - FRF Coefficient 4L 4 */
-	{ 0x000013b0, 0x0000 }, /* R5040 (0x13b0) - FRF Coefficient 5L 1 */
-	{ 0x000013b1, 0x0000 }, /* R5041 (0x13b1) - FRF Coefficient 5L 2 */
-	{ 0x000013b2, 0x0000 }, /* R5042 (0x13b2) - FRF Coefficient 5L 3 */
-	{ 0x000013b3, 0x0000 }, /* R5043 (0x13b3) - FRF Coefficient 5L 4 */
-	{ 0x000013c0, 0x0000 }, /* R5040 (0x13c0) - FRF Coefficient 5R 1 */
-	{ 0x000013c1, 0x0000 }, /* R5041 (0x13c1) - FRF Coefficient 5R 2 */
-	{ 0x000013c2, 0x0000 }, /* R5042 (0x13c2) - FRF Coefficient 5R 3 */
-	{ 0x000013c3, 0x0000 }, /* R5043 (0x13c3) - FRF Coefficient 5R 4 */
 	{ 0x00001700, 0x2001 }, /* R5888 (0x1700) - GPIO1 Control 1 */
 	{ 0x00001701, 0xf000 }, /* R5889 (0x1701) - GPIO1 Control 2 */
 	{ 0x00001702, 0x2001 }, /* R5890 (0x1702) - GPIO2 Control 1 */
@@ -892,7 +866,6 @@ static bool cs47l35_16bit_readable_register(struct device *dev,
 	case MADERA_FLL1_CONTROL_6:
 	case MADERA_FLL1_CONTROL_7:
 	case MADERA_FLL1_EFS_2:
-	case MADERA_FLL1_LOOP_FILTER_TEST_1:
 	case CS47L35_FLL1_SYNCHRONISER_1:
 	case CS47L35_FLL1_SYNCHRONISER_2:
 	case CS47L35_FLL1_SYNCHRONISER_3:
@@ -967,9 +940,6 @@ static bool cs47l35_16bit_readable_register(struct device *dev,
 	case MADERA_OUTPUT_PATH_CONFIG_5R:
 	case MADERA_DAC_DIGITAL_VOLUME_5R:
 	case MADERA_NOISE_GATE_SELECT_5R:
-	case MADERA_DRE_ENABLE:
-	case MADERA_EDRE_ENABLE:
-	case MADERA_EDRE_MANUAL:
 	case MADERA_DAC_AEC_CONTROL_1:
 	case MADERA_DAC_AEC_CONTROL_2:
 	case MADERA_NOISE_GATE_CONTROL:
@@ -1439,28 +1409,6 @@ static bool cs47l35_16bit_readable_register(struct device *dev,
 	case MADERA_ISRC_2_CTRL_1:
 	case MADERA_ISRC_2_CTRL_2:
 	case MADERA_ISRC_2_CTRL_3:
-	case MADERA_DAC_COMP_1:
-	case MADERA_DAC_COMP_2:
-	case MADERA_FRF_COEFFICIENT_1L_1:
-	case MADERA_FRF_COEFFICIENT_1L_2:
-	case MADERA_FRF_COEFFICIENT_1L_3:
-	case MADERA_FRF_COEFFICIENT_1L_4:
-	case MADERA_FRF_COEFFICIENT_1R_1:
-	case MADERA_FRF_COEFFICIENT_1R_2:
-	case MADERA_FRF_COEFFICIENT_1R_3:
-	case MADERA_FRF_COEFFICIENT_1R_4:
-	case CS47L35_FRF_COEFFICIENT_4L_1:
-	case CS47L35_FRF_COEFFICIENT_4L_2:
-	case CS47L35_FRF_COEFFICIENT_4L_3:
-	case CS47L35_FRF_COEFFICIENT_4L_4:
-	case CS47L35_FRF_COEFFICIENT_5L_1:
-	case CS47L35_FRF_COEFFICIENT_5L_2:
-	case CS47L35_FRF_COEFFICIENT_5L_3:
-	case CS47L35_FRF_COEFFICIENT_5L_4:
-	case CS47L35_FRF_COEFFICIENT_5R_1:
-	case CS47L35_FRF_COEFFICIENT_5R_2:
-	case CS47L35_FRF_COEFFICIENT_5R_3:
-	case CS47L35_FRF_COEFFICIENT_5R_4:
 	case MADERA_GPIO1_CTRL_1 ... MADERA_GPIO16_CTRL_2:
 	case MADERA_IRQ1_STATUS_1 ... MADERA_IRQ1_STATUS_33:
 	case MADERA_IRQ1_MASK_1 ... MADERA_IRQ1_MASK_33:
diff --git a/drivers/mfd/cs47l85-tables.c b/drivers/mfd/cs47l85-tables.c
index 43803145d8e53..d0198b5e86bac 100644
--- a/drivers/mfd/cs47l85-tables.c
+++ b/drivers/mfd/cs47l85-tables.c
@@ -402,7 +402,6 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x00000174, 0x007d }, /* R372 (0x174) - FLL1 Control 4 */
 	{ 0x00000175, 0x0000 }, /* R373 (0x175) - FLL1 Control 5 */
 	{ 0x00000176, 0x0000 }, /* R374 (0x176) - FLL1 Control 6 */
-	{ 0x00000177, 0x0281 }, /* R375 (0x177) - FLL1 Loop Filter Test 1 */
 	{ 0x00000179, 0x0000 }, /* R377 (0x179) - FLL1 Control 7 */
 	{ 0x00000181, 0x0000 }, /* R385 (0x181) - FLL1 Synchroniser 1 */
 	{ 0x00000182, 0x0000 }, /* R386 (0x182) - FLL1 Synchroniser 2 */
@@ -419,7 +418,6 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x00000194, 0x007d }, /* R404 (0x194) - FLL2 Control 4 */
 	{ 0x00000195, 0x0000 }, /* R405 (0x195) - FLL2 Control 5 */
 	{ 0x00000196, 0x0000 }, /* R406 (0x196) - FLL2 Control 6 */
-	{ 0x00000197, 0x0281 }, /* R407 (0x197) - FLL2 Loop Filter Test 1 */
 	{ 0x00000199, 0x0000 }, /* R409 (0x199) - FLL2 Control 7 */
 	{ 0x000001a1, 0x0000 }, /* R417 (0x1a1) - FLL2 Synchroniser 1 */
 	{ 0x000001a2, 0x0000 }, /* R418 (0x1a2) - FLL2 Synchroniser 2 */
@@ -436,7 +434,6 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x000001b4, 0x007d }, /* R436 (0x1b4) - FLL3 Control 4 */
 	{ 0x000001b5, 0x0000 }, /* R437 (0x1b5) - FLL3 Control 5 */
 	{ 0x000001b6, 0x0000 }, /* R438 (0x1b6) - FLL3 Control 6 */
-	{ 0x000001b7, 0x0281 }, /* R439 (0x1b7) - FLL3 Loop Filter Test 1 */
 	{ 0x000001b9, 0x0000 }, /* R441 (0x1b9) - FLL3 Control 7 */
 	{ 0x000001c1, 0x0000 }, /* R449 (0x1c1) - FLL3 Synchroniser 1 */
 	{ 0x000001c2, 0x0000 }, /* R450 (0x1c2) - FLL3 Synchroniser 2 */
@@ -546,9 +543,6 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x0000043c, 0x0000 }, /* R1084 (0x43c) - Output Path Config 6R */
 	{ 0x0000043d, 0x0180 }, /* R1085 (0x43d) - DAC Digital Volume 6R */
 	{ 0x0000043f, 0x0800 }, /* R1087 (0x43f) - Noise Gate Select 6R */
-	{ 0x00000440, 0x003f }, /* R1088 (0x440) - DRE Enable */
-	{ 0x00000448, 0x003f }, /* R1096 (0x448) - EDRE Enable */
-	{ 0x0000044a, 0x0000 }, /* R1098 (0x44a) - EDRE Manual */
 	{ 0x00000450, 0x0000 }, /* R1104 (0x450) - DAC AEC Control 1 */
 	{ 0x00000451, 0x0000 }, /* R1105 (0x451) - DAC AEC Control 2 */
 	{ 0x00000458, 0x0000 }, /* R1112 (0x458) - Noise Gate Control */
@@ -556,7 +550,7 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x00000491, 0x0000 }, /* R1169 (0x491) - PDM SPK1 CTRL 2 */
 	{ 0x00000492, 0x0069 }, /* R1170 (0x492) - PDM SPK2 CTRL 1 */
 	{ 0x00000493, 0x0000 }, /* R1171 (0x493) - PDM SPK2 CTRL 2 */
-	{ 0x000004a0, 0x3210 }, /* R1184 (0x4a0) - HP1 Short Circuit Ctrl */
+	{ 0x000004a0, 0x3280 }, /* R1184 (0x4a0) - HP1 Short Circuit Ctrl */
 	{ 0x000004a1, 0x3200 }, /* R1185 (0x4a1) - HP2 Short Circuit Ctrl */
 	{ 0x000004a2, 0x3200 }, /* R1186 (0x4a2) - HP3 Short Circuit Ctrl */
 	{ 0x000004a8, 0x7020 }, /* R1192 (0x4a8) - HP Test Ctrl 5 */
@@ -1365,11 +1359,11 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x00000e82, 0x0018 }, /* R3714 (0xe82) - DRC1 ctrl3 */
 	{ 0x00000e83, 0x0000 }, /* R3715 (0xe83) - DRC1 ctrl4 */
 	{ 0x00000e84, 0x0000 }, /* R3716 (0xe84) - DRC1 ctrl5 */
-	{ 0x00000e88, 0x0933 }, /* R3720 (0xe88) - DRC2 ctrl1 */
-	{ 0x00000e89, 0x0018 }, /* R3721 (0xe89) - DRC2 ctrl2 */
-	{ 0x00000e8a, 0x0000 }, /* R3722 (0xe8a) - DRC2 ctrl3 */
+	{ 0x00000e88, 0x0018 }, /* R3720 (0xe88) - DRC2 ctrl1 */
+	{ 0x00000e89, 0x0933 }, /* R3721 (0xe89) - DRC2 ctrl2 */
+	{ 0x00000e8a, 0x0018 }, /* R3722 (0xe8a) - DRC2 ctrl3 */
 	{ 0x00000e8b, 0x0000 }, /* R3723 (0xe8b) - DRC2 ctrl4 */
-	{ 0x00000e8c, 0x0040 }, /* R3724 (0xe8c) - DRC2 ctrl5 */
+	{ 0x00000e8c, 0x0000 }, /* R3724 (0xe8c) - DRC2 ctrl5 */
 	{ 0x00000ec0, 0x0000 }, /* R3776 (0xec0) - HPLPF1_1 */
 	{ 0x00000ec1, 0x0000 }, /* R3777 (0xec1) - HPLPF1_2 */
 	{ 0x00000ec4, 0x0000 }, /* R3780 (0xec4) - HPLPF2_1 */
@@ -1577,56 +1571,6 @@ static const struct reg_default cs47l85_reg_default[] = {
 	{ 0x00000fc3, 0x0000 }, /* R4035 (0xfc3) - ANC Coefficient */
 	{ 0x00000fc4, 0x0000 }, /* R4036 (0xfc4) - ANC Coefficient */
 	{ 0x00000fc5, 0x0000 }, /* R4037 (0xfc5) - ANC Coefficient */
-	{ 0x00001300, 0x0000 }, /* R4864 (0x1300) - DAC Comp 1 */
-	{ 0x00001302, 0x0000 }, /* R4866 (0x1302) - DAC Comp 2 */
-	{ 0x00001380, 0x0000 }, /* R4992 (0x1380) - FRF Coefficient 1L 1 */
-	{ 0x00001381, 0x0000 }, /* R4993 (0x1381) - FRF Coefficient 1L 2 */
-	{ 0x00001382, 0x0000 }, /* R4994 (0x1382) - FRF Coefficient 1L 3 */
-	{ 0x00001383, 0x0000 }, /* R4995 (0x1383) - FRF Coefficient 1L 4 */
-	{ 0x00001390, 0x0000 }, /* R5008 (0x1390) - FRF Coefficient 1R 1 */
-	{ 0x00001391, 0x0000 }, /* R5009 (0x1391) - FRF Coefficient 1R 2 */
-	{ 0x00001392, 0x0000 }, /* R5010 (0x1392) - FRF Coefficient 1R 3 */
-	{ 0x00001393, 0x0000 }, /* R5011 (0x1393) - FRF Coefficient 1R 4 */
-	{ 0x000013a0, 0x0000 }, /* R5024 (0x13a0) - FRF Coefficient 2L 1 */
-	{ 0x000013a1, 0x0000 }, /* R5025 (0x13a1) - FRF Coefficient 2L 2 */
-	{ 0x000013a2, 0x0000 }, /* R5026 (0x13a2) - FRF Coefficient 2L 3 */
-	{ 0x000013a3, 0x0000 }, /* R5027 (0x13a3) - FRF Coefficient 2L 4 */
-	{ 0x000013b0, 0x0000 }, /* R5040 (0x13b0) - FRF Coefficient 2R 1 */
-	{ 0x000013b1, 0x0000 }, /* R5041 (0x13b1) - FRF Coefficient 2R 2 */
-	{ 0x000013b2, 0x0000 }, /* R5042 (0x13b2) - FRF Coefficient 2R 3 */
-	{ 0x000013b3, 0x0000 }, /* R5043 (0x13b3) - FRF Coefficient 2R 4 */
-	{ 0x000013c0, 0x0000 }, /* R5040 (0x13c0) - FRF Coefficient 3L 1 */
-	{ 0x000013c1, 0x0000 }, /* R5041 (0x13c1) - FRF Coefficient 3L 2 */
-	{ 0x000013c2, 0x0000 }, /* R5042 (0x13c2) - FRF Coefficient 3L 3 */
-	{ 0x000013c3, 0x0000 }, /* R5043 (0x13c3) - FRF Coefficient 3L 4 */
-	{ 0x000013d0, 0x0000 }, /* R5072 (0x13d0) - FRF Coefficient 3R 1 */
-	{ 0x000013d1, 0x0000 }, /* R5073 (0x13d1) - FRF Coefficient 3R 2 */
-	{ 0x000013d2, 0x0000 }, /* R5074 (0x13d2) - FRF Coefficient 3R 3 */
-	{ 0x000013d3, 0x0000 }, /* R5075 (0x13d3) - FRF Coefficient 3R 4 */
-	{ 0x000013e0, 0x0000 }, /* R5088 (0x13e0) - FRF Coefficient 4L 1 */
-	{ 0x000013e1, 0x0000 }, /* R5089 (0x13e1) - FRF Coefficient 4L 2 */
-	{ 0x000013e2, 0x0000 }, /* R5090 (0x13e2) - FRF Coefficient 4L 3 */
-	{ 0x000013e3, 0x0000 }, /* R5091 (0x13e3) - FRF Coefficient 4L 4 */
-	{ 0x000013f0, 0x0000 }, /* R5104 (0x13f0) - FRF Coefficient 4R 1 */
-	{ 0x000013f1, 0x0000 }, /* R5105 (0x13f1) - FRF Coefficient 4R 2 */
-	{ 0x000013f2, 0x0000 }, /* R5106 (0x13f2) - FRF Coefficient 4R 3 */
-	{ 0x000013f3, 0x0000 }, /* R5107 (0x13f3) - FRF Coefficient 4R 4 */
-	{ 0x00001400, 0x0000 }, /* R5120 (0x1400) - FRF Coefficient 5L 1 */
-	{ 0x00001401, 0x0000 }, /* R5121 (0x1401) - FRF Coefficient 5L 2 */
-	{ 0x00001402, 0x0000 }, /* R5122 (0x1402) - FRF Coefficient 5L 3 */
-	{ 0x00001403, 0x0000 }, /* R5123 (0x1403) - FRF Coefficient 5L 4 */
-	{ 0x00001410, 0x0000 }, /* R5136 (0x1410) - FRF Coefficient 5R 1 */
-	{ 0x00001411, 0x0000 }, /* R5137 (0x1411) - FRF Coefficient 5R 2 */
-	{ 0x00001412, 0x0000 }, /* R5138 (0x1412) - FRF Coefficient 5R 3 */
-	{ 0x00001413, 0x0000 }, /* R5139 (0x1413) - FRF Coefficient 5R 4 */
-	{ 0x00001420, 0x0000 }, /* R5152 (0x1420) - FRF Coefficient 6L 1 */
-	{ 0x00001421, 0x0000 }, /* R5153 (0x1421) - FRF Coefficient 6L 2 */
-	{ 0x00001422, 0x0000 }, /* R5154 (0x1422) - FRF Coefficient 6L 3 */
-	{ 0x00001423, 0x0000 }, /* R5155 (0x1423) - FRF Coefficient 6L 4 */
-	{ 0x00001430, 0x0000 }, /* R5168 (0x1430) - FRF Coefficient 6R 1 */
-	{ 0x00001431, 0x0000 }, /* R5169 (0x1431) - FRF Coefficient 6R 2 */
-	{ 0x00001432, 0x0000 }, /* R5170 (0x1432) - FRF Coefficient 6R 3 */
-	{ 0x00001433, 0x0000 }, /* R5171 (0x1433) - FRF Coefficient 6R 4 */
 	{ 0x00001700, 0x2001 }, /* R5888 (0x1700) - GPIO1 Control 1 */
 	{ 0x00001701, 0xe000 }, /* R5889 (0x1701) - GPIO1 Control 2 */
 	{ 0x00001702, 0x2001 }, /* R5890 (0x1702) - GPIO2 Control 1 */
@@ -1845,7 +1789,6 @@ static bool cs47l85_16bit_readable_register(struct device *dev,
 	case MADERA_FLL1_CONTROL_5:
 	case MADERA_FLL1_CONTROL_6:
 	case MADERA_FLL1_CONTROL_7:
-	case MADERA_FLL1_LOOP_FILTER_TEST_1:
 	case MADERA_FLL1_SYNCHRONISER_1:
 	case MADERA_FLL1_SYNCHRONISER_2:
 	case MADERA_FLL1_SYNCHRONISER_3:
@@ -1862,7 +1805,6 @@ static bool cs47l85_16bit_readable_register(struct device *dev,
 	case MADERA_FLL2_CONTROL_5:
 	case MADERA_FLL2_CONTROL_6:
 	case MADERA_FLL2_CONTROL_7:
-	case MADERA_FLL2_LOOP_FILTER_TEST_1:
 	case MADERA_FLL2_SYNCHRONISER_1:
 	case MADERA_FLL2_SYNCHRONISER_2:
 	case MADERA_FLL2_SYNCHRONISER_3:
@@ -1879,7 +1821,6 @@ static bool cs47l85_16bit_readable_register(struct device *dev,
 	case MADERA_FLL3_CONTROL_5:
 	case MADERA_FLL3_CONTROL_6:
 	case MADERA_FLL3_CONTROL_7:
-	case MADERA_FLL3_LOOP_FILTER_TEST_1:
 	case MADERA_FLL3_SYNCHRONISER_1:
 	case MADERA_FLL3_SYNCHRONISER_2:
 	case MADERA_FLL3_SYNCHRONISER_3:
@@ -2004,9 +1945,6 @@ static bool cs47l85_16bit_readable_register(struct device *dev,
 	case MADERA_OUTPUT_PATH_CONFIG_6R:
 	case MADERA_DAC_DIGITAL_VOLUME_6R:
 	case MADERA_NOISE_GATE_SELECT_6R:
-	case MADERA_DRE_ENABLE:
-	case MADERA_EDRE_ENABLE:
-	case MADERA_EDRE_MANUAL:
 	case MADERA_DAC_AEC_CONTROL_1:
 	case MADERA_DAC_AEC_CONTROL_2:
 	case MADERA_NOISE_GATE_CONTROL:
@@ -2792,56 +2730,6 @@ static bool cs47l85_16bit_readable_register(struct device *dev,
 	case MADERA_FCR_FILTER_CONTROL:
 	case MADERA_FCR_ADC_REFORMATTER_CONTROL:
 	case MADERA_FCR_COEFF_START ... MADERA_FCR_COEFF_END:
-	case MADERA_DAC_COMP_1:
-	case MADERA_DAC_COMP_2:
-	case MADERA_FRF_COEFFICIENT_1L_1:
-	case MADERA_FRF_COEFFICIENT_1L_2:
-	case MADERA_FRF_COEFFICIENT_1L_3:
-	case MADERA_FRF_COEFFICIENT_1L_4:
-	case MADERA_FRF_COEFFICIENT_1R_1:
-	case MADERA_FRF_COEFFICIENT_1R_2:
-	case MADERA_FRF_COEFFICIENT_1R_3:
-	case MADERA_FRF_COEFFICIENT_1R_4:
-	case MADERA_FRF_COEFFICIENT_2L_1:
-	case MADERA_FRF_COEFFICIENT_2L_2:
-	case MADERA_FRF_COEFFICIENT_2L_3:
-	case MADERA_FRF_COEFFICIENT_2L_4:
-	case MADERA_FRF_COEFFICIENT_2R_1:
-	case MADERA_FRF_COEFFICIENT_2R_2:
-	case MADERA_FRF_COEFFICIENT_2R_3:
-	case MADERA_FRF_COEFFICIENT_2R_4:
-	case MADERA_FRF_COEFFICIENT_3L_1:
-	case MADERA_FRF_COEFFICIENT_3L_2:
-	case MADERA_FRF_COEFFICIENT_3L_3:
-	case MADERA_FRF_COEFFICIENT_3L_4:
-	case MADERA_FRF_COEFFICIENT_3R_1:
-	case MADERA_FRF_COEFFICIENT_3R_2:
-	case MADERA_FRF_COEFFICIENT_3R_3:
-	case MADERA_FRF_COEFFICIENT_3R_4:
-	case MADERA_FRF_COEFFICIENT_4L_1:
-	case MADERA_FRF_COEFFICIENT_4L_2:
-	case MADERA_FRF_COEFFICIENT_4L_3:
-	case MADERA_FRF_COEFFICIENT_4L_4:
-	case MADERA_FRF_COEFFICIENT_4R_1:
-	case MADERA_FRF_COEFFICIENT_4R_2:
-	case MADERA_FRF_COEFFICIENT_4R_3:
-	case MADERA_FRF_COEFFICIENT_4R_4:
-	case MADERA_FRF_COEFFICIENT_5L_1:
-	case MADERA_FRF_COEFFICIENT_5L_2:
-	case MADERA_FRF_COEFFICIENT_5L_3:
-	case MADERA_FRF_COEFFICIENT_5L_4:
-	case MADERA_FRF_COEFFICIENT_5R_1:
-	case MADERA_FRF_COEFFICIENT_5R_2:
-	case MADERA_FRF_COEFFICIENT_5R_3:
-	case MADERA_FRF_COEFFICIENT_5R_4:
-	case MADERA_FRF_COEFFICIENT_6L_1:
-	case MADERA_FRF_COEFFICIENT_6L_2:
-	case MADERA_FRF_COEFFICIENT_6L_3:
-	case MADERA_FRF_COEFFICIENT_6L_4:
-	case MADERA_FRF_COEFFICIENT_6R_1:
-	case MADERA_FRF_COEFFICIENT_6R_2:
-	case MADERA_FRF_COEFFICIENT_6R_3:
-	case MADERA_FRF_COEFFICIENT_6R_4:
 	case MADERA_GPIO1_CTRL_1 ... MADERA_GPIO40_CTRL_2:
 	case MADERA_IRQ1_STATUS_1 ... MADERA_IRQ1_STATUS_33:
 	case MADERA_IRQ1_MASK_1 ... MADERA_IRQ1_MASK_33:
diff --git a/drivers/mfd/cs47l90-tables.c b/drivers/mfd/cs47l90-tables.c
index c040d3d7232a5..2c761fc241f30 100644
--- a/drivers/mfd/cs47l90-tables.c
+++ b/drivers/mfd/cs47l90-tables.c
@@ -119,7 +119,6 @@ static const struct reg_default cs47l90_reg_default[] = {
 	{ 0x00000174, 0x007d }, /* R372 (0x174) - FLL1 Control 4 */
 	{ 0x00000175, 0x0000 }, /* R373 (0x175) - FLL1 Control 5 */
 	{ 0x00000176, 0x0000 }, /* R374 (0x176) - FLL1 Control 6 */
-	{ 0x00000177, 0x0281 }, /* R375 (0x177) - FLL1 Loop Filter Test 1 */
 	{ 0x00000179, 0x0000 }, /* R377 (0x179) - FLL1 Control 7 */
 	{ 0x0000017a, 0x2906 }, /* R377 (0x17a) - FLL1 Efs 2 */
 	{ 0x00000181, 0x0000 }, /* R385 (0x181) - FLL1 Synchroniser 1 */
@@ -137,7 +136,6 @@ static const struct reg_default cs47l90_reg_default[] = {
 	{ 0x00000194, 0x007d }, /* R404 (0x194) - FLL2 Control 4 */
 	{ 0x00000195, 0x0000 }, /* R405 (0x195) - FLL2 Control 5 */
 	{ 0x00000196, 0x0000 }, /* R406 (0x196) - FLL2 Control 6 */
-	{ 0x00000197, 0x0281 }, /* R407 (0x197) - FLL2 Loop Filter Test 1 */
 	{ 0x00000199, 0x0000 }, /* R409 (0x199) - FLL2 Control 7 */
 	{ 0x0000019a, 0x2906 }, /* R410 (0x19a) - FLL2 Efs 2 */
 	{ 0x000001a1, 0x0000 }, /* R417 (0x1a1) - FLL2 Synchroniser 1 */
@@ -260,8 +258,6 @@ static const struct reg_default cs47l90_reg_default[] = {
 	{ 0x00000434, 0x0000 }, /* R1076 (0x434) - Output Path Config 5R */
 	{ 0x00000435, 0x0180 }, /* R1077 (0x435) - DAC Digital Volume 5R */
 	{ 0x00000437, 0x0200 }, /* R1079 (0x437) - Noise Gate Select 5R */
-	{ 0x00000440, 0x003f }, /* R1088 (0x440) - DRE Enable */
-	{ 0x00000448, 0x003f }, /* R1096 (0x448) - eDRE Enable */
 	{ 0x00000450, 0x0000 }, /* R1104 (0x450) - DAC AEC Control 1 */
 	{ 0x00000451, 0x0000 }, /* R1104 (0x450) - DAC AEC Control 2 */
 	{ 0x00000458, 0x0000 }, /* R1112 (0x458) - Noise Gate Control */
@@ -1262,40 +1258,6 @@ static const struct reg_default cs47l90_reg_default[] = {
 	{ 0x00000fc3, 0x0000 }, /* R4035 (0xfc3) - ANC Coefficient */
 	{ 0x00000fc4, 0x0000 }, /* R4036 (0xfc4) - ANC Coefficient */
 	{ 0x00000fc5, 0x0000 }, /* R4037 (0xfc5) - ANC Coefficient */
-	{ 0x00001300, 0x050E }, /* R4864 (0x1300) - DAC Comp 1 */
-	{ 0x00001302, 0x0101 }, /* R4866 (0x1302) - DAC Comp 2 */
-	{ 0x00001380, 0x0425 }, /* R4992 (0x1380) - FRF Coefficient 1L 1 */
-	{ 0x00001381, 0xF6D8 }, /* R4993 (0x1381) - FRF Coefficient 1L 2 */
-	{ 0x00001382, 0x0632 }, /* R4994 (0x1382) - FRF Coefficient 1L 3 */
-	{ 0x00001383, 0xFEC8 }, /* R4995 (0x1383) - FRF Coefficient 1L 4 */
-	{ 0x00001390, 0x042F }, /* R5008 (0x1390) - FRF Coefficient 1R 1 */
-	{ 0x00001391, 0xF6CA }, /* R5009 (0x1391) - FRF Coefficient 1R 2 */
-	{ 0x00001392, 0x0637 }, /* R5010 (0x1392) - FRF Coefficient 1R 3 */
-	{ 0x00001393, 0xFEC8 }, /* R5011 (0x1393) - FRF Coefficient 1R 4 */
-	{ 0x000013a0, 0x0000 }, /* R5024 (0x13a0) - FRF Coefficient 2L 1 */
-	{ 0x000013a1, 0x0000 }, /* R5025 (0x13a1) - FRF Coefficient 2L 2 */
-	{ 0x000013a2, 0x0000 }, /* R5026 (0x13a2) - FRF Coefficient 2L 3 */
-	{ 0x000013a3, 0x0000 }, /* R5027 (0x13a3) - FRF Coefficient 2L 4 */
-	{ 0x000013b0, 0x0000 }, /* R5040 (0x13b0) - FRF Coefficient 2R 1 */
-	{ 0x000013b1, 0x0000 }, /* R5041 (0x13b1) - FRF Coefficient 2R 2 */
-	{ 0x000013b2, 0x0000 }, /* R5042 (0x13b2) - FRF Coefficient 2R 3 */
-	{ 0x000013b3, 0x0000 }, /* R5043 (0x13b3) - FRF Coefficient 2R 4 */
-	{ 0x000013c0, 0x0000 }, /* R5040 (0x13c0) - FRF Coefficient 3L 1 */
-	{ 0x000013c1, 0x0000 }, /* R5041 (0x13c1) - FRF Coefficient 3L 2 */
-	{ 0x000013c2, 0x0000 }, /* R5042 (0x13c2) - FRF Coefficient 3L 3 */
-	{ 0x000013c3, 0x0000 }, /* R5043 (0x13c3) - FRF Coefficient 3L 4 */
-	{ 0x000013d0, 0x0000 }, /* R5072 (0x13d0) - FRF Coefficient 3R 1 */
-	{ 0x000013d1, 0x0000 }, /* R5073 (0x13d1) - FRF Coefficient 3R 2 */
-	{ 0x000013d2, 0x0000 }, /* R5074 (0x13d2) - FRF Coefficient 3R 3 */
-	{ 0x000013d3, 0x0000 }, /* R5075 (0x13d3) - FRF Coefficient 3R 4 */
-	{ 0x00001400, 0x0000 }, /* R5120 (0x1400) - FRF Coefficient 5L 1 */
-	{ 0x00001401, 0x0000 }, /* R5121 (0x1401) - FRF Coefficient 5L 2 */
-	{ 0x00001402, 0x0000 }, /* R5122 (0x1402) - FRF Coefficient 5L 3 */
-	{ 0x00001403, 0x0000 }, /* R5123 (0x1403) - FRF Coefficient 5L 4 */
-	{ 0x00001410, 0x0000 }, /* R5136 (0x1410) - FRF Coefficient 5R 1 */
-	{ 0x00001411, 0x0000 }, /* R5137 (0x1411) - FRF Coefficient 5R 2 */
-	{ 0x00001412, 0x0000 }, /* R5138 (0x1412) - FRF Coefficient 5R 3 */
-	{ 0x00001413, 0x0000 }, /* R5139 (0x1413) - FRF Coefficient 5R 4 */
 	{ 0x00001480, 0x0000 }, /* R5248 (0x1480) - DFC1_CTRL */
 	{ 0x00001482, 0x1f00 }, /* R5250 (0x1482) - DFC1_RX */
 	{ 0x00001484, 0x1f00 }, /* R5252 (0x1486) - DFC1_TX */
@@ -1535,7 +1497,6 @@ static bool cs47l90_16bit_readable_register(struct device *dev,
 	case MADERA_FLL1_CONTROL_6:
 	case MADERA_FLL1_CONTROL_7:
 	case MADERA_FLL1_EFS_2:
-	case MADERA_FLL1_LOOP_FILTER_TEST_1:
 	case MADERA_FLL1_SYNCHRONISER_1:
 	case MADERA_FLL1_SYNCHRONISER_2:
 	case MADERA_FLL1_SYNCHRONISER_3:
@@ -1553,7 +1514,6 @@ static bool cs47l90_16bit_readable_register(struct device *dev,
 	case MADERA_FLL2_CONTROL_6:
 	case MADERA_FLL2_CONTROL_7:
 	case MADERA_FLL2_EFS_2:
-	case MADERA_FLL2_LOOP_FILTER_TEST_1:
 	case MADERA_FLL2_SYNCHRONISER_1:
 	case MADERA_FLL2_SYNCHRONISER_2:
 	case MADERA_FLL2_SYNCHRONISER_3:
@@ -1690,8 +1650,6 @@ static bool cs47l90_16bit_readable_register(struct device *dev,
 	case MADERA_OUTPUT_PATH_CONFIG_5R:
 	case MADERA_DAC_DIGITAL_VOLUME_5R:
 	case MADERA_NOISE_GATE_SELECT_5R:
-	case MADERA_DRE_ENABLE:
-	case MADERA_EDRE_ENABLE:
 	case MADERA_DAC_AEC_CONTROL_1:
 	case MADERA_DAC_AEC_CONTROL_2:
 	case MADERA_NOISE_GATE_CONTROL:
@@ -2449,40 +2407,6 @@ static bool cs47l90_16bit_readable_register(struct device *dev,
 	case MADERA_FCR_FILTER_CONTROL:
 	case MADERA_FCR_ADC_REFORMATTER_CONTROL:
 	case MADERA_FCR_COEFF_START ... MADERA_FCR_COEFF_END:
-	case MADERA_DAC_COMP_1:
-	case MADERA_DAC_COMP_2:
-	case MADERA_FRF_COEFFICIENT_1L_1:
-	case MADERA_FRF_COEFFICIENT_1L_2:
-	case MADERA_FRF_COEFFICIENT_1L_3:
-	case MADERA_FRF_COEFFICIENT_1L_4:
-	case MADERA_FRF_COEFFICIENT_1R_1:
-	case MADERA_FRF_COEFFICIENT_1R_2:
-	case MADERA_FRF_COEFFICIENT_1R_3:
-	case MADERA_FRF_COEFFICIENT_1R_4:
-	case MADERA_FRF_COEFFICIENT_2L_1:
-	case MADERA_FRF_COEFFICIENT_2L_2:
-	case MADERA_FRF_COEFFICIENT_2L_3:
-	case MADERA_FRF_COEFFICIENT_2L_4:
-	case MADERA_FRF_COEFFICIENT_2R_1:
-	case MADERA_FRF_COEFFICIENT_2R_2:
-	case MADERA_FRF_COEFFICIENT_2R_3:
-	case MADERA_FRF_COEFFICIENT_2R_4:
-	case MADERA_FRF_COEFFICIENT_3L_1:
-	case MADERA_FRF_COEFFICIENT_3L_2:
-	case MADERA_FRF_COEFFICIENT_3L_3:
-	case MADERA_FRF_COEFFICIENT_3L_4:
-	case MADERA_FRF_COEFFICIENT_3R_1:
-	case MADERA_FRF_COEFFICIENT_3R_2:
-	case MADERA_FRF_COEFFICIENT_3R_3:
-	case MADERA_FRF_COEFFICIENT_3R_4:
-	case MADERA_FRF_COEFFICIENT_5L_1:
-	case MADERA_FRF_COEFFICIENT_5L_2:
-	case MADERA_FRF_COEFFICIENT_5L_3:
-	case MADERA_FRF_COEFFICIENT_5L_4:
-	case MADERA_FRF_COEFFICIENT_5R_1:
-	case MADERA_FRF_COEFFICIENT_5R_2:
-	case MADERA_FRF_COEFFICIENT_5R_3:
-	case MADERA_FRF_COEFFICIENT_5R_4:
 	case MADERA_DFC1_CTRL:
 	case MADERA_DFC1_RX:
 	case MADERA_DFC1_TX:
-- 
2.11.0

