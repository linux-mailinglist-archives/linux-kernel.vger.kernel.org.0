Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD2FAB30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 08:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKMHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 02:47:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45070 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMHre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:47:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so1055428pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 23:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=j+Rmv2QRAZYFyDr3XTcc91Xq1BkHJOJyHUbLmK3uyjE=;
        b=XLq9+eozGJ/rjBzNCaFV6kBLhAb4JneTNegXmrQmdD3nAAR38+rIlt3PMo2JW1sGFl
         vINRe2DcL0dRrAbmtbcPQD5E30Anh33s2N2gjq4t47nVTGhf7nG1oseZpMKmLxtuvR9O
         5pw9p0wO6TFHKLl/mpVSs80JDMgyLojaKXSMMiuulWwBT8DnqynM07LbNY78CwkWm50T
         4vjjRhOODKI7ZfD4UM8A+T0kXVTwd58WmXK+XFwPzLJGBmbJsXjnVv7jG+zirVCs5wsO
         UiGUobFyXdp8BbJnOKdnWuxoVotgm2ril+Xfjm9io371ok51Y4d3yZGxu92Cjh4UCR1o
         +YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=j+Rmv2QRAZYFyDr3XTcc91Xq1BkHJOJyHUbLmK3uyjE=;
        b=cn5BmX2Lnedr5s37GjnLANC5+e0RDjX67R/oCPnn7S0O9h6a1u/pzsXQ48ZVoLqYsC
         UVTeo7ybWLT1KhDHRnYMqP9lsHQUGW1xiTX5bKet38XY1L+dXJ5X39q46z/jYzwA36dj
         TAdXN6X/9qk0F4TV0f9E6EwWE+LlNXXU4rHl98QFOJY8Q+BdoaHAC+ae55MkKCh41PoD
         UO1/t5NjmTyrP/sSHoJKPqHsNHNRtvv8irco1MTjYec0WuzTw7JXp0EORvcr+oboah9y
         5XOeNfr9x5wZBEzsbMiJqlTuhiWdVDeTc4K/gCbOVYNPjCrpCmCs/Cr/wcZH2iciuS2+
         0s/g==
X-Gm-Message-State: APjAAAXveqYKjRV/wM6L25lw7I1tf0sw5t1tVBLKH7Z3YBxHIxDABgVR
        VqNatQQcuDbYesnQAdTbgbctJ8Zk
X-Google-Smtp-Source: APXvYqxicNulCgQ3p328sMXCXephUbCXkQoNoPYT853TcqPYimoCW5sQa0wVNeuQwdWRM5d40bFljg==
X-Received: by 2002:a63:8443:: with SMTP id k64mr2106136pgd.417.1573631253278;
        Tue, 12 Nov 2019 23:47:33 -0800 (PST)
Received: from cnn ([2402:3a80:45d:2426:a502:3b3e:c9a:ed61])
        by smtp.gmail.com with ESMTPSA id f35sm1403343pje.32.2019.11.12.23.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 23:47:32 -0800 (PST)
Date:   Wed, 13 Nov 2019 13:17:28 +0530
From:   manikandan-e <manikandan.hcl.ers.epl@gmail.com>
To:     joel@jms.id.au
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191113074727.GA12497@cnn>
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
in the Yosemite V2 platorm based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 168 +++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..ab6ff7f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+// Author:
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook Yosemitev2 BMC";
+	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
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
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&lpc_ctrl {
+	// Enable lpc clock
+	status = "okay";
+};
+
+&vuart {
+	// VUART Host Console
+	status = "okay";
+};
+
+&uart1 {
+	// Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart2 {
+	// SoL Host Console
+	status = "okay";
+};
+
+&uart3 {
+	// SoL BMC Console
+	status = "okay";
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&adc {
+	status = "okay";
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+};
-- 
2.7.4

