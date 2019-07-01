Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3843291DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbfEXHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 03:38:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49652 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:38:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A10551A03C2;
        Fri, 24 May 2019 09:38:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF5E61A03B4;
        Fri, 24 May 2019 09:38:23 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E6199402E0;
        Fri, 24 May 2019 15:38:18 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Enable sata.
Date:   Fri, 24 May 2019 15:30:22 +0800
Message-Id: <20190524073022.32174-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the sata node to enable sata.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |    4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index b359068..4ed1828 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -153,3 +153,7 @@
 &sai1 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index f9c272f..4a203f7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -151,3 +151,7 @@
 &sai4 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
-- 
1.7.1

