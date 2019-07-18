Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951696C44F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbfGRBhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387770AbfGRBha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD1FB81F0F;
        Thu, 18 Jul 2019 01:37:29 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BECA5D9CC;
        Thu, 18 Jul 2019 01:37:28 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 15/22] objtool: Change dead_end_function() to return boolean
Date:   Wed, 17 Jul 2019 20:36:50 -0500
Message-Id: <9e6679610768fb6e6c51dca23f7d4d0c03b0c910.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Jul 2019 01:37:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dead_end_function() can no longer return an error.  Simplify its
interface by making it return boolean.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/check.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 16454cbca679..970dfeac841d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -105,14 +105,9 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
  *
  * For local functions, we have to detect them manually by simply looking for
  * the lack of a return instruction.
- *
- * Returns:
- *  -1: error
- *   0: no dead end
- *   1: dead end
  */
-static int __dead_end_function(struct objtool_file *file, struct symbol *func,
-			       int recursion)
+static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
+				int recursion)
 {
 	int i;
 	struct instruction *insn;
@@ -139,29 +134,29 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 	};
 
 	if (func->bind == STB_WEAK)
-		return 0;
+		return false;
 
 	if (func->bind == STB_GLOBAL)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
-				return 1;
+				return true;
 
 	if (!func->len)
-		return 0;
+		return false;
 
 	insn = find_insn(file, func->sec, func->offset);
 	if (!insn->func)
-		return 0;
+		return false;
 
 	func_for_each_insn_all(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
-			return 0;
+			return false;
 	}
 
 	if (empty)
-		return 0;
+		return false;
 
 	/*
 	 * A function can have a sibling call instead of a return.  In that
@@ -174,7 +169,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 			if (!dest)
 				/* sibling call to another file */
-				return 0;
+				return false;
 
 			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
 
@@ -186,7 +181,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					 * This is a very rare case.  It means
 					 * they aren't dead ends.
 					 */
-					return 0;
+					return false;
 				}
 
 				return __dead_end_function(file, dest->func,
@@ -196,13 +191,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 		if (insn->type == INSN_JUMP_DYNAMIC && list_empty(&insn->alts))
 			/* sibling call */
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
-static int dead_end_function(struct objtool_file *file, struct symbol *func)
+static bool dead_end_function(struct objtool_file *file, struct symbol *func)
 {
 	return __dead_end_function(file, func, 0);
 }
@@ -2080,11 +2075,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				if (is_fentry_call(insn))
 					break;
 
-				ret = dead_end_function(file, insn->call_dest);
-				if (ret == 1)
+				if (dead_end_function(file, insn->call_dest))
 					return 0;
-				if (ret == -1)
-					return 1;
 			}
 
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
-- 
2.20.1

