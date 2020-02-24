Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF87016B4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBXXIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:08:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44930 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgBXXIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B27391B0790;
        Tue, 25 Feb 2020 00:08:30 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D1861B0786;
        Tue, 25 Feb 2020 00:08:30 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id C1AF540A55;
        Mon, 24 Feb 2020 16:08:29 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 03/15] arm64: defconfig: Enable QorIQ DPAA1 drivers
Date:   Mon, 24 Feb 2020 17:07:58 -0600
Message-Id: <1582585690-463-4-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables drivers for NXP DPAA1 framework and related Ethernet device which
can be found on QorIQ SoCs such as LS1043a and LS1046a.  They are enabled
as built-in to boot from network without an initramfs.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 747f233aca72..54ac7c1558d8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -263,6 +263,8 @@ CONFIG_BNX2X=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
 CONFIG_FEC=y
+CONFIG_FSL_FMAN=y
+CONFIG_FSL_DPAA_ETH=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -755,6 +757,7 @@ CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_OWL_PM_DOMAINS=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_FSL_DPAA=y
 CONFIG_IMX_SCU_SOC=y
 CONFIG_QCOM_AOSS_QMP=y
 CONFIG_QCOM_GENI_SE=y
-- 
2.17.1

