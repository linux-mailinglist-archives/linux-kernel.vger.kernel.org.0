Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB662ABE2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfEZTTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 15:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfEZTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D227217D7;
        Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfQ-0004cz-CR; Sun, 26 May 2019 15:18:48 -0400
Message-Id: <20190526191848.266163206@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/16] kprobes: Initialize kprobes at postcore_initcall
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Initialize kprobes at postcore_initcall level instead of module_init
since kprobes is not a module, and it depends on only subsystems
initialized in core_initcall.
This will allow ftrace kprobe event to add new events when it is
initializing because ftrace kprobe event is initialized at
later initcall level.

Link: http://lkml.kernel.org/r/155851394736.15728.13626739508905120098.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b1ea30a5540e..54aaaad00a47 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2289,6 +2289,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
+postcore_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
@@ -2614,5 +2615,3 @@ static int __init debugfs_kprobe_init(void)
 
 late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
-
-module_init(init_kprobes);
-- 
2.20.1


