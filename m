Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009C6FB4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKMQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 11:15:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13592 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbfKMQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:15:45 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADFv0TN018303;
        Wed, 13 Nov 2019 17:15:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=5TjD38QBbB9//539GuMz/PLBV0iVGNkVN9JR03CqXQ0=;
 b=he75MF+09RUdlBB7NerTymiJ6V62+N8f6Ta9s8jqkBtOca1bzd6Z29AGIBZ/I3WXrRyC
 vK5kAjjgntsAoaN1/wNoCRI7hv7JA1IAxWprlTr1v25dQuO7cNbYpOXgc8al4Clz6vhq
 1GTd6zpO/2jEAWlQ27iSkhXMWGenHrUE0B+6enQYwNdjgow4sixX3GJEQjaex/h+RYwc
 J7qp+lVRhkCW1LhDzbM4+XmgmIaUX2k1dUpbn951taXHUI8Bs1wg6rEZj0B+KHc4Q7SM
 Dgp9Bgl09YiXyiqc63lzOf6rFV3bQ+pF5QPFrP39Z00tXZGR8dSIqUjOb8NThYWY4qf4 Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psjs5n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 17:15:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F1EC10002A;
        Wed, 13 Nov 2019 17:15:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83C532CFC6B;
        Wed, 13 Nov 2019 17:15:30 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Nov 2019 17:15:29
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] regulator: stpmic1: Set a default ramp delay value
Date:   Wed, 13 Nov 2019 17:15:29 +0100
Message-ID: <20191113161529.27739-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_04:2019-11-13,2019-11-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a default ramp delay value to the regulators with the worst
case value.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/regulator/stpmic1_regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index f09061473613..f3d7d007ecbb 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -54,6 +54,8 @@ enum {
 
 /* Enable time worst case is 5000mV/(2250uV/uS) */
 #define PMIC_ENABLE_TIME_US 2200
+/* Ramp delay worst case is (2250uV/uS) */
+#define PMIC_RAMP_DELAY 2200
 
 static const struct regulator_linear_range buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(725000, 0, 4, 0),
@@ -208,6 +210,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.supply_name = #base, \
 }
 
@@ -227,6 +230,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.bypass_reg = LDO3_ACTIVE_CR, \
 	.bypass_mask = LDO_BYPASS_MASK, \
 	.bypass_val_on = LDO_BYPASS_MASK, \
@@ -248,6 +252,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.supply_name = #base, \
 }
 
@@ -267,6 +272,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.of_map_mode = stpmic1_map_mode, \
 	.pull_down_reg = ids##_PULL_DOWN_REG, \
 	.pull_down_mask = ids##_PULL_DOWN_MASK, \
-- 
2.17.1

