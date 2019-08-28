Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8201D9FB11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfH1HAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:00:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:25817 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfH1HAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:00:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 00:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="264547037"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2019 00:00:30 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@vger.kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 2/2] dt-bindings: clk: intel: Add bindings document & header file for CGU
Date:   Wed, 28 Aug 2019 15:00:18 +0800
Message-Id: <e717703a746d54fadc35de45ea0bd65710355712.1566975410.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
controller driver of LGM.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  61 +++++++++
 include/dt-bindings/clock/intel,lgm-clk.h          | 150 +++++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h

diff --git a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
new file mode 100644
index 000000000000..8bc5c6f9f792
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/intel,cgu-lgm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightning Mountain SoC's Clock Controller(CGU) Binding
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
+
+description: |
+  Lightning Mountain(LGM) SoC's Clock Generation Unit(CGU) driver provides
+  all means to access the CGU hardware module in order to generate a series
+  of clocks for the whole system and individual peripherals.
+
+  This binding uses the common clock bindings
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    const: intel,cgu-lgm
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+examples:
+  # CGU node
+  - |
+    cgu: cgu@e0200000 {
+        compatible = "intel,cgu-lgm", "syscon";
+        reg = <0xe0200000 0x33c>;
+        #clock-cells = <1>;
+    };
+
+  # Example of clock consumer (UART driver)
+  - |
+    asc0: serial@e0a00000 {
+        compatible = "intel,lgm-asc";
+        reg = <0xe0a00000 0x1000>;
+        interrupt-parent = <&ioapic1>;
+        interrupts = <128 1>;
+        interrupt-names = "asc_irq";
+        clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
+        clock-names = "freq", "asc";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart0>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/intel,lgm-clk.h b/include/dt-bindings/clock/intel,lgm-clk.h
new file mode 100644
index 000000000000..09e5dc59ff5b
--- /dev/null
+++ b/include/dt-bindings/clock/intel,lgm-clk.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Intel Corporation.
+ * Lei Chuanhua <Chuanhua.lei@intel.com>
+ * Zhu Yixin <Yixin.zhu@intel.com>
+ */
+
+#ifndef __INTEL_LGM_CLK_H
+#define __INTEL_LGM_CLK_H
+
+/* PLL clocks */
+#define LGM_CLK_PLLPP		2
+#define LGM_CLK_PLL2		3
+#define LGM_CLK_PLL0CZ		4
+#define LGM_CLK_PLL0B		5
+#define LGM_CLK_PLL1		6
+#define LGM_CLK_LJPLL3		7
+#define LGM_CLK_LJPLL4		8
+#define LGM_CLK_PLL0CM0 	9
+#define LGM_CLK_PLL0CM1 	10
+
+/* clocks from PLLs */
+
+/* ROPLL clocks */
+#define LGM_CLK_PP_HW		15
+#define LGM_CLK_PP_UC		16
+#define LGM_CLK_PP_FXD		17
+#define LGM_CLK_PP_TBM		18
+
+/* PLL2 clocks */
+#define LGM_CLK_DDR		20
+
+/* PLL0CZ */
+#define LGM_CLK_CM		25
+#define LGM_CLK_IC		26
+#define LGM_CLK_SDIO3		27
+
+/* PLL0B */
+#define LGM_CLK_NGI		30
+#define LGM_CLK_NOC4		31
+#define LGM_CLK_SW		32
+#define LGM_CLK_QSPI		33
+#define LGM_CLK_CQEM		LGM_CLK_SW
+#define LGM_CLK_EMMC5		LGM_CLK_NOC4
+
+/* PLL1 */
+#define LGM_CLK_CT		35
+#define LGM_CLK_DSP		36
+#define LGM_CLK_4X		37
+#define LGM_CLK_DCL		38
+
+/* LJPLL3 */
+#define LGM_CLK_CML		40
+#define LGM_CLK_CBPHY		41
+#define LGM_CLK_POOL		42
+#define LGM_CLK_PTP		43
+
+/* LJPLL4 */
+#define LGM_CLK_PCIE		45
+#define LGM_CLK_SATA		LGM_CLK_PCIE
+
+/* Miscellaneous clocks */
+#define LGM_CLK_EMMC4		46
+#define LGM_CLK_SDIO2		47
+#define LGM_CLK_EMMC		48
+#define LGM_CLK_SDIO		49
+
+
+/* Gate clocks */
+/* Gate CLK0 */
+#define LGM_GCLK_C55		60
+#define LGM_GCLK_VCODEC 	61
+#define LGM_GCLK_QSPI		62
+#define LGM_GCLK_TEP		63
+#define LGM_GCLK_EIP197 	64
+#define LGM_GCLK_VAULT		65
+#define LGM_GCLK_TOE		66
+#define LGM_GCLK_SDXC		67
+#define LGM_GCLK_EMMC		68
+#define LGM_GCLK_EIP154 	69
+#define LGM_GCLK_SPI_DBG	70
+#define LGM_GCLK_DMA3		71
+#define LGM_GCLK_TOPNOC 	72
+
+/* Gate CLK1 */
+#define LGM_GCLK_DMA0		80
+#define LGM_GCLK_LEDC0		81
+#define LGM_GCLK_LEDC1		82
+#define LGM_GCLK_I2S0		83
+#define LGM_GCLK_I2S1		84
+#define LGM_GCLK_EBU		85
+#define LGM_GCLK_I2C0		86
+#define LGM_GCLK_I2C1		87
+#define LGM_GCLK_I2C2		88
+#define LGM_GCLK_I2C3		89
+#define LGM_GCLK_SSC0		90
+#define LGM_GCLK_SSC1		91
+#define LGM_GCLK_SSC2		92
+#define LGM_GCLK_SSC3		93
+#define LGM_GCLK_GPTC0		94
+#define LGM_GCLK_GPTC1		95
+#define LGM_GCLK_GPTC2		96
+#define LGM_GCLK_GPTC3		97
+#define LGM_GCLK_ASC0		98
+#define LGM_GCLK_ASC1		99
+#define LGM_GCLK_ASC2		100
+#define LGM_GCLK_ASC3		101
+#define LGM_GCLK_PCM0		102
+#define LGM_GCLK_PCM1		103
+#define LGM_GCLK_PCM2		104
+#define LGM_GCLK_PERINOC	105
+
+/* Gate CLK2 */
+#define LGM_GCLK_PCIE10 	120
+#define LGM_GCLK_PCIE11 	121
+#define LGM_GCLK_PCIE30 	122
+#define LGM_GCLK_PCIE31 	123
+#define LGM_GCLK_PCIE20 	124
+#define LGM_GCLK_PCIE21 	125
+#define LGM_GCLK_PCIE40 	126
+#define LGM_GCLK_PCIE41 	127
+#define LGM_GCLK_XPCS0		128
+#define LGM_GCLK_XPCS1		129
+#define LGM_GCLK_XPCS2		130
+#define LGM_GCLK_XPCS3		131
+#define LGM_GCLK_SATA0		132
+#define LGM_GCLK_SATA1		133
+#define LGM_GCLK_SATA2		134
+#define LGM_GCLK_SATA3		135
+
+/* Gate CLK3 */
+#define LGM_GCLK_ARCEM4 	140
+#define LGM_GCLK_VPNHOST	141
+#define LGM_GCLK_IDMAR1 	142
+#define LGM_GCLK_IDMAT0 	143
+#define LGM_GCLK_IDMAT1 	144
+#define LGM_GCLK_IDMAT2 	145
+#define LGM_GCLK_PPV4		146
+#define LGM_GCLK_GSWIPO 	147
+#define LGM_GCLK_CQEM		148
+#define LGM_GCLK_PON		149
+#define LGM_GCLK_BM		150
+#define LGM_GCLK_PB		151
+#define LGM_GCLK_XPCS5		152
+#define LGM_GCLK_USB1		153
+#define LGM_GCLK_USB2		154
+
+#define CLK_NR_CLKS		180
+
+#endif /* __INTEL_LGM_CLK_H */
-- 
2.11.0

