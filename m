Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BFD1899C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCRKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:43:24 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:51497 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCRKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:43:24 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0zvM3WYQSKGglrOZe4qS9nW731ZR99ZYSOTnB9obzkpu7Fa7oUWoFakKB88/Mt53am09je59e6
 vLKhxRsckpIA9/gL91TlxjWTJui5T3F6cWQ03qIQye5nU1V4ylM07D14KIrY2NOzYvIXQysdlr
 5AsMjzeWjWJBIJtlcLsgA2xso+WeEGH4qVLBVT6rJBlS94gVitMcCPaIq38odYzrzF6kim/YiG
 wVkOg2SF40rhk9hI/xHGKKBB7nZYxm/Lqz937naM/I1UBD2hS8jfznkxyPjIL9bY1jZ01F9f9y
 RLE=
X-IronPort-AV: E=Sophos;i="5.70,566,1574146800"; 
   d="scan'208";a="69337725"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Mar 2020 03:43:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Mar 2020 03:43:20 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 18 Mar 2020 03:43:09 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eugen.hristev@microchip.com>, <cristian.birsan@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d27_wlsom1_ek: add USB device node
Date:   Wed, 18 Mar 2020 12:42:36 +0200
Message-ID: <20200318104236.21114-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Add USB device node for WLSoM1 EK and enable it.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
[eugen.hristev@microchip.com: ported to 5.4]
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index 0b9fa2942dff..6b8461278950 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -186,6 +186,11 @@
 		pinmux = <PIN_PA10__GPIO>;
 		bias-disable;
 	};
+
+	pinctrl_usba_vbus: usba_vbus {
+		pinmux = <PIN_PA16__GPIO>;
+		bias-disable;
+	};
 };
 
 &pwm0 {
@@ -248,6 +253,13 @@
 	status = "okay";
 };
 
+&usb0 {
+	atmel,vbus-gpio = <&pioA PIN_PA16 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
-- 
2.20.1

