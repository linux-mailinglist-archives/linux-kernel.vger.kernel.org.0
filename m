Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441A2134466
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 14:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgAHN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 08:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbgAHN55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:57:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BB020705;
        Wed,  8 Jan 2020 13:57:56 +0000 (UTC)
Date:   Wed, 8 Jan 2020 08:57:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>
Subject: [PATCH] tracing: Initialize ret in syscall_enter_define_fields()
Message-ID: <20200108085755.535e7362@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If syscall_enter_define_fields() is called on a system call with no
arguments, the return code variable "ret" will never get initialized.
Initialize it to zero.

Link: https://lore.kernel.org/r/0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw
Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 73140d80dd46..2978c29d87d4 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -274,7 +274,8 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	struct syscall_trace_enter trace;
 	struct syscall_metadata *meta = call->data;
 	int offset = offsetof(typeof(trace), args);
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	for (i = 0; i < meta->nb_args; i++) {
 		ret = trace_define_field(call, meta->types[i],
-- 
2.20.1

