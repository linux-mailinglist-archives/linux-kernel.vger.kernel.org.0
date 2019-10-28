Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965ABE7AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389748AbfJ1VGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:06:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:44470 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbfJ1VGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:06:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 14:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="224760056"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 14:06:22 -0700
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
Subject: [PATCH v23 17/24] x86/sgx: ptrace() support for the SGX driver
Date:   Mon, 28 Oct 2019 23:03:17 +0200
Message-Id: <20191028210324.12475-18-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
References: <20191028210324.12475-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VMA callbacks for ptrace() that can be used with debug enclaves.
With debug enclaves data can be read and write the memory word at a time
by using ENCLS(EDBGRD) and ENCLS(EDBGWR) leaf instructions.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 312f954c5c07..22186d89042a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -320,6 +320,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 	return 0;
 }
 
+
 static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end, unsigned long prot)
 {
@@ -327,10 +328,97 @@ static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
 				calc_vm_prot_bits(prot, 0));
 }
 
+static int sgx_edbgrd(struct sgx_encl *encl, struct sgx_encl_page *page,
+		      unsigned long addr, void *data)
+{
+	unsigned long offset = addr & ~PAGE_MASK;
+	int ret;
+
+
+	ret = __edbgrd(sgx_epc_addr(page->epc_page) + offset, data);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int sgx_edbgwr(struct sgx_encl *encl, struct sgx_encl_page *page,
+		      unsigned long addr, void *data)
+{
+	unsigned long offset = addr & ~PAGE_MASK;
+	int ret;
+
+	ret = __edbgwr(sgx_epc_addr(page->epc_page) + offset, data);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
+			  void *buf, int len, int write)
+{
+	struct sgx_encl *encl = vma->vm_private_data;
+	struct sgx_encl_page *entry = NULL;
+	char data[sizeof(unsigned long)];
+	unsigned long align;
+	unsigned int flags;
+	int offset;
+	int cnt;
+	int ret = 0;
+	int i;
+
+	/* If process was forked, VMA is still there but vm_private_data is set
+	 * to NULL.
+	 */
+	if (!encl)
+		return -EFAULT;
+
+	flags = atomic_read(&encl->flags);
+
+	if (!(flags & SGX_ENCL_DEBUG) || !(flags & SGX_ENCL_INITIALIZED) ||
+	    (flags & SGX_ENCL_DEAD))
+		return -EFAULT;
+
+	for (i = 0; i < len; i += cnt) {
+		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			break;
+		}
+
+		align = ALIGN_DOWN(addr + i, sizeof(unsigned long));
+		offset = (addr + i) & (sizeof(unsigned long) - 1);
+		cnt = sizeof(unsigned long) - offset;
+		cnt = min(cnt, len - i);
+
+		ret = sgx_edbgrd(encl, entry, align, data);
+		if (ret)
+			goto out;
+
+		if (write) {
+			memcpy(data + offset, buf + i, cnt);
+			ret = sgx_edbgwr(encl, entry, align, data);
+			if (ret)
+				goto out;
+		} else
+			memcpy(buf + i, data + offset, cnt);
+
+out:
+		mutex_unlock(&encl->lock);
+
+		if (ret)
+			break;
+	}
+
+	return ret < 0 ? ret : i;
+}
+
 const struct vm_operations_struct sgx_vm_ops = {
 	.open = sgx_vma_open,
 	.fault = sgx_vma_fault,
 	.may_mprotect = sgx_vma_mprotect,
+	.access = sgx_vma_access,
 };
 
 /**
-- 
2.20.1

