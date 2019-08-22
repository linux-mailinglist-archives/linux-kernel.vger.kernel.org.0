Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2329A242
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbfHVVfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:35:08 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49059 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbfHVVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:35:07 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CE5BBFF809;
        Thu, 22 Aug 2019 21:35:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: dts: pbab01: correct rtc vendor
Date:   Thu, 22 Aug 2019 23:35:03 +0200
Message-Id: <20190822213503.14726-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc8564 is made by Epson but is similar to the NXP pcf8563. Use the
correct vendor name.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 82802f8ce7a0..d434868e870a 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -128,7 +128,7 @@
 	};
 
 	rtc@51 {
-		compatible = "nxp,rtc8564";
+		compatible = "epson,rtc8564";
 		reg = <0x51>;
 	};
 
-- 
2.21.0

