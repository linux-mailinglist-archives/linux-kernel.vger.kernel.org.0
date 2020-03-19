Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15CA18C15A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCSU2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:28:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:60493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgCSU2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:51 -0400
IronPort-SDR: gTlggtOTKwhCqScklgRV65fUDvuiZjqq5Etgq8rMKHhNQWQoJEqjuU3eYYZRz0/KezlPMm/IYZ
 7PKzRdOvpmDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:50 -0700
IronPort-SDR: 84mZVxrl/fL/kq3aefVKpSddPA0pMYlrRfeY5fv4vPalIvAb1iGURIEXOr+FBhPmE0WdFKfveg
 i3xpgoBQFulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031217"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:50 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 04/17] perf stat: Clear HEADER_CPU_PMU_CAPS
Date:   Thu, 19 Mar 2020 13:25:04 -0700
Message-Id: <20200319202517.23423-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The CPU PMU capabilities information is only useful for perf record with
LBR call stack.

Clear the header for perf stat.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ec053dc1e35c..b5c8a5ab5e75 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1595,6 +1595,7 @@ static void init_features(struct perf_session *session)
 	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
 	perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
+	perf_header__clear_feat(&session->header, HEADER_CPU_PMU_CAPS);
 }
 
 static int __cmd_record(int argc, const char **argv)
-- 
2.17.1

