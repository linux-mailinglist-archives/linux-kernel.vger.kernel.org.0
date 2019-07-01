Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0A2F99A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfE3JkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 05:40:09 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:52430 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfE3JkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:40:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 790AA41907;
        Thu, 30 May 2019 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1559209205; x=
        1561023606; bh=UEWo5Wtf7fM/INTSQIzm9jNzGMpxEKHf17NZO+fbVNY=; b=Q
        mV/yQl0nN7POa1dtizwFjp6BEP7coPmsbNdC+/12J48Nu8g/bzAc38CSuklc8UXG
        jyOZ2SOCTaU8NCKrGjr4zCKjc2LQvT0VsxwQl7R+UtZvHNWRqfaFU3Cl2bNPROVN
        bZvR2aBwJ/oTS69nnPqlaQkiVTwcA4zfY3DWMmK6NI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q9Dp95dp-WJG; Thu, 30 May 2019 12:40:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 937F241860;
        Thu, 30 May 2019 12:40:04 +0300 (MSK)
Received: from bbwork.com (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 30
 May 2019 12:40:04 +0300
From:   Alexander Filippov <a.filippov@yadro.com>
To:     <linux-aspeed@lists.ozlabs.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH] ARM: dts: aspeed: Add YADRO VESNIN BMC
Date:   Thu, 30 May 2019 12:39:48 +0300
Message-ID: <20190530093948.12479-1-a.filippov@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
by YADRO.

Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 262 ++++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 834cce80d1b8..811e9312cf22 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1259,6 +1259,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-palmetto.dtb \
+	aspeed-bmc-opp-vesnin.dtb \
 	aspeed-bmc-opp-romulus.dtb \
 	aspeed-bmc-opp-swift.dtb \
 	aspeed-bmc-opp-witherspoon.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
new file mode 100644
index 000000000000..ac0fd525adbd
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -0,0 +1,262 @@
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Vesnin BMC";
+	compatible = "yadro,vesnin-bmc", "aspeed,ast2400";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x40000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer@5f000000 {
+			no-map;
+			reg = <0x5f000000 0x01000000>; /* 16MB */
+		};
+		flash_memory: region@5c000000 {
+			no-map;
+			reg = <0x5c000000 0x02000000>; /* 32M */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_LOW>;
+		};
+		power_red {
+			gpios = <&gpio ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		id_blue {
+			gpios = <&gpio ASPEED_GPIO(O, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		alarm_red {
+			gpios = <&gpio ASPEED_GPIO(N, 6) GPIO_ACTIVE_LOW>;
+		};
+
+		alarm_yel {
+			gpios = <&gpio ASPEED_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button_checkstop {
+			label = "checkstop";
+			linux,code = <74>;
+			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
+		};
+
+		button_identify {
+			label = "identify";
+			linux,code = <152>;
+			gpios = <&gpio ASPEED_GPIO(O, 7) GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+        label = "bmc";
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1debug_default>;
+
+	flash@0 {
+		status = "okay";
+		label = "pnor";
+		m25p,fast-read;
+	};
+};
+
+&mac0 {
+	status = "okay";
+
+	use-ncsi;
+	no-hw-checksum;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+};
+
+
+&uart5 {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&lpc_host {
+    sio_regs: regs {
+        compatible = "aspeed,bmc-misc";
+    };
+};
+
+&mbox {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default &pinctrl_rxd2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+	cpr2021@59 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "general,cpr2021", "general,pmbus";
+		reg = <0x59>;
+		present {
+			gpios = <&gpio ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+		};
+		smbalert {
+			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_LOW>;
+		};
+		pwok {
+			gpios = <&gpio ASPEED_GPIO(E, 6) GPIO_ACTIVE_HIGH>;
+		};
+	};
+	cpr2021@5a {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "general,cpr2021", "general,pmbus";
+		reg = <0x5a>;
+		present {
+			gpios = <&gpio ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
+		};
+		smbalert {
+			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_LOW>;
+		};
+		pwok {
+			gpios = <&gpio ASPEED_GPIO(E, 6) GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	occ-hwmon@50 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x50>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	occ-hwmon@51 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x51>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	w83795g@2f {
+		compatible = "nuvoton,w83795g";
+		reg = <0x2f>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	occ-hwmon@56 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x56>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+
+	occ-hwmon@57 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x57>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	rtc@68 {
+		compatible = "maxim,ds3231";
+		reg = <0x68>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&vuart {
+	status = "okay";
+};
-- 
2.20.1

