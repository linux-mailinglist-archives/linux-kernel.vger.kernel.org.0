Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C611370E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgAJPPt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jan 2020 10:15:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbgAJPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:15:49 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-khQgLo3xPieZKhEqLPLOZQ-1; Fri, 10 Jan 2020 10:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3075D911E8;
        Fri, 10 Jan 2020 15:15:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-205-164.brq.redhat.com [10.40.205.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D31A60CC0;
        Fri, 10 Jan 2020 15:15:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jann Horn <jannh@google.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Setup initial evlist::all_cpus value
Date:   Fri, 10 Jan 2020 16:15:37 +0100
Message-Id: <20200110151537.153012-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: khQgLo3xPieZKhEqLPLOZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn reported crash in perf ftrace because evlist::all_cpus
isn't initialized if there's evlist without events, which is the
case for perf ftrace.

Adding initial initialization of evlist::all_cpus from given cpus,
regardless of events in the evlist.

Reported-by: Jann Horn <jannh@google.com>
Link: https://lkml.kernel.org/n/tip-kzioebqr5c3u4t7tafju8pbx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.24.1

