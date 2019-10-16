Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAAD94C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393065AbfJPPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:02:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55012 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392674AbfJPPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:01:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3287787wmp.4;
        Wed, 16 Oct 2019 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqDLE8eOD/jzuEBYGSJJdfRbfHzmSxgCPCd3m6sI5BM=;
        b=cjg9323SurCwWio8T/pGXDYiVsreN9rB5zKJVur3no4xha6wBi0wvXU8//WTDGMa1y
         d9VZz0KBD9S8vHPVYQEKmkW01hMrH/AK5pZ9nwHCh8OKVhaxyTA/xhKdAJEkXA94FiEY
         4IYTEouFFeLFTbXrFZ35N19PnCRiYx9GoQawl2zQmso9BZg5kofykWUdrcfSaHavqi/V
         JeiFFl+rkc3tiGTgFRVA+xipw30HCI2itAlcBj6dujsTOmKERbZupJ+yqkGsqF8VfO/y
         NlcTlFmAqoIM5a2Ps6FQrbB8YTuBQ6OVHRujv8lHDqhRTFUusKDth8FKIXbTNpQJUZqP
         lcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqDLE8eOD/jzuEBYGSJJdfRbfHzmSxgCPCd3m6sI5BM=;
        b=bY8AnogBl6N3xtY8K+Vztf9jVv4UVtG6Cr77RqL6sMR2rhXfNw1OU3p+O/8InD941J
         d5r0dkA4nBFIiT8gzL8E3BG3hVFpz4HtbJnzxMt1phdYq7OU3LhOCoOE7jG9cusurbz1
         DW95juzz3u1szLCerv2IZvvAV26v+KIjWkBrJRNhXptiZz//3gYjpcbVgfMGea/QWSAi
         alyluCvk3eR4c/HcPI5+NpXGmxsO0FME8D74OLljvTp9KEfddCxZawpXuTv9lzJ/oJTS
         LMbytR1nYN8IBsatWRxrT13uHiGaH9y3Oj/Fluici1yg2JVWL5Zx/T2as5lDwF8oIv2C
         pAFA==
X-Gm-Message-State: APjAAAW0PGPn/KNP4UzZ5IKTriNqIAdOVOA4UUP+ycV9NMbvjzcyC/4j
        9o3PzKq4px7UjQ8ikJdVcXg=
X-Google-Smtp-Source: APXvYqy8plqMN+WHFzRhYYAzRQ39/G5VYthflTU0EHmCjp5zdMxiJ1K646rdp5ZDlsyo2ZtYR4nW0w==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr4184454wmj.150.1571238105430;
        Wed, 16 Oct 2019 08:01:45 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id r18sm3215437wme.48.2019.10.16.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 08:01:44 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 06/11] ARM64: dts: allwinner: sun50i: Add Crypto Engine node on A64
Date:   Wed, 16 Oct 2019 17:01:26 +0200
Message-Id: <20191016150131.15430-7-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016150131.15430-1-clabbe.montjoie@gmail.com>
References: <20191016150131.15430-1-clabbe.montjoie@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 70f4cce6be43..0287d8458675 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -478,6 +478,15 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		crypto: crypto@1c15000 {
+			compatible = "allwinner,sun50i-a64-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_CE>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.21.0

