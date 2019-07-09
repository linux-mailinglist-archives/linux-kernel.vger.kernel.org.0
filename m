Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8F634FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGILfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:35:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGILfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:35:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BZBv21893608
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:35:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BZBv21893608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562672112;
        bh=BJm4T52ZtgHZXczmRw+dQAZJwk81Hq3GCwj+nx+J8ic=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=EUMSYXihTT/PMSd2VUnICr9K11ISm0897X9Ju/Woz/89W5XribvOLQ6e2BCGjqQzB
         7eb98Hsc9RJWZGG1NSWxZ3I7CQoJF/q+rD0RCpW55VYw1xqv9t+LktdogoDoeBGqKF
         QXsITxOK9ToN1793WrN/r5DQDol1vzlyXC/y0TEJ44JfHEO8C6HNVjQdWZEqzpabrm
         9ioEOL1xHBFBtZ1Ry0jRU7/ivT3RIjqupURSFaCuxtl5Y+chMZwAdLfqmmHJ1wkVcZ
         UEvtH2r0p3xK7Qebjg06xZHohFk70icctTXcs3vYD6d5xXSE1AFHr5d4bQEvH7XYHy
         beLE+O+sGlB/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BZBcu1893605;
        Tue, 9 Jul 2019 04:35:11 -0700
Date:   Tue, 9 Jul 2019 04:35:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-y60wnyg2fuxi0hx7icruo9po@git.kernel.org>
Cc:     fenghua.yu@intel.com, namhyung@kernel.org, acme@redhat.com,
        jolsa@kernel.org, bp@suse.de, aaronlewis@google.com,
        mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: aaronlewis@google.com, bp@suse.de, jolsa@kernel.org,
          acme@redhat.com, fenghua.yu@intel.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools arch x86: Sync asm/cpufeatures.h with the
 with the kernel
Git-Commit-ID: 686cbe9e5d88ad639bbe26d963e7d5dafa1c1c28
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

Commit-ID:  686cbe9e5d88ad639bbe26d963e7d5dafa1c1c28
Gitweb:     https://git.kernel.org/tip/686cbe9e5d88ad639bbe26d963e7d5dafa1c1c28
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 8 Jul 2019 13:47:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Jul 2019 13:47:14 -0300

tools arch x86: Sync asm/cpufeatures.h with the with the kernel

To pick up the changes in:

  6dbbf5ec9e1e ("x86/cpufeatures: Enumerate user wait instructions")
  b302e4b176d0 ("x86/cpufeatures: Enumerate the new AVX512 BFLOAT16 instructions")
  acec0ce081de ("x86/cpufeatures: Combine word 11 and 12 into a new scattered features word")
  cbb99c0f5887 ("x86/cpufeatures: Add FDP_EXCPTN_ONLY and ZERO_FCS_FDS")

That don't affect anything in tools/.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Aaron Lewis <aaronlewis@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-y60wnyg2fuxi0hx7icruo9po@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 75f27ee2c263..998c2cc08363 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -239,12 +239,14 @@
 #define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation extensions */
 #define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
 #define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
+#define X86_FEATURE_FDP_EXCPTN_ONLY	( 9*32+ 6) /* "" FPU data pointer updated only on x87 exceptions */
 #define X86_FEATURE_SMEP		( 9*32+ 7) /* Supervisor Mode Execution Protection */
 #define X86_FEATURE_BMI2		( 9*32+ 8) /* 2nd group bit manipulation extensions */
 #define X86_FEATURE_ERMS		( 9*32+ 9) /* Enhanced REP MOVSB/STOSB instructions */
 #define X86_FEATURE_INVPCID		( 9*32+10) /* Invalidate Processor Context ID */
 #define X86_FEATURE_RTM			( 9*32+11) /* Restricted Transactional Memory */
 #define X86_FEATURE_CQM			( 9*32+12) /* Cache QoS Monitoring */
+#define X86_FEATURE_ZERO_FCS_FDS	( 9*32+13) /* "" Zero out FPU CS and FPU DS */
 #define X86_FEATURE_MPX			( 9*32+14) /* Memory Protection Extension */
 #define X86_FEATURE_RDT_A		( 9*32+15) /* Resource Director Technology Allocation */
 #define X86_FEATURE_AVX512F		( 9*32+16) /* AVX-512 Foundation */
@@ -269,13 +271,19 @@
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
 
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:0 (EDX), word 11 */
-#define X86_FEATURE_CQM_LLC		(11*32+ 1) /* LLC QoS if 1 */
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0xf, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_CQM_LLC		(11*32+ 0) /* LLC QoS if 1 */
+#define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* LLC occupancy monitoring */
+#define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
+#define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:1 (EDX), word 12 */
-#define X86_FEATURE_CQM_OCCUP_LLC	(12*32+ 0) /* LLC occupancy monitoring */
-#define X86_FEATURE_CQM_MBM_TOTAL	(12*32+ 1) /* LLC Total MBM monitoring */
-#define X86_FEATURE_CQM_MBM_LOCAL	(12*32+ 2) /* LLC Local MBM monitoring */
+/* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
+#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -322,6 +330,7 @@
 #define X86_FEATURE_UMIP		(16*32+ 2) /* User Mode Instruction Protection */
 #define X86_FEATURE_PKU			(16*32+ 3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
+#define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
