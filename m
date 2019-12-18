Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9C12498D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfLRO1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 09:27:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:21673 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfLRO1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 06:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="240803879"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga004.fm.intel.com with ESMTP; 18 Dec 2019 06:27:19 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf intel-pt: Add support for text poke events
Date:   Wed, 18 Dec 2019 16:26:18 +0200
Message-Id: <20191218142618.19332-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218142618.19332-1-adrian.hunter@intel.com>
References: <20191218142618.19332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select text poke events when available and the kernel is being traced.
Process text poke events to invalidate entries in Intel PT's instruction
cache.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  4 ++
 tools/perf/util/intel-pt.c          | 71 +++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 20df442fdf36..ec75445ef7cf 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -827,6 +827,10 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (have_timing_info && !intel_pt_evsel->core.attr.exclude_kernel &&
+	    perf_can_record_text_poke_events() && perf_can_record_cpu_wide())
+		opts->text_poke = true;
+
 	if (intel_pt_evsel) {
 		/*
 		 * To obtain the auxtrace buffer file descriptor, the auxtrace
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 33cf8928cf05..9603217e437e 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -514,6 +514,17 @@ intel_pt_cache_lookup(struct dso *dso, struct machine *machine, u64 offset)
 	return auxtrace_cache__lookup(dso->auxtrace_cache, offset);
 }
 
+static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
+				      u64 offset)
+{
+	struct auxtrace_cache *c = intel_pt_cache(dso, machine);
+
+	if (!c)
+		return;
+
+	auxtrace_cache__remove(dso->auxtrace_cache, offset);
+}
+
 static inline u8 intel_pt_cpumode(struct intel_pt *pt, uint64_t ip)
 {
 	return ip >= pt->kernel_start ?
@@ -2592,6 +2603,63 @@ static int intel_pt_process_itrace_start(struct intel_pt *pt,
 					event->itrace_start.tid);
 }
 
+static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
+			     struct addr_location *al)
+{
+	if (!al->map || addr < al->map->start || addr >= al->map->end) {
+		if (!thread__find_map(thread, cpumode, addr, al) || !al->map->dso)
+			return -1;
+	}
+
+	return 0;
+}
+
+/* Invalidate all instruction cache entries that overlap the text poke */
+static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
+{
+	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	u64 addr = event->text_poke.addr + event->text_poke.len - 1;
+	/* Assume text poke begins in a basic block no more than 4096 bytes */
+	int cnt = 4096 + event->text_poke.len;
+	struct thread *thread = pt->unknown_thread;
+	struct addr_location al = { .map = NULL };
+	struct machine *machine = pt->machine;
+	struct intel_pt_cache_entry *e;
+	u64 offset;
+
+	for (; cnt; cnt--, addr--) {
+		if (intel_pt_find_map(thread, cpumode, addr, &al)) {
+			if (addr < event->text_poke.addr)
+				return 0;
+			pr_err("%s: failed to find map at %#"PRIx64"\n",
+			       __func__, addr);
+			return -EINVAL;
+		}
+
+		offset = al.map->map_ip(al.map, addr);
+
+		e = intel_pt_cache_lookup(al.map->dso, machine, offset);
+		if (!e)
+			continue;
+
+		if (addr + e->byte_cnt + e->length <= event->text_poke.addr) {
+			/*
+			 * No overlap. Working backwards there cannot be another
+			 * basic block that overlaps the text poke if there is a
+			 * branch instruction before the text poke address.
+			 */
+			if (e->branch != INTEL_PT_BR_NO_BRANCH)
+				return 0;
+		} else {
+			intel_pt_cache_invalidate(al.map->dso, machine, offset);
+			intel_pt_log("Invalidated instruction cache for %s at %#"PRIx64"\n",
+				     al.map->dso->long_name, addr);
+		}
+	}
+
+	return 0;
+}
+
 static int intel_pt_process_event(struct perf_session *session,
 				  union perf_event *event,
 				  struct perf_sample *sample,
@@ -2653,6 +2721,9 @@ static int intel_pt_process_event(struct perf_session *session,
 		 event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		err = intel_pt_context_switch(pt, event, sample);
 
+	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
+		err = intel_pt_text_poke(pt, event);
+
 	intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
 		     event->header.type, sample->cpu, sample->time, timestamp);
 	intel_pt_log_event(event);
-- 
2.17.1

