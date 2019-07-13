Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CD67B5B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfGMRI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 13:08:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:18076 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfGMRIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:08:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 10:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="341981049"
Received: from hbriegel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.48])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2019 10:08:17 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, Kai Huang <kai.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v21 01/28] x86/cpufeatures: Add Intel-defined SGX feature bit
Date:   Sat, 13 Jul 2019 20:07:37 +0300
Message-Id: <20190713170804.2340-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Huang <kai.huang@linux.intel.com>

X86_FEATURE_SGX reflects whether or not the CPU supports Intel's
Software Guard eXtensions (SGX).

Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..fcc192098df7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -236,6 +236,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
 #define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* TSC adjustment MSR 0x3B */
+#define X86_FEATURE_SGX			( 9*32+ 2) /* Software Guard Extensions */
 #define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation extensions */
 #define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
 #define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index a5ea841cc6d2..74de07d0f390 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -62,6 +62,12 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_INTEL_SGX
+# define DISABLE_SGX_CORE	0
+#else
+# define DISABLE_SGX_CORE	(1 << (X86_FEATURE_SGX & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -74,7 +80,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
+#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP|DISABLE_SGX_CORE)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
-- 
2.20.1

