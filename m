Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C56118436B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCMJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 05:12:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53516 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMJMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:12:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7AB1E20121A;
        Fri, 13 Mar 2020 10:12:41 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C4206201237;
        Fri, 13 Mar 2020 10:12:35 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ACB42402D0;
        Fri, 13 Mar 2020 17:12:28 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org, olof@lixom.net,
        vkoul@kernel.org, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] arm64: defconfig: buildin FSL DDR PMU
Date:   Fri, 13 Mar 2020 17:05:48 +0800
Message-Id: <1584090348-28910-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buildin FSL DDR PMU since it is used quite often.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0f212889c931..9a84ef613c7d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -833,7 +833,7 @@ CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_ARM_SMMU_V3_PMU=m
-CONFIG_FSL_IMX8_DDR_PMU=m
+CONFIG_FSL_IMX8_DDR_PMU=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
-- 
2.17.1

