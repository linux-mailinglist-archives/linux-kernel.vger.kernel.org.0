Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60B148C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 17:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbgAXQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 11:30:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbgAXQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so2688542wro.9;
        Fri, 24 Jan 2020 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MtdDB+Ad0iU6rgEXiY5ujEmZtuAHwTecRPkyhRx/V2g=;
        b=aypsDmrwK+xusSVzi2cZtehPj6u2rMYRKcLIcd7vaZKL9HP3ckHFO7r/vJcuSZRKUP
         MiwlmPlW2p0W1mVmSYtktOpTy8maE6t1NQBtEdCjYGq0y6q038wHvYwM7go3ufq4MQHC
         WiTZB1YzTgRPDQG3JhNHenWlhlbgC4jnLXwF1iLCKsHDPhrPQBVY1Kgt7+G1kw6sPrxL
         H5m6wpSxHXCjZIORK5n7hH3MnwSMsm88lWdnqpMU7Aa++P5WbH/B+8Fv9G/yt1jMLFnZ
         Pz9sVgYp+e26LgWBevXEdoXFJlfa93dx5o9ywNTN5WguJJ0vYnwnqpaSycneBzh8GStZ
         /U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MtdDB+Ad0iU6rgEXiY5ujEmZtuAHwTecRPkyhRx/V2g=;
        b=peKWTzfcJ1H3i7ZTG4fXFDeVIZOSukPzJZwvbjSA5Vc/FbVamMHgSa2qrSvU3LKvyg
         Iiho8yNech0el8xjsL9TKQn/AOX0uxFvu5IBNQeNt3D8Qg8TfgNG8/XxCxDDgTUEs3yj
         ydnmLqJ5Fz0WkwzLtgl4hHiOiT2YxrIuh/Oixe5U00yh1F/u/YFP0vVOzog0mcICg525
         Ii4wJz+dce22siMakG3mj9xG6DiNhFzkTu+K4SQuVQlb9GDX5niy9AWHxaqDiDmAkbaJ
         wQYV4YBqmeiAped3yJncXpM5+Hy5DY47bcKVZ0Wfx3WQTBhu9rl3PFsUVOzARPE8W5WJ
         Z5dQ==
X-Gm-Message-State: APjAAAVpa1fxFGRnVtG4Hz1GzpaYx/4c6widyulKPmHMlrhB8zBtWnUn
        wYr6VF2bkZcKanqsn0jTwlw=
X-Google-Smtp-Source: APXvYqxFNPosxjrpJ4H+Ptr3l58QXTCusDkQ0TCFfKpKOQXiyqk42bKBWvVxtpm37CGxyH9wfVwwKg==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr5002968wrs.424.1579883416466;
        Fri, 24 Jan 2020 08:30:16 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:16 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 05/10] ARM: dts: rockchip: add nandc nodes for rk3288
Date:   Fri, 24 Jan 2020 17:29:56 +0100
Message-Id: <20200124163001.28910-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianqun Xu <jay.xu@rock-chips.com>

Add nandc nodes for rk3288.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 415c75f57..ebb833a1a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -30,6 +30,8 @@
 		mshc1 = &sdmmc;
 		mshc2 = &sdio0;
 		mshc3 = &sdio1;
+		nandc0 = &nandc0;
+		nandc1 = &nandc1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -596,6 +598,24 @@
 		status = "disabled";
 	};
 
+	nandc0: nand-controller@ff400000 {
+		compatible = "rockchip,rk3288-nand-controller";
+		reg = <0x0 0xff400000 0x0 0x4000>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC0>, <&cru SCLK_NANDC0>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		status = "disabled";
+	};
+
+	nandc1: nand-controller@ff410000 {
+		compatible = "rockchip,rk3288-nand-controller";
+		reg = <0x0 0xff410000 0x0 0x4000>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC1>, <&cru SCLK_NANDC1>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xff500000 0x0 0x100>;
-- 
2.11.0

