Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0851C1292ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfLWINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 03:13:04 -0500
Received: from comms.puri.sm ([159.203.221.185]:48756 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfLWINE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:13:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AE636DF754;
        Mon, 23 Dec 2019 00:13:03 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4uDTf511eGyR; Mon, 23 Dec 2019 00:13:02 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     shawnguo@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 1/2] arm64: dts: imx8mq-librem5-devkit: add accelerometer and gyro sensor
Date:   Mon, 23 Dec 2019 09:12:52 +0100
Message-Id: <20191223081253.27516-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is driver support, describe the accel and gyro sensor parts
of the LSM9DS1 IMU.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
---

revision history
----------------
v2: use hyphen in node name and reorder (thanks Shawn)
    add Guido's review tag


 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 523e5f2ce873..379510886e3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -449,6 +449,13 @@
 		AVDD28-supply = <&reg_2v8_p>;
 		VDDIO-supply = <&reg_1v8_p>;
 	};
+
+	accel-gyro@6a {
+		compatible = "st,lsm9ds1-imu";
+		reg = <0x6a>;
+		vdd-supply = <&reg_3v3_p>;
+		vddio-supply = <&reg_3v3_p>;
+	};
 };
 
 &iomuxc {
-- 
2.20.1

