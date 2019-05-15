Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173151F3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfEOMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 08:16:54 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:56714 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbfEOMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:16:50 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id CcGm2000P3XaVaC01cGm6o; Wed, 15 May 2019 14:16:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hQspy-0002Tk-5Z; Wed, 15 May 2019 14:16:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hQspy-0007PS-2L; Wed, 15 May 2019 14:16:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alexander Shiyan <shc_work@mail.ru>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video: backlight: Drop default m for {LCD,BACKLIGHT_CLASS_DEVICE}
Date:   Wed, 15 May 2019 14:16:45 +0200
Message-Id: <20190515121645.28413-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running "make oldconfig" on a .config where
CONFIG_BACKLIGHT_LCD_SUPPORT is not set, two new config options
("Lowlevel LCD controls" and "Lowlevel Backlight controls") appear, both
defaulting to "m".

Drop the "default m", as options should default to disabled, and because
several driver config options already select LCD_CLASS_DEVICE or
BACKLIGHT_CLASS_DEVICE when needed.

Fixes: 8c5dc8d9f19c7992 ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/backlight/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 3ed1d9084f942688..8d138cc9eabb9cd2 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -9,7 +9,6 @@ menu "Backlight & LCD device support"
 #
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	default m
 	help
 	  This framework adds support for low-level control of LCD.
 	  Some framebuffer devices connect to platform-specific LCD modules
@@ -142,7 +141,6 @@ endif # LCD_CLASS_DEVICE
 #
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	default m
 	help
 	  This framework adds support for low-level control of the LCD
           backlight. This includes support for brightness and power.
-- 
2.17.1

