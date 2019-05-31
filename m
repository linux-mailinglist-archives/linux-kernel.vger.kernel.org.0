Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26FD31127
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfEaPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 11:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEaPTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:19:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51FA26B9B;
        Fri, 31 May 2019 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315993;
        bh=j3MJSP4jENoyEXuW0b5eN/KBy8+NvrnljBgllrbjJHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+MnYozEhZGvjTmwnkWPIB2FIf3F7wp+DTE1/hS87l45NN0+Dj4SfTeG2sfeG9rMi
         RQT7QUQLVOYul4W02QNlFtgimZhLvgXkPer05hw00COX7lzMArmL28RQH1UMZ3gAVE
         t6yIe0P+HOYSEQcujF3doneoikI0z4rPHRNhQJ+M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/21] selftests/ftrace: Add a testcase for kprobe multiprobe event
Date:   Sat,  1 Jun 2019 00:19:49 +0900
Message-Id: <155931598924.28323.10582408553302432697.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for kprobe event with multi-probe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
new file mode 100644
index 000000000000..44494bac86d1
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Create/delete multiprobe on kprobe event
+
+[ -f kprobe_events ] || exit_unsupported
+
+grep -q "Create/append/" README || exit_unsupported
+
+# Choose 2 symbols for target
+SYM1=_do_fork
+SYM2=do_exit
+EVENT_NAME=kprobes/testevent
+
+DEF1="p:$EVENT_NAME $SYM1"
+DEF2="p:$EVENT_NAME $SYM2"
+
+:;: "Define an event which has 2 probes" ;:
+echo $DEF1 >> kprobe_events
+echo $DEF2 >> kprobe_events
+cat kprobe_events | grep "$DEF1"
+cat kprobe_events | grep "$DEF2"
+
+:;: "Remove the event by name (should remove both)" ;:
+echo "-:$EVENT_NAME" >> kprobe_events
+test `cat kprobe_events | wc -l` -eq 0
+
+:;: "Remove just 1 event" ;:
+echo $DEF1 >> kprobe_events
+echo $DEF2 >> kprobe_events
+echo "-:$EVENT_NAME $SYM1" >> kprobe_events
+! cat kprobe_events | grep "$DEF1"
+cat kprobe_events | grep "$DEF2"
+
+:;: "Appending different type must fail" ;:
+! echo "$DEF1 \$stack" >> kprobe_events

