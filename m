Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF17C43A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfGaN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:58:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:47382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbfGaN6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:58:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 06:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="177318789"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2019 06:58:42 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 3/7] perf tools: Add aux_source attribute flag
Date:   Wed, 31 Jul 2019 16:58:25 +0300
Message-Id: <20190731135829.54435-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
References: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add aux_source attribute flag to match the kernel's perf_event.h file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 3 ++-
 tools/perf/util/evsel.c               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..213cae95e713 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_source     :  1, /* generate AUX records instead of events */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 52459dd5ad0c..0aa44d8e4159 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1684,6 +1684,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(namespaces, p_unsigned);
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
+	PRINT_ATTRf(aux_source, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
-- 
2.20.1

