Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41F81915D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgCXQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:12:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AjyCcnknx5JNjHLXsKwxMk0QOyXUEAMXcY0+YVRRcwM=; b=Y5/+J5A3qN9dWxZt+mDsgmI0SS
        PWOyvO73Fxu5Cz70x7nITUSdBEfeQbPOTp3WBZUjKYPgTi3JT7vZ2A4D6Dk8IqNwjQAXg9vL3/F3z
        WgdSIq+zZKXOXQ+tR6aGOBFs7pk2yyU7D+VasDvRYxcBYpTe398zpzVosMJdpgAlmCRM6HBwTrBZg
        D4IzfNAtOJEYqWO0eGv7Y2TFBUyYlL6b/U4FA1Ul2GbhKJvBOqyNx6+8UJ0yXP0/6FoumkLO2ZamE
        nN9GdPvK1P4lRQDzscITgcwoy4fg1Cn4vrkQ15F6EK/W4oAy/9FqJZ0Env/ioiXVueNiUuichVl8B
        agSDABOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9N-0000CE-2S; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61E58307418;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 565BD29A490F7; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.987489248@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 18/26] objtool: Fix !CFI insn_state propagation
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool keeps per instruction CFI state in struct insn_state and will
save/restore this where required. However, insn_state has grown some
!CFI state, and this must not be saved/restored (and thus lost).

Fix this by explicitly preserving the !CFI state and clarify by
restucturing the code and adding a comment.

XXX, the insn==first condition is not handled right.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   95 +++++++++++++++++++++++++++++---------------------
 tools/objtool/check.h |    8 ++++
 2 files changed, 64 insertions(+), 39 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2033,6 +2033,59 @@ static int validate_return(struct symbol
 	return 0;
 }
 
+static int apply_insn_hint(struct objtool_file *file, struct section *sec,
+			   struct symbol *func, struct instruction *first,
+			   struct instruction *insn, struct insn_state *state)
+{
+	struct insn_state old = *state;
+
+	if (insn->restore) {
+		struct instruction *save_insn, *i;
+
+		i = insn;
+		save_insn = NULL;
+		sym_for_each_insn_continue_reverse(file, func, i) {
+			if (i->save) {
+				save_insn = i;
+				break;
+			}
+		}
+
+		if (!save_insn) {
+			WARN_FUNC("no corresponding CFI save for CFI restore",
+					sec, insn->offset);
+			return 1;
+		}
+
+		if (!save_insn->visited) {
+			/*
+			 * Oops, no state to copy yet.
+			 * Hopefully we can reach this
+			 * instruction from another branch
+			 * after the save insn has been
+			 * visited.
+			 */
+			if (insn == first)
+				return 0; // XXX
+
+			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
+					sec, insn->offset);
+			return 1;
+		}
+
+		insn->state = save_insn->state;
+	}
+
+	*state = insn->state;
+
+	/* restore !CFI state */
+	state->df = old.df;
+	state->uaccess = old.uaccess;
+	state->uaccess_stack = old.uaccess_stack;
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2082,45 +2135,9 @@ static int validate_branch(struct objtoo
 		}
 
 		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				sym_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn = i;
-						break;
-					}
-				}
-
-				if (!save_insn) {
-					WARN_FUNC("no corresponding CFI save for CFI restore",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				insn->state = save_insn->state;
-			}
-
-			state = insn->state;
-
+			ret = apply_insn_hint(file, sec, func, first, insn, &state);
+			if (ret)
+				return ret;
 		} else
 			insn->state = state;
 
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -13,6 +13,14 @@
 #include "orc.h"
 #include <linux/hashtable.h>
 
+/*
+ * This structure (mostly) contains the instruction level CFI (Call Frame
+ * Information) and is saved/restored where appropriate; see validate_branch().
+ *
+ * However it does also contain a limited amount of !CFI state; this state must
+ * not be saved/restored along with the CFI information and is manually
+ * preserved. See apply_insn_hint().
+ */
 struct insn_state {
 	struct cfi_reg cfa;
 	struct cfi_reg regs[CFI_NUM_REGS];


