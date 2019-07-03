Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41315ED00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 21:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGCTxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 15:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfGCTxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:53:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F429218BB;
        Wed,  3 Jul 2019 19:53:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hilJM-0006Wg-Gh; Wed, 03 Jul 2019 15:53:00 -0400
Message-Id: <20190703195300.408302485@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 15:50:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] ftrace/selftest: Test if set_event/ftrace_pid exists before writing
References: <20190703194959.596805445@goodmis.org>
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

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779ec11f61bd..a7b06291e32c 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
     reset_events_filter
     reset_ftrace_filter
     disable_events
-    echo > set_event_pid	# event tracer is always on
-    echo > set_ftrace_pid
+    [ -f set_event_pid ] && echo > set_event_pid  # event tracer is always on
+    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
     [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
-- 
2.20.1


