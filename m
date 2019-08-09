Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782C887DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407366AbfHIPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:24:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:38882 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHIPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:24:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="182932690"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2019 08:24:02 -0700
Received: from [10.252.0.91] (abudanko-mobl.ccr.corp.intel.com [10.252.0.91])
        by linux.intel.com (Postfix) with ESMTP id 5EFF6580417;
        Fri,  9 Aug 2019 08:23:59 -0700 (PDT)
Subject: [PATCH v1 1/3] perf record: enable LBR callstack capture jointly with
 thread stack
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e9e00090-66fb-d2a4-c90f-1d12344f7788@linux.intel.com>
Date:   Fri, 9 Aug 2019 18:23:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Enable '-j stack' applicability together with '--call-graph dwarf'
option so thread stack data and LBR call stack could be captured 
jointly:

  $ perf record -g --call-graph dwarf,1024 -j stack,u -- stack_test

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/parse-branch-options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 726e8d9e8c54..4ed20c833d44 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -30,6 +30,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
+	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_END
 };
 
-- 
2.20.1

