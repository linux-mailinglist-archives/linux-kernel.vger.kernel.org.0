Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65430180544
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCJRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgCJRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:13 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6996222C3;
        Tue, 10 Mar 2020 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583862432;
        bh=GOx4OHBvG32/cclcjnBNpdMqfGpHrRJvLJMaBmsudos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qt2AfPD5pSEEtyxk692KetnfrHYUOfrynhczQwxVq0/FhgZ/z+cHZkIUaUf9YWSUs
         q6UjCdeF/4XigqzSsjpyfLDD5wF2PoN50Lag8JuwFF81zHVvZqu/bvWN4ytqyBp41a
         CpiATD3FXlngWnL3zTf55p2iY7kuR/I05ie5dI5A=
Received: by wens.tw (Postfix, from userid 1000)
        id 20CDA604FD; Wed, 11 Mar 2020 01:47:10 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: sun8i: r40: Fix register base address for SPI2 and SPI3
Date:   Wed, 11 Mar 2020 01:47:08 +0800
Message-Id: <20200310174709.24174-3-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310174709.24174-1-wens@kernel.org>
References: <20200310174709.24174-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When the SPI device nodes were added, SPI2 and SPI3 had incorrect
register base addresses.

Fix the base address for both of them.

Fixes: 554581b79139 ("ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index b278686d0c22..81cc92ddc78b 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -718,10 +718,10 @@ spi1: spi@1c06000 {
 			#size-cells = <0>;
 		};
 
-		spi2: spi@1c07000 {
+		spi2: spi@1c17000 {
 			compatible = "allwinner,sun8i-r40-spi",
 				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c07000 0x1000>;
+			reg = <0x01c17000 0x1000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
 			clock-names = "ahb", "mod";
@@ -731,10 +731,10 @@ spi2: spi@1c07000 {
 			#size-cells = <0>;
 		};
 
-		spi3: spi@1c0f000 {
+		spi3: spi@1c1f000 {
 			compatible = "allwinner,sun8i-r40-spi",
 				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c0f000 0x1000>;
+			reg = <0x01c1f000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
 			clock-names = "ahb", "mod";
-- 
2.25.1

