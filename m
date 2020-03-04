Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA9178D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbgCDJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 04:21:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:13432 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgCDJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:21:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="413077488"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 01:21:47 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ftrace: Tidy create_trampoline()
Date:   Wed,  4 Mar 2020 11:21:05 +0200
Message-Id: <20200304092105.11934-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_trampoline() returns 2 values that the (only) caller simply
assigns to ops members. Amend create_trampoline() to make the
assignments instead, which simplifies the code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kernel/ftrace.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 108ee96f8b66..ee777c76a1c8 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -307,8 +307,7 @@ union ftrace_op_code_union {
 
 #define RET_SIZE		1
 
-static unsigned long
-create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
+static void create_trampoline(struct ftrace_ops *ops)
 {
 	unsigned long start_offset;
 	unsigned long end_offset;
@@ -319,6 +318,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long size;
 	unsigned long retq;
 	unsigned long *ptr;
+	unsigned int tramp_size;
 	void *trampoline;
 	void *ip;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
@@ -347,10 +347,10 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 */
 	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
 	if (!trampoline)
-		return 0;
+		return;
 
-	*tramp_size = size + RET_SIZE + sizeof(void *);
-	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
+	tramp_size = size + RET_SIZE + sizeof(void *);
+	npages = DIV_ROUND_UP(tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
@@ -403,15 +403,16 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
+	ops->trampoline = (unsigned long)trampoline;
+	ops->trampoline_size = tramp_size;
 
 	set_vm_flush_reset_perms(trampoline);
 
 	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
-	return (unsigned long)trampoline;
+	return;
 fail:
 	tramp_free(trampoline);
-	return 0;
 }
 
 static unsigned long calc_trampoline_call_offset(bool save_regs)
@@ -435,14 +436,10 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	ftrace_func_t func;
 	unsigned long offset;
 	unsigned long ip;
-	unsigned int size;
 	const char *new;
 
 	if (!ops->trampoline) {
-		ops->trampoline = create_trampoline(ops, &size);
-		if (!ops->trampoline)
-			return;
-		ops->trampoline_size = size;
+		create_trampoline(ops);
 		return;
 	}
 
-- 
2.17.1

