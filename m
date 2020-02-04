Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58D01515BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 07:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBDGID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 01:08:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:38244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgBDGIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:08:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 22:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="249242553"
Received: from ncouniha-mobl6.ger.corp.intel.com (HELO localhost) ([10.252.20.163])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2020 22:07:56 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v25 21/21] docs: x86/sgx: Document SGX micro architecture and kernel internals
Date:   Tue,  4 Feb 2020 08:05:45 +0200
Message-Id: <20200204060545.31729-22-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
References: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Intel SGX micro architecture and kernel internals. The motivation
is to make the core ideas approachable by keeping a fairly high abstraction
level. Fine-grained micro architecture details can be looked up from Intel
SDM Volume 3D.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-doc@vger.kernel.org
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/x86/index.rst |   1 +
 Documentation/x86/sgx.rst   | 177 ++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100644 Documentation/x86/sgx.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index a8de2fbc1caa..971f30a7d166 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -31,3 +31,4 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   sgx
diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
new file mode 100644
index 000000000000..04deaba83981
--- /dev/null
+++ b/Documentation/x86/sgx.rst
@@ -0,0 +1,177 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Architecture
+============
+
+Introduction
+============
+
+*Software Guard eXtensions (SGX)* is a set of instructions and that enable
+ring-3 applications to set aside private regions of code and data. These regions
+are called enclaves. Enclave can be entered to a fixed set of entry points. Only
+a CPU running inside the enclave can access its code and data.
+
+SGX support can be determined by
+
+	``cat /proc/cpuinfo | grep sgx``
+
+Enclave Page Cache
+==================
+
+SGX utilizes an *Enclave Page Cache (EPC)* to store pages that are associated
+with an enclave. It is contained in a BIOS reserved region of physical memory.
+Unlike pages used for regular memory, pages can only be accessed outside the
+enclave for different purposes with the instructions **ENCLS**, **ENCLV** and
+**ENCLU**.
+
+Direct memory accesses to an enclave can be only done by a CPU executing inside
+the enclave. Enclave can be entered with **ENCLU[EENTER]** leaf function to a
+fixed set of entry points. However, a CPU executing inside the enclave can do
+outside memory accesses.
+
+Page Types
+----------
+
+**SGX Enclave Control Structure (SECS)**
+   Enclave's address range, attributes and other global data is defined
+   by this structure.
+
+**Regular (REG)**
+   Regular EPC pages contain the code and data of an enclave.
+
+**Thread Control Structure (TCS)**
+   Thread Control Structure pages define the entry points to an enclave and
+   track the execution state of an enclave thread.
+
+**Version Array (VA)**
+   Version Array pages contain 512 slots, each of which can contain a version
+   number for a page evicted from the EPC.
+
+Enclave Page Cache Map
+----------------------
+
+The processor tracks EPC pages via the *Enclave Page Cache Map (EPCM)*.  EPCM
+contains entry for each EPC page, which describes the owning enclave, access
+rights and page type among the other things.
+
+The permissions from EPCM is consulted if and only if walking the kernel page
+tables succeeds. The total permissions are thus a conjunction between page table
+and EPCM permissions.
+
+For all intents and purposes the SGX architecture allows the processor to
+invalidate all EPCM entries at will, i.e. requires that software be prepared to
+handle an EPCM fault at any time. The contents of EPC are encrypted with an
+ephemeral key, which is lost on power transitions.
+
+EPC management
+==============
+
+EPC pages do not have ``struct page`` instances. They are IO memory from kernel
+perspective. The consequence is that they are always mapped as shared memory.
+Kernel defines ``/dev/sgx/enclave`` that can be mapped as ``MAP_SHARED`` to
+define the address range for an enclave.
+
+EPC Over-subscription
+=====================
+
+When the amount of free EPC pages goes below a low watermark the swapping thread
+starts reclaiming pages. The pages that have no do not have the **A** bit set
+are selected as victim pages. Each enclave holds an shmem file as a backing
+storage for reclaimed pages.
+
+Launch Control
+==============
+
+SGX provides a launch control mechanism. After all enclave pages have been
+copied, kernel executes **ENCLS[EINIT]**, which initializes the enclave. Only
+after this the CPU can execute inside the enclave.
+
+This leaf function takes a RSA-3072 signature of the enclave measurement and an
+optional cryptographic token. Linux does not take advantage of launch tokens.
+The instruction checks that the signature is signed with the key defined in
+**IA32_SGXLEPUBKEYHASH?** MSRs and the measurement is correct. If so, the
+enclave is allowed to be executed.
+
+MSRs can be configured by the BIOS to be either readable or writable.  Linux
+supports only writable configuration in order give full control to the kernel on
+launch control policy. Readable configuration requires the use of previously
+mentioned launch tokens.
+
+The current kernel implementation supports only writable MSRs. The launch is
+performed by setting the MSRs to the hash of the enclave signer's public key.
+Alternative would be to have *a launch enclave* that would be signed with the
+key set into MSRs, which would then generate launch tokens for other enclaves.
+This would only make sense with read-only MSRs, and thus the option has been
+discluded.
+
+Attestation
+===========
+
+Local Attestation
+-----------------
+
+In local attestation the source enclave calculates a MAC of itself with
+**ENCLS[EREPORT]**. Then the destination enclave verifies this with
+**ENCLS[EGETKEY(REPORT)]** key. This mechanism can also be used in addition as a
+communication channel as the **REPORT** data structure includes 64 byte field
+for passing variable information.
+
+Remote Attestation
+------------------
+
+For remote attestation (aka provisioning) there a multiple options available:
+
+* An EPID based scheme, which requires the use of Intel managed attestation
+  service.
+* ECDSA based scheme, which 3rd party to act as an attestation service.
+
+Intel provides an open source *quoting enclave (QE)* and *provisioning
+certification enclave (PCE)* for the ECDSA based scheme. The latter acts as
+the CA for the local QE's. Intel also a precompiled binary version of the PCE
+so that, if required, quotation can be linked to the hardware.
+
+The use of remote attestation must be strictly controlled because it allows to
+get access to the provisioning keys to attest to a remote party that the
+software is running inside a legitimate enclave on real hardware. This could be
+potentially used by malware, and thus must be protected.
+
+Enclaves can attest their identity when **ATTRIBUTES.PROVISIONKEY** set in SECS.
+This attribute authorizes **ENCLS[EGETKEY]** to access provisioning keys.
+
+Kernel defines ``/dev/sgx/provision`` and a special ioctl
+``SGX_IOC_ENCLAVE_SET_ATTRIBUTE`` to accomplish this. A file descriptor pointing
+to ``/dev/sgx/provision`` is passed to ioctl from which kernel authorizes the
+use of remote attestation keys. This must be called before
+``SGX_IOC_ENCL_CREATE`` if remote attestation is required.
+
+References
+----------
+
+"Intel® Software Guard Extensions: EPID Provisioning and Attestation Services"
+   https://software.intel.com/sites/default/files/managed/57/0e/ww10-2016-sgx-provisioning-and-attestation-final.pdf
+
+"Supporting Third Party Attestation for Intel® SGX with Intel® Data Center
+Attestation Primitives"
+   https://software.intel.com/sites/default/files/managed/f1/b8/intel-sgx-support-for-third-party-attestation.pdf
+
+Usage Models
+============
+
+Shared Library
+--------------
+
+Sensitive data and the code that acts on it is partitioned from the application
+into a separate library. The library is then linked as a DSO which can be loaded
+into an enclave. The application can then make individual function calls into
+the enclave through special SGX instructions. A run-time within the enclave is
+configured to marshall function parameters into and out of the enclave and to
+call the correct library function.
+
+Application Container
+---------------------
+
+An application may be loaded into a container enclave which is specially
+configured with a library OS and run-time which permits the application to run.
+The enclave run-time and library OS work together to execute the application
+when a thread enters the enclave.
-- 
2.20.1

