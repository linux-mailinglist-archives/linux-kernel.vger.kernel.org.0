Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBF173903
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgB1Nw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:52:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:60699 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1Nw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:52:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 05:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="242383197"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 05:52:22 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 04/13] kprobes: Add perf ksymbol events for kprobe insn pages
Date:   Fri, 28 Feb 2020 15:51:16 +0200
Message-Id: <20200228135125.567-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228135125.567-1-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for kprobe's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/uapi/linux/perf_event.h |  5 +++++
 kernel/kprobes.c                | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bae9e9d2d897..9b38ac04c110 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1031,6 +1031,11 @@ enum perf_event_type {
 enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	/*
+	 * Out of line code such as kprobe-replaced instructions or optimized
+	 * kprobes.
+	 */
+	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 229d1b596690..f880eb2189c0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/perf_event.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -184,6 +185,10 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	kip->cache = c;
 	list_add_rcu(&kip->list, &c->pages);
 	slot = kip->insns;
+
+	/* Record the perf ksymbol register event after adding the page */
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)kip->insns,
+			   PAGE_SIZE, false, c->sym);
 out:
 	mutex_unlock(&c->mutex);
 	return slot;
@@ -202,6 +207,13 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 		 * next time somebody inserts a probe.
 		 */
 		if (!list_is_singular(&kip->list)) {
+			/*
+			 * Record perf ksymbol unregister event before removing
+			 * the page.
+			 */
+			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+					   (u64)kip->insns, PAGE_SIZE, true,
+					   kip->cache->sym);
 			list_del_rcu(&kip->list);
 			synchronize_rcu();
 			kip->cache->free(kip->insns);
-- 
2.17.1

