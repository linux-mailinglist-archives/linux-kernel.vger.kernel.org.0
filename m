Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1430D94C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404655AbfJPPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:02:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54007 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392684AbfJPPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:01:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so3296547wmd.3;
        Wed, 16 Oct 2019 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44TuELDtNCusYZupj5B8B0t5vnjX1mlerc4abRfeM5Q=;
        b=qAuaa7ZSjn0FhJ00uXag5V81k2j4Jd8wB3mlHyQMAOmseqw6EhNJ8BC2g7O+/gpJT0
         AKHLSx/YhDsRflFs6PfgQ0DbQPo9jkyYQg7zMZ0eMTGS9WkCPvY774POUrzSJkebbp4Z
         NmKFTj4ZFuku85+S/jOGzuoEZYoA2+nJ3i4lrs+uenKplwZ9WN3BcFpQLSZV5wX9pcZg
         UWfDhZmF/MG4FqIGd64FhvJ8EMp2GNS+7+3FxYLPXOxa6EGjbxbAjChZU5+ZcWuuJaDK
         YAaI6H5jMk7+hk6rb2Gzw6rMT4e5y6Z+2Lrs4KBWwyTX0PJQjj4u3nmgy4nMaLVa2JTE
         4PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44TuELDtNCusYZupj5B8B0t5vnjX1mlerc4abRfeM5Q=;
        b=KA99nAaBVU3mveb6vtWR6WfBb6CQY4GTh0N+0HFZ+bOyYwOz1xksTWXQA6Y7I2hrF7
         vu2+xnTCSP3ngsaEUi8KfIH5gLSsWzST8Ojpwpm0SWkd3domSvAiA91DcTBzhkTPzzsH
         ss0lyp4k/X22pUd3Z97FM6lGY+a7JfcRI2uQp3/5A5KG1F3TRn3dzo/STv5f9124cQQQ
         +O7FCpxFmBsetc7WGxcJgBAi4CIFoAnqDhyk7FWifi8LqZh7Y+v8vbuBBuFepGU/N6kH
         9cN+QNkSpJ7TK/mSggZSYMJiUryPuIUpQ7N67QDtn7qwv3TRdvKIsPsF+8eeHzqb6GrO
         DO6w==
X-Gm-Message-State: APjAAAW5xRVyBVZmbU2qpvO6JyYseAm1ol9ZCNSfnhzdGbv7fBWBfey9
        rztqObH6e9WEToCb8tdMEy4=
X-Google-Smtp-Source: APXvYqyNHc0RjhVWHeqLrSGbq0CGiXXruOOIi8EuUr/Eh09bdBgr0c8S1gBOy4aPvU+bHsSf/Gguqg==
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr3765323wmg.31.1571238108577;
        Wed, 16 Oct 2019 08:01:48 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id r18sm3215437wme.48.2019.10.16.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 08:01:47 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 08/11] ARM64: dts: allwinner: sun50i: Add Crypto Engine node on H6
Date:   Wed, 16 Oct 2019 17:01:28 +0200
Message-Id: <20191016150131.15430-9-clabbe.montjoie@gmail.com>
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

