Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F84F572
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfD3LXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:23:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfD3LXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:23:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBMmxW1347914
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:22:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBMmxW1347914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623369;
        bh=Ge64oaq9IF85kTTWHMmPXyLrFHLm+O8W4XfcR0nuqaA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uWS03uwo9NpLZTnRJVBVkAeCCcJad+QmV6kZSGIyzbk0Vr0wNMwdeBfexZqf76JBL
         MgIa3QXdQUzhiYYg7eV2yFz0Pby36bCwqkCyy6G8wB7zpSSpXddfvtxBZiIAZrSGTZ
         4mMO0ducgxIljAtec3kH5Raa1OUVSqPTFJstEmDTNj7tiaEvf+ibhjMQPRn8f2PIcN
         pRyaLdkFZVrjBXuMCIaxONuyGkoq39p8M719vxfd3ASvVOFkplOJXxDV+TrNh0o8f0
         FrT1StoX9GgaPb/RKup5pF5gtcvt+PloDqkAE+3PGyYXr0O/fSbhwJcoomr+/XHTRl
         RVcWLRaDR5w1Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBMllL1347909;
        Tue, 30 Apr 2019 04:22:47 -0700
Date:   Tue, 30 Apr 2019 04:22:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-f2c65fb3221adc6b73b0549fc7ba892022db9797@git.kernel.org>
Cc:     bp@alien8.de, ard.biesheuvel@linaro.org, deneen.t.dock@intel.com,
        jeyu@kernel.org, torvalds@linux-foundation.org,
        linux_dti@icloud.com, rick.p.edgecombe@intel.com,
        kernel-hardening@lists.openwall.com, keescook@chromium.org,
        mhiramat@kernel.org, dave.hansen@intel.com, luto@amacapital.net,
        peterz@infradead.org, namit@vmware.com, luto@kernel.org,
        kristen@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, akpm@linux-foundation.org, hpa@zytor.com
Reply-To: bp@alien8.de, jeyu@kernel.org, deneen.t.dock@intel.com,
          ard.biesheuvel@linaro.org, rick.p.edgecombe@intel.com,
          linux_dti@icloud.com, torvalds@linux-foundation.org,
          keescook@chromium.org, kernel-hardening@lists.openwall.com,
          luto@amacapital.net, dave.hansen@intel.com, mhiramat@kernel.org,
          mingo@kernel.org, kristen@linux.intel.com, luto@kernel.org,
          namit@vmware.com, peterz@infradead.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org
In-Reply-To: <20190426001143.4983-12-namit@vmware.com>
References: <20190426001143.4983-12-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/modules: Avoid breaking W^X while loading modules
Git-Commit-ID: f2c65fb3221adc6b73b0549fc7ba892022db9797
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

Commit-ID:  f2c65fb3221adc6b73b0549fc7ba892022db9797
Gitweb:     https://git.kernel.org/tip/f2c65fb3221adc6b73b0549fc7ba892022db9797
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:31 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:55 +0200

x86/modules: Avoid breaking W^X while loading modules

When modules and BPF filters are loaded, there is a time window in
which some memory is both writable and executable. An attacker that has
already found another vulnerability (e.g., a dangling pointer) might be
able to exploit this behavior to overwrite kernel code. Prevent having
writable executable PTEs in this stage.

In addition, avoiding having W+X mappings can also slightly simplify the
patching of modules code on initialization (e.g., by alternatives and
static-key), as would be done in the next patch. This was actually the
main motivation for this patch.

To avoid having W+X mappings, set them initially as RW (NX) and after
they are set as RO set them as X as well. Setting them as executable is
done as a separate step to avoid one core in which the old PTE is cached
(hence writable), and another which sees the updated PTE (executable),
which would break the W^X protection.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Andy Lutomirski <luto@amacapital.net>
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
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lkml.kernel.org/r/20190426001143.4983-12-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 28 +++++++++++++++++++++-------
 arch/x86/kernel/module.c      |  2 +-
 include/linux/filter.h        |  1 +
 kernel/module.c               |  5 +++++
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 599203876c32..3d2b6b6fb20c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -668,15 +668,29 @@ void __init alternative_instructions(void)
  * handlers seeing an inconsistent instruction while you patch.
  */
 void *__init_or_module text_poke_early(void *addr, const void *opcode,
-					      size_t len)
+				       size_t len)
 {
 	unsigned long flags;
-	local_irq_save(flags);
-	memcpy(addr, opcode, len);
-	local_irq_restore(flags);
-	sync_core();
-	/* Could also do a CLFLUSH here to speed up CPU recovery; but
-	   that causes hangs on some VIA CPUs. */
+
+	if (boot_cpu_has(X86_FEATURE_NX) &&
+	    is_module_text_address((unsigned long)addr)) {
+		/*
+		 * Modules text is marked initially as non-executable, so the
+		 * code cannot be running and speculative code-fetches are
+		 * prevented. Just change the code.
+		 */
+		memcpy(addr, opcode, len);
+	} else {
+		local_irq_save(flags);
+		memcpy(addr, opcode, len);
+		local_irq_restore(flags);
+		sync_core();
+
+		/*
+		 * Could also do a CLFLUSH here to speed up CPU recovery; but
+		 * that causes hangs on some VIA CPUs.
+		 */
+	}
 	return addr;
 }
 
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b052e883dd8c..cfa3106faee4 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -87,7 +87,7 @@ void *module_alloc(unsigned long size)
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
 				    MODULES_VADDR + get_module_load_offset(),
 				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6074aa064b54..14ec3bdad9a9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -746,6 +746,7 @@ static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
 	set_memory_ro((unsigned long)hdr, hdr->pages);
+	set_memory_x((unsigned long)hdr, hdr->pages);
 }
 
 static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hdr)
diff --git a/kernel/module.c b/kernel/module.c
index 0b9aa8ab89f0..2b2845ae983e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1950,8 +1950,13 @@ void module_enable_ro(const struct module *mod, bool after_init)
 		return;
 
 	frob_text(&mod->core_layout, set_memory_ro);
+	frob_text(&mod->core_layout, set_memory_x);
+
 	frob_rodata(&mod->core_layout, set_memory_ro);
+
 	frob_text(&mod->init_layout, set_memory_ro);
+	frob_text(&mod->init_layout, set_memory_x);
+
 	frob_rodata(&mod->init_layout, set_memory_ro);
 
 	if (after_init)
