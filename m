Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6CF144722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAUWVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:21:10 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35644 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbgAUWVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:21:10 -0500
Received: from mail.linser.at ([80.109.168.170] helo=phil.Hitronhub.home)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iu1tT-0005o8-EX; Tue, 21 Jan 2020 23:21:07 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: fix px30 lvds ports
Date:   Tue, 21 Jan 2020 23:20:55 +0100
Message-Id: <20200121222055.4068166-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121222055.4068166-1-heiko@sntech.de>
References: <20200121222055.4068166-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The lvds controller has two ports. port@0 for the connection
to the display controller(s) and port@1 for the connection to
the panel, so should have a ports node covering the port@x nodes.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 9b1c92132007..37e014444214 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -421,19 +421,24 @@ lvds: lvds {
 			rockchip,output = "lvds";
 			status = "disabled";
 
-			port@0 {
-				reg = <0>;
+			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				lvds_vopb_in: endpoint@0 {
+				port@0 {
 					reg = <0>;
-					remote-endpoint = <&vopb_out_lvds>;
-				};
-
-				lvds_vopl_in: endpoint@1 {
-					reg = <1>;
-					remote-endpoint = <&vopl_out_lvds>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					lvds_vopb_in: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&vopb_out_lvds>;
+					};
+
+					lvds_vopl_in: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&vopl_out_lvds>;
+					};
 				};
 			};
 		};
-- 
2.24.1

