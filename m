Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DCE10EF2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 19:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfLBSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 13:22:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbfLBSWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4321AEF5;
        Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 07/14] ARM: dts: rtd1195: Add reset nodes
Date:   Mon,  2 Dec 2019 19:21:57 +0100
Message-Id: <20191202182205.14629-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202182205.14629-1-afaerber@suse.de>
References: <20191202182205.14629-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller nodes for Realtek RTD1195 SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1: From RTD1195 v4 series (James wants to change the compatible string)
 
 arch/arm/boot/dts/rtd1195.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index ac37366ff7c4..886845e52205 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -141,7 +141,33 @@
 	};
 };
 
+&crt {
+	reset1: reset-controller@0 {
+		compatible = "snps,dw-low-reset";
+		reg = <0x0 0x4>;
+		#reset-cells = <1>;
+	};
+
+	reset2: reset-controller@4 {
+		compatible = "snps,dw-low-reset";
+		reg = <0x4 0x4>;
+		#reset-cells = <1>;
+	};
+
+	reset3: reset-controller@8 {
+		compatible = "snps,dw-low-reset";
+		reg = <0x8 0x4>;
+		#reset-cells = <1>;
+	};
+};
+
 &iso {
+	iso_reset: reset-controller@88 {
+		compatible = "snps,dw-low-reset";
+		reg = <0x88 0x4>;
+		#reset-cells = <1>;
+	};
+
 	wdt: watchdog@680 {
 		compatible = "realtek,rtd1295-watchdog";
 		reg = <0x680 0x100>;
-- 
2.16.4

