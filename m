Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07C3192CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCYPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 11:39:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53380 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgCYPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BD2520056B;
        Wed, 25 Mar 2020 16:39:26 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E59C20055D;
        Wed, 25 Mar 2020 16:39:26 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FC08203CE;
        Wed, 25 Mar 2020 16:39:25 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 04/13] arm64: dts: imx8mp: Add audiomix node
Date:   Wed, 25 Mar 2020 17:38:42 +0200
Message-Id: <1585150731-3354-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audiomix is a mix of multiple functionalities controlled by the audio IPs.
In order to split the functionality between the rightfull drivers, it
will be probled by the imx-mix MFD driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c08156f..3e4c376 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -655,6 +655,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+
+			audiomix: audiomix@30e20000 {
+				compatible = "fsl,imx8mp-mix";
+				reg = <0x30e20000 0x10000>;
+			};
 		};
 
 		gic: interrupt-controller@38800000 {
-- 
2.7.4

