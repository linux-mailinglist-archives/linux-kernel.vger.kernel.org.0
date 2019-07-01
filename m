Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32FC58DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF0WP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 18:15:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0WP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:15:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMFImh472851
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:15:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMFImh472851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561673719;
        bh=8ZTuFEkOgg6P4ySct4Z1PzgcWHbNGCdp1oLL8agGzvs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eLCHTMjYgAxz6SBFeKpoHl3LPl/4iksicuPt06p+S2RjpJBTXxx3NWq2r5tzSOGnT
         71+eNG7vDDRUdMm1ORNy2alTpHQ90Pa66jYglckghCLFFqmo/lcZn4XpjjB67u87Ns
         b236J1zdoNTYaXMsV3QMMw6eLe4TGuprUQDcfspLc7K0TTAB6ukRyR9jq2fka5C7CG
         iFIcLyZDIzGBPT76n+H9aF/bp1ywLVmUI2S+HgZ6yOJ6SMFmT29vFjxmO6JtSNNu6t
         jNB5ZS2nY2sHTfddNBR/KcZEH3de20ZJSGpS0+3T1by62iJLxlgT3+8F8S6OOoGysF
         oP8UIkNiaJmiQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMFIxv472848;
        Thu, 27 Jun 2019 15:15:18 -0700
Date:   Thu, 27 Jun 2019 15:15:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-e0a446ce394a7915f2ffc03f9bb610c5ac4dbbf1@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org,
        kernel-hardening@lists.openwall.com, keescook@chromium.org,
        fweimer@redhat.com, luto@kernel.org, bp@alien8.de,
        jannh@google.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          jannh@google.com, tglx@linutronix.de, bp@alien8.de,
          luto@kernel.org, fweimer@redhat.com,
          kernel-hardening@lists.openwall.com, keescook@chromium.org,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <75c91855fd850649ace162eec5495a1354221aaa.1561610354.git.luto@kernel.org>
References: <75c91855fd850649ace162eec5495a1354221aaa.1561610354.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/vsyscall: Document odd SIGSEGV error code for
 vsyscalls
Git-Commit-ID: e0a446ce394a7915f2ffc03f9bb610c5ac4dbbf1
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

Commit-ID:  e0a446ce394a7915f2ffc03f9bb610c5ac4dbbf1
Gitweb:     https://git.kernel.org/tip/e0a446ce394a7915f2ffc03f9bb610c5ac4dbbf1
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 26 Jun 2019 21:45:05 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:04:39 +0200

x86/vsyscall: Document odd SIGSEGV error code for vsyscalls

Even if vsyscall=none, user page faults on the vsyscall page are reported
as though the PROT bit in the error code was set.  Add a comment explaining
why this is probably okay and display the value in the test case.

While at it, explain why the behavior is correct with respect to PKRU.

Modify also the selftest to print the odd error code so that there is a
way to demonstrate the odd behaviour.

If anyone really cares about more accurate emulation, the behaviour could
be changed. But that needs a real good justification.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/75c91855fd850649ace162eec5495a1354221aaa.1561610354.git.luto@kernel.org

---
 arch/x86/mm/fault.c                         | 7 +++++++
 tools/testing/selftests/x86/test_vsyscall.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 288a5462076f..58e4f1f00bbc 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -710,6 +710,10 @@ static void set_signal_archinfo(unsigned long address,
 	 * To avoid leaking information about the kernel page
 	 * table layout, pretend that user-mode accesses to
 	 * kernel addresses are always protection faults.
+	 *
+	 * NB: This means that failed vsyscalls with vsyscall=none
+	 * will have the PROT bit.  This doesn't leak any
+	 * information and does not appear to cause any problems.
 	 */
 	if (address >= TASK_SIZE_MAX)
 		error_code |= X86_PF_PROT;
@@ -1375,6 +1379,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 *
 	 * The vsyscall page does not have a "real" VMA, so do this
 	 * emulation before we go searching for VMAs.
+	 *
+	 * PKRU never rejects instruction fetches, so we don't need
+	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
 		if (emulate_vsyscall(hw_error_code, regs, address))
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 0b4f1cc2291c..4c9a8d76dba0 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -183,9 +183,13 @@ static inline long sys_getcpu(unsigned * cpu, unsigned * node,
 }
 
 static jmp_buf jmpbuf;
+static volatile unsigned long segv_err;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+
+	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
 	siglongjmp(jmpbuf, 1);
 }
 
@@ -416,8 +420,11 @@ static int test_vsys_r(void)
 	} else if (!can_read && should_read_vsyscall) {
 		printf("[FAIL]\tWe don't have read access, but we should\n");
 		return 1;
+	} else if (can_read) {
+		printf("[OK]\tWe have read access\n");
 	} else {
-		printf("[OK]\tgot expected result\n");
+		printf("[OK]\tWe do not have read access: #PF(0x%lx)\n",
+		       segv_err);
 	}
 #endif
 
