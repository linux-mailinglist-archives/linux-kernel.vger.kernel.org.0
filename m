Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991ADDDC3E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 06:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJTEIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 00:08:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbfJTEIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 00:08:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B383B012;
        Sun, 20 Oct 2019 04:08:28 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        info@synology.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] arm64: dts: realtek: Add RTD1293 and Synology DS418j
Date:   Sun, 20 Oct 2019 06:08:15 +0200
Message-Id: <20191020040817.16882-7-afaerber@suse.de>
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

Add Device Trees for RTD1293 SoC and Synology DiskStation DS418j NAS.

Cc: info@synology.com
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Moved SPDX-License-Identifier to top
 * Dropped "arm,armv8" (Rob)
 * Changed from MIT to BSD-2-Clause (Rob)
 * Dropped accidental enable-method and cpu-release-addr
 
 arch/arm64/boot/dts/realtek/Makefile           |  3 ++
 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts | 30 +++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1293.dtsi       | 51 ++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1293.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 90c897ac3f7a..e7ff40461ddc 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1293-ds418j.dtb
+
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-mele-v9.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts b/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
new file mode 100644
index 000000000000..b2dd583146b4
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2017 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include "rtd1293.dtsi"
+
+/ {
+	compatible = "synology,ds418j", "realtek,rtd1293";
+	model = "Synology DiskStation DS418j";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
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
diff --git a/arch/arm64/boot/dts/realtek/rtd1293.dtsi b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
new file mode 100644
index 000000000000..bd4e22723f7b
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1293 SoC
+ *
+ * Copyright (c) 2017-2019 Andreas Färber
+ */
+
+#include "rtd129x.dtsi"
+
+/ {
+	compatible = "realtek,rtd1293";
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
+	interrupt-affinity = <&cpu0>, <&cpu1>;
+};
-- 
2.16.4

