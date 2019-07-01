Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEE44CD17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfFTLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 07:48:24 -0400
Received: from shell.v3.sk ([90.176.6.54]:51068 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfFTLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:48:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E3BB0CC114;
        Thu, 20 Jun 2019 13:48:21 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mjjGVXUkeHZO; Thu, 20 Jun 2019 13:48:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A4BABCC073;
        Thu, 20 Jun 2019 13:48:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yRqnqWP2PzPw; Thu, 20 Jun 2019 13:48:18 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 973DACC12B;
        Thu, 20 Jun 2019 13:48:18 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ARM: multi_v7_defconfig: enable MMP2 platform
Date:   Thu, 20 Jun 2019 13:48:16 +0200
Message-Id: <20190620114816.1387881-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell MMP/PXA/MMP2 platforms seem to be excluded from the defconfig
for no good reasons. Enable the DT-based boards and the modules for
their peripherals.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
index 6b748f214eae..ef91f41bd48a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -51,6 +51,8 @@ CONFIG_ARCH_MEDIATEK=3Dy
 CONFIG_ARCH_MESON=3Dy
 CONFIG_ARCH_MILBEAUT=3Dy
 CONFIG_ARCH_MILBEAUT_M10V=3Dy
+CONFIG_ARCH_MMP=3Dy
+CONFIG_MACH_MMP2_DT=3Dy
 CONFIG_ARCH_MVEBU=3Dy
 CONFIG_MACH_ARMADA_370=3Dy
 CONFIG_MACH_ARMADA_375=3Dy
@@ -278,6 +280,7 @@ CONFIG_INPUT_EVDEV=3Dy
 CONFIG_KEYBOARD_QT1070=3Dm
 CONFIG_KEYBOARD_GPIO=3Dy
 CONFIG_KEYBOARD_TEGRA=3Dy
+CONFIG_KEYBOARD_PXA27x=3Dm
 CONFIG_KEYBOARD_SAMSUNG=3Dm
 CONFIG_KEYBOARD_ST_KEYSCAN=3Dy
 CONFIG_KEYBOARD_SPEAR=3Dy
@@ -312,6 +315,7 @@ CONFIG_SERIAL_8250_EM=3Dy
 CONFIG_SERIAL_8250_OMAP=3Dy
 CONFIG_SERIAL_8250_MT6577=3Dy
 CONFIG_SERIAL_8250_UNIPHIER=3Dy
+CONFIG_SERIAL_8250_PXA=3Dm
 CONFIG_SERIAL_OF_PLATFORM=3Dy
 CONFIG_SERIAL_AMBA_PL011=3Dy
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
@@ -589,6 +593,7 @@ CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
 CONFIG_MEDIA_USB_SUPPORT=3Dy
 CONFIG_USB_VIDEO_CLASS=3Dm
 CONFIG_V4L_PLATFORM_DRIVERS=3Dy
+CONFIG_VIDEO_MMP_CAMERA=3Dm
 CONFIG_VIDEO_STM32_DCMI=3Dm
 CONFIG_VIDEO_SAMSUNG_EXYNOS4_IS=3Dm
 CONFIG_VIDEO_S5P_FIMC=3Dm
@@ -681,6 +686,9 @@ CONFIG_SND_ATMEL_SOC_PDMIC=3Dm
 CONFIG_SND_ATMEL_SOC_I2S=3Dm
 CONFIG_SND_BCM2835_SOC_I2S=3Dm
 CONFIG_SND_SOC_FSL_SAI=3Dm
+CONFIG_SND_MMP_SOC=3Dy
+CONFIG_SND_PXA_SOC_SSP=3Dm
+CONFIG_SND_PXA910_SOC=3Dm
 CONFIG_SND_SOC_ROCKCHIP=3Dm
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=3Dm
 CONFIG_SND_SOC_ROCKCHIP_MAX98090=3Dm
@@ -719,6 +727,7 @@ CONFIG_USB_EHCI_HCD=3Dy
 CONFIG_USB_EHCI_HCD_STI=3Dy
 CONFIG_USB_EHCI_TEGRA=3Dy
 CONFIG_USB_EHCI_EXYNOS=3Dy
+CONFIG_USB_EHCI_MV=3Dm
 CONFIG_USB_OHCI_HCD=3Dy
 CONFIG_USB_OHCI_HCD_STI=3Dy
 CONFIG_USB_OHCI_EXYNOS=3Dm
@@ -788,6 +797,7 @@ CONFIG_MMC_SDHCI_DOVE=3Dy
 CONFIG_MMC_SDHCI_TEGRA=3Dy
 CONFIG_MMC_SDHCI_S3C=3Dy
 CONFIG_MMC_SDHCI_PXAV3=3Dy
+CONFIG_MMC_SDHCI_PXAV2=3Dm
 CONFIG_MMC_SDHCI_SPEAR=3Dy
 CONFIG_MMC_SDHCI_S3C_DMA=3Dy
 CONFIG_MMC_SDHCI_BCM_KONA=3Dy
@@ -853,6 +863,7 @@ CONFIG_RTC_DRV_DA9063=3Dm
 CONFIG_RTC_DRV_EFI=3Dm
 CONFIG_RTC_DRV_DIGICOLOR=3Dm
 CONFIG_RTC_DRV_S3C=3Dm
+CONFIG_RTC_DRV_SA1100=3Dm
 CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_AT91RM9200=3Dm
 CONFIG_RTC_DRV_AT91SAM9=3Dm
--=20
2.21.0

