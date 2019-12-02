Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E551510EF23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfLBSWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 13:22:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:35998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbfLBSWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D690AEFB;
        Mon,  2 Dec 2019 18:22:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 12/14] arm64: dts: realtek: rtd139x: Add SB2 and SCPU Wrapper syscon nodes
Date:   Mon,  2 Dec 2019 19:22:02 +0100
Message-Id: <20191202182205.14629-13-afaerber@suse.de>
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

Add syscon mfd nodes for SB2 and SCPU Wrapper to RTD139x DT.

Cc: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd139x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd139x.dtsi b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
index 3a571f3b7e38..a3c10ceeb586 100644
--- a/arch/arm64/boot/dts/realtek/rtd139x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
@@ -79,6 +79,15 @@
 				ranges = <0x0 0x7000 0x1000>;
 			};
 
+			sb2: syscon@1a000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1a000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1a000 0x1000>;
+			};
+
 			misc: syscon@1b000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x1b000 0x1000>;
@@ -87,6 +96,15 @@
 				#size-cells = <1>;
 				ranges = <0x0 0x1b000 0x1000>;
 			};
+
+			scpu_wrapper: syscon@1d000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1d000 0x2000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1d000 0x2000>;
+			};
 		};
 
 		gic: interrupt-controller@ff011000 {
-- 
2.16.4

