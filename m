Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C313477C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfFDNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:02:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfFDNCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:00 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:01:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] perf intel-pt: Factor out intel_pt_reposition()
Date:   Tue,  4 Jun 2019 16:00:04 +0300
Message-Id: <20190604130017.31207-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out intel_pt_reposition() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index c06dceb774e9..70bff7bb79f3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -494,6 +494,14 @@ static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
 	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
 }
 
+static void intel_pt_reposition(struct intel_pt_decoder *decoder)
+{
+	decoder->ip = 0;
+	decoder->pkt_state = INTEL_PT_STATE_NO_PSB;
+	decoder->timestamp = 0;
+	decoder->have_tma = false;
+}
+
 static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
@@ -512,11 +520,8 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 		return -ENODATA;
 	}
 	if (!buffer.consecutive) {
-		decoder->ip = 0;
-		decoder->pkt_state = INTEL_PT_STATE_NO_PSB;
+		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
-		decoder->timestamp = 0;
-		decoder->have_tma = false;
 		decoder->state.trace_nr = buffer.trace_nr;
 		intel_pt_log("Reference timestamp 0x%" PRIx64 "\n",
 			     decoder->ref_timestamp);
-- 
2.17.1

