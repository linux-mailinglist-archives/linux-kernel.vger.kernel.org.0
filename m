Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F59AEA32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbfIJMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 08:21:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389215AbfIJMVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:21:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 841CE2001BA;
        Tue, 10 Sep 2019 14:21:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A5CE3200206;
        Tue, 10 Sep 2019 14:21:06 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6980B402F2;
        Tue, 10 Sep 2019 20:21:01 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] arm64: dts: ls208x: Remove non-compatible driver device from qspi node
Date:   Tue, 10 Sep 2019 17:50:55 +0530
Message-Id: <1568118055-9740-5-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since device properties are different, so remove fsl, ls1021a-qspi.
ls1021a-qspi is to be used only for Big-endian verion of QSPI controller

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 64101c9..8e42ac9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -619,7 +619,7 @@
 
 		qspi: spi@20c0000 {
 			status = "disabled";
-			compatible = "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
+			compatible = "fsl,ls2080a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x20c0000 0x0 0x10000>,
-- 
2.7.4

