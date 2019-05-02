Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02D411798
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEBKuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 06:50:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:24027 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEBKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:50:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 03:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="166965988"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2019 03:50:30 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/2] perf: Allow normal events to be sources of AUX data
Date:   Thu,  2 May 2019 13:50:21 +0300
Message-Id: <20190502105022.15534-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, ordinary (non-AUX) events can generate data for AUX events.
For example, PEBS events can come out as records in the Intel PT stream
instead of their usual DS records, if configured to do so.

Add an attribute bit for such events to be configured to generate AUX data.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/uapi/linux/perf_event.h | 3 ++-
 kernel/events/core.c            | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..213cae95e713 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_source     :  1, /* generate AUX records instead of events */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..ea9eff6fcf6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10382,6 +10382,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_ns;
 	}
 
+	/*
+	 * If it's set at this point, the PMU didn't handle it, so
+	 * it doesn't do it.
+	 */
+	if (event->attr.aux_source) {
+		err = -EOPNOTSUPP;
+		goto err_pmu;
+	}
+
 	err = exclusive_event_init(event);
 	if (err)
 		goto err_pmu;
-- 
2.20.1

