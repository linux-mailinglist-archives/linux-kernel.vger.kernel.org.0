Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4360512F57D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 09:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgACIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 03:30:29 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6568 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgACIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:30:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0efb930000>; Fri, 03 Jan 2020 00:30:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:30:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:30:26 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:30:26 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:30:25 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0efba00005>; Fri, 03 Jan 2020 00:30:25 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v1 2/2] arm64: tegra: Add fuse/apbmisc node on Tegra194
Date:   Fri, 3 Jan 2020 16:30:18 +0800
Message-ID: <20200103083018.10575-3-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103083018.10575-1-jckuo@nvidia.com>
References: <20200103083018.10575-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578040211; bh=8Y2BijVcIEM5KZxyDPUnXjgOr5Qx+yudf7guW4l5b1o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PKBXj69SXQxleu1Mmu0a1WuLR1DTnOl2y8tbOYeaZQoKrasqeZybmdoAfiqjYpK47
         jIlVTwDCkqltqiviMp1TbU4/g9/cuU4hmaUY2vLDLI90/Tzb9Hz/qixjc9bn72yTiE
         PyM4tvtHpJIgbtBl6CTl/ZTOX5cgew9JlGXm+XoE4w8jv9x2dO3qHCFe9eRK7Ggy2h
         SbHwp1Ql7M3X2ueCMdX227r7EKir83jgwpvK68tvYbM/+/YCAK76NvyfqTchcVcW6h
         VJVdVCdeJG8lvtfarfbHAFA517YqBiYjcmxWecnhlGvvjSds9CWkbk38WUyVtJRxGi
         Wm9MAOutXYKxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds Tegra194 fuse and apbmisc device nodes.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 495f692e6a0b..f336bc3e195a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -21,6 +21,12 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		misc@100000 {
+			compatible = "nvidia,tegra194-misc";
+			reg = <0x00100000 0xf000>,
+			      <0x0010f000 0x1000>;
+		};
+
 		gpio: gpio@2200000 {
 			compatible = "nvidia,tegra194-gpio";
 			reg-names = "security", "gpio";
@@ -627,6 +633,13 @@
 			status = "disabled";
 		};
 
+		fuse@3820000 {
+			compatible = "nvidia,tegra194-efuse";
+			reg = <0x03820000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_FUSE>;
+			clock-names = "fuse";
+		};
+
 		gic: interrupt-controller@3881000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.17.1

