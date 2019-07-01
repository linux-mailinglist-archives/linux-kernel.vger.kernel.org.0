Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD917AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfEHNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 09:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHNb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:31:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5283205ED;
        Wed,  8 May 2019 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557322317;
        bh=6SqqVrYzWTK+YoKmBvviC94vExCJXee2HMET0tL2OQU=;
        h=From:To:Cc:Subject:Date:From;
        b=F1TkQBBcELv5TIIk4+YNR3CJ6Wd9khr6tnIieEBcJnsf8FtS8p2I8bZOLeKlYS66L
         aMFgPdcNCsZaqF9CCwX5JRlpqzQ9ofylkfzh3wFZm5zTTQAv0PVO9MVQhrE9aEDcFP
         /0SyOodD3ybg3ddr7AS0VpMdXJrFnS0jJV7HV7nc=
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
Subject: [PATCH v7 0/6] tracing/probes: uaccess: Add support user-space access
Date:   Wed,  8 May 2019 22:31:41 +0900
Message-Id: <155732230159.12756.15040196512285621636.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the v7 series of probe-event to support user-space access.
Previous version is here.

https://lkml.kernel.org/r/155289137555.7218.9282784065958321058.stgit@devnote2

In this version, I fixed some documentation according to Steve's
comment. This can be applied against the latest tracing/for-next
+ probeevent bugfix.

https://lkml.kernel.org/r/155723732200.9149.10482668315693777743.stgit@devnote2

Changes in v7:
 - [4/6] Fix typos and update document according to Steve's comment. 

In summary, strncpy_from_user() should work as below

 - strncpy_from_user() can access user memory with set_fs(USER_DS)
   in task context

 - strncpy_from_user() can access kernel memory with set_fs(KERNEL_DS)
   in task context (e.g. devtmpfsd and init)

 - strncpy_from_user() can access user/kernel memory (depends on DS)
   in IRQ context if pagefault is disabled. (both verified)

Note that this changes the warning behavior when
CONFIG_DEBUG_ATOMIC_SLEEP=y, it still warns when
__copy_from_user_inatomic() is called in IRQ context, but don't
warn if pagefault is disabled because it will not sleep in
atomic.

====
Kprobe event user-space memory access features:

For user-space access extension, this series adds 2 features,
"ustring" type and user-space dereference syntax. "ustring" is
used for recording a null-terminated string in user-space from
kprobe events.

"ustring" type is easy, it is able to use instead of "string"
type, so if you want to record a user-space string via
"__user char *", you can use ustring type instead of string.
For example,

echo 'p do_sys_open path=+0($arg2):ustring' >> kprobe_events

will record the path string from user-space.

The user-space dereference syntax is also simple. Thi just
adds 'u' prefix before an offset value.

   +|-u<OFFSET>(<FETCHARG>)

e.g. +u8(%ax), +u0(+0(%si))

This is more generic. If you want to refer the variable in user-
space from its address or access a field in data structure in
user-space, you need to use this.

For example, if you probe do_sched_setscheduler(pid, policy,
param) and record param->sched_priority, you can add new
probe as below;
    
   p do_sched_setscheduler priority=+u0($arg3)

Actually, with this feature, "ustring" type is not absolutely
necessary, because these are same meanings.

  +0($arg2):ustring == +u0($arg2):string

Note that kprobe event provides these methods, but it doesn't
change it from kernel to user automatically because we do not
know whether the given address is in userspace or kernel on
some arch.


Thank you,

---

Masami Hiramatsu (6):
      x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
      uaccess: Add non-pagefault user-space read functions
      tracing/probe: Add ustring type for user-space string
      tracing/probe: Support user-space dereference
      selftests/ftrace: Add user-memory access syntax testcase
      perf-probe: Add user memory access attribute support


 Documentation/trace/kprobetrace.rst                |   28 ++++-
 Documentation/trace/uprobetracer.rst               |   10 +-
 arch/x86/include/asm/uaccess.h                     |    4 +
 include/linux/uaccess.h                            |   19 +++
 kernel/trace/trace.c                               |    7 +
 kernel/trace/trace_kprobe.c                        |   35 ++++++
 kernel/trace/trace_probe.c                         |   37 +++++-
 kernel/trace/trace_probe.h                         |    3 +
 kernel/trace/trace_probe_tmpl.h                    |   37 +++++-
 kernel/trace/trace_uprobe.c                        |   19 +++
 mm/maccess.c                                       |  117 +++++++++++++++++++-
 tools/perf/Documentation/perf-probe.txt            |    3 -
 tools/perf/util/probe-event.c                      |   11 ++
 tools/perf/util/probe-event.h                      |    2 
 tools/perf/util/probe-file.c                       |    7 +
 tools/perf/util/probe-file.h                       |    1 
 tools/perf/util/probe-finder.c                     |   19 ++-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   32 +++++
 18 files changed, 350 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
