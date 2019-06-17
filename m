Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10734850F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfFQOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:15:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45795 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQOPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:15:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEDnR03451839
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:13:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEDnR03451839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560780830;
        bh=9kEpiJU1GVRuUn8KvakClI4dfNrwEcKlYDdWcxUyBUI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=h2PwEzBh+ilaQQGcsZCuNCfrADM6grkUSDbdn0Y/DYHlT6QzUmEH+6KcbYoTOQd4V
         wZ3NtxWhbIH8JU60zkbsIL5KWzm04Q3Va3syHVuToKAWVin+q5aE7Q8csnNj5768nm
         b4SSYpEuFvONEcXOdSEwX7oUZwo+uQSRUM3lp0bG4DjWg1J0CMQoAeQSCa68NNkBU2
         U8N2gohyqcYupyJ+HGAxyIgkSHUyoo31CvinBaTg6Qt6CmPoM6FyTEKyCJVitGYc49
         RrFWGqDAg78sa1SPNvJ0qjHZIbni913sLD99p9iDgQ6D40vvSJ9PD3lLmA+V99f4PP
         4iBgNL+wsNUiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEDnbN3451833;
        Mon, 17 Jun 2019 07:13:49 -0700
Date:   Mon, 17 Jun 2019 07:13:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-4cc6620b5e4c8953c725bcfab86a57df01e83a7c@git.kernel.org>
Cc:     swood@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        hpa@zytor.com, crecklin@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        torvalds@linux-foundation.org, jkosina@suse.cz,
        jpoimboe@redhat.com, mhiramat@kernel.org, peterz@infradead.org,
        williams@redhat.com, jbaron@akamai.com, bp@alien8.de,
        gregkh@linuxfoundation.org, mingo@kernel.org
Reply-To: mingo@kernel.org, gregkh@linuxfoundation.org, bp@alien8.de,
          jbaron@akamai.com, williams@redhat.com, peterz@infradead.org,
          mhiramat@kernel.org, jpoimboe@redhat.com, jkosina@suse.cz,
          torvalds@linux-foundation.org, mtosatti@redhat.com,
          linux-kernel@vger.kernel.org, bristot@redhat.com,
          crecklin@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          rostedt@goodmis.org, swood@redhat.com
In-Reply-To: <d2f52a0010ecd399cf9b02a65bcf5836571b9e52.1560325897.git.bristot@redhat.com>
References: <d2f52a0010ecd399cf9b02a65bcf5836571b9e52.1560325897.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] x86/jump_label: Add a
 __jump_label_set_jump_code() helper
Git-Commit-ID: 4cc6620b5e4c8953c725bcfab86a57df01e83a7c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4cc6620b5e4c8953c725bcfab86a57df01e83a7c
Gitweb:     https://git.kernel.org/tip/4cc6620b5e4c8953c725bcfab86a57df01e83a7c
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Wed, 12 Jun 2019 11:57:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:20 +0200

x86/jump_label: Add a __jump_label_set_jump_code() helper

Move the definition of the code to be written from
__jump_label_transform() to a specialized function. No functional
change.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/d2f52a0010ecd399cf9b02a65bcf5836571b9e52.1560325897.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/jump_label.c | 52 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e631c358f7f4..f33408f1c3f6 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -35,41 +35,43 @@ static void bug_at(unsigned char *ip, int line)
 	BUG();
 }
 
-static void __ref __jump_label_transform(struct jump_entry *entry,
-					 enum jump_label_type type,
-					 int init)
+static void __jump_label_set_jump_code(struct jump_entry *entry,
+				       enum jump_label_type type,
+				       union jump_code_union *code,
+				       int init)
 {
-	union jump_code_union jmp;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect, *code;
+	const void *expect;
 	int line;
 
-	jmp.jump = 0xe9;
-	jmp.offset = jump_entry_target(entry) -
-		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
-
-	if (type == JUMP_LABEL_JMP) {
-		if (init) {
-			expect = default_nop; line = __LINE__;
-		} else {
-			expect = ideal_nop; line = __LINE__;
-		}
+	code->jump = 0xe9;
+	code->offset = jump_entry_target(entry) -
+		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-		code = &jmp.code;
+	if (init) {
+		expect = default_nop; line = __LINE__;
+	} else if (type == JUMP_LABEL_JMP) {
+		expect = ideal_nop; line = __LINE__;
 	} else {
-		if (init) {
-			expect = default_nop; line = __LINE__;
-		} else {
-			expect = &jmp.code; line = __LINE__;
-		}
-
-		code = ideal_nop;
+		expect = code->code; line = __LINE__;
 	}
 
 	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
 		bug_at((void *)jump_entry_code(entry), line);
 
+	if (type == JUMP_LABEL_NOP)
+		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+}
+
+static void __ref __jump_label_transform(struct jump_entry *entry,
+					 enum jump_label_type type,
+					 int init)
+{
+	union jump_code_union code;
+
+	__jump_label_set_jump_code(entry, type, &code, init);
+
 	/*
 	 * As long as only a single processor is running and the code is still
 	 * not marked as RO, text_poke_early() can be used; Checking that
@@ -82,12 +84,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), code,
+		text_poke_early((void *)jump_entry_code(entry), &code,
 				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
 		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
