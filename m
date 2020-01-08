Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E8133FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 11:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgAHK4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 05:56:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20252 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgAHK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:56:12 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008AlxkM021687;
        Wed, 8 Jan 2020 11:56:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=HQegFaRorBiqJXYyjb8evLS2x249g1aHtLlFii1jNgI=;
 b=IJCtyY21s8a/RpoICoEMu6WYJkGhHaXkYRjScYJ0S872dRdKHzJRjOcCSuFxlurtEgSK
 i31g/ngnQwC5tayjfzehfq1p//ovmvRq+R0MDfk6YPrEtCGDPHbur6tjdu4DeTMbxOhR
 snBaJD+oMpKYJoM4JCDY4yfNATWQcQpNqu+dn2Q9NvWPPCbehcNCSR8p0Xhu7nlnnrcv
 FjTaddL2cUk9DF9CUn3AuuzXIgjFTSoCaHqKXLQDSixHgtvUF3/ZOGu76MqObjrGv7WT
 4ICQQJX+SZbA6G1AF+vOkUGW6ZY8a4J1D9gCWxBMiBd0+3uDv/KUGYd7RVZRf2YASwjQ dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakuqudyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 11:56:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BA2710002A;
        Wed,  8 Jan 2020 11:56:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B4D72AC7BA;
        Wed,  8 Jan 2020 11:56:01 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan 2020 11:56:00
 +0100
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@st.com>
Subject: ARM: dts: stih410-b2260: Remove deprecated snps PHY properties
Date:   Wed, 8 Jan 2020 11:54:50 +0100
Message-ID: <20200108105450.31435-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove "snps,phy-bus-name", "snps,phy-bus-id" and "snps,phy-addr"
properties which are deprecated.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2260.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 4fbd8e9eb5b7..e2bb59783146 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -178,9 +178,6 @@
 			phy-mode = "rgmii";
 			pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii1_mdio_1>;
 
-			snps,phy-bus-name = "stmmac";
-			snps,phy-bus-id = <0>;
-			snps,phy-addr = <0>;
 			snps,reset-gpio = <&pio0 7 0>;
 			snps,reset-active-low;
 			snps,reset-delays-us = <0 10000 1000000>;
-- 
2.17.1

