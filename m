Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497D5961DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfHTOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:02:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTOCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:02:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A20DE10C052A;
        Tue, 20 Aug 2019 14:02:23 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 469701001948;
        Tue, 20 Aug 2019 14:02:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Joe Mario <jmario@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf c2c: Display proper cpu count in nodes column
Date:   Tue, 20 Aug 2019 16:02:19 +0200
Message-Id: <20190820140219.28338-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 20 Aug 2019 14:02:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's wrong bitmap considered when checking
for cpu count of specific node.

We do the needed computation for 'set' variable,
but at the end we use the 'c2c_he->cpuset' weight,
which shows misleading numbers.

Reported-by: Joe Mario <jmario@redhat.com>
Link: https://lkml.kernel.org/n/tip-9wvrv74n7d4nbgztr74isv5j@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f0aae6e13a33..9240c6bf70f5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1106,7 +1106,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			break;
 		case 1:
 		{
-			int num = bitmap_weight(c2c_he->cpuset, c2c.cpus_cnt);
+			int num = bitmap_weight(set, c2c.cpus_cnt);
 			struct c2c_stats *stats = &c2c_he->node_stats[node];
 
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
-- 
2.21.0

