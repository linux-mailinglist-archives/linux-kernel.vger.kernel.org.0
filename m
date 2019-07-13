Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570C467B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfGMRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 13:09:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:33964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfGMRJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:09:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 10:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="341981154"
Received: from hbriegel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.48])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2019 10:08:56 -0700
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
        cedric.xing@intel.com, Haim Cohen <haim.cohen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v21 05/28] x86/msr: Add SGX Launch Control MSR definitions
Date:   Sat, 13 Jul 2019 20:07:41 +0300
Message-Id: <20190713170804.2340-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add a new IA32_FEATURE_CONTROL bit, SGX_LE_WR.  When set, SGX_LE_WR
allows software to write the SGXLEPUBKEYHASH MSRs (see below).  The
The existence of the bit is enumerated by CPUID as X86_FEATURE_SGX_LC.
Like all other flags in IA32_FEATURE_CONTROL, the MSR must be locked
for SGX_LE_WR to take effect.

Add four MSRs, SGXLEPUBKEYHASH{0,1,2,3}, or in human readable form,
the SGX Launch Enclave Public Key Hash MSRs.  These MSRs correspond to
the key that is used by the CPU to determine whether or not to allow
software to enter an enclave.  When ENCLS[EINIT] is executed, which is
a prerequisite to entering the enclave, the CPU compares the key
(technically its hash) used to sign the enclave with the key hash
stored in the MSRs, and will reject EINIT if the keys do not match.

Enclaves can also be blessed by proxy, in which case a Launch Enclave
generates and signs an EINIT TOKEN.  If a valid token is provided,
ENCLS[EINIT] compares the signer of the token against the MSRs instead
of the signer of the enclave.  The SGXLEPUBKEYHASH MSRs only exist on
CPUs that support SGX Launch Control, enumerated by X86_FEATURE_SGX_LC.
CPUs without Launch Control use a hardcoded key for the ENCLS[EINIT]
checks.  An internal hardcoded key is also used as the reset value for
the hash MSRs when they exist.

As a final note, the SGX_LEPUBKEYHASH MSRs can also be written by
pre-boot firmware prior to activating SGX (SGX activation is done by
setting bit 0 in MSR 0x7A).  Thus, firmware can lock the MSRs to a
non-Intel value by writing the MSRs and locking IA32_FEATURE_CONTROL
without setting SGX_LE_WR.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Haim Cohen <haim.cohen@intel.com>
Signed-off-by: Haim Cohen <haim.cohen@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c006ba8187aa..24da5800b1c6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -542,6 +542,7 @@
 #define FEATURE_CONTROL_LOCKED				(1<<0)
 #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
 #define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
+#define FEATURE_CONTROL_SGX_LE_WR			(1<<17)
 #define FEATURE_CONTROL_SGX_ENABLE			(1<<18)
 #define FEATURE_CONTROL_LMCE				(1<<20)
 
@@ -555,6 +556,12 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+/* Intel SGX Launch Enclave Public Key Hash MSRs */
+#define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
+#define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
+#define MSR_IA32_SGXLEPUBKEYHASH2	0x0000008E
+#define MSR_IA32_SGXLEPUBKEYHASH3	0x0000008F
+
 #define MSR_IA32_SMM_MONITOR_CTL	0x0000009b
 #define MSR_IA32_SMBASE			0x0000009e
 
-- 
2.20.1

