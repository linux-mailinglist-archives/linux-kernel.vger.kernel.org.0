Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA518C169
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCSU3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:29:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:60493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbgCSU2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:50 -0400
IronPort-SDR: aWGnAvOI2fQW3wnmtdG4ad6J/a0WtmLyhTFbpLuZZi/ifnJjWiO0YHeg2vjGTgVuolgATru7xn
 g2vb5d7/fdAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:50 -0700
IronPort-SDR: dzFNyXVbbAekjMNcaRdfDFx7wVg2eyBRB4eXxbtcXkCFdbguxnJGOOvFqqfcvJzflR2lYT/o2g
 xtivoN73BSAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031214"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:49 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 03/17] perf record: Clear HEADER_CPU_PMU_CAPS for non LBR call stack mode
Date:   Thu, 19 Mar 2020 13:25:03 -0700
Message-Id: <20200319202517.23423-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The CPU PMU capabilities information is only useful for LBR call stack.
Clear the feature for other perf record mode.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..428f7f5b8e48 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1120,6 +1120,9 @@ static void record__init_features(struct record *rec)
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
+	if (!callchain_param.enabled || (callchain_param.record_mode != CALLCHAIN_LBR))
+		perf_header__clear_feat(&session->header, HEADER_CPU_PMU_CAPS);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
-- 
2.17.1

