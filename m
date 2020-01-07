Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7E132280
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 10:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgAGJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 04:34:30 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57420 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgAGJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:34:29 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9637200734;
        Tue,  7 Jan 2020 10:34:27 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2479E200303;
        Tue,  7 Jan 2020 10:34:12 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 14F77402D9;
        Tue,  7 Jan 2020 16:57:05 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, bjorn.andersson@linaro.org, olof@lixom.net,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, ping.bai@nxp.com, abel.vesa@nxp.com,
        nsekhar@ti.com, t-kristo@ti.com, peng.fan@nxp.com,
        yuehaibing@huawei.com, aisheng.dong@nxp.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 5/5] arm64: defconfig: Enable CONFIG_CLK_IMX8MP by default
Date:   Tue,  7 Jan 2020 16:53:17 +0800
Message-Id: <1578387197-5750-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578387197-5750-1-git-send-email-Anson.Huang@nxp.com>
References: <1578387197-5750-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_CLK_IMX8MP by default to support i.MX8MP clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c7a94c4ff..8d9b9ce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -701,6 +701,7 @@ CONFIG_COMMON_CLK_PWM=y
 CONFIG_CLK_RASPBERRYPI=m
 CONFIG_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MN=y
+CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_TI_SCI_CLK=y
-- 
2.7.4

