Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9B1738F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgB1Nvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:51:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1Nvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:51:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9116FEC;
        Fri, 28 Feb 2020 05:51:42 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 150CF3F7B4;
        Fri, 28 Feb 2020 05:51:40 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 1/5] arm: dts: calxeda: Basic DT file fixes
Date:   Fri, 28 Feb 2020 13:51:02 +0000
Message-Id: <20200228135106.220620-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228135106.220620-1-andre.przywara@arm.com>
References: <20200228135106.220620-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .dts files for the Calxeda machines are quite old, so carry some
sloppy mistakes that the DT schema checker will complain about.

Fix those issues, they should not have any effect on functionality.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/ecx-2000.dts | 4 +---
 arch/arm/boot/dts/highbank.dts | 7 ++-----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 5651ae6dc969..8e0489607704 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -13,7 +13,6 @@
 	compatible = "calxeda,ecx-2000";
 	#address-cells = <2>;
 	#size-cells = <2>;
-	clock-ranges;
 
 	cpus {
 		#address-cells = <1>;
@@ -83,8 +82,7 @@
 		intc: interrupt-controller@fff11000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
-			#size-cells = <0>;
-			#address-cells = <1>;
+			#address-cells = <0>;
 			interrupt-controller;
 			interrupts = <1 9 0xf04>;
 			reg = <0xfff11000 0x1000>,
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index f4e4dca6f7e7..9e34d1bd7994 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -13,7 +13,6 @@
 	compatible = "calxeda,highbank";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	clock-ranges;
 
 	cpus {
 		#address-cells = <1>;
@@ -96,7 +95,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x00000000 0xff900000>;
@@ -128,14 +127,12 @@
 		intc: interrupt-controller@fff11000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
-			#size-cells = <0>;
-			#address-cells = <1>;
 			interrupt-controller;
 			reg = <0xfff11000 0x1000>,
 			      <0xfff10100 0x100>;
 		};
 
-		L2: l2-cache {
+		L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0xfff12000 0x1000>;
 			interrupts = <0 70 4>;
-- 
2.17.1

