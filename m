Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1729BE9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390789AbfIZAgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390684AbfIZAgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:37 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40BC21D6C;
        Thu, 26 Sep 2019 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458196;
        bh=dSYTLI9a2bg9fy8mLt8SIa/dAisD6gBb7UAeoj5auPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sor2F1JMGR8dnIzoilo6Rcr7gQgUykdHE5TtgeFoLLea9J0SfoGy1mr3nZJkGNdpS
         nLUpvgqUpMvqMP8k20FgTfSB5iYDZvsS5vHupCHATwRNCutyMRQPVufR2pOxA8U/Jr
         DpqVgfXgdno2aQ9wTmdngEvNqDWwn0/ReRNdiLWo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 61/66] perf stat: Fix free memory access / memory leaks in metrics
Date:   Wed, 25 Sep 2019 21:32:39 -0300
Message-Id: <20190926003244.13962-62-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Make sure to not free the name passed in by the caller, but free all the
allocated ids when parsing expressions.

The loop at the end knows that the first entry shouldn't be freed, so
make sure the caller name is the first entry.

Fixes

  % perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2

  valgrind:
       1.009943231 ==21527== Invalid read of size 1
  ==21527==    at 0x483CB74: strcmp (vg_replace_strmem.c:849)
  ==21527==    by 0x582CF8: collect_all_aliases (stat-display.c:554)
  ==21527==    by 0x582EB3: collect_data (stat-display.c:577)
  ==21527==    by 0x583A32: print_counter_aggr (stat-display.c:806)
  ==21527==    by 0x584FAD: perf_evlist__print_counters (stat-display.c:1200)
  ==21527==    by 0x45133A: print_counters (builtin-stat.c:655)
  ==21527==    by 0x450629: process_interval (builtin-stat.c:353)
  ==21527==    by 0x450FBD: __run_perf_stat (builtin-stat.c:564)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==  Address 0x12826cd0 is 0 bytes inside a block of size 25 free'd
  ==21527==    at 0x4839A0C: free (vg_replace_malloc.c:540)
  ==21527==    by 0x627041: __zfree (zalloc.c:13)
  ==21527==    by 0x57F66A: generic_metric (stat-shadow.c:814)
  ==21527==    by 0x580B21: perf_stat__print_shadow_stats (stat-shadow.c:1057)
  ==21527==    by 0x58418E: print_metric_headers (stat-display.c:943)
  ==21527==    by 0x5844BC: print_interval (stat-display.c:1004)
  ==21527==    by 0x584DEB: perf_evlist__print_counters (stat-display.c:1172)
  ==21527==    by 0x45133A: print_counters (builtin-stat.c:655)
  ==21527==    by 0x450629: process_interval (builtin-stat.c:353)
  ==21527==    by 0x450FBD: __run_perf_stat (builtin-stat.c:564)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==  Block was alloc'd at
  ==21527==    at 0x483880B: malloc (vg_replace_malloc.c:309)
  ==21527==    by 0x51677DE: strdup (in /usr/lib64/libc-2.29.so)
  ==21527==    by 0x506457: parse_events_name (parse-events.c:1754)
  ==21527==    by 0x5550BB: parse_events_parse (parse-events.y:214)
  ==21527==    by 0x50694D: parse_events__scanner (parse-events.c:1887)
  ==21527==    by 0x506AEF: parse_events (parse-events.c:1927)
  ==21527==    by 0x521D8B: metricgroup__parse_groups (metricgroup.c:527)
  ==21527==    by 0x45156F: parse_metric_groups (builtin-stat.c:721)
  ==21527==    by 0x6228A9: get_value (parse-options.c:243)
  ==21527==    by 0x62363F: parse_short_opt (parse-options.c:348)
  ==21527==    by 0x62363F: parse_options_step (parse-options.c:536)
  ==21527==    by 0x62363F: parse_options_subcommand (parse-options.c:651)
  ==21527==    by 0x453C1D: cmd_stat (builtin-stat.c:1718)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)

and also a leak report.

Committer testing:

Before:

  # perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2
  #           time      CPU_Utilization
       1.000470810                      free(): double free detected in tcache 2
  Aborted (core dumped)
  #

After:

  # perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2
  #           time      CPU_Utilization
       1.000494752                  0.1
       2.001105112                  0.1
  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20190923233339.25326-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 70c87fdb2a43..2c41d47f6f83 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -738,6 +738,8 @@ static void generic_metric(struct perf_stat_config *config,
 	char *n, *pn;
 
 	expr__ctx_init(&pctx);
+	/* Must be first id entry */
+	expr__add_id(&pctx, name, avg);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -776,8 +778,6 @@ static void generic_metric(struct perf_stat_config *config,
 			expr__add_id(&pctx, n, avg_stats(stats)*scale);
 	}
 
-	expr__add_id(&pctx, name, avg);
-
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
 
-- 
2.21.0

