Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4343C07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfFMPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:33:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4692 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfFMKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:41:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02285a0000>; Thu, 13 Jun 2019 03:41:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 03:41:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 03:41:30 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:41:30 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:41:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 13 Jun 2019 10:41:29 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0228570000>; Thu, 13 Jun 2019 03:41:29 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v5 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
Date:   Thu, 13 Jun 2019 16:11:16 +0530
Message-ID: <1560422477-11242-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560422490; bh=cOJX5hfv8uGUxCWBjGx50IGoRT5V5NnF5v3cAnHJXNo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=MN/1+jsmXNCVpeaH5cIMkk3UgD9VeQmTX1j+k1fhfCACR+Qf8iiLLkEL6XtmQzmjp
         cO+ZywnZbQp8v/PrX5I7Nd+q9wfKSeIeqJJvHQKBlQUH3dcvECJTocKUMssRoxh+AD
         amqQithB74eBNN/qXlQB2VwoyJMoM8lomjfcmrmRzveqIQl/FhKpE9p9GUF0EjyAY9
         +I0ahDUh64TrBYPOJ7kx0FZcEyEyTFLa8IHYuFsr2q6Y0wWjhsPir5aCXOv/wgCgKL
         iWgKdzhea8l/RB1vXuM5Ox68C4nDysBWsGaUGs/ersqbgctIHRnoWdX8ftmoAtqPOb
         LHrehJjnwYXUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for following devices on Tegra186 and Tegra194
 * ACONNECT
 * ADMA
 * AGIC

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 changes from previous revision
  * fixed size value for ranges property in aconnect

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 426ac0b..5e9fe7e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1295,4 +1295,71 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	aconnect {
+		compatible = "nvidia,tegra210-aconnect";
+		clocks = <&bpmp TEGRA186_CLK_APE>,
+			 <&bpmp TEGRA186_CLK_APB2APE>;
+		clock-names = "ape", "apb2ape";
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x02900000 0x0 0x02900000 0x200000>;
+		status = "disabled";
+
+		dma-controller@2930000 {
+			compatible = "nvidia,tegra186-adma";
+			reg = <0x02930000 0x50000>;
+			interrupt-parent = <&agic>;
+			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&bpmp TEGRA186_CLK_AHUB>;
+			clock-names = "d_audio";
+			status = "disabled";
+		};
+
+		agic: interrupt-controller@2a41000 {
+			compatible = "nvidia,tegra210-agic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x02a41000 0x1000>,
+			      <0x02a42000 0x2000>;
+			interrupts = <GIC_SPI 145
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&bpmp TEGRA186_CLK_APE>;
+			clock-names = "clk";
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c77ca21..a60ed5f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1054,4 +1054,71 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	aconnect {
+		compatible = "nvidia,tegra210-aconnect";
+		clocks = <&bpmp TEGRA194_CLK_APE>,
+			 <&bpmp TEGRA194_CLK_APB2APE>;
+		clock-names = "ape", "apb2ape";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_AUD>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x02900000 0x0 0x02900000 0x200000>;
+		status = "disabled";
+
+		dma-controller@2930000 {
+			compatible = "nvidia,tegra186-adma";
+			reg = <0x02930000 0x50000>;
+			interrupt-parent = <&agic>;
+			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&bpmp TEGRA194_CLK_AHUB>;
+			clock-names = "d_audio";
+			status = "disabled";
+		};
+
+		agic: interrupt-controller@2a41000 {
+			compatible = "nvidia,tegra210-agic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x02a41000 0x1000>,
+			      <0x02a42000 0x2000>;
+			interrupts = <GIC_SPI 145
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&bpmp TEGRA194_CLK_APE>;
+			clock-names = "clk";
+			status = "disabled";
+		};
+	};
 };
-- 
2.7.4

