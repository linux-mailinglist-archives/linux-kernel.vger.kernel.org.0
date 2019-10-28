Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A82E7ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbfJ1VEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:04:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:17748 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbfJ1VEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:04:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 14:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="224759541"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 14:04:39 -0700
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
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v23 07/24] x86/cpu/intel: Detect SGX supprt
Date:   Mon, 28 Oct 2019 23:03:07 +0200
Message-Id: <20191028210324.12475-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
References: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

When the CPU supports SGX, check that the BIOS has enabled SGX and SGX1
opcodes are available. Otherwise, all the SGX related capabilities.

In addition, clear X86_FEATURE_SGX_LC also in the case when the launch
enclave are read-only. This way the feature bit reflects the level that
Linux supports the launch control.

The check is done for every CPU, not just BSP, in order to verify that
MSR_IA32_FEATURE_CONTROL is correctly configured on all CPUs. The other
parts of the kernel, like the enclave driver, expect the same
configuration from all CPUs.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c2fdc00df163..89a71367716c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -624,6 +624,42 @@ static void detect_tme(struct cpuinfo_x86 *c)
 	c->x86_phys_bits -= keyid_bits;
 }
 
+static void __maybe_unused detect_sgx(struct cpuinfo_x86 *c)
+{
+	unsigned long long fc;
+
+	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
+	if (!(fc & FEATURE_CONTROL_LOCKED)) {
+		pr_err_once("sgx: The feature control MSR is not locked\n");
+		goto err_unsupported;
+	}
+
+	if (!(fc & FEATURE_CONTROL_SGX_ENABLE)) {
+		pr_err_once("sgx: SGX is not enabled in IA32_FEATURE_CONTROL MSR\n");
+		goto err_unsupported;
+	}
+
+	if (!cpu_has(c, X86_FEATURE_SGX1)) {
+		pr_err_once("sgx: SGX1 instruction set is not supported\n");
+		goto err_unsupported;
+	}
+
+	if (!(fc & FEATURE_CONTROL_SGX_LE_WR)) {
+		pr_info_once("sgx: The launch control MSRs are not writable\n");
+		goto err_msrs_rdonly;
+	}
+
+	return;
+
+err_unsupported:
+	setup_clear_cpu_cap(X86_FEATURE_SGX);
+	setup_clear_cpu_cap(X86_FEATURE_SGX1);
+	setup_clear_cpu_cap(X86_FEATURE_SGX2);
+
+err_msrs_rdonly:
+	setup_clear_cpu_cap(X86_FEATURE_SGX_LC);
+}
+
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
@@ -761,6 +797,11 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme(c);
 
+#ifdef CONFIG_INTEL_SGX
+	if (cpu_has(c, X86_FEATURE_SGX))
+		detect_sgx(c);
+#endif
+
 	init_intel_misc_features(c);
 }
 
-- 
2.20.1

