Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38629D92E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbfJPNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 09:49:40 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:39680 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfJPNtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:49:39 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 4B6DBA26C1;
        Wed, 16 Oct 2019 15:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571233778;
        bh=oavljzM6Dv7QE7Rmd/6PUWCvDbTXzVq4czozbuvmcbs=;
        h=From:To:Cc:Subject:Date:From;
        b=HTI94LuDeTAU922Hi1QsSz6Gp+dLWtt79pIt5wZr8DXQ1bvkrmvLP1OZRkfo2XEyw
         XfEDMUJuZ5l6IbHThBdU1XL9NvhnGLp06C3qNzUe8NH23SRC1Z4ckRn2B0MUCxeceD
         wKg1mLmApTiE6mpnGZ9Fj4R3nTAYDrJ2UrwZ0g0Q=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Enable UART2
Date:   Wed, 16 Oct 2019 15:49:22 +0200
Message-Id: <1571233762-4444-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second UART is needed for 3D or MFD printer control.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index e8d800fec637..663a72a96b6c 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -447,6 +447,13 @@
 		>;
 	};
 
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__UART2_TX_DATA	0x1b098
+			MX6QDL_PAD_GPIO_8__UART2_RX_DATA	0x1b098
+		>;
+	};
+
 	pinctrl_usbh1: usbh1grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D30__USB_H1_OC	0x1b098
@@ -532,6 +539,12 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh1>;
-- 
2.1.4

