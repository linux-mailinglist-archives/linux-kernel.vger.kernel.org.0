Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45707104759
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 01:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKUAPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 19:15:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:58451 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfKUAPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381553882"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 16:15:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C22B8300D85; Wed, 20 Nov 2019 16:15:34 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 12/12] perf stat: Use affinity for enabling/disabling events
Date:   Wed, 20 Nov 2019 16:15:22 -0800
Message-Id: <20191121001522.180827-13-andi@firstfloor.org>
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

Restructure event enabling/disabling to use affinity, which
minimizes the number of IPIs needed.

Before on a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 54.65    1.899986          22     84812       660 ioctl

after:

 39.21    0.930451          10     84796       644 ioctl

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros
v3: Use new iterator macros
v4: Update iterators again
---
 tools/perf/util/evlist.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 17960e4d3a45..682a1f37d244 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -378,11 +378,28 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
 
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__cpu_iter_skip(pos, cpu))
+				continue;
+			if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__disable_cpu(pos, pos->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
-		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__disable(pos);
+		pos->disabled = true;
 	}
 
 	evlist->enabled = false;
@@ -391,11 +408,28 @@ void evlist__disable(struct evlist *evlist)
 void evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
 
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__cpu_iter_skip(pos, cpu))
+				continue;
+			if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__enable_cpu(pos, pos->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__enable(pos);
+		pos->disabled = false;
 	}
 
 	evlist->enabled = true;
-- 
2.23.0

