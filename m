Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2917D4BD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCHQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 12:32:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCHQcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79F1FB2F7;
        Sun,  8 Mar 2020 16:32:51 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC 11/11] ARM: dts: sp7021-cpu: Add dummy UART0 clock and interrupt
Date:   Sun,  8 Mar 2020 17:32:29 +0100
Message-Id: <20200308163230.4002-12-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts | 7 +++++++
 arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi    | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts b/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
index 3c25b6e79fe2..455416ce9d82 100644
--- a/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
+++ b/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
@@ -15,8 +15,15 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	uart0_clk: clk {
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		#clock-cells = <0>;
+	};
 };
 
 &uart0 {
 	status = "okay";
+	clocks = <&uart0_clk>;
 };
diff --git a/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi b/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
index 7e424baa9214..48c5986a31ed 100644
--- a/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
+++ b/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
@@ -86,3 +86,8 @@
 		#interrupt-cells = <2>;
 	};
 };
+
+&uart0 {
+	interrupt-parent = <&intc>;
+	interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.16.4

