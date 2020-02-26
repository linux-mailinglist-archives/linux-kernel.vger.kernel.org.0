Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91CF16F419
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 01:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBZAMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 19:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZAMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:12:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA0120732;
        Wed, 26 Feb 2020 00:12:39 +0000 (UTC)
Date:   Tue, 25 Feb 2020 19:12:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING
 dependency issue
Message-ID: <20200225191237.03643f96@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since commit d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by
default") also changed the CONFIG_BOOTTIME_TRACING to select
CONFIG_BOOT_CONFIG to show the boot-time tracing on the menu,
it introduced wrong dependencies with BLK_DEV_INITRD as below.

WARNING: unmet direct dependencies detected for BOOT_CONFIG
  Depends on [n]: BLK_DEV_INITRD [=n]
  Selected by [y]:
  - BOOTTIME_TRACING [=y] && TRACING_SUPPORT [=y] && FTRACE [=y] && TRACING [=y]

This makes the CONFIG_BOOT_CONFIG selects CONFIG_BLK_DEV_INITRD to
fix this error and make CONFIG_BOOTTIME_TRACING=n by default, so
that both boot-time tracing and boot configuration off but those
appear on the menu list.

Link: http://lkml.kernel.org/r/158264140162.23842.11237423518607465535.stgit@devnote2

Fixes: d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by default")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Compiled-tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/Kconfig         | 2 +-
 kernel/trace/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a84e7aa89a29..8b4c3e8c05ea 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1217,7 +1217,7 @@ endif
 
 config BOOT_CONFIG
 	bool "Boot config support"
-	depends on BLK_DEV_INITRD
+	select BLK_DEV_INITRD
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 795c3e02d3f1..402eef84c859 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -145,7 +145,6 @@ config BOOTTIME_TRACING
 	bool "Boot-time Tracing support"
 	depends on TRACING
 	select BOOT_CONFIG
-	default y
 	help
 	  Enable developer to setup ftrace subsystem via supplemental
 	  kernel cmdline at boot time for debugging (tracing) driver
-- 
2.20.1

