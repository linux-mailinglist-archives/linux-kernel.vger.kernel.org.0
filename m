Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0465B15D868
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 14:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgBNN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 08:27:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:26521 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:27:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 05:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="347954664"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2020 05:27:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Wei Li <liwei391@huawei.com>
Subject: [PATCH V2 1/5] perf tools: intel-pt: fix endless record after being terminated
Date:   Fri, 14 Feb 2020 15:26:50 +0200
Message-Id: <20200214132654.20395-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214132654.20395-1-adrian.hunter@intel.com>
References: <20200214132654.20395-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be endless.

If the intel_pt event is disabled, we don't enable it again here.

Before the patch:
huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
intel_pt//u -p 46803
^C^C^C^C^C^C

After the patch:
huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
intel_pt//u -p 48591
^C[ perf record: Woken up 0 times to write data ]
Warning:
AUX data lost 504 times out of 4816!

[ perf record: Captured and wrote 2024.405 MB perf.data ]

Signed-off-by: Wei Li <liwei391@huawei.com>
[ahunter: removed redundant 'else' after 'return']
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # 5.4+
---
 tools/perf/arch/x86/util/intel-pt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index ec75445ef7cf..2f0a0832907f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1177,9 +1177,12 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
+		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
+			if (evsel->disabled)
+				return 0;
 			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
 							     idx);
+		}
 	}
 	return -EINVAL;
 }
-- 
2.17.1

