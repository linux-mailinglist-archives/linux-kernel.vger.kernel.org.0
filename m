Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A574CB75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfFTKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 06:01:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:01:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5KA0Qs3907202
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 03:00:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5KA0Qs3907202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024827;
        bh=Nz8MFyC6cXRTKJtqQY7yNc3WXFvBS4oTOTdj6SRGtD4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NqsI9eD339zpmKmrQoFdrWGgDPMi+ji6ibwUfl5a3sJXT4XTiQPbPSQlH2Z2+m1d0
         jZdMyLwBVxzDEO1wmUurI2bali5S0523EDP/TdXiUqv7J2gpmA5aXwU1gJrMNouefJ
         qNodaPSPBdoe5vRWqw6lvMjprzHDoOuYgb8bfztUL03PL3LwB8qi/yrnMBGkXFhRPW
         891XaE+IyKtj7Hs9+YqE+uhEzQh8XWG6PHURp8yEt0jyx06A7muRj9teMF6hx3PVIF
         SFTLpN8Xw4hMftBT1+fgUgiIMpoemlnkIyQBvTGr/gOvhsHz4guzLGVnJqG4BuT4BC
         OiCRnKX+78npA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5KA0QcX907199;
        Thu, 20 Jun 2019 03:00:26 -0700
Date:   Thu, 20 Jun 2019 03:00:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-5da04cc86d1215fd9fe0e5c88ead6e8428a75e56@git.kernel.org>
Cc:     lijiang@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, thomas.lendacky@amd.com, mingo@kernel.org,
        tglx@linutronix.de, x86@kernel.org, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com, bp@suse.de,
        hpa@zytor.com, luto@kernel.org
Reply-To: hpa@zytor.com, luto@kernel.org, bp@suse.de,
          dave.hansen@linux.intel.com, akpm@linux-foundation.org,
          mingo@redhat.com, x86@kernel.org, tglx@linutronix.de,
          mingo@kernel.org, thomas.lendacky@amd.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          lijiang@redhat.com
In-Reply-To: <20190423013007.17838-3-lijiang@redhat.com>
References: <20190423013007.17838-3-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/mm: Rework ioremap resource mapping
 determination
Git-Commit-ID: 5da04cc86d1215fd9fe0e5c88ead6e8428a75e56
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5da04cc86d1215fd9fe0e5c88ead6e8428a75e56
Gitweb:     https://git.kernel.org/tip/5da04cc86d1215fd9fe0e5c88ead6e8428a75e56
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Tue, 23 Apr 2019 09:30:06 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 09:58:07 +0200

x86/mm: Rework ioremap resource mapping determination

On ioremap(), __ioremap_check_mem() does a couple of checks on the
supplied memory range to determine how the range should be mapped and in
particular what protection flags should be used.

Generalize the procedure by introducing IORES_MAP_* flags which control
different aspects of the ioremapping and use them in the respective
helpers which determine which descriptor flags should be set per range.

 [ bp:
   - Rewrite commit message.
   - Add/improve comments.
   - Reflow __ioremap_caller()'s args.
   - s/__ioremap_check_desc/__ioremap_check_encrypted/g;
   - s/__ioremap_res_check/__ioremap_collect_map_flags/g;
   - clarify __ioremap_check_ram()'s purpose. ]

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Co-developed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: bhe@redhat.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: dyoung@redhat.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190423013007.17838-3-lijiang@redhat.com
---
 arch/x86/mm/ioremap.c  | 71 ++++++++++++++++++++++++++++++++------------------
 include/linux/ioport.h |  9 +++++++
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 4b6423e7bd21..e500f1df1140 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -28,9 +28,11 @@
 
 #include "physaddr.h"
 
-struct ioremap_mem_flags {
-	bool system_ram;
-	bool desc_other;
+/*
+ * Descriptor controlling ioremap() behavior.
+ */
+struct ioremap_desc {
+	unsigned int flags;
 };
 
 /*
@@ -62,13 +64,14 @@ int ioremap_change_attr(unsigned long vaddr, unsigned long size,
 	return err;
 }
 
-static bool __ioremap_check_ram(struct resource *res)
+/* Does the range (or a subset of) contain normal RAM? */
+static unsigned int __ioremap_check_ram(struct resource *res)
 {
 	unsigned long start_pfn, stop_pfn;
 	unsigned long i;
 
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
-		return false;
+		return 0;
 
 	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
@@ -76,28 +79,44 @@ static bool __ioremap_check_ram(struct resource *res)
 		for (i = 0; i < (stop_pfn - start_pfn); ++i)
 			if (pfn_valid(start_pfn + i) &&
 			    !PageReserved(pfn_to_page(start_pfn + i)))
-				return true;
+				return IORES_MAP_SYSTEM_RAM;
 	}
 
-	return false;
+	return 0;
 }
 
-static int __ioremap_check_desc_other(struct resource *res)
+/*
+ * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
+ * there the whole memory is already encrypted.
+ */
+static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	if (!sev_active())
+		return 0;
+
+	switch (res->desc) {
+	case IORES_DESC_NONE:
+	case IORES_DESC_RESERVED:
+		break;
+	default:
+		return IORES_MAP_ENCRYPTED;
+	}
+
+	return 0;
 }
 
-static int __ioremap_res_check(struct resource *res, void *arg)
+static int __ioremap_collect_map_flags(struct resource *res, void *arg)
 {
-	struct ioremap_mem_flags *flags = arg;
+	struct ioremap_desc *desc = arg;
 
-	if (!flags->system_ram)
-		flags->system_ram = __ioremap_check_ram(res);
+	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
+		desc->flags |= __ioremap_check_ram(res);
 
-	if (!flags->desc_other)
-		flags->desc_other = __ioremap_check_desc_other(res);
+	if (!(desc->flags & IORES_MAP_ENCRYPTED))
+		desc->flags |= __ioremap_check_encrypted(res);
 
-	return flags->system_ram && flags->desc_other;
+	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
+			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
 }
 
 /*
@@ -106,15 +125,15 @@ static int __ioremap_res_check(struct resource *res, void *arg)
  * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
  */
 static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
-				struct ioremap_mem_flags *flags)
+				struct ioremap_desc *desc)
 {
 	u64 start, end;
 
 	start = (u64)addr;
 	end = start + size - 1;
-	memset(flags, 0, sizeof(*flags));
+	memset(desc, 0, sizeof(struct ioremap_desc));
 
-	walk_mem_res(start, end, flags, __ioremap_res_check);
+	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
 }
 
 /*
@@ -131,15 +150,15 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-static void __iomem *__ioremap_caller(resource_size_t phys_addr,
-		unsigned long size, enum page_cache_mode pcm,
-		void *caller, bool encrypted)
+static void __iomem *
+__ioremap_caller(resource_size_t phys_addr, unsigned long size,
+		 enum page_cache_mode pcm, void *caller, bool encrypted)
 {
 	unsigned long offset, vaddr;
 	resource_size_t last_addr;
 	const resource_size_t unaligned_phys_addr = phys_addr;
 	const unsigned long unaligned_size = size;
-	struct ioremap_mem_flags mem_flags;
+	struct ioremap_desc io_desc;
 	struct vm_struct *area;
 	enum page_cache_mode new_pcm;
 	pgprot_t prot;
@@ -158,12 +177,12 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		return NULL;
 	}
 
-	__ioremap_check_mem(phys_addr, size, &mem_flags);
+	__ioremap_check_mem(phys_addr, size, &io_desc);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
-	if (mem_flags.system_ram) {
+	if (io_desc.flags & IORES_MAP_SYSTEM_RAM) {
 		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
 			  &phys_addr, &last_addr);
 		return NULL;
@@ -201,7 +220,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if ((sev_active() && mem_flags.desc_other) || encrypted)
+	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6ed59de48bd5..5db386cfc2d4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/bits.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -136,6 +137,14 @@ enum {
 	IORES_DESC_RESERVED			= 8,
 };
 
+/*
+ * Flags controlling ioremap() behavior.
+ */
+enum {
+	IORES_MAP_SYSTEM_RAM		= BIT(0),
+	IORES_MAP_ENCRYPTED		= BIT(1),
+};
+
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
 	{								\
