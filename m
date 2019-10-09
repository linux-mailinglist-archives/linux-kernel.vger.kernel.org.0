Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45847D10F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfJIONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 10:13:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4454 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729491AbfJIONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:13:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99EBPS5006630;
        Wed, 9 Oct 2019 16:12:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=QbIurVBvgoZCd53yYTQJYhqlcMve1Nv/TTF9H7KxqwU=;
 b=JeRUP/963XrLDd/wbsFb42t3HbB0ESbVZS0nOFOWL7Ftlf897g78ulZ2+nDjMNxlO1j6
 MMGvnogGa+7jqTDTPsyJZZGqshqFFVW/CaOaJlBfR54S7vL4669oJIFrK2yvwObStdPy
 2Bq5UM8pqeG/oaN4JQsCoarQ68kLNBGoBceMlycckFqxWpq36ybOHgXwJP7tbLW1qqtF
 08PDj0prDIO7JtYvzJLBXGbSlyWXXDpppLIquOm7asOS0kw1/ljvsOZIOtxSOWo9NarF
 zzCkbJFTiXQdUTUgSZOIo0cE47jAh9iYyuqvH14g4xPYySY5xjWqCzzBcT9WirGLbpBV Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxvxcxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 16:12:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A231100034;
        Wed,  9 Oct 2019 16:12:57 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B60E21E6AF;
        Wed,  9 Oct 2019 16:12:57 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 16:12:57 +0200
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019 16:12:57 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: Add DAC pins used on stm32mp157c-ed1
Date:   Wed, 9 Oct 2019 16:12:51 +0200
Message-ID: <1570630372-24579-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
References: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_06:2019-10-08,2019-10-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pins that can be used by digital-to-analog converter on
stm32mp157c eval daughter board:
- PA4 and PA5 pins are available respectively on JP11 and JP10

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index eeb60d0..1e45b75 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -183,6 +183,18 @@
 				};
 			};
 
+			dac_ch1_pins_a: dac-ch1 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 4, ANALOG)>;
+				};
+			};
+
+			dac_ch2_pins_a: dac-ch2 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 5, ANALOG)>;
+				};
+			};
+
 			dcmi_pins_a: dcmi-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 8,  AF13)>,/* DCMI_HSYNC */
-- 
2.7.4

