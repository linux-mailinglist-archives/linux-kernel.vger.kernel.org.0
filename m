Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC051170741
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBZSJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 13:09:21 -0500
Received: from foss.arm.com ([217.140.110.172]:40464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgBZSJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:09:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8C430E;
        Wed, 26 Feb 2020 10:09:17 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63BA83F881;
        Wed, 26 Feb 2020 10:09:16 -0800 (PST)
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
Subject: [PATCH 03/13] arm: dts: calxeda: Fix interrupt grouping
Date:   Wed, 26 Feb 2020 18:08:51 +0000
Message-Id: <20200226180901.89940-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226180901.89940-1-andre.przywara@arm.com>
References: <20200226180901.89940-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently multiple interrupts for some devices are written as one array
instead of using the DT grouping notation (<0 42 4>, <0 23 4>).
This ends up in the same binary representation in the .dtb, but is
semantically not equivalent. The yaml schema checks will stumble over
this, so lets fix that first.

I refrained from using the symbolic names for GIC_SPI/GIC_PPI and
IRQ_TYPE_LEVEL_HIGH, mostly because it increases the delta between the
original DTS files and the mainline versions, so it's just additional
churn.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/ecx-2000.dts    | 2 +-
 arch/arm/boot/dts/ecx-common.dtsi | 4 ++--
 arch/arm/boot/dts/highbank.dts    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 81eb382b4c23..93cdd020637b 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -92,7 +92,7 @@
 
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
+			interrupts = <0 76 4>, <0 75 4>, <0 74 4>, <0 73 4>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index f819e3328a9e..b7e74a357471 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -202,14 +202,14 @@
 		ethernet@fff50000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff50000 0x1000>;
-			interrupts = <0 77 4  0 78 4  0 79 4>;
+			interrupts = <0 77 4>, <0 78 4>, <0 79 4>;
 			dma-coherent;
 		};
 
 		ethernet@fff51000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff51000 0x1000>;
-			interrupts = <0 80 4  0 81 4  0 82 4>;
+			interrupts = <0 80 4>, <0 81 4>, <0 82 4>;
 			dma-coherent;
 		};
 
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index 9e34d1bd7994..b6b0225a769e 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -142,14 +142,14 @@
 
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
+			interrupts = <0 76 4>, <0 75 4>, <0 74 4>, <0 73 4>;
 		};
 
 
 		sregs@fff3c200 {
 			compatible = "calxeda,hb-sregs-l2-ecc";
 			reg = <0xfff3c200 0x100>;
-			interrupts = <0 71 4  0 72 4>;
+			interrupts = <0 71 4>, <0 72 4>;
 		};
 
 	};
-- 
2.17.1

