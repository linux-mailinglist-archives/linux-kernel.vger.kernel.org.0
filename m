Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA01E12E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbfJWHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 03:12:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:11778 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389090AbfJWHMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:12:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="196694574"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 00:11:59 -0700
Received: from [10.249.230.188] (abudanko-mobl.ccr.corp.intel.com [10.249.230.188])
        by linux.intel.com (Postfix) with ESMTP id D701958029F;
        Wed, 23 Oct 2019 00:11:55 -0700 (PDT)
Subject: [PATCH v5 2/4] perf/x86: install platform specific swap_task_ctx
 adapter
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
References: <f8d5a880-38e5-29f4-9e6a-848f70a67988@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b157e97d-32c3-aeaf-13ba-47350c677906@linux.intel.com>
Date:   Wed, 23 Oct 2019 10:11:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f8d5a880-38e5-29f4-9e6a-848f70a67988@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bridge perf core and x86 swap_task_ctx() method calls.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..6e3f0c18908e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2243,6 +2243,13 @@ static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 		x86_pmu.sched_task(ctx, sched_in);
 }
 
+static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
+				  struct perf_event_context *next)
+{
+	if (x86_pmu.swap_task_ctx)
+		x86_pmu.swap_task_ctx(prev, next);
+}
+
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2297,6 +2304,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
-- 
2.20.1

