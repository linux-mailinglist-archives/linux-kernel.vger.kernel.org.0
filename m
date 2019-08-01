Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D007DF53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfHAPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:47:02 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:38658 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfHAPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:02 -0400
Received: from dslb-094-223-182-030.094.223.pools.vodafone-ip.de ([94.223.182.30] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1htDI8-0008SJ-In; Thu, 01 Aug 2019 17:46:56 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/8] ARM: dts: imx27 phyCARD-S: native-mode is part of display-timings
Date:   Thu,  1 Aug 2019 17:46:21 +0200
Message-Id: <20190801154628.1624-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190801154628.1624-1-martin@kaiser.cx>
References: <20190801154628.1624-1-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the native-mode property inside the display-timings node.

According to
Documentation/devicetree/bindings/display/panel/display-timing.txt.
native-mode is a property of the display-timings node.

If it's located outside of display-timings, the native-mode setting is
ignored and the first display timing is used (which is a problem only if
someone adds another display timing).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 5e5e282ed30e..0cd75dadf292 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -15,10 +15,10 @@
 
 	display: display {
 		model = "Primeview-PD050VL1";
-		native-mode = <&timing0>;
 		bits-per-pixel = <16>;  /* non-standard but required */
 		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
 		display-timings {
+			native-mode = <&timing0>;
 			timing0: 640x480 {
 				hactive = <640>;
 				vactive = <480>;
-- 
2.11.0

