Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8680E178677
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 00:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgCCXiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 18:38:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:46848 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgCCXiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:38:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 15:38:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="229117436"
Received: from kwasilew-mobl.ger.corp.intel.com (HELO localhost) ([10.251.88.57])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2020 15:37:56 -0800
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
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v28 09/22] x86/sgx: Add functions to allocate and free EPC pages
Date:   Wed,  4 Mar 2020 01:35:56 +0200
Message-Id: <20200303233609.713348-10-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions for allocating page from Enclave Page Cache (EPC). A page is
allocated by going through the EPC sections and returning the first free
page.

When a page is freed, it might have a valid state, which means that the
callee has assigned it to an enclave, which are protected memory ares used
to run code protected from outside access. The page is returned back to the
invalid state with ENCLS[EREMOVE] [1].

[1] Intel SDM: 40.3 INTEL® SGX SYSTEM LEAF FUNCTION REFERENCE

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 60 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 38424c1e8341..60d82e7537c8 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -13,6 +13,66 @@
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 int sgx_nr_epc_sections;
 
+static struct sgx_epc_page *__sgx_try_alloc_page(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+
+	if (list_empty(&section->page_list))
+		return NULL;
+
+	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
+	list_del_init(&page->list);
+	return page;
+}
+
+/**
+ * sgx_try_alloc_page() - Allocate an EPC page
+ *
+ * Try to grab a page from the free EPC page list.
+ *
+ * Return:
+ *   a pointer to a &struct sgx_epc_page instance,
+ *   -errno on error
+ */
+struct sgx_epc_page *sgx_try_alloc_page(void)
+{
+	struct sgx_epc_section *section;
+	struct sgx_epc_page *page;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_sections; i++) {
+		section = &sgx_epc_sections[i];
+		spin_lock(&section->lock);
+		page = __sgx_try_alloc_page(section);
+		spin_unlock(&section->lock);
+
+		if (page)
+			return page;
+	}
+
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * sgx_free_page() - Free an EPC page
+ * @page:	pointer a previously allocated EPC page
+ *
+ * EREMOVE an EPC page and insert it back to the list of free pages.
+ */
+void sgx_free_page(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section = sgx_epc_section(page);
+	int ret;
+
+	ret = __eremove(sgx_epc_addr(page));
+	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
+		return;
+
+	spin_lock(&section->lock);
+	list_add_tail(&page->list, &section->page_list);
+	spin_unlock(&section->lock);
+}
+
 static void __init sgx_free_epc_section(struct sgx_epc_section *section)
 {
 	struct sgx_epc_page *page;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index aad30980be32..aa85f85412d8 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -67,4 +67,7 @@ extern struct task_struct *ksgxswapd_tsk;
 
 bool __init sgx_page_reclaimer_init(void);
 
+struct sgx_epc_page *sgx_try_alloc_page(void);
+void sgx_free_page(struct sgx_epc_page *page);
+
 #endif /* _X86_SGX_H */
-- 
2.25.0

