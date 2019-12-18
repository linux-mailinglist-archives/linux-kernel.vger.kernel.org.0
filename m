Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54637124A20
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLROtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 09:49:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727327AbfLROtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:49:00 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEmHeF006122;
        Wed, 18 Dec 2019 15:48:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=lsqv5dK6nW9u1qgptNcBYClyryMRb7cAgkte/t+l4zw=;
 b=lyv5PTbFFHTw2F6wBjcgfnhImKbBYAZCf7e0Qos/UEKDHlCC0IeBvGpo9dGuSOwdXadM
 VRp084QPykfWDmJPtJFBkO2IBcCxPiNlZGbDHqwNrD+fuC2VmiZoFqF+rft2xVMDww9K
 POr5kvHNCCEmPz2TwBPYSEAatXz0EA//NTrmrKma7zbqIIucHSoaTebomTihrtyzxPK1
 BxIxZiAZd7Kp5jxyIKxPfzkD3yWDpGTzfwGw3bgaM1b0xik7Zosph0tO7fbO76IuptL0
 NqBh+DPYha3zdpfSb53++mkWu0V8RtNw44qKVS8Xlrnw8s7et+rbz7otWgCILUIBJ3Mj ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp374y8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:48:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A9A1100034;
        Wed, 18 Dec 2019 15:48:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF0A3207547;
        Wed, 18 Dec 2019 15:48:46 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 15:48:46
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 1/3] ARM: dts: stm32: fix dma controller node name on stm32f746
Date:   Wed, 18 Dec 2019 15:48:42 +0100
Message-ID: <20191218144844.7481-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191218144844.7481-1-benjamin.gaignard@st.com>
References: <20191218144844.7481-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify dma controller nodes name to fit with the standard naming.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 3a8e2dc1978c..93c063796780 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -586,7 +586,7 @@
 			assigned-clock-rates = <1000000>;
 		};
 
-		dma1: dma@40026000 {
+		dma1: dma-controller@40026000 {
 			compatible = "st,stm32-dma";
 			reg = <0x40026000 0x400>;
 			interrupts = <11>,
@@ -602,7 +602,7 @@
 			status = "disabled";
 		};
 
-		dma2: dma@40026400 {
+		dma2: dma-controller@40026400 {
 			compatible = "st,stm32-dma";
 			reg = <0x40026400 0x400>;
 			interrupts = <56>,
-- 
2.15.0

