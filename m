Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35DA54EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfFYMgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 08:36:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53480 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFYMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:36:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so2646832wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ZX4reNH1Y4oGZx//omW4y+4kXs+97gm3IKdBMyA4qA=;
        b=HpzFOXWoy+175TZnrqU8T7yGRS2B6tYI96yqoa477Sr0PvZoubHe0dGEE8qR0w9FJ7
         CG87WTWkE5tBOtH+TJYq6Z2JvVZYEi9F69fZ79Z+EGjKnngJSHH4QhxCA3u87A/nl0Fy
         dRrf+rU+uWsBAdpFvOH25TJbTFOknCo7fbfhO5fkeJOMie3CbjWCJgcNd+6rqzhGp6jz
         bjuIyDa1nNsgmc2kxyXTkMMKDr7TFy4CfcIwU3Ws3CjQ350eBLrdJPCVE5Q3Jz+1xt8Y
         43Tkf62WO0jRZW4efWk19shXgogUl/d3voY4MWwz7kVVN3LiEp0euMMXxqMSF59GECjx
         v/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ZX4reNH1Y4oGZx//omW4y+4kXs+97gm3IKdBMyA4qA=;
        b=tOEj7gafwWznRRfR59UzttYYBLD1YvOvaozEbUqqwJhO6l8yAW+79GTavnmBJTWM3B
         ++wr2YTjmrlAblIWRHw5zbYqX8cBH3wgPb2xEN1Ot0n8Wt2NwR26pgwV2wwXfE5/qxSv
         oh18RFeiyXvwp5eNd63bucObSfbjDkRraCMbEHi3Q5gglTJUbEb8tk8VjbmyTlGMhvNP
         lBInEX6TGmR1P6Uy/3pi2mzHNEcx7cEVyeHVluh2mzzZsRfl7rSXE8k0RdyjQ0qrKNC2
         CpKeWEUIXmBjusiPUjq/SFwS16FZLYtP1Q/VsOVrNVeBY6XgpWDyTQISRsTqsaOU+PSg
         jRaA==
X-Gm-Message-State: APjAAAXE9i7xRssZLJi715aySY7ZBk3ezmqoR8aV2n9k/dxn++665QLv
        jM8pPLnQNYzWqOLOgJd6ByQNsqbPP8w=
X-Google-Smtp-Source: APXvYqzgY9PHUvM/ccsDS26S+XkhVdKSnIkiIIFWVo1bY8TU03TmD1YWUBru8miYVEDgfNd2A4wSag==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr20443151wmg.138.1561466210920;
        Tue, 25 Jun 2019 05:36:50 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n1sm10983882wrx.39.2019.06.25.05.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 05:36:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-g12a: add missing dwc2 phy-names
Date:   Tue, 25 Jun 2019 14:36:47 +0200
Message-Id: <20190625123647.26117-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A USB2 OTG capable PHY uses a 8bit large UTMI bus, and the OTG
controller gets the PHY but width by probing the associated phy.

By default it will use 16bit wide settings if a phy is not specified,
in our case we specified the phy, but not the phy-names.

The dwc2 bindings specifies that if phys is present, phy-names shall be
"usb2-phy".

Adding phy-names = "usb2-phy" solves the OTG PHY bus configuration.

Fixes: 9baf7d6be730 ("arm64: dts: meson: g12a: Add G12A USB nodes")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index f8d43e3dcf20..1785552d450c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -2386,6 +2386,7 @@
 				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
 				clock-names = "ddr";
 				phys = <&usb2_phy1>;
+				phy-names = "usb2-phy";
 				dr_mode = "peripheral";
 				g-rx-fifo-size = <192>;
 				g-np-tx-fifo-size = <128>;
-- 
2.21.0

