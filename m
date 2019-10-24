Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF92E2849
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 04:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392393AbfJXChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 22:37:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33882 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390493AbfJXChd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:37:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E68D71A0183;
        Thu, 24 Oct 2019 04:37:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 67A251A099C;
        Thu, 24 Oct 2019 04:37:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E9CEF40282;
        Thu, 24 Oct 2019 10:37:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] ARM: dts: imx7d: Add missing cooling device properties for CPUs
Date:   Thu, 24 Oct 2019 10:34:25 +0800
Message-Id: <1571884465-19720-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571884465-19720-1-git-send-email-Anson.Huang@nxp.com>
References: <1571884465-19720-1-git-send-email-Anson.Huang@nxp.com>
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
 arch/arm/boot/dts/imx7d.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 2792767..d8acd7c 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -22,6 +22,7 @@
 			reg = <1>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_sleep_wait>;
 		};
 	};
-- 
2.7.4

