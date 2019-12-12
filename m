Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE311D1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfLLQCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:02:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:02:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sjoerd)
        with ESMTPSA id 588E328B82D
Received: by beast.luon.net (Postfix, from userid 1000)
        id 618673E1F0D; Thu, 12 Dec 2019 17:02:20 +0100 (CET)
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ARM: dts: imx6qdl: Enable egalax touch screen
Date:   Thu, 12 Dec 2019 17:02:20 +0100
Message-Id: <20191212160220.2265521-1-sjoerd.simons@collabora.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sabrelite boards can have an lvds screen attached with a built-in i2c touch
screen. Enable this in the dtsi.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 8468216dae9b..382b127b2251 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -416,6 +416,14 @@ &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
+
+	touchscreen@4 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &iomuxc {
-- 
2.24.0

