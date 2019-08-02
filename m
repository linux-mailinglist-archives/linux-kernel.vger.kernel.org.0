Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7785B7EF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404233AbfHBIcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:32:22 -0400
Received: from mail5.windriver.com ([192.103.53.11]:50568 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbfHBIcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:32:22 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x728Twtg028074
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 2 Aug 2019 01:30:19 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.468.0; Fri, 2 Aug 2019 01:29:55 -0700
From:   <zhe.he@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <kan.liang@linux.intel.com>,
        <eranian@google.com>, <alexey.budankov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 1/2] perf: Fix failure to set cpumask when only one cpu
Date:   Fri, 2 Aug 2019 16:29:51 +0800
Message-ID: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The buffer containing string used to set cpumask is overwritten by end of
string later in cpu_map__snprint_mask due to not enough memory space, when
there is only one cpu. And thus causes the following failure.

$ perf ftrace ls
failed to reset ftrace

This patch fixes the calculation of cpumask string size.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 66d5a66..0193128 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -173,7 +173,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
 	int last_cpu;
 
 	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
-	mask_size = (last_cpu + 3) / 4 + 1;
+	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
 	cpumask = malloc(mask_size);
-- 
2.7.4

