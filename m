Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FB182545
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 23:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgCKWyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 18:54:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37730 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbgCKWyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:54:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 412A91A0CAF;
        Wed, 11 Mar 2020 23:54:09 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A7A71A0CAE;
        Wed, 11 Mar 2020 23:54:09 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8EC4040A5F;
        Wed, 11 Mar 2020 15:54:08 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 08/15] arm64: defconfig: Enable ARM SBSA watchdog driver
Date:   Wed, 11 Mar 2020 17:53:10 -0500
Message-Id: <20200311225317.11198-9-leoyang.li@nxp.com>
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

Enables ARM generic SBSA compatible watchdog driver for NXP LX2160a SoC.
Enabled as built-in for it is a core feature.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 996dc749ea5c..d2d5d470a6fc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -480,6 +480,7 @@ CONFIG_QCOM_SPMI_TEMP_ALARM=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
+CONFIG_ARM_SBSA_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=m
-- 
2.17.1

