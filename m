Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684376C455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbfGRBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:38:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388242AbfGRBhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4437C3084212;
        Thu, 18 Jul 2019 01:37:32 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 341355D9CC;
        Thu, 18 Jul 2019 01:37:31 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 17/22] objtool: Refactor sibling call detection logic
Date:   Wed, 17 Jul 2019 20:36:52 -0500
Message-Id: <8357dbef9e7f5512e76bf83a76c81722fc09eb5e.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 18 Jul 2019 01:37:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the sibling call detection logic a bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/check.c | 65 ++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3fb656ea96b9..a190a6e79a91 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -97,6 +97,20 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static bool is_sibling_call(struct instruction *insn)
+{
+	/* An indirect jump is either a sibling call or a jump to a table. */
+	if (insn->type == INSN_JUMP_DYNAMIC)
+		return list_empty(&insn->alts);
+
+	if (insn->type != INSN_JUMP_CONDITIONAL &&
+	    insn->type != INSN_JUMP_UNCONDITIONAL)
+		return false;
+
+	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
+	return !!insn->call_dest;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -167,34 +181,25 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * of the sibling call returns.
 	 */
 	func_for_each_insn_all(file, func, insn) {
-		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+		if (is_sibling_call(insn)) {
 			struct instruction *dest = insn->jump_dest;
 
 			if (!dest)
 				/* sibling call to another file */
 				return false;
 
-			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
-
-				/* local sibling call */
-				if (recursion == 5) {
-					/*
-					 * Infinite recursion: two functions
-					 * have sibling calls to each other.
-					 * This is a very rare case.  It means
-					 * they aren't dead ends.
-					 */
-					return false;
-				}
-
-				return __dead_end_function(file, dest->func,
-							   recursion + 1);
+			/* local sibling call */
+			if (recursion == 5) {
+				/*
+				 * Infinite recursion: two functions have
+				 * sibling calls to each other.  This is a very
+				 * rare case.  It means they aren't dead ends.
+				 */
+				return false;
 			}
-		}
 
-		if (insn->type == INSN_JUMP_DYNAMIC && list_empty(&insn->alts))
-			/* sibling call */
-			return false;
+			return __dead_end_function(file, dest->func, recursion+1);
+		}
 	}
 
 	return true;
@@ -581,9 +586,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			insn->retpoline_safe = true;
 			continue;
 		} else {
-			/* sibling call */
+			/* external sibling call */
 			insn->call_dest = rela->sym;
-			insn->jump_dest = NULL;
 			continue;
 		}
 
@@ -633,9 +637,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-				/* sibling class */
+				/* internal sibling call */
 				insn->call_dest = insn->jump_dest->func;
-				insn->jump_dest = NULL;
 			}
 		}
 	}
@@ -1889,7 +1892,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
 	return false;
 }
 
-static inline const char *insn_dest_name(struct instruction *insn)
+static inline const char *call_dest_name(struct instruction *insn)
 {
 	if (insn->call_dest)
 		return insn->call_dest->name;
@@ -1901,13 +1904,13 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
-				insn->sec, insn->offset, insn_dest_name(insn));
+				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
 	if (state->df) {
 		WARN_FUNC("call to %s() with DF set",
-				insn->sec, insn->offset, insn_dest_name(insn));
+				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
@@ -2088,14 +2091,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (func && !insn->jump_dest) {
+			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
 
-			} else if (insn->jump_dest &&
-				   (!func || !insn->jump_dest->func ||
-				    insn->jump_dest->func->pfunc == func)) {
+			} else if (insn->jump_dest) {
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
@@ -2111,7 +2112,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts)) {
+			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
-- 
2.20.1

