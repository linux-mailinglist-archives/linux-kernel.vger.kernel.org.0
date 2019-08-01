Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AA7DF5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfHAPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:47:14 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:38910 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731520AbfHAPrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:09 -0400
Received: from dslb-094-223-182-030.094.223.pools.vodafone-ip.de ([94.223.182.30] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1htDIH-0008SJ-J8; Thu, 01 Aug 2019 17:47:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/8] ARM: dts: imx27-phytec-phycore-rdk: native-mode is part of display-timings
Date:   Thu,  1 Aug 2019 17:46:25 +0200
Message-Id: <20190801154628.1624-6-martin@kaiser.cx>
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
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 5606f417e9e8..bf883e45576a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -14,11 +14,11 @@
 
 	display0: LQ035Q7 {
 		model = "Sharp-LQ035Q7";
-		native-mode = <&timing0>;
 		bits-per-pixel = <16>;
 		fsl,pcr = <0xf00080c0>;
 
 		display-timings {
+			native-mode = <&timing0>;
 			timing0: 240x320 {
 				clock-frequency = <5500000>;
 				hactive = <240>;
-- 
2.11.0

