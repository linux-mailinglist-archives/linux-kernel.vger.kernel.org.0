Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152D818F7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCWPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 11:00:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38619 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgCWPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NEceZY020199;
        Mon, 23 Mar 2020 15:59:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=kyVB+tiE+rN9XPO8kyR9LpGoCVCUanK+RTCgZf2jO/w=;
 b=MXyz0nnEv459Rz7r4TnL48ZtCtsDd2fJpJVrxgLmWsClY8NF/tTZ9Tkr30Ob1K2teP7f
 sTM2kHOLPm0IwBRXmkJfLH+xhn4qON6+jMlTAPE5iqZK1bZcrssGfmRp92R80BWp6Zbt
 HIro4TAbgR6jLGBGrlgl+Vnh2F5LTopOj37sUfIEFN2PDTGBM9tEQiRfiwKBlAbhx12A
 ZigrK9Fszpu+9LIgZJ5ztx33ZkNOG+0fdmrStJOK0RgB8skfmwuFPr5nno1JhJm6DzgX
 0sbIhClBijuCEIQ5b2sq1UHKqvPeS5sXwuxsS3FZtOXbvDM/BFj6oujHSlybi8xAVEjN cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw9jytgfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 15:59:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7AA410002A;
        Mon, 23 Mar 2020 15:59:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9947E220F8F;
        Mon, 23 Mar 2020 15:59:50 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 23 Mar 2020 15:59:49
 +0100
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [06/12] mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
Date:   Mon, 23 Mar 2020 15:58:46 +0100
Message-ID: <1584975532-8038-7-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_05:2020-03-21,2020-03-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the constant FMC2_TIMEOUT_US.
FMC2_TIMEOUT_MS is set to 5 seconds and this constant is used
each time that we need to wait (except when the timeout value
is set by the framework)

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index ab53314..f159c39 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -37,8 +37,7 @@
 /* Max ECC buffer length */
 #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)
 
-#define FMC2_TIMEOUT_US			1000
-#define FMC2_TIMEOUT_MS			1000
+#define FMC2_TIMEOUT_MS			5000
 
 /* Timings */
 #define FMC2_THIZ			1
@@ -525,9 +524,9 @@ static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
 	u32 sr, heccr;
 	int ret;
 
-	ret = readl_relaxed_poll_timeout(fmc2->io_base + FMC2_SR,
-					 sr, sr & FMC2_SR_NWRF, 10,
-					 FMC2_TIMEOUT_MS);
+	ret = readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR,
+						sr, sr & FMC2_SR_NWRF, 1,
+						1000 * FMC2_TIMEOUT_MS);
 	if (ret) {
 		dev_err(fmc2->dev, "ham timeout\n");
 		return ret;
@@ -1315,7 +1314,7 @@ static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
 	/* Check if there is no pending requests to the NAND flash */
 	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
 					      sr & FMC2_SR_NWRF, 1,
-					      FMC2_TIMEOUT_US))
+					      1000 * FMC2_TIMEOUT_MS))
 		dev_warn(fmc2->dev, "Waitrdy timeout\n");
 
 	/* Wait tWB before R/B# signal is low */
-- 
1.9.1

