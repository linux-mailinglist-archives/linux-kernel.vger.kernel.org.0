Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA5DE514
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 09:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfJUHEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 03:04:43 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:50654 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:04:42 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id G74g2100C05gfCL0674goJ; Mon, 21 Oct 2019 09:04:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iMRk8-0002V9-3E; Mon, 21 Oct 2019 09:04:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iMRk8-0002pQ-1B; Mon, 21 Oct 2019 09:04:40 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Max Staudt <max@enpas.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Enable ICY I2C and LTC2990 on Amiga
Date:   Mon, 21 Oct 2019 09:04:38 +0200
Message-Id: <20191021070438.10819-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the ICY I2C board for Amiga, which is typically
equipped with an LTC2990 hwmon chip, in the Amiga and multi-platform
defconfig files.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued for v5.5.

 arch/m68k/configs/amiga_defconfig | 6 +++++-
 arch/m68k/configs/multi_defconfig | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 6c9d4e47cf1745dd..619d30d663a2f515 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -421,11 +421,15 @@ CONFIG_INPUT_M68K_BEEP=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_PRINTER=m
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=m
+CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_ICY=m
 CONFIG_NTP_PPS=y
 CONFIG_PPS_CLIENT_LDISC=m
 CONFIG_PPS_CLIENT_PARPORT=m
 CONFIG_PTP_1588_CLOCK=m
-# CONFIG_HWMON is not set
+CONFIG_HWMON=m
+CONFIG_SENSORS_LTC2990=m
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
 CONFIG_FB_AMIGA=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 45654650f50a32fa..b764a0368a568be5 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -481,11 +481,15 @@ CONFIG_SERIAL_PMACZILOG_TTYS=y
 CONFIG_SERIAL_PMACZILOG_CONSOLE=y
 CONFIG_PRINTER=m
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=m
+CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_ICY=m
 CONFIG_NTP_PPS=y
 CONFIG_PPS_CLIENT_LDISC=m
 CONFIG_PPS_CLIENT_PARPORT=m
 CONFIG_PTP_1588_CLOCK=m
-# CONFIG_HWMON is not set
+CONFIG_HWMON=m
+CONFIG_SENSORS_LTC2990=m
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
 CONFIG_FB_AMIGA=y
-- 
2.17.1

