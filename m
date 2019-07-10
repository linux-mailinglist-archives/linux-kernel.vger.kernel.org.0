Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB10D643F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfGJI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 04:59:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:35486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfGJI7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102578"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] perf script: Add scripting operation process_switch()
Date:   Wed, 10 Jul 2019 11:58:06 +0300
Message-Id: <20190710085810.1650-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scripting operation process_switch() to process switch events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c   | 8 +++++++-
 tools/perf/util/trace-event.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2f6232f1bfdc..3cd0269bbef7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2289,6 +2289,12 @@ static int process_switch_event(struct perf_tool *tool,
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
+	if (scripting_ops && scripting_ops->process_switch)
+		scripting_ops->process_switch(event, sample, machine);
+
+	if (!script->show_switch_events)
+		return 0;
+
 	thread = machine__findnew_thread(machine, sample->pid,
 					 sample->tid);
 	if (thread == NULL) {
@@ -2467,7 +2473,7 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.mmap = process_mmap_event;
 		script->tool.mmap2 = process_mmap2_event;
 	}
-	if (script->show_switch_events)
+	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index d9b0a942090a..c7002fe11673 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -81,6 +81,9 @@ struct scripting_ops {
 			       struct perf_sample *sample,
 			       struct perf_evsel *evsel,
 			       struct addr_location *al);
+	void (*process_switch)(union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct perf_evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
-- 
2.17.1

