Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3086CB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 11:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbfGRJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:03:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33871 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389714AbfGRJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:03:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so21013001wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEPWlaAynzEB3uxsoiThbGJKcclFNIT5ZtJlhLSr90E=;
        b=LdU4BFG6jyQN0ybEhyRRtezrlr27adz7Nni1HrDS5uDhm3eEhhGg76GdQLPNK/Xr0e
         T2ynKqeXJPYKKa9MKyn9Vdq/KpYPDOe4WqRI7zI5hJdrKxT9pZQu91U0NhJRmvUyddds
         3OzicjHVjv9HFhjuWGyOO61buxfPu3i8eXEG21rf5AA+kEwhMY4JXtzYO/0iYwtsA48s
         ZahszRQeFg25USwhJRGnEgjAudmCQf08nBohRckYr/8ITe8na3WyeZhdnqrzPmatqwBE
         lm6Cw8ZhzNNTxpNsn9csJ4iYVn0iOWe2E6aekkKVhW64J1AyTDHCg+psSdFovb5w/S01
         iEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEPWlaAynzEB3uxsoiThbGJKcclFNIT5ZtJlhLSr90E=;
        b=Fzsx+FVfT8KeySoEC37UMCZTKCC53onvIOoP2bFEQ/jwEHSOf00jndV/dL/xn1nn1R
         nbH1HtK8C8JdUAP4DNFWeEbM8F6h0UnYkASpesQqmdLKrohRHClpMrS27XlZvbazpNgu
         ktpMGL/zMG+mJ360sToS1Da5Qz3jWmTchf0i8qvAGIF2zbQDZADBNVFWo9+JXNgL0XY1
         gNERBa/Mrp7OoBpXkXaV29hsXbV5Hd7Xg7S2l+BqKjgaVNlzK8K7BnKO+IICPYcQ3Myh
         UpShVlEm1VDv/mQEZ2XGOkb3dmbQw03rdiQL8yYr1VZJ5wnMnc137ic6vEizl6biLXxM
         vJSw==
X-Gm-Message-State: APjAAAVKjbWvtsYzv4d8QrVoCN6iZiRNs2+DGOZM0/5Ljta3T+o4MLZr
        odkbGn3ICOZjESrtFVkuX241kQ==
X-Google-Smtp-Source: APXvYqye1+eu3ZjWx6OKok5TLOmerHpIOZsjS6dB9eYlpDt//yNdZbHxT3GY30mSRDNU7QZ1zpI+QQ==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr40703700wmb.39.1563440584464;
        Thu, 18 Jul 2019 02:03:04 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z7sm23825652wrh.67.2019.07.18.02.03.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 02:03:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: add ethernet fifo sizes
Date:   Thu, 18 Jul 2019 11:03:01 +0200
Message-Id: <20190718090301.19283-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If unspecified in DT, the fifo sizes are not automatically detected by
the dwmac1000 dma driver and the reported fifo sizes default to 0.
Because of this, flow control will be turned off on the device.

Add the fifo sizes provided by the datasheets in the SoC in DT so
flow control may be enabled if necessary.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 2 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6219337033a0..12bf959c17a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -182,6 +182,8 @@
 				 <&clkc CLKID_FCLK_DIV2>,
 				 <&clkc CLKID_MPLL2>;
 			clock-names = "stmmaceth", "clkin0", "clkin1";
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 0bb9705a33f1..c8b9b9754598 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -150,6 +150,8 @@
 				 <&clkc CLKID_FCLK_DIV2>,
 				 <&clkc CLKID_MPLL2>;
 			clock-names = "stmmaceth", "clkin0", "clkin1";
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
 			status = "disabled";
 
 			mdio0: mdio {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 74d03fc706be..e62aad5bf867 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -493,6 +493,8 @@
 			       0x0 0xc8834540 0x0 0x4>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
 			status = "disabled";
 		};
 
-- 
2.21.0

