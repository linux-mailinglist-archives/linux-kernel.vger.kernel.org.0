Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF45EE4E94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504980AbfJYOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 10:09:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:57127 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503311AbfJYOJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:09:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="350035433"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 07:08:57 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 3/3] perf/x86/intel/pt: Add sampling support
Date:   Fri, 25 Oct 2019 17:08:35 +0300
Message-Id: <20191025140835.53665-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AUX sampling support to the PT PMU: implement an NMI-safe callback
that takes a snapshot of the buffer without touching the event states.
This is done for PT events that don't use PMIs, that is, snapshot mode
(RO mapping of the AUX area).

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 170f3b402274..2f20d5a333c1 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1208,6 +1208,13 @@ pt_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (!nr_pages)
 		return NULL;
 
+	/*
+	 * Only support AUX sampling in snapshot mode, where we don't
+	 * generate NMIs.
+	 */
+	if (event->attr.aux_sample_size && !snapshot)
+		return NULL;
+
 	if (cpu == -1)
 		cpu = raw_smp_processor_id();
 	node = cpu_to_node(cpu);
@@ -1506,6 +1513,52 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	}
 }
 
+static long pt_event_snapshot_aux(struct perf_event *event,
+				  struct perf_output_handle *handle,
+				  unsigned long size)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	unsigned long from = 0, to;
+	long ret;
+
+	if (WARN_ON_ONCE(!buf))
+		return 0;
+
+	/*
+	 * Sampling is only allowed on snapshot events;
+	 * see pt_buffer_setup_aux().
+	 */
+	if (WARN_ON_ONCE(!buf->snapshot))
+		return 0;
+
+	/*
+	 * Here, handle_nmi tells us if the tracing is on
+	 */
+	if (READ_ONCE(pt->handle_nmi))
+		pt_config_stop(event);
+
+	pt_read_offset(buf);
+	pt_update_head(pt);
+
+	to = local_read(&buf->data_size);
+	if (to < size)
+		from = buf->nr_pages << PAGE_SHIFT;
+	from += to - size;
+
+	ret = perf_output_copy_aux(&pt->handle, handle, from, to);
+
+	/*
+	 * If the tracing was on when we turned up, restart it.
+	 * Compiler barrier not needed as we couldn't have been
+	 * preempted by anything that touches pt->handle_nmi.
+	 */
+	if (pt->handle_nmi)
+		pt_config_start(event);
+
+	return ret;
+}
+
 static void pt_event_del(struct perf_event *event, int mode)
 {
 	pt_event_stop(event, PERF_EF_UPDATE);
@@ -1625,6 +1678,7 @@ static __init int pt_init(void)
 	pt_pmu.pmu.del			 = pt_event_del;
 	pt_pmu.pmu.start		 = pt_event_start;
 	pt_pmu.pmu.stop			 = pt_event_stop;
+	pt_pmu.pmu.snapshot_aux		 = pt_event_snapshot_aux;
 	pt_pmu.pmu.read			 = pt_event_read;
 	pt_pmu.pmu.setup_aux		 = pt_buffer_setup_aux;
 	pt_pmu.pmu.free_aux		 = pt_buffer_free_aux;
-- 
2.23.0

