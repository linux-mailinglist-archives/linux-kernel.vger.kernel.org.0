Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6DE4F4BC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFVJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 05:34:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:26120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfFVJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 02:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="312233141"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2019 02:34:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] perf intel-pt: Cater for CBR change in PSB+
Date:   Sat, 22 Jun 2019 12:32:43 +0300
Message-Id: <20190622093248.581-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622093248.581-1-adrian.hunter@intel.com>
References: <20190622093248.581-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSB+ provides status information only so the core-to-bus ratio (CBR) in
PSB+ will not have changed from its previous value. However, cater for the
possibility of a another CBR change that gets caught up in the PSB+ anyway.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 3d2255f284f4..5eb792cc5d3a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1975,6 +1975,13 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 				goto next;
 			if (err)
 				return err;
+			/*
+			 * PSB+ CBR will not have changed but cater for the
+			 * possibility of another CBR change that gets caught up
+			 * in the PSB+.
+			 */
+			if (decoder->cbr != decoder->cbr_seen)
+				return 0;
 			break;
 
 		case INTEL_PT_PIP:
-- 
2.17.1

