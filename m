Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4B16B4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgBXXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:08:43 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45024 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgBXXIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EFC81A4BA6;
        Tue, 25 Feb 2020 00:08:33 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DD61A1B0798;
        Tue, 25 Feb 2020 00:08:32 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 785F140A55;
        Mon, 24 Feb 2020 16:08:32 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 14/15] arm64: defconfig: Enable PHY devices used on QorIQ boards
Date:   Mon, 24 Feb 2020 17:08:09 -0600
Message-Id: <1582585690-463-15-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables various PHY device drivers and PHY MUX drivers used on QorIQ
reference boards supported in mainline kernel.

Enabled as built-in to boot from network without an initramfs.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b092adecf724..a6e9d046e65d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -306,13 +306,17 @@ CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
+CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
+CONFIG_AQUANTIA_PHY=y
 CONFIG_MARVELL_PHY=m
 CONFIG_MARVELL_10G_PHY=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
+CONFIG_MICROSEMI_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=m
 CONFIG_ROCKCHIP_PHY=y
+CONFIG_VITESSE_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
@@ -880,6 +884,7 @@ CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_MUX_MMIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.17.1

