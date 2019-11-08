Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5EF514F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKHQiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:38:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30830 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727412AbfKHQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:38:01 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8GMENE032766;
        Fri, 8 Nov 2019 17:37:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=smoPj/z5Sn90v90H2JHjnC4eM+rbToGswr/u4f90j/g=;
 b=vOZvnoNT0YRkphaJ2ZC3jspcjSv811wxUyT0b9/ZWw5tLJmJqA4sBs5DoWg97XZODQjH
 aJWcICZALYH86Hkrcb+O8b1TTHAi+ntFz0bBX5co2GlXx4qk2kO+iu8a//U+DYeXx8ln
 rLG570a9czCepj+Q5dsQ0QyQfMK47rWkEBOXeJYcCuUmBWO9OtXLjH9okTcNFWY25rH8
 Ly0dbrzclGaVJjkzFtbb6PNI8AFJ+W1A1qhSuALX/0d2xsP/Jgwut836msmunfZHTkE4
 fahvm3uD91TBOpBcCxybYKxBidp6NfR9h14UTXW9oogkIo54URafitsGD2EjSAD4bw5T eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vmvpvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 17:37:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1290D10002A;
        Fri,  8 Nov 2019 17:37:50 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 064AF2C38AC;
        Fri,  8 Nov 2019 17:37:50 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019
 17:37:49 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019 17:37:49 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: add ADC support to stm32mp157c-ed1
Date:   Fri, 8 Nov 2019 17:37:39 +0100
Message-ID: <1573231059-395-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
References: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_05:2019-11-08,2019-11-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADC support to stm32mp157c-ed1 board.
Following ADC signals are dedicated for analog and routed to connectors:
- ADC1/2 in0 (ANA0)
- ADC1/2 in1 (ANA1)
- ADC1 in6 (PF12)
Configure ADC1 with these signals. But keep it disabled by default, so
PF12 can be used as gpio by default.
Add VDD and VDDA supplies to ADC on stm32mp157c-ed1 board. This allows to
get full ADC analog performances in case VDDA is below 2.7V (not the case
by default).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index b8cc0fb..d889813 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -89,6 +89,22 @@
 	};
 };
 
+&adc {
+	/* ANA0, ANA1 are dedicated pins and don't need pinctrl: only in6. */
+	pinctrl-0 = <&adc1_in6_pins_a>;
+	pinctrl-names = "default";
+	vdd-supply = <&vdd>;
+	vdda-supply = <&vdda>;
+	vref-supply = <&vdda>;
+	status = "disabled";
+	adc1: adc@0 {
+		st,adc-channels = <0 1 6>;
+		/* 16.5 ck_cycles sampling time */
+		st,min-sample-time-nsecs = <400>;
+		status = "okay";
+	};
+};
+
 &dac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dac_ch1_pins_a &dac_ch2_pins_a>;
-- 
2.7.4

