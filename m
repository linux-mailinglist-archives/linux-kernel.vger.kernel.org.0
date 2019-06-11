Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E233D621
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392303AbfFKTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388445AbfFKTBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:01:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D3C2184D;
        Tue, 11 Jun 2019 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279710;
        bh=heC0QYeS5YTC+MsORVxIBCYxOA5dsTe559ukfImRyFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWvxEU+c+a48E8JEIaDFyUT1E12DPO1UTZZ3RLeENEUkHjxuxE98B8UfY6GwsbaOD
         PF05DYDo+y0owE6IjDprbv5upn220jTQggsMCQlpmjjKDIDLb75RYlgcRGVjI8b34X
         aeQLNTFWpb99lqEcEzdi+yohgY5xMXsDexRrhFsY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Song Liu <songliubraving@fb.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/85] perf trace: Exit when failing to build eBPF program
Date:   Tue, 11 Jun 2019 15:58:19 -0300
Message-Id: <20190611185911.11645-34-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

On my Juno board with ARM64 CPUs, perf trace command reports the eBPF
program building failure but the command will not exit and continue to
run.  If we define an eBPF event in config file, the event will be
parsed with below flow:

  perf_config()
    `> trace__config()
         `> parse_events_option()
              `> parse_events__scanner()
                   `-> parse_events_parse()
                         `> parse_events_load_bpf()
                              `> llvm__compile_bpf()

Though the low level functions return back error values when detect eBPF
building failure, but parse_events_option() returns 1 for this case and
trace__config() passes 1 to perf_config(); perf_config() doesn't treat
the returned value 1 as failure and it continues to parse other
configurations.  Thus the perf command continues to run even without
enabling eBPF event successfully.

This patch changes error handling in trace__config(), when it detects
failure it will return -1 rather than directly pass error value (1);
finally, perf_config() will directly bail out and perf will exit for
this case.

Committer notes:

Simplified the patch to just check directly the return of
parse_events_option() and it it is non-zero, change err from its initial
zero value to -1.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: ac96287cae08 ("perf trace: Allow specifying a set of events to add in perfconfig")
Link: https://lkml.kernel.org/n/tip-x4i63f5kscykfok0hqim3zma@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f7e4e50bddbd..1a2a605cf068 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3703,7 +3703,12 @@ static int trace__config(const char *var, const char *value, void *arg)
 		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
-		err = parse_events_option(&o, value, 0);
+		/*
+		 * We can't propagate parse_event_option() return, as it is 1
+		 * for failure while perf_config() expects -1.
+		 */
+		if (parse_events_option(&o, value, 0))
+			err = -1;
 	} else if (!strcmp(var, "trace.show_timestamp")) {
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
-- 
2.20.1

