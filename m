Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9D174750
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgB2OWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 09:22:31 -0500
Received: from inva020.nxp.com ([92.121.34.13]:49346 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgB2OW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:22:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EED91A0716;
        Sat, 29 Feb 2020 15:22:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0790A1A071C;
        Sat, 29 Feb 2020 15:22:23 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 617EA402CB;
        Sat, 29 Feb 2020 22:22:16 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] arm64: dts: imx8mp-evk: Enable pca6416 on i2c3 bus
Date:   Sat, 29 Feb 2020 22:16:26 +0800
Message-Id: <1582985786-2198-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582985786-2198-1-git-send-email-Anson.Huang@nxp.com>
References: <1582985786-2198-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pca6416 on i.MX8MP EVK board's i2c3 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b70c42a..3da1fff 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -71,6 +71,13 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &snvs_pwrkey {
-- 
2.7.4

