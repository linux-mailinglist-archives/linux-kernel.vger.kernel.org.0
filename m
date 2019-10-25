Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B8E4671
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438194AbfJYI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:58:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:14208 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfJYI6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:58:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="204500111"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 01:58:13 -0700
Received: from [10.125.252.238] (abudanko-mobl.ccr.corp.intel.com [10.125.252.238])
        by linux.intel.com (Postfix) with ESMTP id 14322580104;
        Fri, 25 Oct 2019 01:58:09 -0700 (PDT)
Subject: [PATCH v5 1/4] perf/core,x86: introduce swap_task_ctx() method at
 struct pmu
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6750143f-f237-35a4-396e-0cc5c8a1fbd4@linux.intel.com>
Date:   Fri, 25 Oct 2019 11:58:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Declare swap_task_ctx() methods at the generic and x86 specific
pmu types to bridge calls to platform specific pmu code on optimized
context switch path between equivalent task perf event contexts.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/perf_event.h | 8 ++++++++
 include/linux/perf_event.h   | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf4ebc1..5384317eaa16 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -682,6 +682,14 @@ struct x86_pmu {
 	 */
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
+	/*
+	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
+	 * switch helper to bridge calls from perf/core to perf/x86.
+	 * See struct pmu::swap_task_ctx() usage for examples;
+	 */
+	void		(*swap_task_ctx)(struct perf_event_context *prev,
+					 struct perf_event_context *next);
+
 	/*
 	 * AMD bits
 	 */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 587ae4d002f5..7887e4a3d487 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -410,6 +410,15 @@ struct pmu {
 	 */
 	size_t				task_ctx_size;
 
+	/*
+	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
+	 * can be synchronized using this function. See Intel LBR callstack support
+	 * implementation and Perf core context switch handling callbacks for usage
+	 * examples.
+	 */
+	void (*swap_task_ctx)		(struct perf_event_context *prev,
+					 struct perf_event_context *next);
+					/* optional */
 
 	/*
 	 * Set up pmu-private data structures for an AUX area
-- 
2.20.1

