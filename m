Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505DB120382
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLPLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:15:50 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36732 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLPLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:15:49 -0500
Received: by mail-yw1-f67.google.com with SMTP id n184so2320506ywc.3;
        Mon, 16 Dec 2019 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUR5yQ/XBT06UW39mN8rkGX71PlTXaLwibh2EkbRSl4=;
        b=bLf3wLEtQdqplXZbaAVgHW4CkMv36oTw85Uv6jYHflFMCdfkgBm3COKTreaqbxmTdc
         qiQgf7Asyt34117bNjfapKHllrdYu2aoKvtU54bA5PHaOuxEstcysNdqT1mGvCFn3VSr
         O7gxnRTqEZf7DdmoauTvdncvdPzLgfqI4ZcVvNs0bTv1ARLfm0oFUubEmWjQBydsLUWW
         xubQnyJpDEuXJaqnsR9P/+G+aOWXoOWmSf4Cie4ZZid8Hqmu+pL5JhTNoXt9n4RIRysI
         /CtF4UXgW2snlxoKkJRpwo28By8edBy1m5gO9aDIYx+fFAl7Szs2enxTOpGMH1bjEuYI
         RuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUR5yQ/XBT06UW39mN8rkGX71PlTXaLwibh2EkbRSl4=;
        b=dMY8KxJSD9v3MupPXjWN4Fg/jJUC5GeXSw5Z9nZpjkyshLtixt5BBKoZZavhj9ObsC
         tg4lLai3TtTvKaJ79+6nAFKqbvxbalT9lKqjttBAuvZUqDFflcXK/czKEyEdqMugA78+
         CK2LYccTFR3Az8qxLoHjPJSiHJSWPU2LL8GGo45iDou9fzUVuj63zhbhAdXnL++K5KMd
         VMuTeHeYNWED3bR4IV/SUSyMuuy+IRYzz0LIropGHFFhI5ou1J7xlcS2NEHOoVewqJlY
         Yx1Yx2vzu0dpogaQ7Z/ju94Vr6rJKXV3QSJLGTeFyIXds1TjhCPGDmcESjRA2nGJVA19
         3GUQ==
X-Gm-Message-State: APjAAAU7dRkmeBkWXIMQZmYcPkQI8frWMiWEgFMgJql7ls46T7yGscaS
        jNj8YpVUhQA1pCXrgYxoopQ=
X-Google-Smtp-Source: APXvYqw1gE7A6yrW3oJywOj16NPJXMW4gLQQwOzMm61XMUGaeLODWIdavMuwLNE52GKWKXjEbGrfOw==
X-Received: by 2002:a81:3acb:: with SMTP id h194mr18371887ywa.406.1576494948651;
        Mon, 16 Dec 2019 03:15:48 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id o69sm7644544ywd.38.2019.12.16.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 03:15:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Change SDMA1 ahb clock for imx8mm
Date:   Mon, 16 Dec 2019 05:15:30 -0600
Message-Id: <20191216111530.29558-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using SDMA1 with UART1 is causing a "Timeout waiting for CH0" error.
This patch changes to ahb clock from SDMA1_ROOT to AHB which
fixes the timeout error.

Fixes:  a05ea40eb384 ("arm64: dts: imx: Add i.mx8mm dtsi support")

Signed-off-by: Adam Ford <aford173@gmail.com>
---
A similar fix was made to the i.MX8MQ for the same reason

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 6edbdfe2d0d7..3d95b66a2d71 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -740,7 +740,7 @@
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MM_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MM_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.20.1

