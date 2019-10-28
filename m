Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030E8E7ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbfJ1VE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:04:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:13456 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfJ1VE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:04:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 14:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="224759572"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 14:04:49 -0700
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
Subject: [PATCH v23 08/24] x86/sgx: Enumerate and track EPC sections
Date:   Mon, 28 Oct 2019 23:03:08 +0200
Message-Id: <20191028210324.12475-9-jarkko.sakkinen@linux.intel.com>
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

Enumerate Enclave Page Cache (EPC) sections via CPUID and add the data
structures necessary to track EPC pages so that they can be allocated,
freed and managed. As a system may have multiple EPC sections, invoke CPUID
on SGX sub-leafs until an invalid leaf is encountered.

For simplicity, support a maximum of eight EPC sections. Existing client
hardware supports only a single section, while upcoming server hardware
will support at most eight sections. Bounding the number of sections also
allows the section ID to be embedded along with a page's offset in a single
unsigned long, enabling easy retrieval of both the VA and PA for a given
page.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/Kconfig                  |  14 +++
 arch/x86/kernel/cpu/Makefile      |   1 +
 arch/x86/kernel/cpu/sgx/Makefile  |   3 +
 arch/x86/kernel/cpu/sgx/main.c    | 154 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/reclaim.c |  87 +++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h     |  70 ++++++++++++++
 6 files changed, 329 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/Makefile
 create mode 100644 arch/x86/kernel/cpu/sgx/main.c
 create mode 100644 arch/x86/kernel/cpu/sgx/reclaim.c
 create mode 100644 arch/x86/kernel/cpu/sgx/sgx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..8f2faadc447e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1940,6 +1940,20 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config INTEL_SGX
+	bool "Intel SGX"
+	depends on X86_64 && CPU_SUP_INTEL
+	select SRCU
+	select MMU_NOTIFIER
+	help
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
new file mode 100644
index 000000000000..2dec75916a5e
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -0,0 +1,3 @@
+obj-y += \
+	main.o \
+	reclaim.o
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
new file mode 100644
index 000000000000..f8ba10516eaf
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -0,0 +1,154 @@
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
+#include "encls.h"
+
+struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+int sgx_nr_epc_sections;
+
+static void __init sgx_free_epc_section(struct sgx_epc_section *section)
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
+static bool __init sgx_alloc_epc_section(u64 addr, u64 size,
+					 unsigned long index,
+					 struct sgx_epc_section *section)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct sgx_epc_page *page;
+	unsigned long i;
+
+	section->va = memremap(addr, size, MEMREMAP_WB);
+	if (!section->va)
+		return false;
+
+	section->pa = addr;
+	spin_lock_init(&section->lock);
+	INIT_LIST_HEAD(&section->page_list);
+	INIT_LIST_HEAD(&section->unsanitized_page_list);
+
+	for (i = 0; i < nr_pages; i++) {
+		page = kzalloc(sizeof(*page), GFP_KERNEL);
+		if (!page)
+			goto err_out;
+
+		page->desc = (addr + (i << PAGE_SHIFT)) | index;
+		list_add_tail(&page->list, &section->unsanitized_page_list);
+	}
+
+	return true;
+
+err_out:
+	sgx_free_epc_section(section);
+	return false;
+}
+
+static void __init sgx_page_cache_teardown(void)
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
+static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
+{
+	return (low & GENMASK_ULL(31, 12)) +
+	       ((high & GENMASK_ULL(19, 0)) << 32);
+}
+
+static bool __init sgx_page_cache_init(void)
+{
+	u32 eax, ebx, ecx, edx, type;
+	u64 pa, size;
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
+
+		if (type != SGX_CPUID_SUB_LEAF_EPC_SECTION) {
+			pr_err_once("Unknown sub-leaf type: %u\n", type);
+			break;
+		}
+
+		if (i == SGX_MAX_EPC_SECTIONS) {
+			pr_warn("More than %d EPC sections\n",
+				SGX_MAX_EPC_SECTIONS);
+			break;
+		}
+
+		pa = sgx_calc_section_metric(eax, ebx);
+		size = sgx_calc_section_metric(ecx, edx);
+
+		pr_info("EPC section 0x%llx-0x%llx\n", pa, pa + size - 1);
+
+		if (!sgx_alloc_epc_section(pa, size, i, &sgx_epc_sections[i])) {
+			pr_err("No memory for the EPC section\n");
+			break;
+		}
+
+		sgx_nr_epc_sections++;
+	}
+
+	if (!sgx_nr_epc_sections) {
+		pr_err("There are zero EPC sections.\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void __init sgx_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SGX))
+		return;
+
+	if (!sgx_page_cache_init())
+		return;
+
+	if (!sgx_page_reclaimer_init())
+		goto err_page_cache;
+
+	return;
+
+err_page_cache:
+	sgx_page_cache_teardown();
+}
+
+arch_initcall(sgx_init);
diff --git a/arch/x86/kernel/cpu/sgx/reclaim.c b/arch/x86/kernel/cpu/sgx/reclaim.c
new file mode 100644
index 000000000000..f071158d34f6
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/reclaim.c
@@ -0,0 +1,87 @@
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
+
+struct task_struct *ksgxswapd_tsk;
+
+/*
+ * Reset all pages to uninitialized state. Pages could be in initialized on
+ * kmemexec.
+ */
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
+bool __init sgx_page_reclaimer_init(void)
+{
+	struct task_struct *tsk;
+
+	tsk = kthread_run(ksgxswapd, NULL, "ksgxswapd");
+	if (IS_ERR(tsk))
+		return false;
+
+	ksgxswapd_tsk = tsk;
+
+	return true;
+}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
new file mode 100644
index 000000000000..9d8036f997b1
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -0,0 +1,70 @@
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
+#include "arch.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "sgx: " fmt
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
+extern struct task_struct *ksgxswapd_tsk;
+
+bool __init sgx_page_reclaimer_init(void);
+
+#endif /* _X86_SGX_H */
-- 
2.20.1

