Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050E26C452
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbfGRBhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389094AbfGRBhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00D2F30A5A6F;
        Thu, 18 Jul 2019 01:37:36 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5D8F5D9CC;
        Thu, 18 Jul 2019 01:37:34 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 20/22] objtool: Fix seg fault on bad switch table entry
Date:   Wed, 17 Jul 2019 20:36:55 -0500
Message-Id: <a9db88eec4f1ca089e040989846961748238b6d8.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 18 Jul 2019 01:37:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one rare case, Clang generated the following code:

 5ca:       83 e0 21                and    $0x21,%eax
 5cd:       b9 04 00 00 00          mov    $0x4,%ecx
 5d2:       ff 24 c5 00 00 00 00    jmpq   *0x0(,%rax,8)
                    5d5: R_X86_64_32S       .rodata+0x38

which uses the corresponding jump table relocations:

  000000000038  000200000001 R_X86_64_64       0000000000000000 .text + 834
  000000000040  000200000001 R_X86_64_64       0000000000000000 .text + 5d9
  000000000048  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000050  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000058  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000060  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000068  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000070  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000078  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000080  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000088  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000090  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000098  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000a0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000a8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000b0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000b8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000c0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000c8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000d0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000d8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000e0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000e8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000f0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000f8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000100  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000108  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000110  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000118  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000120  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000128  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000130  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000138  000200000001 R_X86_64_64       0000000000000000 .text + 82f
  000000000140  000200000001 R_X86_64_64       0000000000000000 .text + 828

Since %eax was masked with 0x21, only the first two and the last two
entries are possible.

Objtool doesn't actually emulate all the code, so it isn't smart enough
to know that all the middle entries aren't reachable.  They point to the
NOP padding area after the end of the function, so objtool seg faulted
when it tried to dereference a NULL insn->func.

After this fix, objtool still gives an "unreachable" error because it
stops reading the jump table when it encounters the bad addresses:

  /home/jpoimboe/objtool-tests/adm1275.o: warning: objtool: adm1275_probe()+0x828: unreachable instruction

While the above code is technically correct, it's very wasteful of
memory -- it uses 34 jump table entries when only 4 are needed.  It's
also not possible for objtool to validate this type of switch table
because the unused entries point outside the function and objtool has no
way of determining if that's intentional.  Hopefully the Clang folks can
fix it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a64bb54abd29..082ede40c6c0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -932,7 +932,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the destination is in the same function: */
-		if (dest_insn->func->pfunc != pfunc)
+		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
-- 
2.20.1

