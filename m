Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6562119AAFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgDALke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 07:40:34 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53972 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbgDALkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:40:33 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so2587130pjb.3;
        Wed, 01 Apr 2020 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=frwB9HCh+bckiKeVXR7fySiqWLZJB1ugfHiteg0Zg6A=;
        b=uO1rue67YuGneI+FwjSH0oNn4qzb32FAY5QIxDM4BPM5usA6Lb7PjtcdiCwpCpEChd
         ZM+Tt5RcPC8q2HWJ0QGK0WVzo8SVB4KIoHppAhEyiPTZubVgvvhI8vkKnzyUboO6TAhg
         EpY9pjBDnGA3N+5w8yE0YqafS83l6hJo8SC6cYn4dZnzWocGzMyrCU0rh1k/k0S4rcdP
         lWs+XOGKcPsfAx5Sd26YkgYkq9+rGQNVvIgGsolBqbYwvL3CmWJXUSPz2OQ9K9o2FQjJ
         KAmel9efYIMF2LfVxOkyQB807tl8m6B8SHRGiqurpEhyUHghwp+oDA5XUhdz7biLrGEs
         qkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=frwB9HCh+bckiKeVXR7fySiqWLZJB1ugfHiteg0Zg6A=;
        b=d4SlZ0lR2vlTb+2uRZf1It+Lc1b8fZbSzVovton6s8YvAS+4CK217WI5d63m7Ow+x/
         KPx3PbRCxJxq7s45BQORyUrkRhCu8475eVHauEnevt53r7rIMqjUcWMfqhZL4aXpIzQf
         TmPhJIAuOWqutKVkGzET4WaPofX4HU4INDnBvZksc+oJoMqdYQWsC77bqxhkZKElxKO2
         aVqtXlOwb5P/cVFyeE7mjiqFd5/uLZx8/0ReUSSvJeb5m5IFm/kx0XHuCNFwUzuvovGc
         ZaSrJtKYNrQA/j02ZbiX04W6N923f0rrWjxKdl1BBDYXlhY7FONV9Zm/1/aO2Vz0OExx
         6YyA==
X-Gm-Message-State: AGi0Pub4KkKfx+XU6XjXFa1e69CE1Xgtt0SBa/2TgwpLCNrfNIvc18ca
        1shMQuZXqZeD3rM7nc3JhQym014sg8c=
X-Google-Smtp-Source: APiQypJ0ytCgLWwK/pGbVcTMZm+D7llsACYyxAi+SvlJPVMzHdnrHgN18R3C3SuNS09Mw7LpjMxbtQ==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr4407221pjq.100.1585741231649;
        Wed, 01 Apr 2020 04:40:31 -0700 (PDT)
Received: from cnn ([2402:3a80:463:99ca:94f8:dc27:324a:484e])
        by smtp.gmail.com with ESMTPSA id f5sm1418767pfq.63.2020.04.01.04.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 04:40:30 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:10:23 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     andrew@aj.id.au, joel@jms.id.au
Cc:     sdasari@fb.com, vijaykhemka@fb.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: [PATCH v7] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20200401114023.GA29180@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Yosemite V2 is a facebook multi-node server
platform that host four OCP server. The BMC
in the Yosemite V2 platform based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Acked-by     : Andrew Jeffery <andrew@aj.id.au>
Reviewed-by  : Vijay Khemka <vkhemka@fb.com>
---
---      v7 - Added multi-host SOL feature.
---      v6 - Added device tree property for multi-host Mellanox NIC in the ncsi driver.
---      v5 - Spell and contributor name correction.
---           - License identifier changed to GPL-2.0-or-later.
---           - aspeed-gpio.h removed.
---           - FAN2 tacho channel changed.
---      v4 - Bootargs removed.
---      v3 - Uart1 Debug removed .
---      v2 - LPC and VUART removed .
---      v1 - Initial draft.
---
---
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 186 +++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..bc83901
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+
+/ {
+	model = "Facebook Yosemitev2 BMC";
+	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
+	aliases {
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	iio-hwmon {
+		// VOLATAGE SENSOR
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
+		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
+		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
+		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+&uart1 {
+	// Host1 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart2 {
+	// Host2 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+		     &pinctrl_rxd2_default>;
+
+};
+
+&uart3 {
+	// Host3 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	// Host4 Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default>;
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&vuart {
+	// Virtual UART
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+	mlx,multi-host;
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+			&pinctrl_adc1_default
+			&pinctrl_adc2_default
+			&pinctrl_adc3_default
+			&pinctrl_adc4_default
+			&pinctrl_adc5_default
+			&pinctrl_adc6_default
+			&pinctrl_adc7_default
+			&pinctrl_adc8_default
+			&pinctrl_adc9_default
+			&pinctrl_adc10_default
+			&pinctrl_adc11_default
+			&pinctrl_adc12_default
+			&pinctrl_adc13_default
+			&pinctrl_adc14_default
+			&pinctrl_adc15_default>;
+};
+
+&i2c8 {
+	status = "okay";
+	//FRU EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	tmp421@4e {
+	//INLET TEMP
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	//OUTLET TEMP
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	//HSC
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+	//MEZZ_TEMP_SENSOR
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	//MEZZ_FRU
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&pwm_tacho {
+	status = "okay";
+	//FSC
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+};
-- 
2.7.4

