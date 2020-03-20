Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1445B18D5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCTRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:41:23 -0400
Received: from v6.sk ([167.172.42.174]:51752 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbgCTRlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:22 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 512EC60EEF;
        Fri, 20 Mar 2020 17:41:20 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 02/10] ARM: dts: pxa*: Fix serial port names
Date:   Fri, 20 Mar 2020 18:40:59 +0100
Message-Id: <20200320174107.29406-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a preferred node name for serial ports, and it's not "uart":

  pxa910-dkb.dt.yaml: uart@d4017000: $nodename:0: 'uart@d4017000'
      does not match '^serial(@[0-9a-f,]+)*$'
  ...

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/pxa168.dtsi | 6 +++---
 arch/arm/boot/dts/pxa910.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 72f8cb60cb531..41dc79c9f6320 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -55,7 +55,7 @@ timer0: timer@d4014000 {
 				interrupts = <13>;
 			};
 
-			uart1: uart@d4017000 {
+			uart1: serial@d4017000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <27>;
@@ -64,7 +64,7 @@ uart1: uart@d4017000 {
 				status = "disabled";
 			};
 
-			uart2: uart@d4018000 {
+			uart2: serial@d4018000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <28>;
@@ -73,7 +73,7 @@ uart2: uart@d4018000 {
 				status = "disabled";
 			};
 
-			uart3: uart@d4026000 {
+			uart3: serial@d4026000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4026000 0x1000>;
 				interrupts = <29>;
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index b3d6182d4de4a..209b1f0ea67b2 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -67,7 +67,7 @@ timer1: timer@d4016000 {
 				status = "disabled";
 			};
 
-			uart1: uart@d4017000 {
+			uart1: serial@d4017000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <27>;
@@ -76,7 +76,7 @@ uart1: uart@d4017000 {
 				status = "disabled";
 			};
 
-			uart2: uart@d4018000 {
+			uart2: serial@d4018000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <28>;
@@ -85,7 +85,7 @@ uart2: uart@d4018000 {
 				status = "disabled";
 			};
 
-			uart3: uart@d4036000 {
+			uart3: serial@d4036000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4036000 0x1000>;
 				interrupts = <59>;
-- 
2.25.1

