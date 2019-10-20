Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1318DDC41
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 06:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfJTEIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 00:08:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfJTEIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 00:08:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 839B3B3E5;
        Sun, 20 Oct 2019 04:08:29 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        info@synology.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: realtek: Add RTD1296 and Synology DS418
Date:   Sun, 20 Oct 2019 06:08:17 +0200
Message-Id: <20191020040817.16882-9-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191020040817.16882-1-afaerber@suse.de>
References: <20191020040817.16882-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for RTD1296 SoC and Synology DiskStation DS418.

Cc: info@synology.com
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Moved SPDX-License-Identifier to top
 * Dropped "arm,armv8" (Rob)
 * Changed from MIT to BSD-2-Clause (Rob)
 * Dropped accidental enable-method and cpu-release-addr
 * Fixed DS418 to use rtd1296.dtsi
 
 arch/arm64/boot/dts/realtek/Makefile          |  2 +
 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts | 30 +++++++++++++
 arch/arm64/boot/dts/realtek/rtd1296.dtsi      | 65 +++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index e7ff40461ddc..555638ada721 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -5,3 +5,5 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1293-ds418j.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-mele-v9.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
+
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts b/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
new file mode 100644
index 000000000000..5a051a52bf88
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2017-2019 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include "rtd1296.dtsi"
+
+/ {
+	compatible = "synology,ds418", "realtek,rtd1296";
+	model = "Synology DiskStation DS418";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
new file mode 100644
index 000000000000..0f9e59cac086
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1296 SoC
+ *
+ * Copyright (c) 2017-2019 Andreas Färber
+ */
+
+#include "rtd129x.dtsi"
+
+/ {
+	compatible = "realtek,rtd1296";
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x1>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x2>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x3>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
+
+&arm_pmu {
+	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+};
-- 
2.16.4

