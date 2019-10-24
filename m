Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCFE2C94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438477AbfJXIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 04:51:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44724 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438453AbfJXIvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:51:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B88732000D3;
        Thu, 24 Oct 2019 10:51:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3232420085F;
        Thu, 24 Oct 2019 10:51:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4F778402F0;
        Thu, 24 Oct 2019 16:51:38 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] ARM: dts: imx6ul-14x14-evk: Assign power supplies for magnetometer
Date:   Thu, 24 Oct 2019 16:48:40 +0800
Message-Id: <1571906920-29966-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571906920-29966-1-git-send-email-Anson.Huang@nxp.com>
References: <1571906920-29966-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6UL 14x14 EVK board, mag3110's power is controlled by
sensor regulator, assign power supplies for mag3110 driver
to do power management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index c74ba60..7b155ed 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -193,6 +193,8 @@
 	magnetometer@e {
 		compatible = "fsl,mag3110";
 		reg = <0x0e>;
+		vdd-supply = <&reg_sensors>;
+		vddio-supply = <&reg_sensors>;
 	};
 };
 
-- 
2.7.4

