Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05345C728
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGBC0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfGBC0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28C82184C;
        Tue,  2 Jul 2019 02:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034400;
        bh=hZZx90USKOXdhLDm2MZbIX+3c21jlzKDNpiSezYBM2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKIQhTkQPdNJCIY4iBocjvHBErBg57iskV5qthug7HB5HgLYU/9aSCyt3dEZK5d9M
         AZbsFbqYrVmlTXAKRodBUNjiGEVfs/lj7bFnTN1NWh5J1y55E6uOSmx0ZgfAmQ9nNi
         EOluRLng0LNRzgP3dYqE8iE5NfQSHE0L+2LvYeWQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/43] perf intel-pt: Decoder to output CBR changes immediately
Date:   Mon,  1 Jul 2019 23:25:38 -0300
Message-Id: <20190702022616.1259-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The core-to-bus ratio (CBR) provides the CPU frequency. With branches
enabled, the decoder was outputting CBR changes only when there was a
branch. That loses the correct time of the change if the trace is not in
context (e.g. not tracing kernel space). Change to output the CBR change
immediately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

