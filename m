Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644F9153AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBEWWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:21:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE0421927;
        Wed,  5 Feb 2020 22:21:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izT3H-001P0c-20; Wed, 05 Feb 2020 17:21:43 -0500
Message-Id: <20200205222142.949099420@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 17:21:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 2/5] bootconfig: Use bootconfig instead of boot config
References: <20200205222110.912457436@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Use "bootconfig" (1 word) instead of "boot config" (2 words)
in the boot message.

Link: http://lkml.kernel.org/r/158091059459.27924.14414336187441539879.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index f174a59d3903..2de2f9f7aab9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -372,7 +372,7 @@ static void __init setup_boot_config(const char *cmdline)
 
 	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
 	if (!copy) {
-		pr_err("Failed to allocate memory for boot config\n");
+		pr_err("Failed to allocate memory for bootconfig\n");
 		return;
 	}
 
@@ -380,9 +380,9 @@ static void __init setup_boot_config(const char *cmdline)
 	copy[size] = '\0';
 
 	if (xbc_init(copy) < 0)
-		pr_err("Failed to parse boot config\n");
+		pr_err("Failed to parse bootconfig\n");
 	else {
-		pr_info("Load boot config: %d bytes\n", size);
+		pr_info("Load bootconfig: %d bytes\n", size);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
-- 
2.24.1


