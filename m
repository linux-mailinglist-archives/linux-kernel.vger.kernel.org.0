Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0ADF336
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfJUQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 12:35:06 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57526 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AA221042;
        Mon, 21 Oct 2019 09:34:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02B233F71F;
        Mon, 21 Oct 2019 09:34:34 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCH 1/8] ftrace: add ftrace_init_nop()
Date:   Mon, 21 Oct 2019 17:34:19 +0100
Message-Id: <20191021163426.9408-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021163426.9408-1-mark.rutland@arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures may need to perform special initialization of ftrace
callsites, and today they do so by special-casing ftrace_make_nop() when
the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
patchable-function-entry), we don't have an mcount-like symbol and don't
want a synthetic MCOUNT_ADDR, but we may need to perform some
initialization of callsites.

To make it possible to separate initialization from runtime
modification, and to handle cases without an mcount-like symbol, this
patch adds an optional ftrace_init_nop() function that architectures can
implement, which does not pass a branch address.

Where an architecture does not provide ftrace_init_nop(), we will fall
back to the existing behaviour of calling ftrace_make_nop() with
MCOUNT_ADDR.

At the same time, ftrace_code_disable() is renamed to
ftrace_code_init_disabled() to make it clearer that it is intended to
intialize a callsite into a disabled state, and is not for disabling a
callsite that has been runtime enabled.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Torsten Duwe <duwe@suse.de>
---
 kernel/trace/ftrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f296d89be757..afd7e210e595 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2493,15 +2493,22 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
 	return &iter->pg->records[iter->index];
 }
 
+#ifndef ftrace_init_nop
+static int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
+{
+	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+}
+#endif
+
 static int
-ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
+ftrace_code_init_disabled(struct module *mod, struct dyn_ftrace *rec)
 {
 	int ret;
 
 	if (unlikely(ftrace_disabled))
 		return 0;
 
-	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+	ret = ftrace_init_nop(mod, rec);
 	if (ret) {
 		ftrace_bug_type = FTRACE_BUG_INIT;
 		ftrace_bug(ret, rec);
@@ -2943,7 +2950,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			 * to the NOP instructions.
 			 */
 			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
-			    !ftrace_code_disable(mod, p))
+			    !ftrace_code_init_disabled(mod, p))
 				break;
 
 			update_cnt++;
-- 
2.11.0

