Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C918C49874
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 06:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfFREzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 00:55:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45389 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfFREzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:55:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so6892475pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yYHRZxcVIOJ87/Z9nm6LP7uJRHg7vrdw/pdXnFLGsoI=;
        b=WPtBC2/rnGbL7o69gsOB23X74xE0oDbilDU7We7N2elbiNp3awRnsHxmToWToxdABs
         dwRcja/rlwPlKVx9c+Rs2Ks0FVVKTz4u8P1WqjIfRvx5DH+8869aO+lZZ2QCdwh/a6vW
         9HRLbapCE4X6TwD0uieKc3s3yst/KMb949N1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yYHRZxcVIOJ87/Z9nm6LP7uJRHg7vrdw/pdXnFLGsoI=;
        b=toR3KWiBnArgjLsluDChZZlTzuAudiG3Gk8UbMfsQ6J01nxutKOzTgeo7dmlB89PKU
         mhQqMLsuJitV3JqTXx/9LM01T/xOM+Gs1xA7zCxnPRF8agg+X1yJIEXES0EdpCltlYcD
         EC+VoLqLeIdAaEFnqNi02LyVjhcBScw7tFLQ2Y3CxZLoSK2kYPfsTXtBrn0fhK8utiGf
         BgXx18iPM+4zza7RiX3kiQXpRt1KS74b7m1VSCyAjmJvZpgYlSm+WV4yEtYqu0ALB0JT
         T+VVx+9ySmWyiKj47G+uxABw37ky2Tf0t/QWDBfjPvpQQTjQP/gYzu5cTMMPQQiHRqZ0
         n49Q==
X-Gm-Message-State: APjAAAUln38pzc+1KKZO1LJsQNIq4OQfk35L641S7E7cGFifh2pjRjMk
        QbSmJrSgCiXmdEYvC6kmj47rdzw1l4To+Q==
X-Google-Smtp-Source: APXvYqy5Y64lPIwaK9NSnPD/QkHTqK38gXsW4ijdVJD1ZUwxlHY/qrWZ1RA+bu069kcyh7dUgxq3ug==
X-Received: by 2002:a62:2ec4:: with SMTP id u187mr116203059pfu.84.1560833709401;
        Mon, 17 Jun 2019 21:55:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm12856366pgi.91.2019.06.17.21.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 21:55:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v3 2/3] x86/asm: Pin sensitive CR4 bits
Date:   Mon, 17 Jun 2019 21:55:02 -0700
Message-Id: <20190618045503.39105-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618045503.39105-1-keescook@chromium.org>
References: <20190618045503.39105-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several recent exploits have used direct calls to the native_write_cr4()
function to disable SMEP and SMAP before then continuing their exploits
using userspace memory access. This pins bits of CR4 so that they cannot
be changed through a common function. This is not intended to be general
ROP protection (which would require CFI to defend against properly), but
rather a way to avoid trivial direct function calling (or CFI bypasses
via a matching function prototype) as seen in:

https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
(https://github.com/xairy/kernel-exploits/tree/master/CVE-2017-7308)

The goals of this change:
 - pin specific bits (SMEP, SMAP, and UMIP) when writing CR4.
 - avoid setting the bits too early (they must become pinned only after
   CPU feature detection and selection has finished).
 - pinning mask needs to be read-only during normal runtime.
 - pinning needs to be checked after write to validate the cr4 state

Using __ro_after_init on the mask is done so it can't be first disabled
with a malicious write.

Since these bits are global state (once established by the boot CPU
and kernel boot parameters), they are safe to write to secondary CPUs
before those CPUs have finished feature detection. As such, the bits
are set at the first cr4 write, so that cr4 write bugs can be detected
(instead of silently papered over). This uses a few bytes less storage
of a location we don't have: read-only per-CPU data.

A check is performed after the register write because an attack could
just skip directly to the register write. Such a direct jump is possible
because of how this function may be built by the compiler (especially
due to the removal of frame pointers) where it doesn't add a stack frame
(function exit may only be a retq without pops) which is sufficient for
trivial exploitation like in the timer overwrites mentioned above).

The asm argument constraints gain the "+" modifier to convince the
compiler that it shouldn't make ordering assumptions about the arguments
or memory, and treat them as changed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- added missing EXPORT_SYMBOL()s
- remove always-OR, instead doing an early OR in secondary startup (tglx)
v2:
- move setup until after CPU feature detection and selection.
- refactor to use static branches to have atomic enabling.
- only perform the "or" after a failed check.
---
 arch/x86/include/asm/special_insns.h | 22 +++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         | 20 ++++++++++++++++++++
 arch/x86/kernel/smpboot.c            |  8 +++++++-
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 0a3c4cab39db..c8c8143ab27b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -6,6 +6,8 @@
 #ifdef __KERNEL__
 
 #include <asm/nops.h>
+#include <asm/processor-flags.h>
+#include <linux/jump_label.h>
 
 /*
  * Volatile isn't enough to prevent the compiler from reordering the
@@ -16,6 +18,10 @@
  */
 extern unsigned long __force_order;
 
+/* Starts false and gets enabled once CPU feature detection is done. */
+DECLARE_STATIC_KEY_FALSE(cr_pinning);
+extern unsigned long cr4_pinned_bits;
+
 static inline unsigned long native_read_cr0(void)
 {
 	unsigned long val;
@@ -74,7 +80,21 @@ static inline unsigned long native_read_cr4(void)
 
 static inline void native_write_cr4(unsigned long val)
 {
-	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
+			bits_missing = ~val & cr4_pinned_bits;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
+			  bits_missing);
+	}
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..c578addfcf8a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,6 +366,25 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
+EXPORT_SYMBOL(cr_pinning);
+unsigned long cr4_pinned_bits __ro_after_init;
+EXPORT_SYMBOL(cr4_pinned_bits);
+
+/*
+ * Once CPU feature detection is finished (and boot params have been
+ * parsed), record any of the sensitive CR bits that are set, and
+ * enable CR pinning.
+ */
+static void __init setup_cr_pinning(void)
+{
+	unsigned long mask;
+
+	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
+	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
+	static_key_enable(&cr_pinning.key);
+}
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1464,6 +1483,7 @@ void __init identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
+	setup_cr_pinning();
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd8953f48..1af7a2d89419 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -205,13 +205,19 @@ static int enable_start_cpu0;
  */
 static void notrace start_secondary(void *unused)
 {
+	unsigned long cr4 = __read_cr4();
+
 	/*
 	 * Don't put *anything* except direct CPU state initialization
 	 * before cpu_init(), SMP booting is too fragile that we want to
 	 * limit the things done here to the most necessary things.
 	 */
 	if (boot_cpu_has(X86_FEATURE_PCID))
-		__write_cr4(__read_cr4() | X86_CR4_PCIDE);
+		cr4 |= X86_CR4_PCIDE;
+	if (static_branch_likely(&cr_pinning))
+		cr4 |= cr4_pinned_bits;
+
+	__write_cr4(cr4);
 
 #ifdef CONFIG_X86_32
 	/* switch away from the initial page table */
-- 
2.17.1

