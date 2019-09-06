Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBDABFB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436658AbfIFSqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 14:46:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395374AbfIFSqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:46:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so7599796wrt.13;
        Fri, 06 Sep 2019 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xU1lxAstjQUR72wZ/J0MWjQAlXMs9ML/BZPoCjnCEo0=;
        b=QL30LEzcYGE52tClH7qDSUb8rdbuplxJVHHskcftGAV0S6j3DeS2KHQNHuWtYJp5Sb
         hXGerX01T65u+PFpqv0CH6/t9MQpbNd1qCWZdD5PE3ir5Eoy6IcVgqs/KRa3cGbl5w5S
         xdLu216r67or4h0XUxQZuyEy38Gy9E9Hbu5d/8VSRGG6/aTUg5aVEiiheI8qhCmt7C6o
         VW0jsr2hgYyUEAAgk4Gm6RnWV47lWY9Tp9zVXQ4qet/NwZZskfp7HE4q2QzqXKT8/aDO
         68ZZMMuhHYLzwJvDrJzggQzkJAeztA7oL5btV9AW0EbepEkzFfx+Df+6hj0sKcj3pk7n
         xuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU1lxAstjQUR72wZ/J0MWjQAlXMs9ML/BZPoCjnCEo0=;
        b=bCFw7vyuC2xbAPPCqkP9dEmlGRWZOhNXtcESPLGttIn1v2WwBiu9Gn1otxSRYC0i02
         YsZ7hmb35EA5jmRtfWcQJCkfnCpXGciGvOHzCT7ZuWzafIhMSPVqWsMd0yKYVo/FFr/m
         4x12Xmp/+wGIxydNHTTZiiyldId9qxoy8YIcABHN1yOIlKQVfEVZYQ/FKR3RvAgCQhTs
         y8KqVk0f7XYkBU2AiTMtTDiXhbIP1r2bFhVFPPdN14hfsZ8p+WLmZO7nRk2TY5CbaeuA
         BbnUy47/I4ALlSy4KgJzRJWpZueVAljCO8P34O64TVaWRy7PeCrkSG442OhIiJLVkDMb
         jBpQ==
X-Gm-Message-State: APjAAAVFCGbue02SiaP0F3udC698ffoGH7KX2jokwW4JoP/iHZVS9Xay
        NsBuvnYqhH0zPz6RLKxtLKY=
X-Google-Smtp-Source: APXvYqwDs4Nh97WeZFVLe8CNTzlwOhTt4GnK72gpsm66rGYD7SOIVos0xjrZSIonRTHM0uwsDW3Vdg==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr8938109wrj.56.1567795569299;
        Fri, 06 Sep 2019 11:46:09 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j1sm8677577wrg.24.2019.09.06.11.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 11:46:08 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, mripard@kernel.org,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 4/9] ARM: dts: sun8i: r40: add crypto engine node
Date:   Fri,  6 Sep 2019 20:45:46 +0200
Message-Id: <20190906184551.17858-5-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Crypto Engine is a hardware cryptographic offloader that supports
many algorithms.
It could be found on most Allwinner SoCs.

This patch enables the Crypto Engine on the Allwinner R40 SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index bde068111b85..7eb649cea163 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -266,6 +266,17 @@
 			#phy-cells = <1>;
 		};
 
+		crypto: crypto-engine@1c15000 {
+			compatible = "allwinner,sun8i-r40-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_CE>;
+			reset-names = "ahb";
+			status = "okay";
+		};
+
 		ehci1: usb@1c19000 {
 			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
 			reg = <0x01c19000 0x100>;
-- 
2.21.0

