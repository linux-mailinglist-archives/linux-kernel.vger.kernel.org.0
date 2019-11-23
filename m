Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08C3108068
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKWUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 15:38:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbfKWUiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:38:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E5C9B135;
        Sat, 23 Nov 2019 20:38:11 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 5/8] ARM: dts: rtd1195: Introduce r-bus
Date:   Sat, 23 Nov 2019 21:37:56 +0100
Message-Id: <20191123203759.20708-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191123203759.20708-1-afaerber@suse.de>
References: <20191123203759.20708-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Model Realtek's register bus in DT.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v3: from RTD1395 v1
 * Fixed r-bus size from 0x100000 to 0x70000 in reg and ranges (James)
 * Renamed bus node from r-bus to bus (Rob)
 
 arch/arm/boot/dts/rtd1195.dtsi | 52 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index 0d7c2be750f6..a8f7b9caacba 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -93,28 +93,36 @@
 			 <0x18100000 0x18100000 0x01000000>,
 			 <0x80000000 0x80000000 0x80000000>;
 
-		wdt: watchdog@18007680 {
-			compatible = "realtek,rtd1295-watchdog";
-			reg = <0x18007680 0x100>;
-			clocks = <&osc27M>;
-		};
-
-		uart0: serial@18007800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x18007800 0x400>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <27000000>;
-			status = "disabled";
-		};
-
-		uart1: serial@1801b200 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x1801b200 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <27000000>;
-			status = "disabled";
+		rbus: bus@18000000 {
+			compatible = "simple-bus";
+			reg = <0x18000000 0x70000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x18000000 0x70000>;
+
+			wdt: watchdog@7680 {
+				compatible = "realtek,rtd1295-watchdog";
+				reg = <0x7680 0x100>;
+				clocks = <&osc27M>;
+			};
+
+			uart0: serial@7800 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x7800 0x400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <27000000>;
+				status = "disabled";
+			};
+
+			uart1: serial@1b200 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x1b200 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <27000000>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ff011000 {
-- 
2.16.4

