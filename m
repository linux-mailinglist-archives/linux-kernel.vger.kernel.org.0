Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4732290
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFBIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 04:01:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfFBIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:01:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so9150608wrq.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1tMVKDcnY0AsHYQC7kH5mkhPScubjTBOZaBll4fZ84=;
        b=RcomYFUrLr/l27vnVlMJp72OCI/et7lAHiS3fDLxdE1sW8e/X3XzhbiR8MrI57+5ME
         VDdWzLUKf5EcLRsFZ2+Lfzy+EF3V4/FHmmZSzZ5/7pNpG1etKOymJgmcvwQUtN0dF/N3
         LZzzF6fwDdt6Ybij9IEUYHrjY7F9u+XuOrSlWuMXN1zH7h3CgfHemPlkuBL9xw+HqPld
         +nuJDxg5fiMOoWNyNW7FPoFCHYscscGzr5a/eX/3qGWldJJsxc1uLVZjoZ4eaTOLG4Qd
         TciNLMOoYeBUPP6nMNZL8J6Iipjbvy6B09Y70Teubb+Rf1qOn8DywXmIMw4DTKR0SwcF
         x63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1tMVKDcnY0AsHYQC7kH5mkhPScubjTBOZaBll4fZ84=;
        b=RYQ1J46rI/qykgDYYtZEMv3dlhPclS0gx8vFqrJqmKvcaEiCBupfUl9CkAEDUgTanW
         YvJoAnsSp4zdzuwUtXy8P+PtrTGsv0dxoBbsEWv2gDCS1ABjqv50UMatJb86ad9HQDU6
         A3ldnNyYm1tkeMc6hPFOTap/B1slwSk/zGGn0afrTTe/hgW5mw5n53tU2OBe/+rDUSdG
         wopOcpjCaCY2LEYkF9M90SZyYSMdJk5nKIuF6lIVXSTW2Hrub1jfGRm9MaJH/GLqNmMj
         BT3VCofREQ0gugvri+LxFQhTjVyC32kKzyV0cnisH/2ARMFQWX9wuZ1f6fQEz6sJa/ef
         uA8Q==
X-Gm-Message-State: APjAAAXyO7trRwzMKg+q6BN3zhwtWP29mikVyxkcFmwNag0yx3BE0imC
        Ns2u2Bdn4MCcyE+HdnfTg/OTnFGsdgY=
X-Google-Smtp-Source: APXvYqwIMtsSCpvMaxuHTz6S7V9i+3lNKsJpXaHeRtN3Q/udjqaEWATcy2WAYd5D7eTPWNpTR5DVfA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr12093267wrq.148.1559462496502;
        Sun, 02 Jun 2019 01:01:36 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id y133sm4868583wmg.5.2019.06.02.01.01.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:01:36 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        ShihPo Hung <shihpo.hung@sifive.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/5] riscv: dts: add initial support for the SiFive FU540-C000 SoC
Date:   Sun,  2 Jun 2019 01:01:25 -0700
Message-Id: <20190602080126.31075-5-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080126.31075-1-paul.walmsley@sifive.com>
References: <20190602080126.31075-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the SiFive FU540-C000 SoC.  This is a 28nm SoC
based around the SiFive U54-MC core complex and a TileLink
interconnect.

This file is expected to grow as more device drivers are added to the
kernel.

This patch includes a fix to the QSPI memory map due to a
documentation bug, found by ShihPo Hung <shihpo.hung@sifive.com>, adds
entries for the I2C controller, and merges all DT changes that
formerly were made dynamically by the riscv-pk BBL proxy kernel.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: ShihPo Hung <shihpo.hung@sifive.com>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 215 +++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
new file mode 100644
index 000000000000..3c06ee4b2b29
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2018-2019 SiFive, Inc */
+
+/dts-v1/;
+
+#include <dt-bindings/clock/sifive-fu540-prci.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "sifive,fu540-c000", "sifive,fu540";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <1000000>;
+		cpu0: cpu@0 {
+			compatible = "sifive,e51", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <16384>;
+			reg = <0>;
+			riscv,isa = "rv64imac";
+			status = "disabled";
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu1: cpu@1 {
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <1>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			cpu1_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu2: cpu@2 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <2>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			cpu2_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu3: cpu@3 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <3>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			cpu3_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu4: cpu@4 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <4>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			cpu4_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "sifive,fu540-c000", "sifive,fu540", "simple-bus";
+		ranges;
+		plic0: interrupt-controller@c000000 {
+			#interrupt-cells = <1>;
+			compatible = "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			riscv,ndev = <53>;
+			interrupt-controller;
+			interrupts-extended = <
+				&cpu0_intc 0xffffffff
+				&cpu1_intc 0xffffffff &cpu1_intc 9
+				&cpu2_intc 0xffffffff &cpu2_intc 9
+				&cpu3_intc 0xffffffff &cpu3_intc 9
+				&cpu4_intc 0xffffffff &cpu4_intc 9>;
+		};
+		prci: clock-controller@10000000 {
+			compatible = "sifive,fu540-c000-prci";
+			reg = <0x0 0x10000000 0x0 0x1000>;
+			clocks = <&hfclk>, <&rtcclk>;
+			#clock-cells = <1>;
+		};
+		uart0: serial@10010000 {
+			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+			reg = <0x0 0x10010000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <4>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+		};
+		uart1: serial@10011000 {
+			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+			reg = <0x0 0x10011000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <5>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+		};
+		i2c0: i2c@10030000 {
+			compatible = "sifive,fu540-c000-i2c", "sifive,i2c0";
+			reg = <0x0 0x10030000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <50>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		qspi0: spi@10040000 {
+			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+			reg = <0x0 0x10040000 0x0 0x1000
+			       0x0 0x20000000 0x0 0x10000000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <51>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		qspi1: spi@10041000 {
+			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+			reg = <0x0 0x10041000 0x0 0x1000
+			       0x0 0x30000000 0x0 0x10000000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <52>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		qspi2: spi@10050000 {
+			compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+			reg = <0x0 0x10050000 0x0 0x1000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <6>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
-- 
2.20.1

