Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9782E28E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 03:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbfEXBRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 21:17:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:15050 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388766AbfEXBQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:16:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 18:16:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:38 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [RFC PATCH v4 17/21] x86/tsc: Switch to perf-based hardlockup detector if TSC become unstable
Date:   Thu, 23 May 2019 18:16:19 -0700
Message-Id: <1558660583-28561-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPET-based hardlockup detector relies on the TSC to determine if an
observed NMI interrupt was originated by HPET timer. Hence, this detector
can no longer be used with an unstable TSC.

In such case, permanently stop the HPET-based hardlockup detector and
start the perf-based detector.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h    | 2 ++
 arch/x86/kernel/tsc.c          | 2 ++
 arch/x86/kernel/watchdog_hld.c | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index fd99f2390714..a82cbe17479d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -128,6 +128,7 @@ extern int hardlockup_detector_hpet_init(void);
 extern void hardlockup_detector_hpet_stop(void);
 extern void hardlockup_detector_hpet_enable(unsigned int cpu);
 extern void hardlockup_detector_hpet_disable(unsigned int cpu);
+extern void hardlockup_detector_switch_to_perf(void);
 #else
 static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 { return NULL; }
@@ -136,6 +137,7 @@ static inline int hardlockup_detector_hpet_init(void)
 static inline void hardlockup_detector_hpet_stop(void) {}
 static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
 static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
+static void harrdlockup_detector_switch_to_perf(void) {}
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #else /* CONFIG_HPET_TIMER */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 59b57605e66c..b2210728ce3d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1158,6 +1158,8 @@ void mark_tsc_unstable(char *reason)
 
 	clocksource_mark_unstable(&clocksource_tsc_early);
 	clocksource_mark_unstable(&clocksource_tsc);
+
+	hardlockup_detector_switch_to_perf();
 }
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
index c2512d4c79c5..c8547c227a41 100644
--- a/arch/x86/kernel/watchdog_hld.c
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -76,3 +76,10 @@ void watchdog_nmi_stop(void)
 	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
 		hardlockup_detector_hpet_stop();
 }
+
+void hardlockup_detector_switch_to_perf(void)
+{
+	detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
+	hardlockup_detector_hpet_stop();
+	hardlockup_start_all();
+}
-- 
2.17.1

