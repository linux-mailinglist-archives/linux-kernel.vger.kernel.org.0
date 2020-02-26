Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989D7170724
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 19:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgBZSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 13:09:17 -0500
Received: from foss.arm.com ([217.140.110.172]:40436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgBZSJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:09:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 695EC31B;
        Wed, 26 Feb 2020 10:09:14 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7ABD3F881;
        Wed, 26 Feb 2020 10:09:12 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 01/13] arm: dts: calxeda: Basic DT file fixes
Date:   Wed, 26 Feb 2020 18:08:49 +0000
Message-Id: <20200226180901.89940-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226180901.89940-1-andre.przywara@arm.com>
References: <20200226180901.89940-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .dts files for the Calxeda machines are quite old, so carry some
sloppy mistakes that the DT schema checker will complain about.

Fix those issues, they should not have any effect on functionality.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/ecx-2000.dts | 3 ---
 arch/arm/boot/dts/highbank.dts | 7 ++-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 5651ae6dc969..81eb382b4c23 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -13,7 +13,6 @@
 	compatible = "calxeda,ecx-2000";
 	#address-cells = <2>;
 	#size-cells = <2>;
-	clock-ranges;
 
 	cpus {
 		#address-cells = <1>;
@@ -83,8 +82,6 @@
 		intc: interrupt-controller@fff11000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
-			#size-cells = <0>;
-			#address-cells = <1>;
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

