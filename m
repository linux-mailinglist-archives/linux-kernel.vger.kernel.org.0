Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159C4FF853
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 08:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfKQHVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 02:21:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:40812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfKQHVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:21:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41726B315;
        Sun, 17 Nov 2019 07:21:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 7/8] ARM: dts: rtd1195: Add UART resets
Date:   Sun, 17 Nov 2019 08:21:08 +0100
Message-Id: <20191117072109.20402-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191117072109.20402-1-afaerber@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Associate the UART nodes with the corresponding reset controller bits.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3: from RTD1295 reset v2
 * Rebased onto r-bus
 
 arch/arm/boot/dts/rtd1195.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index e0f133a1354f..4eec45244132 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -8,6 +8,7 @@
 /memreserve/ 0x17fff000 0x00001000;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/realtek,rtd1195.h>
 
 / {
 	compatible = "realtek,rtd1195";
@@ -134,6 +135,7 @@
 				reg = <0x7800 0x400>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
+				resets = <&iso_reset RTD1195_ISO_RSTN_UR0>;
 				clock-frequency = <27000000>;
 				status = "disabled";
 			};
@@ -143,6 +145,7 @@
 				reg = <0x1b200 0x100>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
+				resets = <&reset2 RTD1195_RSTN_UR1>;
 				clock-frequency = <27000000>;
 				status = "disabled";
 			};
-- 
2.16.4

