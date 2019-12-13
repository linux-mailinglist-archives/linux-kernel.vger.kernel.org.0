Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9211DC0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 03:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfLMCTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 21:19:34 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34528 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLMCTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:19:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D8581A07E2;
        Fri, 13 Dec 2019 03:19:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE6B51A031C;
        Fri, 13 Dec 2019 03:19:27 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0600640296;
        Fri, 13 Dec 2019 10:19:21 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: ls1028a-rdb: enable emmc hs400 mode
Date:   Fri, 13 Dec 2019 10:18:38 +0800
Message-Id: <20191213021839.23517-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to enable emmc hs400 mode for ls1028ardb

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Change in v2:
		add Acked-by 

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 9720a190049f..61c4f772e3a6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -93,6 +93,8 @@
 
 &esdhc1 {
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
 	status = "okay";
 };
 
-- 
2.17.1

