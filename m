Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07BE23E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407384AbfJWUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 16:05:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52744 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407354AbfJWUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:05:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so274715wmh.2;
        Wed, 23 Oct 2019 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44TuELDtNCusYZupj5B8B0t5vnjX1mlerc4abRfeM5Q=;
        b=h1/5ykbSeK2MvTxfvsr+9IgQVPUcm525MFfBL54hFqWeOoUeG14PcdjHy/oqw6iRLj
         S/aazg33LohoatqDWTxMxdaDV7nDwAiuIaKDEPxiiDFvWGbSsWoa3+OJiBSsTBPuryTb
         UayPoR6RAYUybFq7HO+NzsRbxXzf17cjMz+If8YOSdorOb/4j1uCGHF20LU55V86QzGd
         DT12sHqQL1emWnjPo6A3M7YIaNSr29uYi/tULTWTLbvRbMZz8CgVL5yrBsh3WXPeVA8P
         ytdTwD8E+2ZZIRVudT4t9t1izDcnJu7GyM/0yod4y/0LmAk6Bx/daC47gg6kQalPIebp
         jk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44TuELDtNCusYZupj5B8B0t5vnjX1mlerc4abRfeM5Q=;
        b=lJxmiok9sljmtKqXDEwg/QLCQLKydty03r2rWsp/jjqD/2jaVEdu0I55CmXPB7nlQ9
         Pus5MsjjBIe01IINujtSpIPnI+lQP4Gqrwpt1H/6b2GkiTXV8x5gNXHUqSMPGkK7ABH8
         V9/4m9K8bSzrfCTAZuiPw1WoTzd8StRVsSN2RwijrJZa0SUQmLRjlu41I5g1c+z95+sL
         7b6pNEXqY4vWUMjhGhoNi9QR2C2dO6dT86R5gdm5Gvu++TlOBA6dF3Tqq/vFFwn/qy+m
         3QhkrffKAQk3maE9vV5Nu11YqJqXOJTJMUVEWX7Wr7heAVklsZFtcQ7UcsU2LrX+XxbC
         jpaQ==
X-Gm-Message-State: APjAAAVvzbprCYJGBN0GHRJ7ZY8E8QwTAKyuFOlrPSWucwxuQJaYZTus
        S3WPyDGj73Ka5TmVtw+dUbU=
X-Google-Smtp-Source: APXvYqzZXD4PfW/Fig+qtqAV7jM5QtA5LeGXSih2yJGonjEMHu2NKHrk7dZyOttonuBKpuf4S33OsA==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr1360450wmk.148.1571861130332;
        Wed, 23 Oct 2019 13:05:30 -0700 (PDT)
Received: from Red.localdomain (lfbn-1-7036-79.w90-116.abo.wanadoo.fr. [90.116.209.79])
        by smtp.googlemail.com with ESMTPSA id b5sm177555wmj.18.2019.10.23.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:05:29 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v6 08/11] ARM64: dts: allwinner: sun50i: Add Crypto Engine node on H6
Date:   Wed, 23 Oct 2019 22:05:10 +0200
Message-Id: <20191023200513.22630-9-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023200513.22630-1-clabbe.montjoie@gmail.com>
References: <20191023200513.22630-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Crypto Engine is a hardware cryptographic accelerator that supports
many algorithms.

This patch enables the Crypto Engine on the Allwinner H6 SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 5d7ab540b950..89d09b441abc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -149,6 +149,15 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		crypto: crypto@1904000 {
+			compatible = "allwinner,sun50i-h6-crypto";
+			reg = <0x01904000 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>, <&ccu CLK_MBUS_CE>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CE>;
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.21.0

