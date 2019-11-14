Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC4FC8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 15:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 09:26:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:49130 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfKNO0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:26:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 06:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="208137128"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2019 06:26:34 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf callchain: Fix segfault in thread__resolve_callchain_sample()
Date:   Thu, 14 Nov 2019 16:25:38 +0200
Message-Id: <20191114142538.4097-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not dereference 'chain' when it is NULL.

  $ perf record -e intel_pt//u -e branch-misses:u uname
  $ perf report --itrace=l --branch-history
  perf: Segmentation fault

Fixes: e9024d519d89 ("perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6a0f5c25ce3e..0a21ab69a247 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2414,7 +2414,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	}
 
 check_calls:
-	if (callchain_param.order != ORDER_CALLEE) {
+	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
 					&cpumode, chain->nr - first_call);
 		if (err)
-- 
2.17.1

