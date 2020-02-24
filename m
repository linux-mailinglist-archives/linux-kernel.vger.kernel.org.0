Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C264C16AD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 18:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBXRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 12:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgBXRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DF622527;
        Mon, 24 Feb 2020 17:21:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPx-001Agm-NB; Mon, 24 Feb 2020 12:21:17 -0500
Message-Id: <20200224172117.582148505@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-linus][PATCH 11/15] tools/bootconfig: Remove unneeded error message silencer
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Remove error message silent knob, we don't need it anymore
because we can check if there is a bootconfig by checking
the magic word.
If there is a magic word, but failed to load a bootconfig
from initrd, there is a real problem.

Link: http://lkml.kernel.org/r/158220113256.26565.14264598654427773104.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/include/linux/printk.h | 5 +----
 tools/bootconfig/main.c                 | 8 --------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
index e978a63d3222..036e667596eb 100644
--- a/tools/bootconfig/include/linux/printk.h
+++ b/tools/bootconfig/include/linux/printk.h
@@ -4,10 +4,7 @@
 
 #include <stdio.h>
 
-/* controllable printf */
-extern int pr_output;
-#define printk(fmt, ...)	\
-	(pr_output ? printf(fmt, ##__VA_ARGS__) : 0)
+#define printk(fmt, ...) printf(fmt, ##__VA_ARGS__)
 
 #define pr_err printk
 #define pr_warn	printk
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 742271f019a9..a9b97814d1a9 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -14,8 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
-int pr_output = 1;
-
 static int xbc_show_array(struct xbc_node *node)
 {
 	const char *val;
@@ -227,13 +225,7 @@ int delete_xbc(const char *path)
 		return -errno;
 	}
 
-	/*
-	 * Suppress error messages in xbc_init() because it can be just a
-	 * data which concidentally matches the size and checksum footer.
-	 */
-	pr_output = 0;
 	size = load_xbc_from_initrd(fd, &buf);
-	pr_output = 1;
 	if (size < 0) {
 		ret = size;
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
-- 
2.25.0


