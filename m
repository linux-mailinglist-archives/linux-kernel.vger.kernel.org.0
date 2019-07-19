Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023BB6E3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfGSKJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 06:09:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44454 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSKJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:09:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA5EE1A0159;
        Fri, 19 Jul 2019 12:09:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DFDD1A003F;
        Fri, 19 Jul 2019 12:09:12 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CB26B402B5;
        Fri, 19 Jul 2019 18:09:06 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, liviu.dudau@arm.com,
        robh+dt@kernel.org
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v2 3/3] dts: arm64: ls1028a: Add optional property node for Mali DP500
Date:   Fri, 19 Jul 2019 17:59:56 +0800
Message-Id: <20190719095956.11774-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch use the optional property node "arm,malidp-arqos-value" to
can be dynamic configure QoS signaling.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7975519b4f56..aef5b06a98d5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -554,6 +554,7 @@
 		clocks = <&dpclk>, <&aclk>, <&aclk>, <&pclk>;
 		clock-names = "pxlclk", "mclk", "aclk", "pclk";
 		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
+		arm,malidp-arqos-value = <0xd000d000>;
 
 		port {
 			dp0_out: endpoint {
-- 
2.17.1

