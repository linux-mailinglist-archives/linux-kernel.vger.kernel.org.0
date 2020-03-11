Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F5181DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgCKQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:25:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40297 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgCKQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:25:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p2so3436824wrw.7;
        Wed, 11 Mar 2020 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5aBI0bpGlbj4fmQPyekc6UQv8Sa0uaFXtWHR+NmRKk=;
        b=EvmsL8ILi0NHgYAyZfmeO4DevhhIX473PCnA4urmWtc1h95Ilnd5Mx4DFY1OM3aLRO
         8KtsayRDd+nOcl+R98AvLVZUeTY+2OjbEJy+jNWI8g6gt2Cq+7cxvJbwT9g7KfWIj84Q
         LlJFDUhu8gjnwaZ/nz6feBLfsbw0aHfw5kZX6kXoBJmhwcodrVgM07rhZ/YZpkrQ31fS
         w9qZngCpCkDyvrE2ZEIq5lObAOMWtzVN4pqPSyaablhRVW5yW5j5x+Zgl5YQxqOHJPLV
         uksf1t+kGSMGMeQDo8GujRpvUzUaTQq2biVoQxKRpU0qrQVsuHwUOdXbBfonUunXT9Pr
         oYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5aBI0bpGlbj4fmQPyekc6UQv8Sa0uaFXtWHR+NmRKk=;
        b=o9NlRR0aFcFZMiT22Hw1snR18eeUtMncjqJGd4cFrHZkXSmyoIpF0BF6wgUq++unl+
         zuaTtic4NQlRk7/unSshM+E1TX9Ggn40zXTo4Lt2r+txDDl60v3udtES6JGG2YEMFh4s
         slQ/s3ysw51cp7vY9lE/oEiuZtYS6sXpzte90kyqDdrEEKMJaaeLlpChXh1fqAYjfJZ2
         Om49AtWGa+36Sx0nOOqWYNdhBNtJIowbfB7tbKJE9bnjVQCQIZBp+Iv6kbHbffPxx15w
         mP7ZD8FY2F1yKm7bF6llazCjyBqcr8GnzV0002hFsUtnJ22gs7ar740v7sLsuP07Z65H
         2kGg==
X-Gm-Message-State: ANhLgQ3HK1xVVczKaqjveuZGEsu+J/d5qX+D0QY9vePe9lNozuXZSbbX
        ZfF73VL3vFJkforjygV4TntpqKhz
X-Google-Smtp-Source: ADFU+vsC4pAqQ4jiDIDc+T+NrN/+UYkkE5neBBka34GX9ESC0bOwHgGOtUPDD+9haYRT3rQhyjl5JQ==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr5679978wrw.340.1583943933879;
        Wed, 11 Mar 2020 09:25:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i1sm53624688wrs.18.2020.03.11.09.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:25:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: rockchip: remove #address-cells and #size-cells from i2s nodes
Date:   Wed, 11 Mar 2020 17:25:24 +0100
Message-Id: <20200311162524.19748-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200311162524.19748-1-jbx6244@gmail.com>
References: <20200311162524.19748-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental test with the command below gives
for example this error:

arch/arm/boot/dts/rk3036-evb.dt.yaml: i2s@10220000:
'#address-cells', '#size-cells'
do not match any of the regexes: 'pinctrl-[0-9]+'

'#address-cells' and '#size-cells' are not a valid property
for i2s nodes, so remove them.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-i2s.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi  | 2 --
 arch/arm/boot/dts/rk3066a.dtsi | 6 ------
 arch/arm/boot/dts/rk3188.dtsi  | 2 --
 arch/arm/boot/dts/rk322x.dtsi  | 6 ------
 arch/arm/boot/dts/rk3288.dtsi  | 2 --
 5 files changed, 18 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 2226f0d70..781ac7583 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -281,8 +281,6 @@
 		compatible = "rockchip,rk3036-i2s", "rockchip,rk3066-i2s";
 		reg = <0x10220000 0x4000>;
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S>, <&cru HCLK_I2S>;
 		dmas = <&pdma 0>, <&pdma 1>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index f3fc92e57..b599394d1 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -156,8 +156,6 @@
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x10118000 0x2000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
@@ -174,8 +172,6 @@
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x1011a000 0x2000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
 		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1>;
@@ -192,8 +188,6 @@
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x1011c000 0x2000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
 		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 651ea4e15..24abf214a 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -166,8 +166,6 @@
 		compatible = "rockchip,rk3188-i2s", "rockchip,rk3066-i2s";
 		reg = <0x1011a000 0x2000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 8ad44213f..a0acf2ef8 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -152,8 +152,6 @@
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100b0000 0x4000>;
 		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1_8CH>;
 		dmas = <&pdma 14>, <&pdma 15>;
@@ -167,8 +165,6 @@
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100c0000 0x4000>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
 		dmas = <&pdma 11>, <&pdma 12>;
@@ -193,8 +189,6 @@
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100e0000 0x4000>;
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2_2CH>;
 		dmas = <&pdma 0>, <&pdma 1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f68dcde6c..4745be518 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -962,8 +962,6 @@
 		reg = <0x0 0xff890000 0x0 0x10000>;
 		#sound-dai-cells = <0>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac_bus_s 0>, <&dmac_bus_s 1>;
-- 
2.11.0

