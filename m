Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14F4165D95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgBTM2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:28:06 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60184 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgBTM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 413D93F53F;
        Thu, 20 Feb 2020 13:27:41 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=jnkBtvxg;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9-VwuXEww7Sp; Thu, 20 Feb 2020 13:27:40 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id F35293F439;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id AB17C360481;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201654; bh=PC0ObXncuosXfOTedLamOENbqJpHqToCf6XcPkZEDYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnkBtvxgh6o45fzUEAHlgpicyBxUvgLhz7rw8uPrCo5jNTC+eLMpwbszQ3xDAdxXd
         3Ckxxfs1FCWa6rkwIwR0Ho3fmtFHNCFWmBJA+GLeKJrU5/8QT1rIWMPFVfgTWGx+1h
         /MICBwmB05bISlxvALyJxmlrwNtsxQlyAUaxDNS8=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 4/9] mm: Add vmf_insert_pfn_xxx_prot() for huge page-table entries
Date:   Thu, 20 Feb 2020 13:27:14 +0100
Message-Id: <20200220122719.4302-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220122719.4302-1-thomas_os@shipmail.org>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

For graphics drivers needing to modify the page-protection, add
huge page-table entries counterparts to vmf_insert_pfn_prot().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 include/linux/huge_mm.h | 41 +++++++++++++++++++++++++++++++++++++++--
 mm/huge_memory.c        | 38 ++++++++++++++++++++++++++++++++------
 2 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0b84e13e88e2..a95d1bc8ffe8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -47,8 +47,45 @@ extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
 			int prot_numa);
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
+				   pgprot_t pgprot, bool write);
+
+/**
+ * vmf_insert_pfn_pmd - insert a pmd size pfn
+ * @vmf: Structure describing the fault
+ * @pfn: pfn to insert
+ * @pgprot: page protection to use
+ * @write: whether it's a write fault
+ *
+ * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
+ *
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn,
+					    bool write)
+{
+	return vmf_insert_pfn_pmd_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
+}
+vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
+				   pgprot_t pgprot, bool write);
+
+/**
+ * vmf_insert_pfn_pud - insert a pud size pfn
+ * @vmf: Structure describing the fault
+ * @pfn: pfn to insert
+ * @pgprot: page protection to use
+ * @write: whether it's a write fault
+ *
+ * Insert a pud size pfn. See vmf_insert_pfn() for additional info.
+ *
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
+					    bool write)
+{
+	return vmf_insert_pfn_pud_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
+}
+
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f8d24fc3f4df..b2ec62cca3ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -811,11 +811,24 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pte_free(mm, pgtable);
 }
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+/**
+ * vmf_insert_pfn_pmd_prot - insert a pmd size pfn
+ * @vmf: Structure describing the fault
+ * @pfn: pfn to insert
+ * @pgprot: page protection to use
+ * @write: whether it's a write fault
+ *
+ * Insert a pmd size pfn. See vmf_insert_pfn() for additional info and
+ * also consult the vmf_insert_mixed_prot() documentation when
+ * @pgprot != @vmf->vma->vm_page_prot.
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
+				   pgprot_t pgprot, bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
-	pgprot_t pgprot = vma->vm_page_prot;
 	pgtable_t pgtable = NULL;
 
 	/*
@@ -843,7 +856,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
 	return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
+EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd_prot);
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
@@ -889,11 +902,24 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	spin_unlock(ptl);
 }
 
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+/**
+ * vmf_insert_pfn_pud_prot - insert a pud size pfn
+ * @vmf: Structure describing the fault
+ * @pfn: pfn to insert
+ * @pgprot: page protection to use
+ * @write: whether it's a write fault
+ *
+ * Insert a pud size pfn. See vmf_insert_pfn() for additional info and
+ * also consult the vmf_insert_mixed_prot() documentation when
+ * @pgprot != @vmf->vma->vm_page_prot.
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
+				   pgprot_t pgprot, bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
-	pgprot_t pgprot = vma->vm_page_prot;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -914,7 +940,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
 	return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
+EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud_prot);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-- 
2.21.1

