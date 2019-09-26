Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958C3BE97A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfIZAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:01 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE974222C1;
        Thu, 26 Sep 2019 00:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569457979;
        bh=yEBqYbI5eRaDvwbMGyIxssHX0xPLXDf1vb8X96rbURE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djRN9fb6Fgf64fCiHzrt9Ab1YtHsevcK3WrJic8rzXPbpdJfRJBPgOL0LuC0S3ahg
         8SGymno0dBNNE2ADPbUsTsNdcG3lzVMq9Xrtk2QFofxg4TIipIbimV44P3oZWMrXq2
         JA+f1CtcYodyiWtZdrPQ730XwOc0QJQO93Zh4sno=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/66] perf record: Fix priv level with branch sampling for paranoid=2
Date:   Wed, 25 Sep 2019 21:31:39 -0300
Message-Id: <20190926003244.13962-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Now that the default perf_events paranoid level is set to 2, a regular
user cannot monitor kernel level activity anymore. As such, with the
following cmdline:

  $ perf record -e cycles date

The perf tool first tries cycles:uk but then falls back to cycles:u as
can be seen in the perf report --header-only output:

  cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
  event : name = cycles:u, , id = { 436186, ... }

This is okay as long as there is way to learn the priv level was changed
internally by the tool.

But consider a similar example:

  $ perf record -b -e cycles date
  Error:
  You may not have permission to collect stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_SYS_ADMIN).
...

Why is that treated differently given that the branch sampling inherits the
priv level of the first event in this case, i.e., cycles:u? It turns out
that the branch sampling code is more picky and also checks exclude_hv.

In the fallback path, perf record is setting exclude_kernel = 1, but it
does not change exclude_hv. This does not seem to match the restriction
imposed by paranoid = 2.

This patch fixes the problem by forcing exclude_hv = 1 in the fallback
for paranoid=2. With this in place:

  $ perf record -b -e cycles date
    cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
    event : name = cycles:u, , id = { 436847, ... }

And the command succeeds as expected.

V2 fix a white space.

Committer testing:

After aplying the patch we get:

  [acme@quaco ~]$ perf record -b -e cycles date
  WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
  check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.

  Samples in kernel functions may not be resolved if a suitable vmlinux
  file is not found in the buildid cache or in the vmlinux path.

  Samples in kernel modules won't be resolved at all.

  If some relocation was applied (e.g. kexec) symbols may be misresolved
  even with a suitable vmlinux or kallsyms file.

  Mon 23 Sep 2019 11:00:59 AM -03
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.005 MB perf.data (14 samples) ]
  [acme@quaco ~]$ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  [acme@quaco ~]$

That warning about restricted kernel maps will be suppressed in a follow
up patch, as perf_event_attr.exclude_kernel is set, i.e. no samples for
the kernel will be taken and thus no need for those maps.

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190920230356.41420-1-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8e335d168503..502bc3d50e0d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2535,9 +2535,11 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		if (evsel->name)
 			free(evsel->name);
 		evsel->name = new_name;
-		scnprintf(msg, msgsize,
-"kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
+		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
+			  "to fall back to excluding kernel and hypervisor "
+			  " samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
+		evsel->core.attr.exclude_hv     = 1;
 
 		return true;
 	}
-- 
2.21.0

