Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DCE43CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405605AbfJYGwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 02:52:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393177AbfJYGwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D56AB2C0;
        Fri, 25 Oct 2019 06:52:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] stacktrace: don't skip first entry on noncurrent tasks
Date:   Fri, 25 Oct 2019 08:52:26 +0200
Message-Id: <20191025065226.10196-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing cat /proc/<PID>/stack, the output is missing the first entry.
When the current code walks the stack starting in stack_trace_save_tsk,
it skips all scheduler functions (that's OK) plus one more function. But
this one function should be skipped only for the 'current' task as it is
stack_trace_save_tsk proper.

The original code (before the common infrastructure) skipped one
function only for the 'current' task -- see save_stack_trace_tsk before
3599fe12a125. So do so also in the new infrastructure now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 6d1f68b7e528..d06a2e4d0142 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -141,7 +141,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 	struct stacktrace_cookie c = {
 		.store	= store,
 		.size	= size,
-		.skip	= skipnr + 1,
+		/* skip this function if they are tracing us */
+		.skip	= skipnr + !!(current == tsk),
 	};
 
 	if (!try_get_task_stack(tsk))
-- 
2.23.0

