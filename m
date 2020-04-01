Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73BF19A951
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgDAKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 06:17:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:34142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbgDAKRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:45 -0400
IronPort-SDR: IJP0cbPNGUa1QEOmZkdHcdbpjifpi7mo7L0QsduuA4WQGQVbsdcnOgoV/jPhiQYYfz3Rh/ahdX
 xevixdFY2hUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:43 -0700
IronPort-SDR: E8Vr0lE5xqGli3+7OXbKc5IzwkFj/GKp2DfQRSNIOLVEStL30x7jHA8wAoKX8y1ptKyJT8xe3O
 Z15p5LRhEu8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925510"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 06/16] perf s390-cpumsf: Implement ->evsel_is_auxtrace() callback
Date:   Wed,  1 Apr 2020 13:16:03 +0300
Message-Id: <20200401101613.6201-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/s390-cpumcf-kernel.h | 1 +
 tools/perf/util/s390-cpumsf.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
index d4356030b504..f55ca07f3ca1 100644
--- a/tools/perf/util/s390-cpumcf-kernel.h
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -11,6 +11,7 @@
 
 #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
 #define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
+#define PERF_EVENT_CPUM_SF_DIAG	0xBD000 /* Event: Combined-sampling */
 
 struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
 	unsigned int def:16;	/* 0-15  Data Entry Format */
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6785cd87aa4d..d7779e48652f 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1047,6 +1047,14 @@ static void s390_cpumsf_free(struct perf_session *session)
 	free(sf);
 }
 
+static bool
+s390_cpumsf_evsel_is_auxtrace(struct perf_session *session __maybe_unused,
+			      struct evsel *evsel)
+{
+	return evsel->core.attr.type == PERF_TYPE_RAW &&
+	       evsel->core.attr.config == PERF_EVENT_CPUM_SF_DIAG;
+}
+
 static int s390_cpumsf_get_type(const char *cpuid)
 {
 	int ret, family = 0;
@@ -1142,6 +1150,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->auxtrace.flush_events = s390_cpumsf_flush;
 	sf->auxtrace.free_events = s390_cpumsf_free_events;
 	sf->auxtrace.free = s390_cpumsf_free;
+	sf->auxtrace.evsel_is_auxtrace = s390_cpumsf_evsel_is_auxtrace;
 	session->auxtrace = &sf->auxtrace;
 
 	if (dump_trace)
-- 
2.17.1

