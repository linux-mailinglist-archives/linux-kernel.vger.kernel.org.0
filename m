Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D794F6C456
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbfGRBiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387812AbfGRBhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09CE530821C2;
        Thu, 18 Jul 2019 01:37:31 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7A0A5D9CC;
        Thu, 18 Jul 2019 01:37:29 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 16/22] objtool: Do frame pointer check before dead end check
Date:   Wed, 17 Jul 2019 20:36:51 -0500
Message-Id: <aed62fbd60e239280218be623f751a433658e896.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 18 Jul 2019 01:37:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even calls to __noreturn functions need the frame pointer setup first.
Such functions often dump the stack.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/check.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 970dfeac841d..3fb656ea96b9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -133,6 +133,9 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_do_exit",
 	};
 
+	if (!func)
+		return false;
+
 	if (func->bind == STB_WEAK)
 		return false;
 
@@ -2071,19 +2074,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (insn->type == INSN_CALL) {
-				if (is_fentry_call(insn))
-					break;
-
-				if (dead_end_function(file, insn->call_dest))
-					return 0;
-			}
-
-			if (!no_fp && func && !has_valid_stack_frame(&state)) {
+			if (!no_fp && func && !is_fentry_call(insn) &&
+			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
 			}
+
+			if (dead_end_function(file, insn->call_dest))
+				return 0;
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
-- 
2.20.1

