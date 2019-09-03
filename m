Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89762A6B63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfICO2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 10:28:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:55209 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICO17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:27:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 07:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="183567335"
Received: from vkuppusa-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.39.67])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2019 07:27:44 -0700
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
        cedric.xing@intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v22 05/24] x86/sgx: Add ENCLS architectural error codes
Date:   Tue,  3 Sep 2019 17:26:36 +0300
Message-Id: <20190903142655.21943-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ENCLS architectural error codes. These error codes are returned by
the SGX opcodes. Make the header as part of the uapi so that they can be
used in some situations directly returned to the user space (ENCLS[EINIT]
leaf function error codes could be one potential use case).

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/uapi/asm/sgx_errno.h | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/sgx_errno.h

diff --git a/arch/x86/include/uapi/asm/sgx_errno.h b/arch/x86/include/uapi/asm/sgx_errno.h
new file mode 100644
index 000000000000..48b87aed58d7
--- /dev/null
+++ b/arch/x86/include/uapi/asm/sgx_errno.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ * Contains the architecturally defined error codes that are returned by SGX
+ * instructions, e.g. ENCLS, and may be propagated to userspace via errno.
+ */
+
+#ifndef _UAPI_ASM_X86_SGX_ERRNO_H
+#define _UAPI_ASM_X86_SGX_ERRNO_H
+
+/**
+ * enum sgx_encls_leaves - return codes for ENCLS, ENCLU and ENCLV
+ * %SGX_SUCCESS:		No error.
+ * %SGX_INVALID_SIG_STRUCT:	SIGSTRUCT contains an invalid value.
+ * %SGX_INVALID_ATTRIBUTE:	Enclave is not attempting to access a resource
+ *				for which it is not authorized.
+ * %SGX_BLKSTATE:		EPC page is already blocked.
+ * %SGX_INVALID_MEASUREMENT:	SIGSTRUCT or EINITTOKEN contains an incorrect
+ *				measurement.
+ * %SGX_NOTBLOCKABLE:		EPC page type is not one which can be blocked.
+ * %SGX_PG_INVLD:		EPC page is invalid (and cannot be blocked).
+ * %SGX_EPC_PAGE_CONFLICT:	EPC page in use by another SGX instruction.
+ * %SGX_INVALID_SIGNATURE:	Enclave's signature does not validate with
+ *				public key enclosed in SIGSTRUCT.
+ * %SGX_MAC_COMPARE_FAIL:	MAC check failed when reloading EPC page.
+ * %SGX_PAGE_NOT_BLOCKED:	EPC page is not marked as blocked.
+ * %SGX_NOT_TRACKED:		ETRACK has not been completed on the EPC page.
+ * %SGX_VA_SLOT_OCCUPIED:	Version array slot contains a valid entry.
+ * %SGX_CHILD_PRESENT:		Enclave has child pages present in the EPC.
+ * %SGX_ENCLAVE_ACT:		Logical processors are currently executing
+ *				inside the enclave.
+ * %SGX_ENTRYEPOCH_LOCKED:	SECS locked for EPOCH update, i.e. an ETRACK is
+ *				currently executing on the SECS.
+ * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
+ *				public key does not match IA32_SGXLEPUBKEYHASH.
+ * %SGX_PREV_TRK_INCMPL:	All processors did not complete the previous
+ *				tracking sequence.
+ * %SGX_PG_IS_SECS:		Target EPC page is an SECS and cannot be
+ *				blocked.
+ * %SGX_PAGE_ATTRIBUTES_MISMATCH:	Attributes of the EPC page do not match
+ *					the expected values.
+ * %SGX_PAGE_NOT_MODIFIABLE:	EPC page cannot be modified because it is in
+ *				the PENDING or MODIFIED state.
+ * %SGX_PAGE_NOT_DEBUGGABLE:	EPC page cannot be modified because it is in
+ *				the PENDING or MODIFIED state.
+ * %SGX_INVALID_COUNTER:	{In,De}crementing a counter would cause it to
+ *				{over,under}flow.
+ * %SGX_PG_NONEPC:		Target page is not an EPC page.
+ * %SGX_TRACK_NOT_REQUIRED:	Target page type does not require tracking.
+ * %SGX_INVALID_CPUSVN:		Security version number reported by CPU is less
+ *				than what is required by the enclave.
+ * %SGX_INVALID_ISVSVN:		Security version number of enclave is less than
+ *				what is required by the KEYREQUEST struct.
+ * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
+ *				while the instruction was executing.
+ * %SGX_INVALID_KEYNAME:	Requested key is not supported by hardware.
+ */
+enum sgx_return_codes {
+	SGX_SUCCESS			= 0,
+	SGX_INVALID_SIG_STRUCT		= 1,
+	SGX_INVALID_ATTRIBUTE		= 2,
+	SGX_BLKSTATE			= 3,
+	SGX_INVALID_MEASUREMENT		= 4,
+	SGX_NOTBLOCKABLE		= 5,
+	SGX_PG_INVLD			= 6,
+	SGX_EPC_PAGE_CONFLICT		= 7,
+	SGX_INVALID_SIGNATURE		= 8,
+	SGX_MAC_COMPARE_FAIL		= 9,
+	SGX_PAGE_NOT_BLOCKED		= 10,
+	SGX_NOT_TRACKED			= 11,
+	SGX_VA_SLOT_OCCUPIED		= 12,
+	SGX_CHILD_PRESENT		= 13,
+	SGX_ENCLAVE_ACT			= 14,
+	SGX_ENTRYEPOCH_LOCKED		= 15,
+	SGX_INVALID_EINITTOKEN		= 16,
+	SGX_PREV_TRK_INCMPL		= 17,
+	SGX_PG_IS_SECS			= 18,
+	SGX_PAGE_ATTRIBUTES_MISMATCH	= 19,
+	SGX_PAGE_NOT_MODIFIABLE		= 20,
+	SGX_PAGE_NOT_DEBUGGABLE		= 21,
+	SGX_INVALID_COUNTER		= 25,
+	SGX_PG_NONEPC			= 26,
+	SGX_TRACK_NOT_REQUIRED		= 27,
+	SGX_INVALID_CPUSVN		= 32,
+	SGX_INVALID_ISVSVN		= 64,
+	SGX_UNMASKED_EVENT		= 128,
+	SGX_INVALID_KEYNAME		= 256,
+};
+
+#endif /* _UAPI_ASM_X86_SGX_ERRNO_H */
-- 
2.20.1

