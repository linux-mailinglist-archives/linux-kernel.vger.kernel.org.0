Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08E67B67
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfGMRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 13:10:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:62221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfGMRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:10:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 10:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="341981352"
Received: from hbriegel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.48])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2019 10:10:19 -0700
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
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>
Subject: [PATCH v21 12/28] x86/sgx: Enumerate and track EPC sections
Date:   Sat, 13 Jul 2019 20:07:48 +0300
Message-Id: <20190713170804.2340-13-jarkko.sakkinen@linux.intel.com>
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

Enumerate Enclave Page Cache (EPC) sections via CPUID and add the data
structures necessary to track EPC pages so that they can be allocated,
freed and managed.  As a system may have multiple EPC sections, invoke
CPUID on SGX sub-leafs until an invalid leaf is encountered.

On NUMA systems, a node can have at most one bank. A bank can be at
most part of two nodes.  SGX supports both nodes with a single memory
controller and also sub-cluster nodes with severals memory controllers
on a single die.

For simplicity, support a maximum of eight EPC sections.  Current
client hardware supports only a single section, while upcoming server
hardware will support at most eight sections.  Bounding the number of
sections also allows the section ID to be embedded along with a page's
offset in a single unsigned long, enabling easy retrieval of both the
VA and PA for a given page.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
---
 arch/x86/Kconfig                  |  12 +++
 arch/x86/kernel/cpu/Makefile      |   1 +
 arch/x86/kernel/cpu/sgx/Makefile  |   2 +-
 arch/x86/kernel/cpu/sgx/main.c    | 158 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/reclaim.c |  84 ++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h     |  67 +++++++++++++
 6 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/main.c
 create mode 100644 arch/x86/kernel/cpu/sgx/reclaim.c
 create mode 100644 arch/x86/kernel/cpu/sgx/sgx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dce10b18f4bc..815328adf561 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1933,6 +1933,18 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config INTEL_SGX
+	bool "Intel SGX core functionality"
+	depends on X86_64 && CPU_SUP_INTEL
+	---help---
+	  Intel(R) SGX is a set of CPU instructions that can be used by
+	  applications to set aside private regions of code and data, referred
+	  to as enclaves. An enclave's private memory can only be accessed by
+	  code running within the enclave. Accesses from outside the enclave,
+	  including other enclaves, are disallowed by hardware.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index d7a1e5a9331c..97deac5108df 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
+obj-$(CONFIG_INTEL_SGX)			+= sgx/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 4432d935894e..fa930e292110 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -1 +1 @@
-obj-y += encls.o
+obj-y += encls.o main.o reclaim.o
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
new file mode 100644
index 000000000000..e2317f6e4374
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+
+#include <linux/freezer.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include "arch.h"
+#include "sgx.h"
+
+struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+EXPORT_SYMBOL_GPL(sgx_epc_sections);
+
+int sgx_nr_epc_sections;
+
+static __init void sgx_free_epc_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+
+	while (!list_empty(&section->page_list)) {
+		page = list_first_entry(&section->page_list,
+					struct sgx_epc_page, list);
+		list_del(&page->list);
+		kfree(page);
+	}
+
+	while (!list_empty(&section->unsanitized_page_list)) {
+		page = list_first_entry(&section->unsanitized_page_list,
+					struct sgx_epc_page, list);
+		list_del(&page->list);
+		kfree(page);
+	}
+
+	memunmap(section->va);
+}
+
+static __init int sgx_init_epc_section(u64 addr, u64 size, unsigned long index,
+				       struct sgx_epc_section *section)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct sgx_epc_page *page;
+	unsigned long i;
+
+	section->va = memremap(addr, size, MEMREMAP_WB);
+	if (!section->va)
+		return -ENOMEM;
+
+	section->pa = addr;
+	spin_lock_init(&section->lock);
+	INIT_LIST_HEAD(&section->page_list);
+	INIT_LIST_HEAD(&section->unsanitized_page_list);
+
+	for (i = 0; i < nr_pages; i++) {
+		page = kzalloc(sizeof(*page), GFP_KERNEL);
+		if (!page)
+			goto out;
+		page->desc = (addr + (i << PAGE_SHIFT)) | index;
+		list_add_tail(&page->list, &section->unsanitized_page_list);
+		section->free_cnt++;
+	}
+
+	return 0;
+out:
+	sgx_free_epc_section(section);
+	return -ENOMEM;
+}
+
+static __init void sgx_page_cache_teardown(void)
+{
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		sgx_free_epc_section(&sgx_epc_sections[i]);
+}
+
+/**
+ * A section metric is concatenated in a way that @low bits 12-31 define the
+ * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
+ * metric.
+ */
+static inline u64 sgx_calc_section_metric(u64 low, u64 high)
+{
+	return (low & GENMASK_ULL(31, 12)) +
+	       ((high & GENMASK_ULL(19, 0)) << 32);
+}
+
+static __init int sgx_page_cache_init(void)
+{
+	u32 eax, ebx, ecx, edx, type;
+	u64 pa, size;
+	int ret;
+	int i;
+
+	BUILD_BUG_ON(SGX_MAX_EPC_SECTIONS > (SGX_EPC_SECTION_MASK + 1));
+
+	for (i = 0; i < (SGX_MAX_EPC_SECTIONS + 1); i++) {
+		cpuid_count(SGX_CPUID, i + SGX_CPUID_FIRST_VARIABLE_SUB_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+
+		type = eax & SGX_CPUID_SUB_LEAF_TYPE_MASK;
+		if (type == SGX_CPUID_SUB_LEAF_INVALID)
+			break;
+		if (type != SGX_CPUID_SUB_LEAF_EPC_SECTION) {
+			pr_err_once("sgx: Unknown sub-leaf type: %u\n", type);
+			return -ENODEV;
+		}
+		if (i == SGX_MAX_EPC_SECTIONS) {
+			pr_warn("sgx: More than "
+				__stringify(SGX_MAX_EPC_SECTIONS)
+				" EPC sections\n");
+			break;
+		}
+
+		pa = sgx_calc_section_metric(eax, ebx);
+		size = sgx_calc_section_metric(ecx, edx);
+		pr_info("sgx: EPC section 0x%llx-0x%llx\n", pa, pa + size - 1);
+
+		ret = sgx_init_epc_section(pa, size, i, &sgx_epc_sections[i]);
+		if (ret) {
+			sgx_page_cache_teardown();
+			return ret;
+		}
+
+		sgx_nr_epc_sections++;
+	}
+
+	if (!sgx_nr_epc_sections) {
+		pr_err("sgx: There are zero EPC sections.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static __init int sgx_init(void)
+{
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_SGX))
+		return false;
+
+	ret = sgx_page_cache_init();
+	if (ret)
+		return ret;
+
+	ret = sgx_page_reclaimer_init();
+	if (ret) {
+		sgx_page_cache_teardown();
+		return ret;
+	}
+
+	return 0;
+}
+
+arch_initcall(sgx_init);
diff --git a/arch/x86/kernel/cpu/sgx/reclaim.c b/arch/x86/kernel/cpu/sgx/reclaim.c
new file mode 100644
index 000000000000..042769f03be9
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/reclaim.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-19 Intel Corporation.
+
+#include <linux/freezer.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/ratelimit.h>
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include "encls.h"
+#include "sgx.h"
+
+static struct task_struct *ksgxswapd_tsk;
+
+static void sgx_sanitize_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page, *tmp;
+	LIST_HEAD(secs_list);
+	int ret;
+
+	while (!list_empty(&section->unsanitized_page_list)) {
+		if (kthread_should_stop())
+			return;
+
+		spin_lock(&section->lock);
+
+		page = list_first_entry(&section->unsanitized_page_list,
+					struct sgx_epc_page, list);
+
+		ret = __eremove(sgx_epc_addr(page));
+		if (!ret)
+			list_move(&page->list, &section->page_list);
+		else
+			list_move_tail(&page->list, &secs_list);
+
+		spin_unlock(&section->lock);
+
+		cond_resched();
+	}
+
+	list_for_each_entry_safe(page, tmp, &secs_list, list) {
+		if (kthread_should_stop())
+			return;
+
+		ret = __eremove(sgx_epc_addr(page));
+		if (!WARN_ON_ONCE(ret)) {
+			spin_lock(&section->lock);
+			list_move(&page->list, &section->page_list);
+			spin_unlock(&section->lock);
+		} else {
+			list_del(&page->list);
+			kfree(page);
+		}
+
+		cond_resched();
+	}
+}
+
+static int ksgxswapd(void *p)
+{
+	int i;
+
+	set_freezable();
+
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+	return 0;
+}
+
+int sgx_page_reclaimer_init(void)
+{
+	struct task_struct *tsk;
+
+	tsk = kthread_run(ksgxswapd, NULL, "ksgxswapd");
+	if (IS_ERR(tsk))
+		return PTR_ERR(tsk);
+
+	ksgxswapd_tsk = tsk;
+
+	return 0;
+}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
new file mode 100644
index 000000000000..3009ec816339
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+#ifndef _X86_SGX_H
+#define _X86_SGX_H
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <asm/asm.h>
+#include <uapi/asm/sgx_errno.h>
+
+struct sgx_epc_page {
+	unsigned long desc;
+	struct list_head list;
+};
+
+/**
+ * struct sgx_epc_section
+ *
+ * The firmware can define multiple chunks of EPC to the different areas of the
+ * physical memory e.g. for memory areas of the each node. This structure is
+ * used to store EPC pages for one EPC section and virtual memory area where
+ * the pages have been mapped.
+ */
+struct sgx_epc_section {
+	unsigned long pa;
+	void *va;
+	struct list_head page_list;
+	struct list_head unsanitized_page_list;
+	unsigned long free_cnt;
+	spinlock_t lock;
+};
+
+#define SGX_MAX_EPC_SECTIONS	8
+
+extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+
+/**
+ * enum sgx_epc_page_desc - bits and masks for an EPC page's descriptor
+ * %SGX_EPC_SECTION_MASK:	SGX allows to have multiple EPC sections in the
+ *				physical memory. The existing and near-future
+ *				hardware defines at most eight sections, hence
+ *				three bits to hold a section.
+ */
+enum sgx_epc_page_desc {
+	SGX_EPC_SECTION_MASK			= GENMASK_ULL(3, 0),
+	/* bits 12-63 are reserved for the physical page address of the page */
+};
+
+static inline struct sgx_epc_section *sgx_epc_section(struct sgx_epc_page *page)
+{
+	return &sgx_epc_sections[page->desc & SGX_EPC_SECTION_MASK];
+}
+
+static inline void *sgx_epc_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section = sgx_epc_section(page);
+
+	return section->va + (page->desc & PAGE_MASK) - section->pa;
+}
+
+extern int sgx_nr_epc_sections;
+
+int sgx_page_reclaimer_init(void);
+
+#endif /* _X86_SGX_H */
-- 
2.20.1

