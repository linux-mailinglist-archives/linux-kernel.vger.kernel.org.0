Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74342116FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfLIOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 09:53:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46586 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfLIOxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:53:13 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ieKPN-0001Ca-Pw; Mon, 09 Dec 2019 15:53:09 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: hook up the px30-evb dsi display
Date:   Mon,  9 Dec 2019 15:53:01 +0100
Message-Id: <20191209145301.5307-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209145301.5307-1-heiko@sntech.de>
References: <20191209145301.5307-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Create the necessary display nodes to activate the Xingpeng XPP055C272
dsi display that can be found on the px30-evb.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 180995a590c1..0a680257d9c2 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -112,6 +112,38 @@ &display_subsystem {
 	status = "okay";
 };
 
+&dsi {
+	status = "okay";
+
+	ports {
+		mipi_out: port@1 {
+			reg = <1>;
+
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
+	};
+
+	panel@0 {
+		compatible = "xinpeng,xpp055c272";
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc_1v8>;
+		vci-supply = <&vcc3v3_lcd>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_dphy {
+	status = "okay";
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
2.24.0

