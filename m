Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5003F191183
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgCXNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgCXNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA77820CC7;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=Iudx1SaPuA77OwushIhw/636atSAbLZx+o4BpBYw51M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=re5TheaC4j1aLvVt5LVd5vKa8rjkXjB+okATFobt3FHEwnVeedKR3JAT4jAd5r3bC
         ejW8+w4IuTVzSAmkE4hY0zwuHbcegJ8WZJ/h4SLkEIwGUAUZE/1Y0zXNqWJEUPh2Qp
         qrqS7aYEVMES9C/dDQLvbqzj86H2oTtU/RZERO9A=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjpt-0025rk-0K; Tue, 24 Mar 2020 14:43:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 14/20] media: Kconfig: move drivers-specific TTPCI_EEPROM Kconfig var
Date:   Tue, 24 Mar 2020 14:43:07 +0100
Message-Id: <a28d152444549befcd2ec215caf69ffe844ea21d.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is used only by av7110 and by an USB driver. As
the av7110 is the first DVB hardware, hardly found those
days, let's opt to place it at usb/Kconfig, as the driver
with needs it might have a longer lifetime.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig     | 8 --------
 drivers/media/usb/Kconfig | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index d6fb8411a8de..54daeba339b7 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -157,14 +157,6 @@ config DVB_CORE
 
 	help
 
-
-
-
-# This Kconfig option is used by both PCI and USB drivers
-config TTPCI_EEPROM
-	tristate
-	depends on I2C
-
 source "drivers/media/dvb-core/Kconfig"
 
 comment "Media drivers"
diff --git a/drivers/media/usb/Kconfig b/drivers/media/usb/Kconfig
index e678d3d11467..bf08393e38d1 100644
--- a/drivers/media/usb/Kconfig
+++ b/drivers/media/usb/Kconfig
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# This Kconfig option is also used by the legacy av7110 driver
+config TTPCI_EEPROM
+	tristate
+	depends on I2C
+
 if USB && MEDIA_SUPPORT
 
 menuconfig MEDIA_USB_SUPPORT
-- 
2.24.1

