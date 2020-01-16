Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92BC13DC53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 14:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAPNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 08:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:45 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EB92087E;
        Thu, 16 Jan 2020 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182524;
        bh=U9bGmkKu+y5sFzv7p1+FCXuR6nfik3QQK3h50RdP5WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLZc7nr10Zqkx+w1JXuFDuKMYu0TZHokVPlIgnEXu9JxGcWlQQGscvUWLLFCVWfHp
         Z0Uxckqa6bVfiULRL2JUXkQxP1ODYBUKufw3KXzQ8rEQwQArJ9gIhqoqUYjjpmnSDU
         +0liGJTil0hFzRcMZgrwI4PEtrDx98Lncxor6p3g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jann Horn <jannh@google.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/12] libperf: Setup initial evlist::all_cpus value
Date:   Thu, 16 Jan 2020 10:48:08 -0300
Message-Id: <20200116134814.8811-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Jann Horn reported crash in perf ftrace because evlist::all_cpus isn't
initialized if there's evlist without events, which is the case for perf
ftrace.

Adding initial initialization of evlist::all_cpus from given cpus,
regardless of events in the evlist.

Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200110151537.153012-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/evlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index ae9e65aa2491..5b9f2ca50591 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -164,6 +164,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
+	if (!evlist->all_cpus && cpus)
+		evlist->all_cpus = perf_cpu_map__get(cpus);
+
 	perf_evlist__propagate_maps(evlist);
 }
 
-- 
2.21.1

