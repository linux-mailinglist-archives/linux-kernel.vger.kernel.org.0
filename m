Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49A10EF30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 19:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfLBSW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 13:22:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbfLBSWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5A72AEE1;
        Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 08/14] ARM: dts: rtd1195: Add UART resets
Date:   Mon,  2 Dec 2019 19:21:58 +0100
Message-Id: <20191202182205.14629-9-afaerber@suse.de>
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

Associate the UART nodes with the corresponding reset controller bits.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1: From RTD1195 v4 series
 
 arch/arm/boot/dts/rtd1195.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index 886845e52205..09acb99083c1 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -8,6 +8,7 @@
 /memreserve/ 0x17fff000 0x00001000;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/realtek,rtd1195.h>
 
 / {
 	compatible = "realtek,rtd1195";
@@ -179,6 +180,7 @@
 		reg = <0x800 0x400>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		resets = <&iso_reset RTD1195_ISO_RSTN_UR0>;
 		clock-frequency = <27000000>;
 		status = "disabled";
 	};
@@ -190,6 +192,7 @@
 		reg = <0x200 0x100>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		resets = <&reset2 RTD1195_RSTN_UR1>;
 		clock-frequency = <27000000>;
 		status = "disabled";
 	};
-- 
2.16.4

