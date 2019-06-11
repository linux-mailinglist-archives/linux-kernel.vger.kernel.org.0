Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB56E3CA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfFKLqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 07:46:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23650 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389282AbfFKLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:46:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BBf8g4027845;
        Tue, 11 Jun 2019 13:45:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=UHkKYvr07JUPpR6+O+OHG40CIbSuZZB5RoqilIve/M8=;
 b=fklX/5a88/vDeXzr6ZnFcOeRM38ODI41A3SchpcjzGGWGWjrx9SZwOOaPv7ZUnLH6sd3
 /AyO6eVM1Rvwq/hR4v2rSNs+9Ceo+jbDttaobt6PKt+hO2Om1iXhJgt6jYLughQu5WjS
 udiKEopvmQIIulcLGPotoQtVUD22VWjhCmw27ULfl2w9NNW54GlZVjAvH67h4pXKZ7Gr
 pQSm/dkuNvBsLW4RoqHjibBSoI01SyRFtPrUbNkuI35W80jmydXqfT2VDeuRNwJqsvIr
 hBpV1U5NJJmwx2xrpUFPxGrIQeXbqRgv0sgfIs9jgF8JZoilS5dwPvjz5iFfdUMpJdsG 0A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t26rjspev-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Jun 2019 13:45:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2CC434;
        Tue, 11 Jun 2019 11:45:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F0782953;
        Tue, 11 Jun 2019 11:45:58 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 13:45:58 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun 2019 13:45:58
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH] ARM: dts: stm32: add sai id registers to stm32mp157c
Date:   Tue, 11 Jun 2019 13:45:56 +0200
Message-ID: <1560253556-18399-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identification registers to address range
of SAI DT parent node, for stm32mp157c.

Change-Id: I696363794fab59ba8d7869b3ffbc041dacdf28de
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index e98aad37ff9e..0c4e6ebc3529 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -746,7 +746,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4400a000 0x400>;
-			reg = <0x4400a000 0x4>;
+			reg = <0x4400a000 0x4>, <0x4400a3f0 0x10>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&rcc SAI1_R>;
 			status = "disabled";
@@ -778,7 +778,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4400b000 0x400>;
-			reg = <0x4400b000 0x4>;
+			reg = <0x4400b000 0x4>, <0x4400b3f0 0x10>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&rcc SAI2_R>;
 			status = "disabled";
@@ -809,7 +809,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4400c000 0x400>;
-			reg = <0x4400c000 0x4>;
+			reg = <0x4400c000 0x4>, <0x4400c3f0 0x10>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&rcc SAI3_R>;
 			status = "disabled";
@@ -1164,7 +1164,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x50027000 0x400>;
-			reg = <0x50027000 0x4>;
+			reg = <0x50027000 0x4>, <0x500273f0 0x10>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&rcc SAI4_R>;
 			status = "disabled";
-- 
2.7.4

