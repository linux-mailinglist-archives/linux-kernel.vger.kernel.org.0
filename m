Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF37FBC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436632AbfHBOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:09:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38968 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732817AbfHBOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:09:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72E6uLF014555;
        Fri, 2 Aug 2019 16:09:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=V4Oy0E5gbwyi1cbiRiVoGW45+5zWyza++ydGz4D477E=;
 b=Z8BqG/0ydEYKorRq6uN7BstyvNz9rvTzsNTLIiUk0O/KLzdXaVrhf3fKJhOL+XEeruk1
 dGUUYZ4gXS3ohGtP7MiUizl4oLWZ+3EVWP2e5syGLv5FHVEzscdE5QRYsQOizAfJ3arT
 If/qqA0CWJFToyr79Oo1fW+TyDtXUPqoCjCri19Zu2UKJOzafaDMbPx4oM+cc3YbTcgq
 FdYxSHDdY1A1zlMjTW4MURJTjducO/Wg9zL1r6gc++okNND+3dMKEHtGkOU+dfm4N5OJ
 vrzrvZf/IH6fEAqSaggQGi8n5GCeCFmQ5c9+eKAk8Q7L+qYSDlwvbGiC2Hggumm9od11 vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2yvs6w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 16:09:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 537F634;
        Fri,  2 Aug 2019 14:09:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CEE72C4581;
        Fri,  2 Aug 2019 16:09:00 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019
 16:09:00 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019 16:08:59
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: move ltdc pinctrl on stm32mp157a dk1 board
Date:   Fri, 2 Aug 2019 16:08:51 +0200
Message-ID: <1564754931-13861-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ltdc pinctrl must be in the display controller node and
not in the peripheral node (hdmi bridge).

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index f3f0e37..1285cfc 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -99,9 +99,6 @@
 		reset-gpios = <&gpioa 10 GPIO_ACTIVE_LOW>;
 		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-parent = <&gpiog>;
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&ltdc_pins_a>;
-		pinctrl-1 = <&ltdc_pins_sleep_a>;
 		status = "okay";
 
 		ports {
@@ -276,6 +273,9 @@
 };
 
 &ltdc {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-1 = <&ltdc_pins_sleep_a>;
 	status = "okay";
 
 	port {
-- 
2.7.4

