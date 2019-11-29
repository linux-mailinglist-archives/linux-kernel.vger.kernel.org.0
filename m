Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3066010D30C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 10:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfK2JOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 04:14:10 -0500
Received: from olimex.com ([184.105.72.32]:49778 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfK2JOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:14:09 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 01:14:04 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 2/3] arm64: dts: allwinner: a64: olinuxino: Add bank supply regulators
Date:   Fri, 29 Nov 2019 11:13:35 +0200
Message-Id: <20191129091336.13104-3-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129091336.13104-1-stefan@olimex.com>
References: <20191129091336.13104-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 SoC has separate supplies for PC, PD, PE, PG and PL. This
patch adds regulators for them to the pinctrl node.

Exception is PL which is used by the RSB bus. To avoid circular
dependencies, VCC-PL is omitted.

On boards with eMMC, VCC-PC is supplied by ELDO1, instead of DCDC1.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 .../dts/allwinner/sun50i-a64-olinuxino-emmc.dts  |  4 ++++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts  | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
index 7d135decbd53..75f101d9cd3e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
@@ -21,3 +21,7 @@
 	cap-mmc-hw-reset;
 	status = "okay";
 };
+
+&pio {
+	vcc-pc-supply = <&reg_eldo1>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 01a9a52edae4..ad3559c576dd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -163,6 +163,22 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_dcdc1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_aldo1>;
+	vcc-pg-supply = <&reg_dldo4>;
+};
+
+&r_pio {
+	/**
+	 * Do not add vcc-pl-supply, since PL0 and PL1 are used
+	 * by the RSB bus.
+	 *
+	 * vcc-pl-supply = <&reg_aldo2>;
+	 */
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.17.1

