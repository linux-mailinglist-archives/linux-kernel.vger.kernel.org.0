Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0686F34793
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfFDNDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:03:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfFDNB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:01:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:01:56 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:01:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] perf intel-pt: Add lookahead callback
Date:   Tue,  4 Jun 2019 16:00:02 +0300
Message-Id: <20190604130017.31207-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a callback function to enable the decoder to lookahead at subsequent
trace buffers. This will be used to implement a "fast forward" facility
which will be needed to support efficient time interval filtering.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 9eb778f9c911..13123b195083 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -104,6 +104,7 @@ struct intel_pt_decoder {
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	struct intel_pt_state state;
 	const unsigned char *buf;
@@ -233,6 +234,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->get_trace          = params->get_trace;
 	decoder->walk_insn          = params->walk_insn;
 	decoder->pgd_ip             = params->pgd_ip;
+	decoder->lookahead          = params->lookahead;
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 6a61773dc44b..de36254c6ac9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -102,12 +102,15 @@ struct intel_pt_buffer {
 	uint64_t trace_nr;
 };
 
+typedef int (*intel_pt_lookahead_cb_t)(struct intel_pt_buffer *, void *);
+
 struct intel_pt_params {
 	int (*get_trace)(struct intel_pt_buffer *buffer, void *data);
 	int (*walk_insn)(struct intel_pt_insn *intel_pt_insn,
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	bool return_compression;
 	bool branch_enable;
-- 
2.17.1

