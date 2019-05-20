Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179AE232B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfETLh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 07:37:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733094AbfETLh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:56 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/22] perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
Date:   Mon, 20 May 2019 14:37:16 +0300
Message-Id: <20190520113728.14389-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it easier to add new code for different TIP cases, separate each
case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index a2384a314990..99773445872d 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2128,18 +2128,29 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
 			decoder->continuous_period = false;
-			__fallthrough;
+			decoder->pge = false;
+			if (intel_pt_have_ip(decoder))
+				intel_pt_set_ip(decoder);
+			if (!decoder->ip)
+				break;
+			decoder->state.type |= INTEL_PT_TRACE_END;
+			return 0;
+
 		case INTEL_PT_TIP_PGE:
+			decoder->pge = true;
+			if (intel_pt_have_ip(decoder))
+				intel_pt_set_ip(decoder);
+			if (!decoder->ip)
+				break;
+			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
+			return 0;
+
 		case INTEL_PT_TIP:
-			decoder->pge = decoder->packet.type != INTEL_PT_TIP_PGD;
+			decoder->pge = true;
 			if (intel_pt_have_ip(decoder))
 				intel_pt_set_ip(decoder);
 			if (!decoder->ip)
 				break;
-			if (decoder->packet.type == INTEL_PT_TIP_PGE)
-				decoder->state.type |= INTEL_PT_TRACE_BEGIN;
-			if (decoder->packet.type == INTEL_PT_TIP_PGD)
-				decoder->state.type |= INTEL_PT_TRACE_END;
 			return 0;
 
 		case INTEL_PT_FUP:
-- 
2.17.1

