Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9118214B16B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgA1JG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 04:06:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55730 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgA1JGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:06:54 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S92i9c021525;
        Tue, 28 Jan 2020 10:06:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=osJmv1TofsLiqLia+94YgpW5rj8JhzwPxMGK3NL9Llg=;
 b=bk06kxhVT9niKdowr/sJozA1K1H5u4/CpemQFHGURTB2SJePjg/ChM4ZbRhtiPPYpquc
 QZy1k6v3Ih0a/swDDtHmqaPpfzFpvTD/onLQF6OQ0mFT11V9FBi1AxhBo1cywPgwvj9E
 Yedi75xWmv5ThLB/8R2yDHwosIkcK/QFKVTVCTLuPuSt37IndIJv3Q0gYmGk/BkzsvHS
 WekHwDJIegsAI9fDZdEf2a/8kFCVec+OLHk9iH5cB6QQ2p918WSlPJQ9KzTCmeOuVtVO
 M+7I+BXXwc5VesIXw/LJ2ps/fyFLqcXThmrDmDIL4QtrfyNOrHs1RnsuTnZhSfwYzRNZ Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekcugq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:06:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5AF6E10002A;
        Tue, 28 Jan 2020 10:06:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E7CA212A38;
        Tue, 28 Jan 2020 10:06:40 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan 2020 10:06:39
 +0100
From:   Ludovic Barre <ludovic.barre@st.com>
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
Subject: [PATCH V2 1/9] mmc: mmci: sdmmc: replace sg_dma_xxx macros
Date:   Tue, 28 Jan 2020 10:06:28 +0100
Message-ID: <20200128090636.13689-2-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sg_dma_xxx should be used after a dma_map_sg call has been done
to get bus addresses of each of the SG entries and their lengths.
But mmci_host_ops validate_data can be called before dma_map_sg.
This patch replaces theses macros by sg->offset and sg->length
which are always defined.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index a4f7e8e689d3..6ccfbbc82c77 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -36,8 +36,8 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 	 * excepted the last element which has no constraint on idmasize
 	 */
 	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
-		if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32)) ||
-		    !IS_ALIGNED(sg_dma_len(data->sg), SDMMC_IDMA_BURST)) {
+		if (!IS_ALIGNED(data->sg->offset, sizeof(u32)) ||
+		    !IS_ALIGNED(data->sg->length, SDMMC_IDMA_BURST)) {
 			dev_err(mmc_dev(host->mmc),
 				"unaligned scatterlist: ofst:%x length:%d\n",
 				data->sg->offset, data->sg->length);
@@ -45,7 +45,7 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 		}
 	}
 
-	if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32))) {
+	if (!IS_ALIGNED(data->sg->offset, sizeof(u32))) {
 		dev_err(mmc_dev(host->mmc),
 			"unaligned last scatterlist: ofst:%x length:%d\n",
 			data->sg->offset, data->sg->length);
-- 
2.17.1

