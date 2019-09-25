Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5ECBDB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfIYJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 05:35:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44262 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbfIYJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:34:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so5819814wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QqOEvMqoCoUF7f1Dy17fvae1Nl1QHGOxlBQdkZghTQ=;
        b=t374Xv6jPUHTL79Zgkxi/GSH1HMJT3V058CR7ElIAfrg6QdNyOPKmYSI6Tptw9PFjH
         Yy3Ac5hwUSiLuptZw5c5vARlkXVh5fZ9IxGzCG5Ae1HLiF230SXzn6QQnarE2asbs5ea
         Z0zfPzlW30Hkxu7dOHm49ta3PbUMtBCXxk0HYW9Vp40RfzJn+WFrtFpyzzHoJcIVuA61
         iD6mr4/24pj1TKmaqWWmBr+SzxSZXDj/eFJ/pK6jGcr3LFSxVq1Wwf5CHxy4iA6ZzKDB
         sVtfoStqA9vjHj6pdoXgypFtDBiCnyFIw8zcGk00L4Banxe0xKHO7iSWulcKtzPBsN6P
         Tw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QqOEvMqoCoUF7f1Dy17fvae1Nl1QHGOxlBQdkZghTQ=;
        b=rAkLEwppfJg9M4uQRXR6yKjvWzROfd7MW49soBepyR6vUQXxmq5UODX+xblgKu3RTU
         6vFJh4pvjV6Tk2qczGgTPMAIsy0kdr2SHDkjr3D8H+dt7XYNNGaOquAnOnaHK+2an+Ih
         RBQoPNf43kle2OM+o73hjzwPo19VVq41V0z2HESEG75sz1RLdjgOhgeEya/P1vfB20ZY
         M2vjpM4xSf9PNFDP2jo5lq1s4Lk1W9QOxx/5zaxQojoGOEDhHEK7GmZVZp726f5r1DLl
         oOuKPqTNgsKPajffvUkcbbtT6D/yo6CRGswBhmUaa7qyFL4VMgQ4HEqDzyKY+Jyb1sTb
         hfbQ==
X-Gm-Message-State: APjAAAXdzksBv/E2WAF0VRN6g2eNHYqxmj7agxP4vbz8SFC2Ioz2+7uM
        czsqiR6yV/XrVLpEwdgXmATZHA==
X-Google-Smtp-Source: APXvYqzdk4+6z20DfPXX7A08NwxtUu+BoD7RqzK4rts9K9MTVCg1XgXs5fVakZPPvjm9cz/Rx8m2Yg==
X-Received: by 2002:a5d:670c:: with SMTP id o12mr8602618wru.103.1569404062291;
        Wed, 25 Sep 2019 02:34:22 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i1sm4268476wmb.19.2019.09.25.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 02:34:21 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: g12a: add audio devices resets
Date:   Wed, 25 Sep 2019 11:33:58 +0200
Message-Id: <20190925093358.15476-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the reset lines coming from the audio clock controller to
the audio devices of the g12 family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 28 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index 0d9df29994f3..3cf74fc96434 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -103,7 +103,9 @@
 			sound-name-prefix = "TODDR_A";
 			interrupts = <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
-			resets = <&arb AXG_ARB_TODDR_A>;
+			resets = <&arb AXG_ARB_TODDR_A>,
+				 <&clkc_audio AUD_RESET_TODDR_A>;
+			reset-names = "arb", "rst";
 			status = "disabled";
 		};
 
@@ -115,7 +117,9 @@
 			sound-name-prefix = "TODDR_B";
 			interrupts = <GIC_SPI 149 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
-			resets = <&arb AXG_ARB_TODDR_B>;
+			resets = <&arb AXG_ARB_TODDR_B>,
+				 <&clkc_audio AUD_RESET_TODDR_B>;
+			reset-names = "arb", "rst";
 			status = "disabled";
 		};
 
@@ -127,7 +131,9 @@
 			sound-name-prefix = "TODDR_C";
 			interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
-			resets = <&arb AXG_ARB_TODDR_C>;
+			resets = <&arb AXG_ARB_TODDR_C>,
+				 <&clkc_audio AUD_RESET_TODDR_C>;
+			reset-names = "arb", "rst";
 			status = "disabled";
 		};
 
@@ -139,7 +145,9 @@
 			sound-name-prefix = "FRDDR_A";
 			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
-			resets = <&arb AXG_ARB_FRDDR_A>;
+			resets = <&arb AXG_ARB_FRDDR_A>,
+				 <&clkc_audio AUD_RESET_FRDDR_A>;
+			reset-names = "arb", "rst";
 			status = "disabled";
 		};
 
@@ -151,7 +159,9 @@
 			sound-name-prefix = "FRDDR_B";
 			interrupts = <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
-			resets = <&arb AXG_ARB_FRDDR_B>;
+			resets = <&arb AXG_ARB_FRDDR_B>,
+				 <&clkc_audio AUD_RESET_FRDDR_B>;
+			reset-names = "arb", "rst";
 			status = "disabled";
 		};
 
@@ -163,7 +173,9 @@
 			sound-name-prefix = "FRDDR_C";
 			interrupts = <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
-			resets = <&arb AXG_ARB_FRDDR_C>;
+			resets = <&arb AXG_ARB_FRDDR_C>,
+				 <&clkc_audio AUD_RESET_FRDDR_C>;
+			reset-names = "arb", "rst";
 			status = "disabled";
 		};
 
@@ -249,6 +261,7 @@
 			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
 				 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
 			clock-names = "pclk", "refclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
 			status = "disabled";
 		};
 
@@ -261,6 +274,7 @@
 			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
 				 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
 			clock-names = "pclk", "mclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
 			status = "disabled";
 		};
 
@@ -318,6 +332,7 @@
 			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
 				 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
 			clock-names = "pclk", "mclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
 			status = "disabled";
 		};
 
@@ -326,6 +341,7 @@
 			reg = <0x0 0x744 0x0 0x4>;
 			#sound-dai-cells = <1>;
 			sound-name-prefix = "TOHDMITX";
+			resets = <&clkc_audio AUD_RESET_TOHDMITX>;
 			status = "disabled";
 		};
 	};
-- 
2.21.0

