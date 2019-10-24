Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7CE2846
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 04:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392287AbfJXChb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 22:37:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34812 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390493AbfJXChb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:37:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 39FB7200345;
        Thu, 24 Oct 2019 04:37:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ADA0D2000F8;
        Thu, 24 Oct 2019 04:37:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D9D0E402C4;
        Thu, 24 Oct 2019 10:37:19 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] ARM: dts: imx6q: Add missing cooling device properties for CPUs
Date:   Thu, 24 Oct 2019 10:34:23 +0800
Message-Id: <1571884465-19720-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling device properties "#cooling-cells" should either be present
for all the CPUs of a cluster or none. If these are present only for a
subset of CPUs of a cluster then things will start falling apart as soon
as the CPUs are brought online in a different order. For example, this
will happen because the operating system looks for such properties in the
CPU node it is trying to bring up, so that it can register a cooling
device.

Add such missing properties.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d038f41..9d3be1c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -73,6 +73,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
@@ -107,6 +108,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
@@ -141,6 +143,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
-- 
2.7.4

