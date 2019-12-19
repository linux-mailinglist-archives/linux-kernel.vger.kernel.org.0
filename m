Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2C126EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 21:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLSUWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 15:22:07 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:10052 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLSUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786908;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JtjZ1Nu6sfM70p1ADDmUjRAk5cVU1JLE+vgtlBuy/dc=;
        b=px11CRCCIOZLQdZ3EGxU4ACUinCC7UEad+bVPa9b5EcT0Banhgv4vlZi2OIEHQlBv/
        firHhvniQlgAnjf039ibBZwWXP2tYSsIkJgjKlMHaaHeV5T21S/ISc1/HMKd0i/iKMYT
        SGxaf3azXHu294ilSDyddvLRBfOl3ulRrgsvZlFHJR4kA4y6mgWJADeeC7LLEj4UOyQy
        Z5p+E4qnSEx5EE2lH0VLJbDkqrfX/QsKE6PGsoStAwwLQJowaWDgTgY+L0+6VnmXge4Z
        mjQ299DUTfoMFodXOMxWnx6nz3MaT4yVzNu2faKurtEY9my6UrsTjH2rUoA8arzGQ+s2
        NlDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLk3ZH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:46 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 9/9] ARM: defconfig: u8500: Enable new drivers for samsung-golden
Date:   Thu, 19 Dec 2019 21:20:52 +0100
Message-Id: <20191219202052.19039-10-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new device tree for samsung-golden depends on some additional
drivers that are not selected in the u8500 defconfig yet:

  - Bluetooth: hci_bcm
  - WiFi: brcmfmac
  - Touchscreen: atmel_mxt_ts
  - Vibrator: gpio-vibra
  - Sensors: inv_mpu6050 (IMU)

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/configs/u8500_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 822cddfbf1af..aff87c5ecc43 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -30,6 +30,9 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NETFILTER=y
 CONFIG_PHONET=y
+CONFIG_BT=y
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=y
 CONFIG_CFG80211_DEBUGFS=y
 CONFIG_MAC80211=y
@@ -42,6 +45,7 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
+CONFIG_BRCMFMAC=m
 CONFIG_CW1200=y
 CONFIG_CW1200_WLAN_SDIO=y
 CONFIG_INPUT_EVDEV=y
@@ -52,9 +56,11 @@ CONFIG_KEYBOARD_STMPE=y
 CONFIG_KEYBOARD_TC3589X=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_TOUCHSCREEN_BU21013=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_AB8500_PONKEY=y
+CONFIG_INPUT_GPIO_VIBRA=y
 CONFIG_RMI4_CORE=y
 CONFIG_RMI4_I2C=y
 CONFIG_RMI4_F11=y
@@ -62,7 +68,9 @@ CONFIG_RMI4_F11=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
 CONFIG_HW_RANDOM=y
+CONFIG_I2C_MUX=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_STMPE=y
@@ -113,6 +121,7 @@ CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
 CONFIG_IIO_ST_GYRO_3AXIS=y
+CONFIG_INV_MPU6050_I2C=y
 CONFIG_BH1780=y
 CONFIG_AK8974=y
 CONFIG_IIO_ST_MAGN_3AXIS=y
-- 
2.24.1

