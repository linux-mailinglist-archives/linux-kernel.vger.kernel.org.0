Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13D3343D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfFCPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:55:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18684 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727501AbfFCPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:55:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53Frao7004235;
        Mon, 3 Jun 2019 17:55:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=oj2i9QotepYR2OEJaRA4rA4osloqDgU7KpWmr2xHAV4=;
 b=Z5RTgstEjTOu3kJzZDKFMDW0pptuG4kynxRZd4pfrSSzUfc5448kRLvPE9By7hDZtOII
 AVFchbmjzobh8nvqt9IUvPQahxuv0ayDJDl+IISHGEbIGM8Ggr8TLriFO9L+obMcUhWA
 apQnahQGLNggaqyqciQ5SjUkCXrjnGVqufkmHVpYOMwlrTozcf3uiy+s8srrwn7cYK+J
 ptm56t88CzYu6ViQzX5fReyuLsava8GrQ2hlKtzD1qgYFYqHM3voavDPr2pUfORMSDQS
 S/p9D6pkw9EvMm/aAD8LdiRo7swQcOfAjQgWPqBWuH1iI+padv5R34fNJNjoabGRdPtV 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sunmeb8pu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 17:55:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A7D931;
        Mon,  3 Jun 2019 15:55:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69E414E66;
        Mon,  3 Jun 2019 15:55:31 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:55:31 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:55:30 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V3 3/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date:   Mon, 3 Jun 2019 17:55:25 +0200
Message-ID: <1559577325-19266-4-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch enables busy detection for stm32 sdmmc which requires
to set data timer to define the busy timeout.
sdmmc has 2 flags:
-busyd0: inverted value of d0 line.
-busyd0end which indicates only end of busy following a cmd response.
Only one interrupt on busyd0end.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 4 ++++
 drivers/mmc/host/mmci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5a8b232..6210f1f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -264,6 +264,10 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.busy_detect		= true,
+	.busy_timeout		= true,
+	.busy_detect_flag	= MCI_STM32_BUSYD0,
+	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
 	.init			= sdmmc_variant_init,
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index b43a958..ac19de8 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -167,6 +167,7 @@
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
 #define MCI_STM32_BUSYD0	BIT(20)
+#define MCI_STM32_BUSYD0END	BIT(21)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
-- 
2.7.4

