Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA67103BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfKTNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbfKTNhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:16 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14FC22529;
        Wed, 20 Nov 2019 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257036;
        bh=AxbKwjFQI/6s3clvhOzB6xU8y6OAygNZ4nXJUqw7RRo=;
        h=From:To:Cc:Subject:Date:From;
        b=Js3JvDf7ylCsJgpXt/BSwr6AY2Cb666FOKlqzvXYJ5mEX1kuPtKY9ymdK04WMw/i8
         PI+c40zB2U+KsbiJhCoYEht7jx8Ga8j51MKiNxe8Sz2NphwiCNRwJuCWkXYX9S4Qwb
         xFrvUtER9blvO8LQsqBFdYLN0M3nIDrDy2z65ACk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:12 +0800
Message-Id: <20191120133712.12066-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/openrisc/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index bf326f0edd2f..1928e061ff96 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -13,7 +13,7 @@ config OPENRISC
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
 	select GPIOLIB
-        select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
@@ -51,12 +51,12 @@ config NO_IOPORT_MAP
 	def_bool y
 
 config TRACE_IRQFLAGS_SUPPORT
-        def_bool y
+	def_bool y
 
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config STACKTRACE_SUPPORT
 	def_bool y
@@ -89,8 +89,8 @@ config DCACHE_WRITETHROUGH
 	  If unsure say N here
 
 config OPENRISC_BUILTIN_DTB
-        string "Builtin DTB"
-        default ""
+	string "Builtin DTB"
+	default ""
 
 menu "Class II Instructions"
 
@@ -161,13 +161,13 @@ config OPENRISC_HAVE_SHADOW_GPRS
 	  On a unicore system it's safe to say N here if you are unsure.
 
 config CMDLINE
-        string "Default kernel command string"
-        default ""
-        help
-          On some architectures there is currently no way for the boot loader
-          to pass arguments to the kernel. For these architectures, you should
-          supply some command-line options at build time by entering them
-          here.
+	string "Default kernel command string"
+	default ""
+	help
+	  On some architectures there is currently no way for the boot loader
+	  to pass arguments to the kernel. For these architectures, you should
+	  supply some command-line options at build time by entering them
+	  here.
 
 menu "Debugging options"
 
@@ -185,7 +185,7 @@ config OPENRISC_ESR_EXCEPTION_BUG_CHECK
 	default n
 	help
 	  This option enables some checks that might expose some problems
-          in kernel.
+	  in kernel.
 
 	  Say N if you are unsure.
 
-- 
2.17.1

