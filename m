Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3189369839
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfGOPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:17:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfGOPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:17:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6FFHEMf640486
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 15 Jul 2019 08:17:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6FFHEMf640486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563203834;
        bh=tveKyG0DqkP8yUywvSw+AzOPsQKsscipt54mT58F9MY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gRx33ZoeO3FyAQrxMkmGXSrXVUfmkmzvo2E42+vvQVmLq24CI+f94yeXjeyuhOZrN
         g1FQwngY2l5tXb3mlmKgBKbrZwrmydvcwNwqGM4dAJAs0eMMbHlF49utky4LnPSCsc
         N3iswcEtEysE8HkotXesZ1+XVRhJ7hMMne37l90iLGDAJ5pWCMgbB8SzB1gNrfqKa9
         h38G0cwM/CR68UriwlAnuMgEYEx/DKHjWZyjKwA/6EQeGNdmySgGpG4qOOAPAdFqzQ
         T0eA4pM0NwKxaOva5fTXRIeJqYYWN0pi+89YJBH8qHtYSAThq9i/OuH34xoQBVJ1SV
         2/eJ+AvFn/LXA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6FFHDh9640483;
        Mon, 15 Jul 2019 08:17:13 -0700
Date:   Mon, 15 Jul 2019 08:17:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-c7ca0b614513afba57824cae68447f9c32b1ee61@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, luto@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, luto@kernel.org
In-Reply-To: <fca39c478ea7fb15bc76fe8a36bd180810a067f6.1563200250.git.luto@kernel.org>
References: <fca39c478ea7fb15bc76fe8a36bd180810a067f6.1563200250.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Revert "x86/ptrace: Prevent ptrace from clearing
 the FS/GS selector" and fix the test
Git-Commit-ID: c7ca0b614513afba57824cae68447f9c32b1ee61
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c7ca0b614513afba57824cae68447f9c32b1ee61
Gitweb:     https://git.kernel.org/tip/c7ca0b614513afba57824cae68447f9c32b1ee61
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 15 Jul 2019 07:21:44 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 15 Jul 2019 17:12:31 +0200

Revert "x86/ptrace: Prevent ptrace from clearing the FS/GS selector" and fix the test

This reverts commit 48f5e52e916b55fb73754833efbacc7f8081a159.

The ptrace ABI change was a prerequisite to the proposed design for
FSGSBASE.  Since FSGSBASE support has been reverted, and since I'm not
convinced that the ABI was ever adequately tested, revert the ABI change as
well.

This also modifies the test case so that it tests the preexisting behavior.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/fca39c478ea7fb15bc76fe8a36bd180810a067f6.1563200250.git.luto@kernel.org

---
 arch/x86/kernel/ptrace.c               | 14 ++++++++++++--
 tools/testing/selftests/x86/fsgsbase.c | 22 ++++------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 71691a8310e7..0fdbe89d0754 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -369,12 +369,22 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		x86_fsbase_write_task(child, value);
+		/*
+		 * When changing the FS base, use do_arch_prctl_64()
+		 * to set the index to zero and to set the base
+		 * as requested.
+		 */
+		if (child->thread.fsbase != value)
+			return do_arch_prctl_64(child, ARCH_SET_FS, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
+		/*
+		 * Exactly the same here as the %fs handling above.
+		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		x86_gsbase_write_task(child, value);
+		if (child->thread.gsbase != value)
+			return do_arch_prctl_64(child, ARCH_SET_GS, value);
 		return 0;
 #endif
 	}
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 5ab4c60c100e..15a329da59fa 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -489,25 +489,11 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs != *shared_scratch) {
-			nerrs++;
-			printf("[FAIL]\tGS changed to %lx\n", gs);
-
-			/*
-			 * On older kernels, poking a nonzero value into the
-			 * base would zero the selector.  On newer kernels,
-			 * this behavior has changed -- poking the base
-			 * changes only the base and, if FSGSBASE is not
-			 * available, this may have no effect.
-			 */
-			if (gs == 0)
-				printf("\tNote: this is expected behavior on older kernels.\n");
-		} else if (have_fsgsbase && (base != 0xFF)) {
-			nerrs++;
-			printf("[FAIL]\tGSBASE changed to %lx\n", base);
+		if (gs == 0 && base == 0xFF) {
+			printf("[OK]\tGS was reset as expected\n");
 		} else {
-			printf("[OK]\tGS remained 0x%hx%s", *shared_scratch, have_fsgsbase ? " and GSBASE changed to 0xFF" : "");
-			printf("\n");
+			nerrs++;
+			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
 		}
 	}
 
