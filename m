Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4884158DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 00:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF0WOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 18:14:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:14:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMDs4M472449
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:13:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMDs4M472449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561673635;
        bh=qUJfGIgj6Xy3i1+LLl29OmQhEUUk+m4ZweRFueSrG20=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UQRXwtRCI/RHLwQvlDt4EtG02jNNL5Fa/3JyTAV70/RipYy6MdLiLWUTW0HSMwCD2
         tOZzzb9fWq334fsVLxStgNda0kiOy5RGFQyRySYvM8Sdmy6JB7x9axnQGuXlngSiBW
         8bYefGW10pPAgsuH+VqNTcAufa9Mu8C0u7BsELqMtcOUlOSMneirbsNKOIE4sfvU+g
         diszxTTxaYmkH7GPk0sA/gL15c/GIyX2JyI/FW1RqnMLD8K2islpzZ8Ar+9ckTlt0e
         FSLdVVtv4VJ1BX/Nww6mhq6ovUXjQgJxk4EBjKuaHFjbzItwDjnIYPggC9AbR0iQoI
         3EHXUmVoRyybA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMDsWH472446;
        Thu, 27 Jun 2019 15:13:54 -0700
Date:   Thu, 27 Jun 2019 15:13:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-bd49e16e3339f052fae05fb3e955c5db0c9c6445@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        keescook@chromium.org, hpa@zytor.com, fweimer@redhat.com,
        tglx@linutronix.de, kernel-hardening@lists.openwall.com,
        peterz@infradead.org, jannh@google.com, bp@alien8.de
Reply-To: keescook@chromium.org, fweimer@redhat.com, mingo@kernel.org,
          peterz@infradead.org, jannh@google.com, tglx@linutronix.de,
          kernel-hardening@lists.openwall.com, luto@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, bp@alien8.de
In-Reply-To: <d17655777c21bc09a7af1bbcf74e6f2b69a51152.1561610354.git.luto@kernel.org>
References: <d17655777c21bc09a7af1bbcf74e6f2b69a51152.1561610354.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/vsyscall: Add a new vsyscall=xonly mode
Git-Commit-ID: bd49e16e3339f052fae05fb3e955c5db0c9c6445
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bd49e16e3339f052fae05fb3e955c5db0c9c6445
Gitweb:     https://git.kernel.org/tip/bd49e16e3339f052fae05fb3e955c5db0c9c6445
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 26 Jun 2019 21:45:03 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:04:38 +0200

x86/vsyscall: Add a new vsyscall=xonly mode

With vsyscall emulation on, a readable vsyscall page is still exposed that
contains syscall instructions that validly implement the vsyscalls.

This is required because certain dynamic binary instrumentation tools
attempt to read the call targets of call instructions in the instrumented
code.  If the instrumented code uses vsyscalls, then the vsyscall page needs
to contain readable code.

Unfortunately, leaving readable memory at a deterministic address can be
used to help various ASLR bypasses, so some hardening value can be gained
by disallowing vsyscall reads.

Given how rarely the vsyscall page needs to be readable, add a mechanism to
make the vsyscall page be execute only.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d17655777c21bc09a7af1bbcf74e6f2b69a51152.1561610354.git.luto@kernel.org

---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++-
 arch/x86/Kconfig                                | 33 ++++++++++++++++++-------
 arch/x86/entry/vsyscall/vsyscall_64.c           | 16 ++++++++++--
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0082d1e56999..be8c3a680afa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5100,7 +5100,12 @@
 			targets for exploits that can control RIP.
 
 			emulate     [default] Vsyscalls turn into traps and are
-			            emulated reasonably safely.
+			            emulated reasonably safely.  The vsyscall
+				    page is readable.
+
+			xonly       Vsyscalls turn into traps and are
+			            emulated reasonably safely.  The vsyscall
+				    page is not readable.
 
 			none        Vsyscalls don't work at all.  This makes
 			            them quite hard to use for exploits but
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..0182d2c67590 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2293,23 +2293,38 @@ choice
 	  it can be used to assist security vulnerability exploitation.
 
 	  This setting can be changed at boot time via the kernel command
-	  line parameter vsyscall=[emulate|none].
+	  line parameter vsyscall=[emulate|xonly|none].
 
 	  On a system with recent enough glibc (2.14 or newer) and no
 	  static binaries, you can say None without a performance penalty
 	  to improve security.
 
-	  If unsure, select "Emulate".
+	  If unsure, select "Emulate execution only".
 
 	config LEGACY_VSYSCALL_EMULATE
-		bool "Emulate"
+		bool "Full emulation"
 		help
-		  The kernel traps and emulates calls into the fixed
-		  vsyscall address mapping. This makes the mapping
-		  non-executable, but it still contains known contents,
-		  which could be used in certain rare security vulnerability
-		  exploits. This configuration is recommended when userspace
-		  still uses the vsyscall area.
+		  The kernel traps and emulates calls into the fixed vsyscall
+		  address mapping. This makes the mapping non-executable, but
+		  it still contains readable known contents, which could be
+		  used in certain rare security vulnerability exploits. This
+		  configuration is recommended when using legacy userspace
+		  that still uses vsyscalls along with legacy binary
+		  instrumentation tools that require code to be readable.
+
+		  An example of this type of legacy userspace is running
+		  Pin on an old binary that still uses vsyscalls.
+
+	config LEGACY_VSYSCALL_XONLY
+		bool "Emulate execution only"
+		help
+		  The kernel traps and emulates calls into the fixed vsyscall
+		  address mapping and does not allow reads.  This
+		  configuration is recommended when userspace might use the
+		  legacy vsyscall area but support for legacy binary
+		  instrumentation of legacy code is not needed.  It mitigates
+		  certain uses of the vsyscall area as an ASLR-bypassing
+		  buffer.
 
 	config LEGACY_VSYSCALL_NONE
 		bool "None"
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index d9d81ad7a400..fedd7628f3a6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -42,9 +42,11 @@
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
 
-static enum { EMULATE, NONE } vsyscall_mode =
+static enum { EMULATE, XONLY, NONE } vsyscall_mode =
 #ifdef CONFIG_LEGACY_VSYSCALL_NONE
 	NONE;
+#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
+	XONLY;
 #else
 	EMULATE;
 #endif
@@ -54,6 +56,8 @@ static int __init vsyscall_setup(char *str)
 	if (str) {
 		if (!strcmp("emulate", str))
 			vsyscall_mode = EMULATE;
+		else if (!strcmp("xonly", str))
+			vsyscall_mode = XONLY;
 		else if (!strcmp("none", str))
 			vsyscall_mode = NONE;
 		else
@@ -357,12 +361,20 @@ void __init map_vsyscall(void)
 	extern char __vsyscall_page;
 	unsigned long physaddr_vsyscall = __pa_symbol(&__vsyscall_page);
 
-	if (vsyscall_mode != NONE) {
+	/*
+	 * For full emulation, the page needs to exist for real.  In
+	 * execute-only mode, there is no PTE at all backing the vsyscall
+	 * page.
+	 */
+	if (vsyscall_mode == EMULATE) {
 		__set_fixmap(VSYSCALL_PAGE, physaddr_vsyscall,
 			     PAGE_KERNEL_VVAR);
 		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
 	}
 
+	if (vsyscall_mode == XONLY)
+		gate_vma.vm_flags = VM_EXEC;
+
 	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
 		     (unsigned long)VSYSCALL_ADDR);
 }
