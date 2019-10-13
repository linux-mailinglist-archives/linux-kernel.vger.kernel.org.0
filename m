Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD87FD5694
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfJMPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 11:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMPOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 11:14:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16B843082E03;
        Sun, 13 Oct 2019 15:14:31 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97BEC600C6;
        Sun, 13 Oct 2019 15:14:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/3] perf tools: Share struct map after clone
Date:   Sun, 13 Oct 2019 17:14:24 +0200
Message-Id: <20191013151427.11941-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 13 Oct 2019 15:14:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Andi reported that maps cloning is eating lot of memory and
it's probably unnecessary, because they keep the same data.

This 'maps sharing' seems to save lot of heap for reports with
many forks/cloned mmaps (over 60% in example below).

Profile kernel build:

  $ perf record make -j 40

Get heap profile (tools/perf directory):

  $ <install gperftools>
  $ make TCMALLOC=1
  $ HEAPPROFILE=/tmp/heapprof ./perf report -i perf.data --stdio > out
  $ pprof ./perf /tmp/heapprof.000*

Before:

  (pprof) top
  Total: 2335.5 MB
    1735.1  74.3%  74.3%   1735.1  74.3% memdup
     402.0  17.2%  91.5%    402.0  17.2% zalloc
     140.2   6.0%  97.5%    145.8   6.2% map__new
      33.6   1.4%  98.9%     33.6   1.4% symbol__new
      12.4   0.5%  99.5%     12.4   0.5% alloc_event
       6.2   0.3%  99.7%      6.2   0.3% nsinfo__new
       5.5   0.2% 100.0%      5.5   0.2% nsinfo__copy
       0.3   0.0% 100.0%      0.3   0.0% dso__new
       0.1   0.0% 100.0%      0.1   0.0% do_read_string
       0.0   0.0% 100.0%      0.0   0.0% __GI__IO_file_doallocate

After:

  (pprof) top
  Total: 784.5 MB
     385.8  49.2%  49.2%    385.8  49.2% memdup
     285.8  36.4%  85.6%    285.8  36.4% zalloc
      80.4  10.3%  95.9%     83.7  10.7% map__new
      19.1   2.4%  98.3%     19.1   2.4% symbol__new
       6.2   0.8%  99.1%      6.2   0.8% alloc_event
       3.6   0.5%  99.6%      3.6   0.5% nsinfo__new
       3.2   0.4% 100.0%      3.2   0.4% nsinfo__copy
       0.2   0.0% 100.0%      0.2   0.0% dso__new
       0.0   0.0% 100.0%      0.0   0.0% do_read_string
       0.0   0.0% 100.0%      0.0   0.0% elf_fill

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/map_shared

thanks,
jirka


---
Jiri Olsa (3):
      perf tools: Allow to build with -ltcmalloc
      perf tools: Separate shareable part of 'struct map' into 'struct map_shared'
      perf tools: Make 'struct map_shared' truly shared

 tools/perf/Makefile.config                             |   5 +++
 tools/perf/Makefile.perf                               |   2 +
 tools/perf/arch/arm/tests/dwarf-unwind.c               |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c             |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c           |   2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c      |   4 +-
 tools/perf/arch/powerpc/util/sym-handling.c            |   4 +-
 tools/perf/arch/s390/annotate/instructions.c           |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c               |   2 +-
 tools/perf/arch/x86/util/event.c                       |   6 +--
 tools/perf/builtin-annotate.c                          |   8 ++--
 tools/perf/builtin-inject.c                            |  10 +++--
 tools/perf/builtin-kallsyms.c                          |   7 ++-
 tools/perf/builtin-kmem.c                              |   2 +-
 tools/perf/builtin-mem.c                               |   6 +--
 tools/perf/builtin-report.c                            |  19 ++++----
 tools/perf/builtin-script.c                            |  16 +++----
 tools/perf/builtin-top.c                               |  15 ++++---
 tools/perf/builtin-trace.c                             |   2 +-
 tools/perf/tests/code-reading.c                        |  34 ++++++++-------
 tools/perf/tests/hists_common.c                        |   4 +-
 tools/perf/tests/hists_cumulate.c                      |   4 +-
 tools/perf/tests/hists_filter.c                        |   4 +-
 tools/perf/tests/hists_output.c                        |   2 +-
 tools/perf/tests/map_groups.c                          |  22 +++++-----
 tools/perf/tests/mmap-thread-lookup.c                  |   2 +-
 tools/perf/tests/vmlinux-kallsyms.c                    |  36 ++++++++--------
 tools/perf/ui/browsers/annotate.c                      |   4 +-
 tools/perf/ui/browsers/hists.c                         |  10 ++---
 tools/perf/ui/browsers/map.c                           |   4 +-
 tools/perf/ui/gtk/annotate.c                           |   2 +-
 tools/perf/util/annotate.c                             |  34 +++++++--------
 tools/perf/util/auxtrace.c                             |   2 +-
 tools/perf/util/bpf-event.c                            |   8 ++--
 tools/perf/util/build-id.c                             |   2 +-
 tools/perf/util/callchain.c                            |   6 +--
 tools/perf/util/db-export.c                            |   4 +-
 tools/perf/util/dso.c                                  |   2 +-
 tools/perf/util/event.c                                |   6 +--
 tools/perf/util/evsel_fprintf.c                        |   2 +-
 tools/perf/util/hist.c                                 |  10 ++---
 tools/perf/util/intel-pt.c                             |  42 ++++++++++--------
 tools/perf/util/machine.c                              |  76 ++++++++++++++++----------------
 tools/perf/util/map.c                                  | 226 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 tools/perf/util/map.h                                  |  32 ++++++++------
 tools/perf/util/probe-event.c                          |  32 +++++++-------
 tools/perf/util/scripting-engines/trace-event-perl.c   |   8 ++--
 tools/perf/util/scripting-engines/trace-event-python.c |  12 +++---
 tools/perf/util/sort.c                                 |  58 +++++++++++++------------
 tools/perf/util/symbol-elf.c                           |  28 ++++++------
 tools/perf/util/symbol.c                               |  80 +++++++++++++++++-----------------
 tools/perf/util/symbol_fprintf.c                       |   2 +-
 tools/perf/util/synthetic-events.c                     |  14 +++---
 tools/perf/util/thread.c                               |  14 +++---
 tools/perf/util/unwind-libdw.c                         |  16 ++++---
 tools/perf/util/unwind-libunwind-local.c               |  37 ++++++++--------
 tools/perf/util/unwind-libunwind.c                     |   4 +-
 tools/perf/util/vdso.c                                 |   2 +-
 58 files changed, 547 insertions(+), 456 deletions(-)
