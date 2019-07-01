Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902CF457AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 10:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfFNIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 04:36:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59606 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfFNIgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:36:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE0501A05C7;
        Fri, 14 Jun 2019 10:36:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 38AC51A05EE;
        Fri, 14 Jun 2019 10:36:19 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2623840310;
        Fri, 14 Jun 2019 16:36:01 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, maxime.ripard@bootlin.com,
        horms+renesas@verge.net.au, olof@lixom.net,
        jagan@amarulasolutions.com, bjorn.andersson@linaro.org,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        enric.balletbo@collabora.com, aisheng.dong@nxp.com,
        ping.bai@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 5/5] arm64: defconfig: Select CONFIG_CLK_IMX8MN by default
Date:   Fri, 14 Jun 2019 16:37:47 +0800
Message-Id: <20190614083747.28762-5-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614083747.28762-1-Anson.Huang@nxp.com>
References: <20190614083747.28762-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Enable CONFIG_CLK_IMX8MN to support i.MX8MN clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3dfbd6a..b2de9d0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -658,6 +658,7 @@ CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_TI_SCI_CLK=y
-- 
2.7.4

