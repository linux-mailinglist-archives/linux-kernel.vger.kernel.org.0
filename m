Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635D2102320
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfKSLdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 06:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKSLdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:44 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750AD22302;
        Tue, 19 Nov 2019 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163223;
        bh=FYQtsLKQ9PHpxsh44V3TvDh7JOWCy2kZnNZs+2oMZ90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZkwZ4NkH9exQYsmmlqmjUMoJ3LbvPwyA/H9iDeXxdHZra4OStkU/U8nMazK1RnFe
         o6sHG9GOHo1L1F5f1eOs0J6+m/MarGv96X9K46cNsOVcJgQT61J6HfU+LGAbrzNUCo
         oQYkKPFJb/0vcEtCwUHBsHl3tiwvLK1YWwoaw6m4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 12/25] perf callchain: Fix segfault in thread__resolve_callchain_sample()
Date:   Tue, 19 Nov 2019 08:32:32 -0300
Message-Id: <20191119113245.19593-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Do not dereference 'chain' when it is NULL.

  $ perf record -e intel_pt//u -e branch-misses:u uname
  $ perf report --itrace=l --branch-history
  perf: Segmentation fault

Fixes: e9024d519d89 ("perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191114142538.4097-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7d2e211e376c..71ee078d30f4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2385,7 +2385,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	}
 
 check_calls:
-	if (callchain_param.order != ORDER_CALLEE) {
+	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
 					&cpumode, chain->nr - first_call);
 		if (err)
-- 
2.21.0

