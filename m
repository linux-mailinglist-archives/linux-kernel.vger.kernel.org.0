Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4577CF576
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfD3LYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:24:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfD3LYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:24:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBOBdF1349793
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:24:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBOBdF1349793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623452;
        bh=jkpd+GVdrkh7KzOnB4lfVWgT8IU7cAG8FRCqg3nsW2c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TFSoNBH0Q7xSDHMm4potaxttnfnwDqF0qh5Ylki4CNuADFrKHAkKWVmB2HuBQpsBJ
         VUhEQzQoSMf9JFoNn5WSalRq5abBysqzoMaoBJYTpYLX0gGuz12ibJmFKBSDopPYPw
         PUjdzOwJWWGWAhM3fM1g6GXj//upR5urFmxhocxD81H5jIsDMoGR7TmujLImzhGtaZ
         GmxO55dG1y8ClJJYnc1cIW7xHj/OQ71xkbNIgpV70DUDymC8GGXPyV35eq3kdi2n2h
         POBy4li8F9eLblyvff6BxqgCGUpvL3qP1e8bC4hLF+VnHzGnI8xghAlyuKCjw4uJsZ
         mXa1deCnbxeKw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBO94p1349614;
        Tue, 30 Apr 2019 04:24:09 -0700
Date:   Tue, 30 Apr 2019 04:24:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-0a203df5cf0eb709be4f190314e262b72d7e5b76@git.kernel.org>
Cc:     mhiramat@kernel.org, torvalds@linux-foundation.org,
        kernel-hardening@lists.openwall.com, tglx@linutronix.de,
        rick.p.edgecombe@intel.com, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        kristen@linux.intel.com, akpm@linux-foundation.org,
        linux_dti@icloud.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, namit@vmware.com, riel@surriel.com,
        mingo@kernel.org, luto@kernel.org, keescook@chromium.org,
        peterz@infradead.org, bp@alien8.de
Reply-To: dave.hansen@intel.com, linux_dti@icloud.com,
          akpm@linux-foundation.org, deneen.t.dock@intel.com,
          namit@vmware.com, mingo@kernel.org, luto@kernel.org,
          keescook@chromium.org, riel@surriel.com, peterz@infradead.org,
          bp@alien8.de, torvalds@linux-foundation.org, mhiramat@kernel.org,
          tglx@linutronix.de, rick.p.edgecombe@intel.com,
          kernel-hardening@lists.openwall.com,
          linux-kernel@vger.kernel.org, kristen@linux.intel.com,
          will.deacon@arm.com, hpa@zytor.com, ard.biesheuvel@linaro.org
In-Reply-To: <20190426001143.4983-14-namit@vmware.com>
References: <20190426001143.4983-14-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/alternatives: Remove the return value of
 text_poke_*()
Git-Commit-ID: 0a203df5cf0eb709be4f190314e262b72d7e5b76
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0a203df5cf0eb709be4f190314e262b72d7e5b76
Gitweb:     https://git.kernel.org/tip/0a203df5cf0eb709be4f190314e262b72d7e5b76
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:33 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:56 +0200

x86/alternatives: Remove the return value of text_poke_*()

The return value of text_poke_early() and text_poke_bp() is useless.
Remove it.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-14-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  4 ++--
 arch/x86/kernel/alternative.c        | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index a75eed841eed..c90678fd391a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,7 +18,7 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
-extern void *text_poke_early(void *addr, const void *opcode, size_t len);
+extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
@@ -37,7 +37,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3d2b6b6fb20c..18f959975ea0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -265,7 +265,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
-void *text_poke_early(void *addr, const void *opcode, size_t len);
+void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Are we looking at a near JMP with a 1 or 4-byte displacement.
@@ -667,8 +667,8 @@ void __init alternative_instructions(void)
  * instructions. And on the local CPU you need to be protected again NMI or MCE
  * handlers seeing an inconsistent instruction while you patch.
  */
-void *__init_or_module text_poke_early(void *addr, const void *opcode,
-				       size_t len)
+void __init_or_module text_poke_early(void *addr, const void *opcode,
+				      size_t len)
 {
 	unsigned long flags;
 
@@ -691,7 +691,6 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 		 * that causes hangs on some VIA CPUs.
 		 */
 	}
-	return addr;
 }
 
 __ro_after_init struct mm_struct *poking_mm;
@@ -893,7 +892,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  *	  replacing opcode
  *	- sync cores
  */
-void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
 	unsigned char int3 = 0xcc;
 
@@ -935,7 +934,5 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	 * the writing of the new instruction.
 	 */
 	bp_patching_in_progress = false;
-
-	return addr;
 }
 
