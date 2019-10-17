Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC9DB75A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407161AbfJQTVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 15:21:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:22068 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfJQTVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:21:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 12:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="397690533"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 17 Oct 2019 12:21:06 -0700
From:   richard.gong@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] arm64: dts: agilex: add service layer, fpga manager and fpga region
Date:   Thu, 17 Oct 2019 14:34:40 -0500
Message-Id: <1571340880-18421-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add service layer, fpga manager and fpga region to the device tree
on Intel Agilex platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 36abc25..94090c6 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -12,6 +12,19 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer@0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x1000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -81,6 +94,13 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
+		base_fpga_region {
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			compatible = "fpga-region";
+			fpga-mgr = <&fpga_mgr>;
+		};
+
 		gmac0: ethernet@ff800000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff800000 0x2000>;
@@ -442,5 +462,17 @@
 
 			status = "disabled";
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,stratix10-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+
+				fpga_mgr: fpga-mgr {
+					compatible = "intel,stratix10-soc-fpga-mgr";
+				};
+			};
+		};
 	};
 };
-- 
2.7.4

