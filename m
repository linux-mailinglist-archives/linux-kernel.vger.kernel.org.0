Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0378487016
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 05:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404934AbfHIDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 23:12:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39302 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:12:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so6706421wra.6;
        Thu, 08 Aug 2019 20:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGHNJ41q8Xk+rxqslkgHM8iSCXHrbORbX9tN8p2H7Dg=;
        b=LXwyjzgmbqWLxl7RnRdnV9VukxwLGVefvMXj/ntON8hHJuBW/PhA/Q8KogmmFOCYCJ
         H9cBh6nMxQXTViMQ2Xc/fXpIyVPDJsnc3B8v+8Swzx12pNUy/5A4+SSzc/168thwKdgw
         6uY0WNfWgPeYbXLIyfm8C0+8dz5pVz0Fnl/CP5ej6M5EqhEvpcEPg9CJF2wduqI9nOmR
         +bIkqm3SHsOjfUZswjQ1TnPJ8CimkshskiAhlX5PHQeDEbfG3y1obiZI3Erygr2R89oX
         +JdYj5/2czVxSZyZeBibevRSHXlRpWdSYhCLrOSJjgQ0cP2tz+ST3ZaPKyY6sWJ6rGnM
         yPhQ==
X-Gm-Message-State: APjAAAWX2BR9sG8r1ZfsMYG4dqHgV/HdAVIfS41D9gM29Gna5S2IBYM4
        KCbGaslYGHJ4y4C+zGsJGNrtNBVQRRCjGQ==
X-Google-Smtp-Source: APXvYqyEWcvAnhF4Ue9wN4qIrQ6LTTi30ZSRVlF3B9zoC2iuTwaAv0Ylfl09QVksRxGknvXGG4p0/A==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr7959113wrs.131.1565320353238;
        Thu, 08 Aug 2019 20:12:33 -0700 (PDT)
Received: from tfsielt31850.garage.tyco.com ([79.97.20.138])
        by smtp.gmail.com with ESMTPSA id t19sm4798565wmi.29.2019.08.08.20.12.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:12:32 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx7d: cl-som-imx7: make ethernet work again
Date:   Fri,  9 Aug 2019 04:12:27 +0100
Message-Id: <20190809031227.3319-1-git@andred.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to the atheros at803x driver caused
ethernet to stop working on this board.
In particular commit 6d4cd041f0af
("net: phy: at803x: disable delay only for RGMII mode")
and commit cd28d1d6e52e
("net: phy: at803x: Disable phy delay for RGMII mode")
fix the AR8031 driver to configure the phy's (RX/TX)
delays as per the 'phy-mode' in the device tree.

This now prevents ethernet from working on this board.

It used to work before those commits, because the
AR8031 comes out of reset with RX delay enabled, and
the at803x driver didn't touch the delay configuration
at all when "rgmii" mode was selected, and because
arch/arm/mach-imx/mach-imx7d.c:ar8031_phy_fixup()
unconditionally enables TX delay.

Since above commits ar8031_phy_fixup() also has no
effect anymore, and the end-result is that all delays
are disabled in the phy, no ethernet.

Update the device tree to restore functionality.

Signed-off-by: André Draszik <git@andred.net>
CC: Ilya Ledvich <ilya@compulab.co.il>
CC: Igor Grinberg <grinberg@compulab.co.il>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index e61567437d73..62d5e9a4a781 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -44,7 +44,7 @@
 			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
 	status = "okay";
@@ -70,7 +70,7 @@
 			  <&clks IMX7D_ENET2_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 	fsl,magic-packet;
 	status = "okay";
-- 
2.20.1

