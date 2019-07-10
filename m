Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC06564741
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfGJNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 09:44:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47465 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGJNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:15 -0400
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6B1B9200017;
        Wed, 10 Jul 2019 13:44:11 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v7 1/6] dt-bindings: ap806: add the cluster clock node in the syscon file
Date:   Wed, 10 Jul 2019 15:43:41 +0200
Message-Id: <20190710134346.30239-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710134346.30239-1-gregory.clement@bootlin.com>
References: <20190710134346.30239-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device tree binding for the cluster clock controllers found
in the Armada 7K/8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../arm/marvell/ap806-system-controller.txt   | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 7b8b8eb0191f..4f21c1024073 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -21,8 +21,8 @@ Clocks:
 The Device Tree node representing the AP806 system controller provides
 a number of clocks:
 
- - 0: clock of CPU cluster 0
- - 1: clock of CPU cluster 1
+ - 0: reference clock of CPU cluster 0
+ - 1: reference clock of CPU cluster 1
  - 2: fixed PLL at 1200 Mhz
  - 3: MSS clock, derived from the fixed PLL
 
@@ -143,3 +143,30 @@ ap_syscon1: system-controller@6f8000 {
 		#thermal-sensor-cells = <1>;
 	};
 };
+
+Cluster clocks:
+---------------
+
+Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
+cluster contain up to 2 CPUs running at the same frequency.
+
+Required properties:
+- compatible: must be  "marvell,ap806-cpu-clock";
+- #clock-cells : should be set to 1.
+
+- clocks : shall be the input parent clock(s) phandle for the clock
+           (one per cluster)
+
+- reg: register range associated with the cluster clocks
+
+ap_syscon1: system-controller@6f8000 {
+	compatible = "marvell,armada-ap806-syscon1", "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	cpu_clk: clock-cpu@278 {
+		compatible = "marvell,ap806-cpu-clock";
+		clocks = <&ap_clk 0>, <&ap_clk 1>;
+		#clock-cells = <1>;
+		reg = <0x278 0xa30>;
+	};
+};
-- 
2.20.1

