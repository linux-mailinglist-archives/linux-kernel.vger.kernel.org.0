Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189F36E423
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 12:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGSKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 06:19:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43108 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfGSKTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:19:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 311702000C9;
        Fri, 19 Jul 2019 12:19:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB23C20000A;
        Fri, 19 Jul 2019 12:19:01 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2266F402E3;
        Fri, 19 Jul 2019 18:18:56 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v2 3/4] arm64: ls1028ardb: Add support DP nodes for LS1028ARDB
Date:   Fri, 19 Jul 2019 18:09:41 +0800
Message-Id: <20190719100942.12016-3-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190719100942.12016-1-wen.he_1@nxp.com>
References: <20190719100942.12016-1-wen.he_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add HDP PHY Controller related nodes on the LS1028ARDB.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 9fb911317ecd..a907eb2c000b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -171,3 +171,15 @@
 &sata {
 	status = "okay";
 };
+
+&hdptx0 {
+	fsl,no_edid;
+	resolution = "3840x2160@60",
+		   "1920x1080@60",
+		   "1280x720@60",
+		   "720x480@60";
+	lane_mapping = <0x4e>;
+	edp_link_rate = <0x6>;
+	edp_num_lanes = <0x4>;
+	status = "okay";
+};
-- 
2.17.1

