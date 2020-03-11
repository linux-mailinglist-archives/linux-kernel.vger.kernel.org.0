Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D25182537
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgCKWyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 18:54:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42794 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731397AbgCKWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:54:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08376200BE2;
        Wed, 11 Mar 2020 23:54:09 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C440F200BDA;
        Wed, 11 Mar 2020 23:54:08 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 4DF9A40AB3;
        Wed, 11 Mar 2020 15:54:08 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Date:   Wed, 11 Mar 2020 17:53:09 -0500
Message-Id: <20200311225317.11198-8-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20200311225317.11198-1-leoyang.li@nxp.com>
References: <20200311225317.11198-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the generic QorIQ cpufreq driver to support frequency scaling
for various QorIQ SoCs.  Enabled as built-in as it is a core feature.

Remove CONFIG_CLK_QORIQ as it is seleted by CONFIG_QORIQ_CPUFREQ.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e97ef8b944b8..996dc749ea5c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -90,6 +90,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
 CONFIG_ARM_QCOM_CPUFREQ_HW=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
 CONFIG_ARM_TEGRA186_CPUFREQ=y
+CONFIG_QORIQ_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
@@ -722,7 +723,6 @@ CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
-CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_CLK_RASPBERRYPI=m
 CONFIG_CLK_IMX8MM=y
-- 
2.17.1

