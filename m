Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C921052FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKUN2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfKUN2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:28:52 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89B12068D;
        Thu, 21 Nov 2019 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342931;
        bh=dgfpf5kJCL6nN+KhYLJcwVIUErWJUWLBSES+yxGfN88=;
        h=From:To:Cc:Subject:Date:From;
        b=bCPVxMcurfOZQt+tmrvZo4oejR5NlTCICTlBz7Dx6wr2G0+6usPjvmV9KA+7+w8mx
         3APzeA799/iteJuw9eU0nHSb95ZFI6up88KAqbk++0L/4vJnb77LiX8QZjd+zkuq1X
         QaGJWf7CSsiFR5Cm9HLYfHDpfsxkR1uzRIDPYiJg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tty: Fix Kconfig indentation, continued
Date:   Thu, 21 Nov 2019 21:28:47 +0800
Message-Id: <20191121132847.29015-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from seven spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/Kconfig     | 28 ++++++++++++++--------------
 drivers/tty/hvc/Kconfig | 28 ++++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index ec53b1d4aef3..a312cb33a99b 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -82,20 +82,20 @@ config HW_CONSOLE
 	default y
 
 config VT_HW_CONSOLE_BINDING
-       bool "Support for binding and unbinding console drivers"
-       depends on HW_CONSOLE
-       ---help---
-	 The virtual terminal is the device that interacts with the physical
-	 terminal through console drivers. On these systems, at least one
-	 console driver is loaded. In other configurations, additional console
-	 drivers may be enabled, such as the framebuffer console. If more than
-	 1 console driver is enabled, setting this to 'y' will allow you to
-	 select the console driver that will serve as the backend for the
-	 virtual terminals.
-
-	 See <file:Documentation/driver-api/console.rst> for more
-	 information. For framebuffer console users, please refer to
-	 <file:Documentation/fb/fbcon.rst>.
+	bool "Support for binding and unbinding console drivers"
+	depends on HW_CONSOLE
+	---help---
+	  The virtual terminal is the device that interacts with the physical
+	  terminal through console drivers. On these systems, at least one
+	  console driver is loaded. In other configurations, additional console
+	  drivers may be enabled, such as the framebuffer console. If more than
+	  1 console driver is enabled, setting this to 'y' will allow you to
+	  select the console driver that will serve as the backend for the
+	  virtual terminals.
+
+	  See <file:Documentation/driver-api/console.rst> for more
+	  information. For framebuffer console users, please refer to
+	  <file:Documentation/fb/fbcon.rst>.
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support" if EXPERT
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 94734ac511bf..6a3c97d345a0 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -70,22 +70,22 @@ config HVC_XEN_FRONTEND
 	  Xen driver for secondary virtual consoles
 
 config HVC_UDBG
-       bool "udbg based fake hypervisor console"
-       depends on PPC
-       select HVC_DRIVER
-       help
-	 This is meant to be used during HW bring up or debugging when
-	 no other console mechanism exist but udbg, to get you a quick
-	 console for userspace. Do NOT enable in production kernels. 
+	bool "udbg based fake hypervisor console"
+	depends on PPC
+	select HVC_DRIVER
+	help
+	  This is meant to be used during HW bring up or debugging when
+	  no other console mechanism exist but udbg, to get you a quick
+	  console for userspace. Do NOT enable in production kernels.
 
 config HVC_DCC
-       bool "ARM JTAG DCC console"
-       depends on ARM || ARM64
-       select HVC_DRIVER
-       help
-	 This console uses the JTAG DCC on ARM to create a console under the HVC
-	 driver. This console is used through a JTAG only on ARM. If you don't have
-	 a JTAG then you probably don't want this option.
+	bool "ARM JTAG DCC console"
+	depends on ARM || ARM64
+	select HVC_DRIVER
+	help
+	  This console uses the JTAG DCC on ARM to create a console under the HVC
+	  driver. This console is used through a JTAG only on ARM. If you don't have
+	  a JTAG then you probably don't want this option.
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-- 
2.17.1

