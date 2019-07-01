Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1475258DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF0WQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 18:16:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0WQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:16:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMG1nA472928
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:16:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMG1nA472928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561673762;
        bh=qPtuQ4BTfUqxRxM4raDrmCUwiC/8aZm4v5J5xlGw2Mk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wdc1pKyTOS0kTHOXh+siT1t2IRrzVEDNm/mAYuBIYJgH0AGlyWWI6SGQ24k2cx4qY
         51JgLTtXWi0+RV0v89wTw6hdubjvfi4FeW0OWeqkpEP+1yCvLkSjvVt8cCBjGiUnOq
         WS2ZfVa8U9ZfYoJL1is59LCN0Cc0hxWZlhLqV4a4PKSThNB6palRbGJYcbNoEb7KEq
         vKutZi3j/udVhPJdZ/6IOuVLJomG/lPVheNb+9MNSENnHBfcW2fq+7eYxqREIFvKFR
         cq0i3BsCd1RTc+eYc/bPLxFHJqGIt/v+SWVeiZwbusSNpGuLcRMjc17MLGmnSVKQW8
         dSEShgiVn81Lw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMG1aC472925;
        Thu, 27 Jun 2019 15:16:01 -0700
Date:   Thu, 27 Jun 2019 15:16:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-b0386979867168575118501104f3d135067eab4f@git.kernel.org>
Cc:     kernel-hardening@lists.openwall.com, hpa@zytor.com,
        jannh@google.com, linux-kernel@vger.kernel.org, fweimer@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        peterz@infradead.org, keescook@chromium.org, bp@alien8.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
          peterz@infradead.org, keescook@chromium.org, luto@kernel.org,
          kernel-hardening@lists.openwall.com, fweimer@redhat.com,
          linux-kernel@vger.kernel.org, jannh@google.com, hpa@zytor.com
In-Reply-To: <b413397c804265f8865f3e70b14b09485ea7c314.1561610354.git.luto@kernel.org>
References: <b413397c804265f8865f3e70b14b09485ea7c314.1561610354.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] selftests/x86/vsyscall: Verify that vsyscall=none
 blocks execution
Git-Commit-ID: b0386979867168575118501104f3d135067eab4f
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

Commit-ID:  b0386979867168575118501104f3d135067eab4f
Gitweb:     https://git.kernel.org/tip/b0386979867168575118501104f3d135067eab4f
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 26 Jun 2019 21:45:06 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:04:39 +0200

selftests/x86/vsyscall: Verify that vsyscall=none blocks execution

If vsyscall=none accidentally still allowed vsyscalls, the test wouldn't
fail.  Fix it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/b413397c804265f8865f3e70b14b09485ea7c314.1561610354.git.luto@kernel.org

---
 tools/testing/selftests/x86/test_vsyscall.c | 76 ++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 4c9a8d76dba0..34a1d35995ef 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -49,21 +49,21 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 }
 
 /* vsyscalls and vDSO */
-bool should_read_vsyscall = false;
+bool vsyscall_map_r = false, vsyscall_map_x = false;
 
 typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-gtod_t vgtod = (gtod_t)VSYS(0xffffffffff600000);
+const gtod_t vgtod = (gtod_t)VSYS(0xffffffffff600000);
 gtod_t vdso_gtod;
 
 typedef int (*vgettime_t)(clockid_t, struct timespec *);
 vgettime_t vdso_gettime;
 
 typedef long (*time_func_t)(time_t *t);
-time_func_t vtime = (time_func_t)VSYS(0xffffffffff600400);
+const time_func_t vtime = (time_func_t)VSYS(0xffffffffff600400);
 time_func_t vdso_time;
 
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
-getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
+const getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
 getcpu_t vdso_getcpu;
 
 static void init_vdso(void)
@@ -107,7 +107,7 @@ static int init_vsys(void)
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) {
 		printf("[WARN]\tCould not open /proc/self/maps -- assuming vsyscall is r-x\n");
-		should_read_vsyscall = true;
+		vsyscall_map_r = true;
 		return 0;
 	}
 
@@ -133,12 +133,8 @@ static int init_vsys(void)
 		}
 
 		printf("\tvsyscall permissions are %c-%c\n", r, x);
-		should_read_vsyscall = (r == 'r');
-		if (x != 'x') {
-			vgtod = NULL;
-			vtime = NULL;
-			vgetcpu = NULL;
-		}
+		vsyscall_map_r = (r == 'r');
+		vsyscall_map_x = (x == 'x');
 
 		found = true;
 		break;
@@ -148,10 +144,8 @@ static int init_vsys(void)
 
 	if (!found) {
 		printf("\tno vsyscall map in /proc/self/maps\n");
-		should_read_vsyscall = false;
-		vgtod = NULL;
-		vtime = NULL;
-		vgetcpu = NULL;
+		vsyscall_map_r = false;
+		vsyscall_map_x = false;
 	}
 
 	return nerrs;
@@ -242,7 +236,7 @@ static int test_gtod(void)
 		err(1, "syscall gettimeofday");
 	if (vdso_gtod)
 		ret_vdso = vdso_gtod(&tv_vdso, &tz_vdso);
-	if (vgtod)
+	if (vsyscall_map_x)
 		ret_vsys = vgtod(&tv_vsys, &tz_vsys);
 	if (sys_gtod(&tv_sys2, &tz_sys) != 0)
 		err(1, "syscall gettimeofday");
@@ -256,7 +250,7 @@ static int test_gtod(void)
 		}
 	}
 
-	if (vgtod) {
+	if (vsyscall_map_x) {
 		if (ret_vsys == 0) {
 			nerrs += check_gtod(&tv_sys1, &tv_sys2, &tz_sys, "vsyscall", &tv_vsys, &tz_vsys);
 		} else {
@@ -277,7 +271,7 @@ static int test_time(void) {
 	t_sys1 = sys_time(&t2_sys1);
 	if (vdso_time)
 		t_vdso = vdso_time(&t2_vdso);
-	if (vtime)
+	if (vsyscall_map_x)
 		t_vsys = vtime(&t2_vsys);
 	t_sys2 = sys_time(&t2_sys2);
 	if (t_sys1 < 0 || t_sys1 != t2_sys1 || t_sys2 < 0 || t_sys2 != t2_sys2) {
@@ -298,7 +292,7 @@ static int test_time(void) {
 		}
 	}
 
-	if (vtime) {
+	if (vsyscall_map_x) {
 		if (t_vsys < 0 || t_vsys != t2_vsys) {
 			printf("[FAIL]\tvsyscall failed (ret:%ld output:%ld)\n", t_vsys, t2_vsys);
 			nerrs++;
@@ -334,7 +328,7 @@ static int test_getcpu(int cpu)
 	ret_sys = sys_getcpu(&cpu_sys, &node_sys, 0);
 	if (vdso_getcpu)
 		ret_vdso = vdso_getcpu(&cpu_vdso, &node_vdso, 0);
-	if (vgetcpu)
+	if (vsyscall_map_x)
 		ret_vsys = vgetcpu(&cpu_vsys, &node_vsys, 0);
 
 	if (ret_sys == 0) {
@@ -373,7 +367,7 @@ static int test_getcpu(int cpu)
 		}
 	}
 
-	if (vgetcpu) {
+	if (vsyscall_map_x) {
 		if (ret_vsys) {
 			printf("[FAIL]\tvsyscall getcpu() failed\n");
 			nerrs++;
@@ -414,10 +408,10 @@ static int test_vsys_r(void)
 		can_read = false;
 	}
 
-	if (can_read && !should_read_vsyscall) {
+	if (can_read && !vsyscall_map_r) {
 		printf("[FAIL]\tWe have read access, but we shouldn't\n");
 		return 1;
-	} else if (!can_read && should_read_vsyscall) {
+	} else if (!can_read && vsyscall_map_r) {
 		printf("[FAIL]\tWe don't have read access, but we should\n");
 		return 1;
 	} else if (can_read) {
@@ -431,6 +425,39 @@ static int test_vsys_r(void)
 	return 0;
 }
 
+static int test_vsys_x(void)
+{
+#ifdef __x86_64__
+	if (vsyscall_map_x) {
+		/* We already tested this adequately. */
+		return 0;
+	}
+
+	printf("[RUN]\tMake sure that vsyscalls really page fault\n");
+
+	bool can_exec;
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		vgtod(NULL, NULL);
+		can_exec = true;
+	} else {
+		can_exec = false;
+	}
+
+	if (can_exec) {
+		printf("[FAIL]\tExecuting the vsyscall did not page fault\n");
+		return 1;
+	} else if (segv_err & (1 << 4)) { /* INSTR */
+		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
+		       segv_err);
+	} else {
+		printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
+		       segv_err);
+		return 1;
+	}
+#endif
+
+	return 0;
+}
 
 #ifdef __x86_64__
 #define X86_EFLAGS_TF (1UL << 8)
@@ -462,7 +489,7 @@ static int test_emulation(void)
 	time_t tmp;
 	bool is_native;
 
-	if (!vtime)
+	if (!vsyscall_map_x)
 		return 0;
 
 	printf("[RUN]\tchecking that vsyscalls are emulated\n");
@@ -504,6 +531,7 @@ int main(int argc, char **argv)
 
 	sethandler(SIGSEGV, sigsegv, 0);
 	nerrs += test_vsys_r();
+	nerrs += test_vsys_x();
 
 #ifdef __x86_64__
 	nerrs += test_emulation();
