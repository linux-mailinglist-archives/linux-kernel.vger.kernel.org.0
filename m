Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED97D1738FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgB1NwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:52:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:60699 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgB1NwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:52:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 05:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="242383153"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 05:52:06 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 00/13] perf/x86: Add perf text poke events
Date:   Fri, 28 Feb 2020 15:51:12 +0200
Message-Id: <20200228135125.567-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to add a text poke event to record changes to kernel text
(i.e. self-modifying code) in order to support tracers like Intel PT
decoding through jump labels, kprobes and ftrace trampolines.

The first 8 patches make the kernel changes and the subsequent patches are
tools changes.

The next 4 patches add support for updating perf tools' data cache
with the changed bytes.

The last patch is an Intel PT specific tools change.

Patches also here:

	git://git.infradead.org/users/ahunter/linux-perf.git text_poke


Changes in V3:

  perf: Add perf text poke event

	To prevent warning, cast pointer to (unsigned long) not (u64)

  kprobes: Add symbols for kprobe insn pages

	Expand commit message
	Remove un-needed declarations of kprobe_cache_get_kallsym() and arch_kprobe_get_kallsym() when !CONFIG_KPROBES

  ftrace: Add symbols for ftrace trampolines

	Expand commit message
	Make ftrace_get_trampoline_kallsym() static

Changes in V2:

  perf: Add perf text poke event

	Separate out x86 changes
	The text poke event now has old len and new len
	Revised commit message

  perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers

	New patch containing x86 changes from original first patch

  kprobes: Add symbols for kprobe insn pages
  kprobes: Add perf ksymbol events for kprobe insn pages
  perf/x86: Add perf text poke events for kprobes
  ftrace: Add symbols for ftrace trampolines
  ftrace: Add perf ksymbol events for ftrace trampolines
  ftrace: Add perf text poke events for ftrace trampolines
  perf kcore_copy: Fix module map when there are no modules loaded
  perf evlist: Disable 'immediate' events last

	New patches

  perf tools: Add support for PERF_RECORD_TEXT_POKE

	The text poke event now has old len and new len
	Also select ksymbol events with text poke events

  perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL

	New patch

  perf intel-pt: Add support for text poke events

	The text poke event now has old len and new len
	Allow for the address not having a map yet


Changes since RFC:

  Dropped 'flags' from the new event.  The consensus seemed to be that text
  pokes should employ a scheme similar to x86's INT3 method instead.

  dropped tools patches already applied.


Example:

  For jump labels, the kernel needs
	CONFIG_JUMP_LABEL=y
  and also an easy to flip jump label is in sysctl_schedstats() which needs
	CONFIG_SCHEDSTATS=y
	CONFIG_PROC_SYSCTL=y
	CONFIG_SCHED_DEBUG=y

  Also note the 'sudo perf record' is put into the background which, as
  written, needs sudo credential caching (otherwise the background task
  will stop awaiting the sudo password), hence the 'sudo echo' to start.

Before:

  $ sudo echo
  $ sudo perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M &
  [1] 1640
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo bash -c 'echo 1 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  1
  $ sudo bash -c 'echo 0 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo kill 1640
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 16.635 MB perf.data.before ]
  $ perf script -i perf.data.before --itrace=e >/dev/null
  Warning:
  1946 instruction trace errors

After:

  $ sudo echo
  $ sudo perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
  [1] 1882
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo bash -c 'echo 1 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  1
  $ sudo bash -c 'echo 0 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo kill 1882
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 10.893 MB perf.data.after ]
  $ perf script -i perf.data.after --itrace=e
  $


Adrian Hunter (13):
      perf: Add perf text poke event
      perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
      kprobes: Add symbols for kprobe insn pages
      kprobes: Add perf ksymbol events for kprobe insn pages
      perf/x86: Add perf text poke events for kprobes
      ftrace: Add symbols for ftrace trampolines
      ftrace: Add perf ksymbol events for ftrace trampolines
      ftrace: Add perf text poke events for ftrace trampolines
      perf kcore_copy: Fix module map when there are no modules loaded
      perf evlist: Disable 'immediate' events last
      perf tools: Add support for PERF_RECORD_TEXT_POKE
      perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
      perf intel-pt: Add support for text poke events

 arch/x86/include/asm/kprobes.h            |  4 ++
 arch/x86/include/asm/text-patching.h      |  2 +
 arch/x86/kernel/alternative.c             | 70 +++++++++++++++++++-----
 arch/x86/kernel/ftrace.c                  | 37 ++++++++-----
 arch/x86/kernel/kprobes/core.c            |  7 +++
 arch/x86/kernel/kprobes/opt.c             | 18 ++++++-
 include/linux/ftrace.h                    | 15 ++++--
 include/linux/kprobes.h                   | 15 ++++++
 include/linux/perf_event.h                |  8 +++
 include/uapi/linux/perf_event.h           | 26 ++++++++-
 kernel/events/core.c                      | 90 ++++++++++++++++++++++++++++++-
 kernel/kallsyms.c                         | 32 +++++++++--
 kernel/kprobes.c                          | 57 ++++++++++++++++++++
 kernel/trace/ftrace.c                     | 53 +++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     | 26 ++++++++-
 tools/lib/perf/include/perf/event.h       |  9 ++++
 tools/perf/arch/x86/util/intel-pt.c       |  4 ++
 tools/perf/builtin-record.c               | 45 ++++++++++++++++
 tools/perf/util/dso.c                     |  3 ++
 tools/perf/util/dso.h                     |  1 +
 tools/perf/util/event.c                   | 40 ++++++++++++++
 tools/perf/util/event.h                   |  5 ++
 tools/perf/util/evlist.c                  | 31 +++++++----
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/evsel.c                   |  7 ++-
 tools/perf/util/intel-pt.c                | 75 ++++++++++++++++++++++++++
 tools/perf/util/machine.c                 | 49 +++++++++++++++++
 tools/perf/util/machine.h                 |  3 ++
 tools/perf/util/map.c                     |  5 ++
 tools/perf/util/map.h                     |  3 +-
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/record.c                  | 10 ++++
 tools/perf/util/record.h                  |  1 +
 tools/perf/util/session.c                 | 23 ++++++++
 tools/perf/util/symbol-elf.c              |  7 +++
 tools/perf/util/symbol.c                  |  1 +
 tools/perf/util/tool.h                    |  3 +-
 37 files changed, 736 insertions(+), 51 deletions(-)


Regards
Adrian
