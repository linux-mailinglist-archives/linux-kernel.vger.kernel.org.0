Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510AE696E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfGOPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387723AbfGOOE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6D3759440;
        Mon, 15 Jul 2019 14:04:29 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B45B6085B;
        Mon, 15 Jul 2019 14:04:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Carrillo-Cisneros <davidcc@google.com>,
        Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Fix proper buffer size for feature processing
Date:   Mon, 15 Jul 2019 16:04:26 +0200
Message-Id: <20190715140426.32509-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 15 Jul 2019 14:04:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After Song Liu's segfault fix for pipe mode, Arnaldo reported
following error:

  # perf record -o - | perf script
  0x514 [0x1ac]: failed to process type: 80

It's caused by wrong buffer size setup in feature processing,
which makes cpu topology feature fail, because it's using
buffer size to recognize its header version.

Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Fixes: e9def1b2e74e ("perf tools: Add feature header record to pipe-mode")
Link: http://lkml.kernel.org/n/tip-2lj87zz8tq9ye1ntax3ulw0n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..20111f8da5cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3747,7 +3747,7 @@ int perf_event__process_feature(struct perf_session *session,
 		return 0;
 
 	ff.buf  = (void *)fe->data;
-	ff.size = event->header.size - sizeof(event->header);
+	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
 	if (feat_ops[feat].process(&ff, NULL))
-- 
2.21.0

