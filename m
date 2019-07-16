Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD71C6AF79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbfGPTA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 15:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388448AbfGPTA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:00:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2344217F9;
        Tue, 16 Jul 2019 19:00:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hnSh6-0006Cv-V6; Tue, 16 Jul 2019 15:00:56 -0400
Message-Id: <20190716190056.854959986@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 16 Jul 2019 15:00:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 2/5] ftrace/selftest: Test if set_event/ftrace_pid exists before writing
References: <20190716190014.840939538@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

While testing on a very old kernel (3.5), the tests failed because the write
to set_event_pid in the setup code, did not exist. The tests themselves
could pass, but the setup failed causing an error.

Other files test for existance before writing to them. Do the same for
set_event_pid and set_ftrace_pid.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779ec11f61bd..1d96c5f7e402 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
     reset_events_filter
     reset_ftrace_filter
     disable_events
-    echo > set_event_pid	# event tracer is always on
-    echo > set_ftrace_pid
+    [ -f set_event_pid ] && echo > set_event_pid
+    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
     [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
-- 
2.20.1


