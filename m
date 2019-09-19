Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40997B8800
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 01:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406379AbfISXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 19:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405579AbfISXYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:24:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11EDD21A4C;
        Thu, 19 Sep 2019 23:24:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iB5mK-0000h5-8E; Thu, 19 Sep 2019 19:24:00 -0400
Message-Id: <20190919232400.143897364@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 19:23:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 5/8] selftests/ftrace: Select an existing function in kprobe_eventname
 test
References: <20190919232313.198902049@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Running the ftrace selftests on the latest kernel caused the
kprobe_eventname test to fail. It was due to the test that searches for
a function with at "dot" in the name and adding a probe to that.
Unfortunately, for this test, it picked:

 optimize_nops.isra.2.cold.4

Which happens to be marked as "__init", which means it no longer exists
in the kernel! (kallsyms keeps those function names around for tracing
purposes)

As only functions that still exist are in the
available_filter_functions file, as they are removed when the functions
are freed at boot or module exit, have the test search for a function
with ".isra." in the name as well as being in the
available_filter_functions (if the file exists).

Link: http://lkml.kernel.org/r/20190322150923.1b58eca5@gandalf.local.home

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/kprobe/kprobe_eventname.tc     | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 3fb70e01b1fe..3ff236719b6e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -24,7 +24,21 @@ test -d events/kprobes2/event2 || exit_failure
 
 :;: "Add an event on dot function without name" ;:
 
-FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
+find_dot_func() {
+	if [ ! -f available_filter_functions ]; then
+		grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "
+		return;
+	fi
+
+	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
+		if grep -s $f available_filter_functions; then
+			echo $f
+			break
+		fi
+	done
+}
+
+FUNC=`find_dot_func | tail -n 1`
 [ "x" != "x$FUNC" ] || exit_unresolved
 echo "p $FUNC" > kprobe_events
 EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
-- 
2.20.1


