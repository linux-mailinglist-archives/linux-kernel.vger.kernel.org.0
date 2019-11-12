Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B2F9074
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfKLNUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 08:20:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44894 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfKLNUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:20:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id z188so5612212lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/A2f9kHIFOCYbqEWyI5d4hToF+Uq4/YnGy8bo4uWSk=;
        b=gM8MrR8fpyn4D3f/S9EA8B8+euhGtgB+lGz82qjsDCTe1bJ1kiHnsQYFbiW/5akGyH
         0mp2q9cT8A/OkZQgMiiVMsZSMYP7lzx+i0+PscS5YENMZjpxjMRfriZdcUEGItBE4t1y
         tuIfz4VW5ZZL40S/NoLsb+KAqWW86ZFGdIV1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/A2f9kHIFOCYbqEWyI5d4hToF+Uq4/YnGy8bo4uWSk=;
        b=jQjatp2PQyOjxMBcQI96wTtssjKgN7YY2dOjXBiwTEdCrx4OzQ5JI925oDHJx9U9by
         GSNNN6xek9aBLHZ83DpgZo+KJ6/BNnD+GjdVjNUoVhtsdzk+IBjhmYfklL9GHSh8Og0H
         4OxrRCoxmylWNkHEyghXOP1XPDr3IGpwyNnP5hI1gGu5Vz9++QLYUSRAegRWF3SIjOZj
         VHl/QtWCBhmviNyIiZHehUeaAwdRPNf7bJtyD23CzLDDxgCYb9/i+EZnVY4i7bo6ulug
         JHZpBsKlPJEUweZPJXekZgOUXbo07Gqw5bF6t9DI2voV1dFtiJ7dVmLhatYo+E3FK5iM
         znZg==
X-Gm-Message-State: APjAAAWYQb6kyusSLjVpL42mBgyVkZxJmAu9AtIs+fJfs3QpUgOt1RtN
        s7ARxBhWIRW7hwpyT29pTuzHnX47zqBglEEA
X-Google-Smtp-Source: APXvYqz/sFZqp2pxbjkEJ36q/AU0dl23QXcsNzmg6b9X5nHorefiUNSVmG7PoCczzVrEgRSF7p9rHw==
X-Received: by 2002:a19:c514:: with SMTP id w20mr19905250lfe.143.1573564815900;
        Tue, 12 Nov 2019 05:20:15 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f20sm869050lfc.75.2019.11.12.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:20:15 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: ls1021a: add node describing external interrupt lines
Date:   Tue, 12 Nov 2019 14:20:09 +0100
Message-Id: <20191112132010.18274-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112132010.18274-1-linux@rasmusvillemoes.dk>
References: <20191112132010.18274-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a node describing the six external interrupt lines IRQ0-IRQ5
with configurable polarity.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2f6977ada447..0855b1fe98e0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -216,6 +216,25 @@
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
 			big-endian;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x1570000 0x10000>;
+
+			extirq: interrupt-controller@1ac {
+				compatible = "fsl,ls1021a-extirq";
+				#interrupt-cells = <2>;
+				#address-cells = <0>;
+				interrupt-controller;
+				reg = <0x1ac 4>;
+				interrupt-map =
+					<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0xffffffff 0x0>;
+			};
 		};
 
 		crypto: crypto@1700000 {
-- 
2.23.0

