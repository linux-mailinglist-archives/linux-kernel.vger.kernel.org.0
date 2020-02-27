Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A1817178E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgB0MiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:38:11 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:40138 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgB0MiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:38:11 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01RCbb6U019114;
        Thu, 27 Feb 2020 21:37:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01RCbb6U019114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582807057;
        bh=OfBqph3sclJ76L08S3946c2Ab+KCXHqtiVA7HkK9BFE=;
        h=From:To:Cc:Subject:Date:From;
        b=JeS4J17PgWBPIUM4+qnMqoRLn0+3vj7iqACMn6BnXwYD+uQESrarxrHetq2mEFtCP
         P1qMcqqS0uu+9zvZh1DzGTZNmuM3OI559uymLfWxN9C7ut7yIJdpQCLhfjW015GY+Q
         ZYh80f+cPASB1amYBWVOVnIGzh/7d/Xwh0LqB6dN0B/wRbc0UliN2fHTFP0PkoguGX
         PUSVREG2rpYhZmtcUEhv7ek9f5V22oYrusGvlx4QeeRhohwmw8+/f0/WEbyA+Wgi23
         U/XR1uCeP41JbkBWxgirkfSuWoSnaNa26lMe1Ti1HV+KPDInysyX3x5QkTzq0cwhmI
         G2Vvhc1+8503g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: uniphier: rename cache controller nodes to follow json-schema
Date:   Thu, 27 Feb 2020 21:37:26 +0900
Message-Id: <20200227123726.12910-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the standard nodename pattern
"^(cache-controller|cpu)(@[0-9a-f,]+)*$" defined in
schemas/cache-controller.yaml of dt-schema.

Otherwise, after the dt-binding is converted to json-schema,
'make ARCH=arm dtbs_check' will show a warning like this:

  l2-cache@500c0000: $nodename:0: 'l2-cache@500c0000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 197bee7d8b7f..06e7400d2940 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -51,7 +51,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		l2: l2-cache@500c0000 {
+		l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
 			      <0x506c0000 0x400>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index b02bc8a6346b..1c866f0306fc 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -59,7 +59,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		l2: l2-cache@500c0000 {
+		l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
 			      <0x506c0000 0x400>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index f84a43a10f38..da772429b55a 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -131,7 +131,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		l2: l2-cache@500c0000 {
+		l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
 			      <0x506c0000 0x400>;
@@ -144,7 +144,7 @@
 			next-level-cache = <&l3>;
 		};
 
-		l3: l3-cache@500c8000 {
+		l3: cache-controller@500c8000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
 			      <0x506c8000 0x400>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 989b2a241822..7044f8700cb2 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -157,7 +157,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		l2: l2-cache@500c0000 {
+		l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
 			      <0x506c0000 0x400>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index fbfd25050a04..09992163e1f4 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -51,7 +51,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		l2: l2-cache@500c0000 {
+		l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
 			      <0x506c0000 0x400>;
-- 
2.17.1

