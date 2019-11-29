Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ABE10DBBA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfK2XSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 18:18:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:60934 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfK2XSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 18:18:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 15:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,259,1571727600"; 
   d="scan'208";a="384194621"
Received: from gamanzi-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.3.126])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2019 15:18:24 -0800
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
        linux-doc@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v24 24/24] docs: x86/sgx: Document kernel internals
Date:   Sat, 30 Nov 2019 01:13:26 +0200
Message-Id: <20191129231326.18076-25-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Document some of the more tricky parts of the kernel implementation
internals.

Cc: linux-doc@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/x86/sgx/2.Kernel-internals.rst | 78 ++++++++++++++++++++
 Documentation/x86/sgx/index.rst              |  1 +
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/x86/sgx/2.Kernel-internals.rst

diff --git a/Documentation/x86/sgx/2.Kernel-internals.rst b/Documentation/x86/sgx/2.Kernel-internals.rst
new file mode 100644
index 000000000000..7bfd5cb19b8e
--- /dev/null
+++ b/Documentation/x86/sgx/2.Kernel-internals.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Kernel Internals
+================
+
+CPU configuration
+=================
+
+Because SGX has an ever evolving and expanding feature set, it's possible for
+a BIOS or VMM to configure a system in such a way that not all CPUs are equal,
+e.g. where Launch Control is only enabled on a subset of CPUs.  Linux does
+*not* support such a heterogeneous system configuration, nor does it even
+attempt to play nice in the face of a misconfigured system.  With the exception
+of Launch Control's hash MSRs, which can vary per CPU, Linux assumes that all
+CPUs have a configuration that is identical to the boot CPU.
+
+EPC management
+==============
+
+Because the kernel can't arbitrarily read EPC memory or share RO backing pages
+between enclaves, traditional memory models such as CoW and fork() do not work
+with enclaves.  In other words, the architectural rules of EPC force it to be
+treated as MAP_SHARED at all times.
+
+The inability to employ traditional memory models also means that EPC memory
+must be isolated from normal memory pools, e.g. attempting to use EPC memory
+for normal mappings would result in faults and/or perceived data corruption.
+Furthermore, EPC is not enumerated as normal memory, e.g. BIOS enumerates
+EPC as reserved memory in the e820 tables, or not at all.  As a result, EPC
+memory is directly managed by the SGX subsystem, e.g. SGX employs VM_PFNMAP to
+manually insert/zap/swap page table entries, and exposes EPC to userspace via
+a well known device, /dev/sgx/enclave.
+
+The net effect is that all enclave VMAs must be MAP_SHARED and are backed by
+a single file, /dev/sgx/enclave.
+
+EPC oversubscription
+====================
+
+SGX allows to have larger enclaves the than amount of available EPC by providing
+a subset of leaf instructions for swapping EPC pages to the system memory. The
+details of these instructions are discussed in the architecture document. Due to
+the unique requirements for swapping EPC pages, and because EPC pages do not
+have associated page structures, management of the EPC is not handled by the
+standard memory subsystem.
+
+SGX directly handles swapping of EPC pages, including a thread to initiate the
+reclaiming process and a rudimentary LRU mechanism. When the amount of free EPC
+pages goes below a low watermark the swapping thread starts reclaiming pages.
+The pages that have not been recently accessed (i.e. do not have the A bit set)
+are selected as victim pages. Each enclave holds an shmem file as a backing
+storage for reclaimed pages.
+
+Launch Control
+==============
+
+The current kernel implementation supports only writable MSRs. The launch is
+performed by setting the MSRs to the hash of the public key modulus of the
+enclave signer and a token with the valid bit set to zero.
+
+If the MSRs were read-only, the platform would need to provide a launch enclave
+(LE), which would be signed with the key matching the MSRs. The LE creates
+cryptographic tokens for other enclaves that they can pass together with their
+signature to the ENCLS(EINIT) opcode, which is used to initialize enclaves.
+
+Provisioning
+============
+
+The use of provisioning must be controlled because it allows to get access to
+the provisioning keys to attest to a remote party that the software is running
+inside a legitimate enclave. This could be used by a malware network to ensure
+that its nodes are running inside legitimate enclaves.
+
+The driver introduces a special device file /dev/sgx/provision and a special
+ioctl SGX_IOC_ENCLAVE_SET_ATTRIBUTE to accomplish this. A file descriptor
+pointing to /dev/sgx/provision is passed to ioctl from which kernel authorizes
+the PROVISION_KEY attribute to the enclave.
diff --git a/Documentation/x86/sgx/index.rst b/Documentation/x86/sgx/index.rst
index c5dfef62e612..5d660e83d984 100644
--- a/Documentation/x86/sgx/index.rst
+++ b/Documentation/x86/sgx/index.rst
@@ -14,3 +14,4 @@ potentially malicious.
    :maxdepth: 1
 
    1.Architecture
+   2.Kernel-internals
-- 
2.20.1

