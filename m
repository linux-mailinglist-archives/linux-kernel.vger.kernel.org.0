Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFF109297
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfKYRFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 12:05:47 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:36117 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfKYRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574701539;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=UhMf0lnVjOcfCEB7ic10qPMrUlMrwwMjTmGRUymYol8=;
        b=RtcC6wjU6Gv0ZsPFnUU3E+tA200YEv39SolUbxUZUQTNA/A7NHd3IoNWGoef9NvS+G
        hv8Py82ie9zc6DHSP5hAnrCtXAOJnJ3+awkChZrLG4YOk93eW2F+GGt23JEcSIqNpXU5
        a2pk8Ego0sOhZRcZFOHyLp5/fwwmxTQag4Bg+37m9GxxvOWfG/OFoIS5jrylh4mKlmN9
        CJB4D7sowXV4v/ZDpaiOl5Yt+HMv7Jx7q1vK91deGxMwCtf2upuYaSqSLqijwXpvIDmb
        uSELJi7DwSifNQln3TWBAGNx3UXmNj1DSL9Ld+0Z2Lgz+P2L9yPup3BXAu9kAVnZRncO
        fRKg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPH5d2r9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 18:05:39 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/4] ARM: dts: ux500: Remove ux500_ prefix from ux500_serial* labels
Date:   Mon, 25 Nov 2019 18:04:28 +0100
Message-Id: <20191125170428.76069-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125170428.76069-1-stephan@gerhold.net>
References: <20191125170428.76069-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ux500_serial{0,1,2} are the only labels with ux500_ prefix in
ste-dbx5x0.dtsi, the other labels (gpio0, msp, ...) do not use
any prefix. Remove it for consistency.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 841934093c3b..d4a55369452d 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -24,9 +24,9 @@
 		spi1 = &spi1;
 		spi2 = &spi2;
 		spi3 = &spi3;
-		serial0 = &ux500_serial0;
-		serial1 = &ux500_serial1;
-		serial2 = &ux500_serial2;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
 	};
 
 	chosen {
@@ -838,7 +838,7 @@
 			status = "disabled";
 		};
 
-		ux500_serial0: uart@80120000 {
+		serial0: uart@80120000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80120000 0x1000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
@@ -853,7 +853,7 @@
 			status = "disabled";
 		};
 
-		ux500_serial1: uart@80121000 {
+		serial1: uart@80121000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80121000 0x1000>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -868,7 +868,7 @@
 			status = "disabled";
 		};
 
-		ux500_serial2: uart@80007000 {
+		serial2: uart@80007000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80007000 0x1000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.0

