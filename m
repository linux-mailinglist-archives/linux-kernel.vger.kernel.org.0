Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AD181DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgCKQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:25:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39989 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbgCKQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:25:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so2825082wme.5;
        Wed, 11 Mar 2020 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g92svwYBuSyg8jgfB1ySNd3KartWFgju0AKQL5BNu30=;
        b=b0RzEB3LUIItSreCToIbiC/rkCpE2jb4oD+C0GmG6jhAcdgWNuq9QCPBt+JayskKHM
         T4elVkDCsK5DKgWsOPXM6Qyg5UK2B/nifMpbkipfYZtCkXuddjLBeVSQsQ0Vv8mKPxvE
         YliMbOO4ppc+hhi/YbhokRy94j+SfZ6/zUH53n4nUVfTAkIW5m53XIUc414LPbmwU086
         XYla6tjKjsyTUzfWNSnRQvVa11/t2qfsIS/4Y1IUATdsyavWHUfXGSJS/TmJKCHggIQl
         wbbheNOmOLiMVZjNKA9sgGFekKMvD3eNBMAgVU5yJBcZwxrvhG+IXDAYRUBR88s/9yTf
         T09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g92svwYBuSyg8jgfB1ySNd3KartWFgju0AKQL5BNu30=;
        b=HStFrtuyLo9USPN/BBFVeotibA6jMd7+dVUiYS2PkMlJ4Yaz1sC6TuS32fb2F8SfAT
         uTXYdv1rsjDDh0bTa1XAJDz/GJrQGHlTTwZJEuugrXXcMX3NetDfo3hlE6q4bohuFUNX
         QRmDGedYJfUSpbIxqBCGfQ6c4R++rWqnVMhQ15f5L4o1PGbCTY5n/Dho8dhgY4WERulF
         PCXoXjUN6ZdujG1zx6tkR98uvdE5ZVztVM0tv1DFAztORobjo3aXI/O1ah/GgV2YyTYT
         2ILhH6J/ScjsPf6y+HyLLbEhhSOucbv5AKOvCMauSJNPc4xpX//+rWnvxt+XQi4SRxUu
         PN0A==
X-Gm-Message-State: ANhLgQ18ZxEMZGRsLIrtdt3fmKFc46H5AYPEO7rwfFmoHeMG73Oe7tc4
        j929QUdd3KpkNFV5rUIVZZ+RWVvh
X-Google-Smtp-Source: ADFU+vvs61AYxW8DEMnQEw8rODfkI0Hq6B1WdiR+aSW/ymhbIQSqukGtGfpeakTg74muhZKWjCshIw==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr4587872wmc.171.1583943932278;
        Wed, 11 Mar 2020 09:25:32 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i1sm53624688wrs.18.2020.03.11.09.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:25:30 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: swap clocks and clock-names values for i2s nodes
Date:   Wed, 11 Mar 2020 17:25:23 +0100
Message-Id: <20200311162524.19748-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'i2s' nodes are manually verified.
In order to automate this process rockchip-i2s.txt
has to be converted to yaml. In the new setup dtbs_check with
rockchip-i2s.yaml expect clocks and clock-names values
in the same order. Fix this for some older Rockchip models.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-i2s.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 12 ++++++------
 arch/arm/boot/dts/rk3188.dtsi  |  4 ++--
 arch/arm/boot/dts/rk3288.dtsi  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 3d1b02f45..f3fc92e57 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -160,10 +160,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 4>, <&dmac1_s 5>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		rockchip,playback-channels = <8>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
@@ -178,10 +178,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
+		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 6>, <&dmac1_s 7>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S1>, <&cru SCLK_I2S1>;
 		rockchip,playback-channels = <2>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
@@ -196,10 +196,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
+		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 9>, <&dmac1_s 10>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S2>, <&cru SCLK_I2S2>;
 		rockchip,playback-channels = <2>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 10ede65d9..651ea4e15 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -170,10 +170,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 6>, <&dmac1_s 7>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		rockchip,playback-channels = <2>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8bcb4a516..f68dcde6c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -964,10 +964,10 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac_bus_s 0>, <&dmac_bus_s 1>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		rockchip,playback-channels = <8>;
-- 
2.11.0

