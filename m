Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B973818C15C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCSU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:29:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:60498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgCSU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:57 -0400
IronPort-SDR: I5ZiZveZAdEHft+DcXOGedzNWDNptbD5t1vKjvzGqIy8uQ3UsqwcYS4DSu9uzfuYhvO7+7d2Jr
 1zS9HBziq7Pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:56 -0700
IronPort-SDR: IqDDaMkzaHWsODnDkvy3zeHH78gd2gHMFOChvfG2/sZUkDfOT8zyAar4osw7HebfBKnUPy7G0P
 7tNWA0ZahUlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031251"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:56 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 09/17] perf thread: Add a knob for LBR stitch approach
Date:   Thu, 19 Mar 2020 13:25:09 -0700
Message-Id: <20200319202517.23423-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR stitch approach should be disabled by default. Because
- The stitching approach base on LBR call stack technology. The known
limitations of LBR call stack technology still apply to the approach,
e.g. Exception handing such as setjmp/longjmp will have calls/returns
not match.
- This approach is not full proof. There can be cases where it creates
incorrect call stacks from incorrect matches. There is no attempt to
validate any matches in another way.

The 'lbr_stitch_enable' is used to indicate whether enable LBR stitch
approach, which is disabled by default. The following patch will
introduce a new option for each tools to enable the LBR stitch
approach.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/thread.c | 1 +
 tools/perf/util/thread.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 28b719388028..1f080db23615 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -47,6 +47,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread->tid = tid;
 		thread->ppid = -1;
 		thread->cpu = -1;
+		thread->lbr_stitch_enable = false;
 		INIT_LIST_HEAD(&thread->namespaces_list);
 		INIT_LIST_HEAD(&thread->comm_list);
 		init_rwsem(&thread->namespaces_lock);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 20b96b5d1f15..95294050cff2 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -46,6 +46,9 @@ struct thread {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
+
+	/* LBR call stack stitch */
+	bool			lbr_stitch_enable;
 };
 
 struct machine;
-- 
2.17.1

