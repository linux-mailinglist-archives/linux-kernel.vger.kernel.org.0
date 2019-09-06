Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E6ABFA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436604AbfIFSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 14:46:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39008 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395395AbfIFSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:46:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so7598389wra.6;
        Fri, 06 Sep 2019 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8QtDLRptoE0CXvLgWwD97LTRuIDfzhWBaIHIlaUJgmo=;
        b=ep9HDZiCfuH8kRXERj63g91rhrUuOyjEtVhLHhk3QU7BOoV9SqhsZwanleSEly4oOJ
         w7Y3pMfAcOu2q5O1TSb6zwebqf/VygYEk0FnMQzBbayl/y+4F9NoAROZEWG9wYTzecab
         ILeNav7qAoyi8Jlr3+aGknSZpYk8aUkjUZkykfwVW9yawNu4C8/RAX9hVgKUn8OrniEM
         2OTJYpZwtnU2xUlqymmZrxVpBu9NYIJz1BIM2mTokFhR0nMnFaT6/yT0ebWuINPczJO1
         218A/xVTZ9dWS0qUzRQXYOO8cYk2BfhUhq6b/t8T/mvl1h/bRNy+5ecEIK13j8qkQ4c0
         +s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QtDLRptoE0CXvLgWwD97LTRuIDfzhWBaIHIlaUJgmo=;
        b=lPVVLGAL8agD4BHOlh4hgSCwQ7xSpKGnib8+8yTOcQMRSP8kFYOyqRT+wL82b5b6SN
         0pztxlQ02QCM2882nf+6LiRByTdjatnRP3JVhohIXxuf7bs2rAUJBo/1n64nAAaoTvKf
         tu9NIvxig3N+J/J5Jwcli1XNXbH6ggbFkOmbLMVp+SbRymvjQwEIPN9MYA8jp5UbhfPQ
         CQ0Oh7sGg1VTNBwx2ekHLpS3HIqjtGx3GxBPg/dD+nB0OmnY39Ck447mcjORkn95qNWZ
         AQUL9iDBdGfV5YsqaAUhIV+Kc98yQeXFlAQTClo+w77CCV6Ne/TlltgPe48wTbxv7mU7
         AXBg==
X-Gm-Message-State: APjAAAVA1rA5N8q9FD8+p/tg/6dKoi1PqiV2h4OBF4xwsS64R7ORgY9o
        PAd+RJ1gIEHVRt+kIwUhSw4=
X-Google-Smtp-Source: APXvYqx6NlZ/z+8VM/lYa3eo4+OsBuha3D3in2/3qbeTJ1A8BpcmX87Ghu+Ha7n2Ik0Ln+e88LowVA==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr1800226wri.50.1567795573543;
        Fri, 06 Sep 2019 11:46:13 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j1sm8677577wrg.24.2019.09.06.11.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 11:46:12 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, mripard@kernel.org,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 7/9] ARM64: dts: allwinner: sun50i: Add crypto engine node on H5
Date:   Fri,  6 Sep 2019 20:45:49 +0200
Message-Id: <20190906184551.17858-8-clabbe.montjoie@gmail.com>
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

This patch enables the Crypto Engine on the Allwinner H5 SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index f002a496d7cb..174fb3dcb3f7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -127,6 +127,17 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		crypto: crypto@1c15000 {
+			compatible = "allwinner,sun50i-h5-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ce_ns";
+			resets = <&ccu RST_BUS_CE>;
+			reset-names = "ahb";
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
+			clock-names = "ahb", "mod";
+		};
+
 		mali: gpu@1e80000 {
 			compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
 			reg = <0x01e80000 0x30000>;
-- 
2.21.0

