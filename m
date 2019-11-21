Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499B5104760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 01:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKUAPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 19:15:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:65026 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKUAPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="200927573"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2019 16:15:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8CB41300B64; Wed, 20 Nov 2019 16:15:34 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 03/12] perf cpumap: Maintain cpumaps ordered and without dups
Date:   Wed, 20 Nov 2019 16:15:13 -0800
Message-Id: <20191121001522.180827-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Enforce this in _trim()

Needed for followon change.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/lib/cpumap.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2ca1fafa620d..d81656b4635e 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -68,14 +68,28 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
+static int cmp_int(const void *a, const void *b)
+{
+	return *(const int *)a - *(const int*)b;
+}
+
 static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 {
 	size_t payload_size = nr_cpus * sizeof(int);
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
+	int i, j;
 
 	if (cpus != NULL) {
-		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
+		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
+		/* Remove dups */
+		j = 0;
+		for (i = 0; i < nr_cpus; i++) {
+			if (i == 0 || cpus->map[i] != cpus->map[i - 1])
+				cpus->map[j++] = cpus->map[i];
+		}
+		cpus->nr = j;
+		assert(j <= nr_cpus);
 		refcount_set(&cpus->refcnt, 1);
 	}
 
-- 
2.23.0

