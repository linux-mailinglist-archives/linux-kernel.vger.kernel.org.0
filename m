Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061A3165857
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 08:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBTH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 02:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgBTH0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:26:38 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A492465D;
        Thu, 20 Feb 2020 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582183598;
        bh=yD8l9vJjxB5YvN3w56a28sWrSLLJ5iXYBRvWc556vvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GaxNTdCvjjHVYXi/HUGyech3870lDYTAG5J2CLKEaFtvp0zfEP7kuNDnRZKwJ5Zjy
         iSj5/cPsAE6OWFXwL0YkI3TM4ZyCgNwa7gZKIUlf5MHGhfNzjwFUlMIG/P2iMs5Pnz
         yCzX6ts3ke4mT0Fl1A4cJQkltriSTPjAmJMg5Bis=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
Date:   Thu, 20 Feb 2020 16:26:33 +0900
Message-Id: <158218359349.6940.8460152450938960505.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158218358363.6940.18380270211351882136.stgit@devnote2>
References: <158218358363.6940.18380270211351882136.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set CONFIG_BOOT_CONFIG=n by default. This also warns
user if CONFIG_BOOT_CONFIG=n but "bootconfig" is given
in the kernel command line.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/Kconfig         |    2 +-
 init/main.c          |    8 ++++++++
 kernel/trace/Kconfig |    3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4a672c6629d0..824f3763260d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1218,7 +1218,7 @@ endif
 config BOOT_CONFIG
 	bool "Boot config support"
 	depends on BLK_DEV_INITRD
-	default y
+	default n
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
diff --git a/init/main.c b/init/main.c
index 59248717c925..680ff7123705 100644
--- a/init/main.c
+++ b/init/main.c
@@ -418,6 +418,14 @@ static void __init setup_boot_config(const char *cmdline)
 }
 #else
 #define setup_boot_config(cmdline)	do { } while (0)
+
+static int __init warn_bootconfig(char *str)
+{
+	pr_err("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
+	return 0;
+}
+early_param("bootconfig", warn_bootconfig);
+
 #endif
 
 /* Change NUL term back to "=", to make "param" the whole string. */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 91e885194dbc..795c3e02d3f1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -143,7 +143,8 @@ if FTRACE
 
 config BOOTTIME_TRACING
 	bool "Boot-time Tracing support"
-	depends on BOOT_CONFIG && TRACING
+	depends on TRACING
+	select BOOT_CONFIG
 	default y
 	help
 	  Enable developer to setup ftrace subsystem via supplemental

