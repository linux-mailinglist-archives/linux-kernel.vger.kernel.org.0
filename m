Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5C169E71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 07:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBXGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 01:31:16 -0500
Received: from comms.puri.sm ([159.203.221.185]:47064 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgBXGbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:31:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C66CDE030E;
        Sun, 23 Feb 2020 22:31:14 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tXu7Yfun2uuC; Sun, 23 Feb 2020 22:31:14 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v3 8/8] arm64: dts: librem5-devkit: add lsm9ds1 mount matrix
Date:   Mon, 24 Feb 2020 07:29:17 +0100
Message-Id: <20200224062917.4895-9-martin.kepplinger@puri.sm>
In-Reply-To: <20200224062917.4895-1-martin.kepplinger@puri.sm>
References: <20200224062917.4895-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IMU chip on the librem5-devkit is not mounted at the "natural" place
that would match normal phone orientation (see the documentation for the
details about what that is).

Since the lsm9ds1 driver supports providing a mount matrix, we can describe
the orientation on the board in the dts:

Create a right-handed coordinate system (x * -1; see the datasheet for the
axis) and rotate 180 degrees around the y axis because the device sits on
the back side from the display.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 72c622ffe6de..10eca94194be 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -539,6 +539,9 @@
 		reg = <0x6a>;
 		vdd-supply = <&reg_3v3_p>;
 		vddio-supply = <&reg_3v3_p>;
+		mount-matrix =  "1",  "0",  "0",
+				"0",  "1",  "0",
+				"0",  "0", "-1";
 	};
 };
 
-- 
2.20.1

