Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9DEABF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436593AbfIFSqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 14:46:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35130 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395384AbfIFSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:46:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so7639429wrx.2;
        Fri, 06 Sep 2019 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7B3pdgueaTQoEx/oPVjB5PBvNleh5XGxboZw228Zx0=;
        b=fXAj/oFnSdb6IabmspTKjVarmJg8RHtLu3Ax/i7LLanXPSfUnht0o0jIOlQIkQNPvi
         hnKTdLMkqBNr3Kc8/50ClePJkB/Mdfe7bfoEVM0zoUEGcgpVUe0qLuWslAw32wGZoFoi
         ssQBgtefefxHpKJ7YypkI4UU2OHlU6J4HCF4F6pwvy6Ckft/tS4BmY0fxXlbkVrngXGe
         faiadrmAN43x0lessYdYqObgKhb5QoYZEDdXCYhdSo29kRPVveu1UEZxCDmVE9YzzvvW
         KELGFrgDBHtl4TcZCZniYtJz6wQ99NCSKb93+szw6Jv3an9pNddMt2usjMcZJIOwlSCV
         imUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7B3pdgueaTQoEx/oPVjB5PBvNleh5XGxboZw228Zx0=;
        b=RX3M3KwzjNunmhsKf0Miq3VDdJ/RIsELfJfRMmduxj4Rzvi3I9nZ77/tIWUS2ABHE7
         2gU+UoEII11mpdBICtqHpuxBgoe2ovM45Kw7SkOCQjcVRCJya4BAF6ERmgpaBK702sf3
         rdU4P9QU+jUy7eflixlMOLO4l3zPjI1aFzee7O+hrs6WrVRuNzKr1k2jrLIHSYpGH7E1
         vEl5hcrb+9Z0ZntlgEqV5WQUTwWV60BxapUhzmSlYicIMnYHnAHS3oXDup+v3rrEsi4r
         CBIRf6h94eDgF5LjU0WPJhztPyVYzwvlPRR10pv/RV8suv8P+CcHW3gK7MZGsfgn4GOa
         uphA==
X-Gm-Message-State: APjAAAVt5YefglvRtYvag39BlNFkhc/5D65sPf/OAEYEt3IOX1ihkIlw
        4HEA9kc6+NVqjtqJVxnMrIA=
X-Google-Smtp-Source: APXvYqyqzdUc2jNRTwd83hy+NRUGUlKAEAYXdsuFtAFSvYJ9Z0R/bbQ7sN+U0gRd1Os/fJyeLxpM5A==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr8443567wru.227.1567795572094;
        Fri, 06 Sep 2019 11:46:12 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j1sm8677577wrg.24.2019.09.06.11.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 11:46:11 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, mripard@kernel.org,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 6/9] ARM64: dts: allwinner: sun50i: Add Crypto Engine node on A64
Date:   Fri,  6 Sep 2019 20:45:48 +0200
Message-Id: <20190906184551.17858-7-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Crypto Engine is a hardware cryptographic accelerator that supports
many algorithms.
It could be found on most Allwinner SoCs.

This patch enables the Crypto Engine on the Allwinner A64 SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 69128a6dfc46..c9e30d462ab1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -487,6 +487,17 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		crypto: crypto@1c15000 {
+			compatible = "allwinner,sun50i-a64-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ce_ns";
+			resets = <&ccu RST_BUS_CE>;
+			reset-names = "ahb";
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
+			clock-names = "ahb", "mod";
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.21.0

