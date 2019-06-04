Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E187A3478B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfFDNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:02:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:5111 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfFDNCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:05 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] perf intel-pt: Factor out intel_pt_get_buffer()
Date:   Tue,  4 Jun 2019 16:00:07 +0300
Message-Id: <20190604130017.31207-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out intel_pt_get_buffer() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 60 +++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3cff8fe2eaa0..4a61c73c9711 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -239,32 +239,13 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 	return 0;
 }
 
-/* This function assumes data is processed sequentially only */
-static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
+static int intel_pt_get_buffer(struct intel_pt_queue *ptq,
+			       struct auxtrace_buffer *buffer,
+			       struct auxtrace_buffer *old_buffer,
+			       struct intel_pt_buffer *b)
 {
-	struct intel_pt_queue *ptq = data;
-	struct auxtrace_buffer *buffer = ptq->buffer;
-	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
-	struct auxtrace_queue *queue;
 	bool might_overlap;
 
-	if (ptq->stop) {
-		b->len = 0;
-		return 0;
-	}
-
-	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
-
-	buffer = auxtrace_buffer__next(queue, buffer);
-	if (!buffer) {
-		if (old_buffer)
-			auxtrace_buffer__drop_data(old_buffer);
-		b->len = 0;
-		return 0;
-	}
-
-	ptq->buffer = buffer;
-
 	if (!buffer->data) {
 		int fd = perf_data__fd(ptq->pt->session->data);
 
@@ -294,6 +275,39 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 		b->consecutive = true;
 	}
 
+	return 0;
+}
+
+/* This function assumes data is processed sequentially only */
+static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
+{
+	struct intel_pt_queue *ptq = data;
+	struct auxtrace_buffer *buffer = ptq->buffer;
+	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
+	struct auxtrace_queue *queue;
+	int err;
+
+	if (ptq->stop) {
+		b->len = 0;
+		return 0;
+	}
+
+	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
+
+	buffer = auxtrace_buffer__next(queue, buffer);
+	if (!buffer) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		b->len = 0;
+		return 0;
+	}
+
+	ptq->buffer = buffer;
+
+	err = intel_pt_get_buffer(ptq, buffer, old_buffer, b);
+	if (err)
+		return err;
+
 	if (ptq->step_through_buffers)
 		ptq->stop = true;
 
-- 
2.17.1

