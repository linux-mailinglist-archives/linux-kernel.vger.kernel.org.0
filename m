Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B490D17AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfEHNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 09:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHNcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:32:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9899A21530;
        Wed,  8 May 2019 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557322375;
        bh=Q2wrxlPrXLcFkDHNhcUzdjdBeRuKkQt34AEOPrdQUDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr+c3X9rASgpI35Qdpxy67TymBhuzxVhPo1ifFKaEqs9bpCvtsqHxuYeHgnErbt/c
         0sS7w3Vo37OUWuLbwcY0G6S8EB2lXldUGH4y6pGzf+B2+/n+qojJv/7I2PxwEFZeQh
         6oiX61moHUSUE3FkizcWLsno6c4brT0qarwBasZM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH v7 5/6] selftests/ftrace: Add user-memory access syntax testcase
Date:   Wed,  8 May 2019 22:32:49 +0900
Message-Id: <155732236945.12756.14753216541571057263.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155732230159.12756.15040196512285621636.stgit@devnote2>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user-memory access syntax testcase which checks
new user-memory access syntax and ustring type.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Add $argN availability check
---
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
new file mode 100644
index 000000000000..0f60087583d8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event user-memory access
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -q '\$arg<N>' README || exit_unresolved # depends on arch
+grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
+grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
+
+:;: "user-memory access syntax and ustring working on user memory";:
+echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
+	> kprobe_events
+
+grep myevent kprobe_events | \
+	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
+echo 1 > events/kprobes/myevent/enable
+echo > /dev/null
+echo 0 > events/kprobes/myevent/enable
+
+grep myevent trace | grep -q 'path="/dev/null" path2="/dev/null"'
+
+:;: "user-memory access syntax and ustring not working with kernel memory";:
+echo 'p:myevent vfs_symlink path=+0($arg3):ustring path2=+u0($arg3):string' \
+	> kprobe_events
+echo 1 > events/kprobes/myevent/enable
+ln -s foo $TMPDIR/bar
+echo 0 > events/kprobes/myevent/enable
+
+grep myevent trace | grep -q 'path=(fault) path2=(fault)'
+
+exit 0

