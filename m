Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51C24F4BB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFVJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 05:34:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:26120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFVJeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 02:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="312233137"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2019 02:34:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] perf intel-pt: Decoder to output CBR changes immediately
Date:   Sat, 22 Jun 2019 12:32:42 +0300
Message-Id: <20190622093248.581-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622093248.581-1-adrian.hunter@intel.com>
References: <20190622093248.581-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core-to-bus ratio (CBR) provides the CPU frequency. With branches
enabled, the decoder was outputting CBR changes only when there was a
branch. That loses the correct time of the change if the trace is not in
context (e.g. not tracing kernel space). Change to output the CBR change
immediately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c     | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f8b71bf2bb4c..3d2255f284f4 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2015,16 +2015,8 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_CBR:
 			intel_pt_calc_cbr(decoder);
-			if (!decoder->branch_enable &&
-			    decoder->cbr != decoder->cbr_seen) {
-				decoder->cbr_seen = decoder->cbr;
-				decoder->state.type = INTEL_PT_CBR_CHG;
-				decoder->state.from_ip = decoder->ip;
-				decoder->state.to_ip = 0;
-				decoder->state.cbr_payload =
-							decoder->packet.payload;
+			if (decoder->cbr != decoder->cbr_seen)
 				return 0;
-			}
 			break;
 
 		case INTEL_PT_MODE_EXEC:
@@ -2626,8 +2618,12 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
 	} else {
 		decoder->state.err = 0;
-		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
+		if (decoder->cbr != decoder->cbr_seen) {
 			decoder->cbr_seen = decoder->cbr;
+			if (!decoder->state.type) {
+				decoder->state.from_ip = decoder->ip;
+				decoder->state.to_ip = 0;
+			}
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
-- 
2.17.1

