Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45761603DC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 12:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgBPLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 06:32:49 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:58851 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBPLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 06:32:49 -0500
Received: from localhost.localdomain ([93.22.36.246])
        by mwinf5d13 with ME
        id 3PYm220055JeL2d03PYmwf; Sun, 16 Feb 2020 12:32:47 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Feb 2020 12:32:47 +0100
X-ME-IP: 93.22.36.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: Kconfig: Fix some typo
Date:   Sun, 16 Feb 2020 12:32:42 +0100
Message-Id: <20200216113242.20268-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several variations of typo around functionality.ies

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b203290e7b9..cde9cef2e4a3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1201,7 +1201,7 @@ config AB8500_CORE
 	  chip. This connects to U8500 either on the SSP/SPI bus (deprecated
 	  since hardware version v1.0) or the I2C bus via PRCMU. It also adds
 	  the irq_chip parts for handling the Mixed Signal chip events.
-	  This chip embeds various other multimedia funtionalities as well.
+	  This chip embeds various other multimedia functionalities as well.
 
 config AB8500_DEBUG
 	bool "Enable debug info via debugfs"
@@ -1851,7 +1851,7 @@ config MFD_WM8994
 	  has on board GPIO and regulator functionality which is
 	  supported via the relevant subsystems.  This driver provides
 	  core support for the WM8994, in order to use the actual
-	  functionaltiy of the device other drivers must be enabled.
+	  functionality of the device other drivers must be enabled.
 
 config MFD_WM97xx
 	tristate "Wolfson Microelectronics WM97xx"
@@ -1864,7 +1864,7 @@ config MFD_WM97xx
 	  designed for smartphone applications.  As well as audio functionality
 	  it has on board GPIO and a touchscreen functionality which is
 	  supported via the relevant subsystems.  This driver provides core
-	  support for the WM97xx, in order to use the actual functionaltiy of
+	  support for the WM97xx, in order to use the actual functionality of
 	  the device other drivers must be enabled.
 
 config MFD_STW481X
@@ -1957,7 +1957,7 @@ config MFD_STPMIC1
 	  Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 has power on
 	  key, watchdog and regulator functionalities which are supported via
 	  the relevant subsystems. This driver provides core support for the
-	  STPMIC1. In order to use the actual functionaltiy of the device other
+	  STPMIC1. In order to use the actual functionality of the device other
 	  drivers must be enabled.
 
 	  To compile this driver as a module, choose M here: the
-- 
2.20.1

