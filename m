Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05EBA59132
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 04:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF1CgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 22:36:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:17520 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF1CgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:36:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 19:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,426,1557212400"; 
   d="scan'208";a="189296349"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2019 19:36:20 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Alan Cox <alan.cox@intel.com>, Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordan Borgner <mail@jordan-borgner.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Mohammad Etemadi <mohammad.etemadi@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Feiner <pfeiner@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 1/2] x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata
Date:   Thu, 27 Jun 2019 19:35:36 -0700
Message-Id: <1561689337-19390-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561689337-19390-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1561689337-19390-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Processors which have self-snooping capability can handle conflicting
memory type across CPUs by snooping its own cache. However, there exists
CPU models in which having conflicting memory types still leads to
unpredictable behavior, machine check errors, or hangs. Clear this feature
to prevent its use. 

Cc: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Alan Cox <alan.cox@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f17c1a714779..62e366ec0812 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -66,6 +66,32 @@ void check_mpx_erratum(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * Processors which have self-snooping capability can handle conflicting
+ * memory type across CPUs by snooping its own cache. However, there exists
+ * CPU models in which having conflicting memory types still leads to
+ * unpredictable behavior, machine check errors, or hangs. Clear this feature
+ * to prevent its use.
+ */
+static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_model) {
+	case INTEL_FAM6_CORE_YONAH:
+	case INTEL_FAM6_CORE2_MEROM:
+	case INTEL_FAM6_CORE2_MEROM_L:
+	case INTEL_FAM6_CORE2_PENRYN:
+	case INTEL_FAM6_CORE2_DUNNINGTON:
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_NEHALEM_G:
+	case INTEL_FAM6_NEHALEM_EP:
+	case INTEL_FAM6_NEHALEM_EX:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_WESTMERE_EP:
+	case INTEL_FAM6_SANDYBRIDGE:
+		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
+	}
+}
+
 static bool ring3mwait_disabled __read_mostly;
 
 static int __init ring3mwait_disable(char *__unused)
@@ -304,6 +330,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	check_mpx_erratum(c);
+	check_memory_type_self_snoop_errata(c);
 
 	/*
 	 * Get the number of SMT siblings early from the extended topology
-- 
2.17.1

