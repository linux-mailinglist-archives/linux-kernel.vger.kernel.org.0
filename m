Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45C1173908
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgB1Nwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:52:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:23007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgB1Nwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:52:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 05:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="242383259"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 05:52:38 -0800
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
Subject: [PATCH V3 07/13] ftrace: Add perf ksymbol events for ftrace trampolines
Date:   Fri, 28 Feb 2020 15:51:19 +0200
Message-Id: <20200228135125.567-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228135125.567-1-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kernel/ftrace.c        | 6 ++++++
 include/uapi/linux/perf_event.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 76920ce85b9c..34e1dd495ce4 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -406,7 +406,10 @@ static void create_trampoline(struct ftrace_ops *ops)
 	ops->trampoline = (unsigned long)trampoline;
 	ops->trampoline_size = tramp_size;
 
+	/* Add to kallsyms before the perf events */
 	ftrace_add_trampoline_to_kallsyms(ops);
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)trampoline,
+			   tramp_size, false, FTRACE_TRAMPOLINE_SYM);
 
 	set_vm_flush_reset_perms(trampoline);
 
@@ -534,6 +537,9 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 		return;
 
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)ops->trampoline,
+			   ops->trampoline_size, true, FTRACE_TRAMPOLINE_SYM);
+	/* Remove from kallsyms after the perf events */
 	ftrace_remove_trampoline_from_kallsyms(ops);
 	synchronize_rcu();
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9b38ac04c110..f80ce2e9f8b9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1033,7 +1033,7 @@ enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
 	/*
 	 * Out of line code such as kprobe-replaced instructions or optimized
-	 * kprobes.
+	 * kprobes or ftrace trampolines.
 	 */
 	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
-- 
2.17.1

