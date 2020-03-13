Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF13D184341
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 10:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 05:07:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46396 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgCMJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:07:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so11024709wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KrJf+EGLXE8nvYgZtr6atvulE/NcTou2lZGP+D+d2qw=;
        b=BOVKBU0Ujuzg0xDGWTs/W1y0roYbWeUvMBriY4xI3p+BCY48nGP4y+J7KmoYc6mhYP
         cThTepp8+g70rWRbmqNvc1ofqIv7gOpAdSUT15RROZDKtVgDGycvvVc9rvEI2zMdZw1W
         ZC9opbu8pF43mYmDBythnQVVQh/AS0FHU6sC431mSosuX4Pn9wloX4IH4/Kc7ousft3H
         sbe+51tKPQydX1ojL3RPgC2B4QiiKzZ2Vx1SntQktZexGrz+lWHygUAdYMXdMifLTS7c
         gj34RDmRDa/JzjiZAPJGm+j2uOrLuLj23zsAQwy4EfJ7U9B3rNFVJS/J+IV4TVPaW4Hg
         nHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KrJf+EGLXE8nvYgZtr6atvulE/NcTou2lZGP+D+d2qw=;
        b=JP/PkHVX3Fr5iOedegewv1SNrp3WJ2r/Tt/8i8PJeJEFFDpxMfN8toqy/yTySAUnch
         1YBkYXTHU9qlmP4cKKOUpCN8VHFCk+atf67ekMql2EdKWr96w30pXAS7ke4QnXH3cPdk
         6stg7uRPZWgLRkBTjIlPO/3XHrqYXMNH0fb3GxSkI0pT3fPGwTrZXvUzIpkCqc2YkVe4
         gDol+bfqwNYBb4/iYrdF4R8oe9gMfXi5a1BUnmRGpAi7dHhZ+QUSpnaA1rI6NUYlJSi4
         QdbPpPCti5PBOsC2AXLTbvUm4/nOzj/DpHY/TyN/FqUdJ3OT9AGWxm+AjMyx6+AdHmvK
         nbzg==
X-Gm-Message-State: ANhLgQ0WAJ6gRRZGVzsZemt2fbXAa4tjvE4DavUMR4HIqfzQQgcUGv9q
        FtdDoVivPl733c76Fumj2R17yA==
X-Google-Smtp-Source: ADFU+vu0BdY5m1oq1hZ64fBK3Lt0+33tWgB3mGxdT6gg9HNBrGg14nro/t4yX9kgtHUi01cFFBaogQ==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr15867133wrp.48.1584090440564;
        Fri, 13 Mar 2020 02:07:20 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id i1sm61872399wrs.18.2020.03.13.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:07:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/4] arm64: dts: khadas-vim3: add SPIFC controller node
Date:   Fri, 13 Mar 2020 10:07:12 +0100
Message-Id: <20200313090713.15147-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200313090713.15147-1-narmstrong@baylibre.com>
References: <20200313090713.15147-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add disabled SPIFC controller node with instruction on how to enable
it while lowering capabilities of the eMMC controller from 8bits bus
width to 4bits bus width, it's data pins 4 to 7 being shared with
the SPI NOR controller pins.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index b6f22a0bd318..f09854560938 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -328,6 +328,26 @@
 	vqmmc-supply = <&emmc_1v8>;
 };
 
+/*
+ * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR CS
+ * and eMMC Data 4 to 7 pins.
+ * Replace emmc_data_8b_pins to emmc_data_4b_pins from sd_emmc_c pinctrl-0,
+ * and change bus-width to 4 then spifc can be enabled.
+ */
+&spifc {
+	status = "disabled";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	w25q32: spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128fw", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+	};
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.22.0

