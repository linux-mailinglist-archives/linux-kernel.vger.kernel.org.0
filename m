Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB91519C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 12:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBDLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 06:20:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14286 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgBDLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:20:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3953280001>; Tue, 04 Feb 2020 03:19:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:20:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 03:20:01 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:20:00 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:19:59 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e39535c0000>; Tue, 04 Feb 2020 03:19:59 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 18/19] arm64: tegra: Enable xudc node on Jetson TX2
Date:   Tue, 4 Feb 2020 16:47:04 +0530
Message-ID: <1580815025-10915-19-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815144; bh=lm0DXX9SoyMPuI/zAeIShf/kuUssinRZRxQSZdiRP5Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cnF2nSbATj2971NveyW2OVeZSr5BACFUWBaeed4WHPkyAi6I0R+K94GgChWLPWlMq
         DU6BmjC7omO9n3q4UUmteSDTLA5MjGdt90+PAbgr4NQEQf/bZ0ax8IXHg4lrPa6G2a
         ylq6zD1T1EemAG3C3pLLOKCte6oxri2uAOpP+k0Yrqro2ogmbBLQDrcSLrmimzS2Ch
         ah83weQq8t5EDt11GXMJ87LIw1caqbiFJtNV95Fmkfpy0yPygpF+1CJOiJlOQ9lsdj
         LjgQt5ZEfJvdyJDF2PUxuv4Ll/r2Z7g6VFwKn4QCYBkL+EdW8Y25DUq/8a2ZYnzc15
         uZ7wKszRTHGdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XUSB device mode driver for USB 2-0 slot on Jetson TX2.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2-V4:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index a1dcdb9..d7628f5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -131,7 +131,7 @@
 				status = "okay";
 
 				lanes {
-					usb2-0 {
+					micro_b: usb2-0 {
 						nvidia,function = "xusb";
 						status = "okay";
 					};
@@ -213,6 +213,13 @@
 		phy-names = "usb2-0", "usb2-1", "usb3-0";
 	};
 
+	usb@3550000 {
+		status = "okay";
+
+		phys = <&micro_b>;
+		phy-names = "usb2-0";
+	};
+
 	i2c@c250000 {
 		/* carrier board ID EEPROM */
 		eeprom@57 {
-- 
2.7.4

