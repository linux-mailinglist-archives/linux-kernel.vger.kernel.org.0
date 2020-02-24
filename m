Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467C8169E72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 07:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgBXGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 01:31:16 -0500
Received: from comms.puri.sm ([159.203.221.185]:47038 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgBXGbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:31:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 001D9E041E;
        Sun, 23 Feb 2020 22:31:11 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XuBT-JObv-8Y; Sun, 23 Feb 2020 22:31:11 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 7/8] arm64: dts: librem5-devkit: increase the VBUS current in the kernel
Date:   Mon, 24 Feb 2020 07:29:16 +0100
Message-Id: <20200224062917.4895-8-martin.kepplinger@puri.sm>
In-Reply-To: <20200224062917.4895-1-martin.kepplinger@puri.sm>
References: <20200224062917.4895-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

The poly fuses can handle 6V 4Amps so incease the kernel limts to 5V
3.5Amps.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 12a91d2d36db..72c622ffe6de 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -428,10 +428,10 @@
 				PDO_FIXED_USB_COMM |
 				PDO_FIXED_DUAL_ROLE |
 				PDO_FIXED_DATA_SWAP )>;
-			sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
+			sink-pdos = <PDO_FIXED(5000, 3500, PDO_FIXED_USB_COMM |
 				PDO_FIXED_DUAL_ROLE |
 				PDO_FIXED_DATA_SWAP )
-			     PDO_VAR(5000, 3000, 3000)>;
+			     PDO_VAR(5000, 5000, 3500)>;
 			op-sink-microwatt = <10000000>;
 
 			ports {
-- 
2.20.1

