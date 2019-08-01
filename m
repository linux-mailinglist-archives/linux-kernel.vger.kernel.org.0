Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576E37DF58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfHAPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:47:17 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:38950 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731714AbfHAPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:11 -0400
Received: from dslb-094-223-182-030.094.223.pools.vodafone-ip.de ([94.223.182.30] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1htDIJ-0008SJ-UA; Thu, 01 Aug 2019 17:47:08 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/8] ARM: dts: apf27dev: native-mode is part of display-timings
Date:   Thu,  1 Aug 2019 17:46:27 +0200
Message-Id: <20190801154628.1624-8-martin@kaiser.cx>
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
 arch/arm/boot/dts/imx27-apf27dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 087c6e237af0..6f1e8ce9e76e 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -12,10 +12,10 @@
 
 	display: display {
 		model = "Chimei-LW700AT9003";
-		native-mode = <&timing0>;
 		bits-per-pixel = <16>;  /* non-standard but required */
 		fsl,pcr = <0xfae80083>;	/* non-standard but required */
 		display-timings {
+			native-mode = <&timing0>;
 			timing0: 800x480 {
 				clock-frequency = <33000033>;
 				hactive = <800>;
-- 
2.11.0

