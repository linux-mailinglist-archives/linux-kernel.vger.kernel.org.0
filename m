Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF12165D90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:27:48 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40842 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgBTM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 24DBF3F401;
        Thu, 20 Feb 2020 13:27:40 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=EsL3zqsY;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AKgQQuC0Bh89; Thu, 20 Feb 2020 13:27:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id E9AAE3F32A;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 861AE360476;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201654; bh=I4dTEA5C4I3JwRk7pTpNlz2a8W6Im6M0WNPnyIsfSGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsL3zqsYTubFEI86dJ/b9vOJiUfulEgyqRrN7suvJPPKGOO7l03gsDYKOTqLT3Jnw
         TIk6LJ5EznLO0Ily4N7ly1LqC3qvl5uGemdHNBL5klRshKdhwRVvEgw+CYb/qgT1ui
         R5xSQRigEHw2c/bTIIuxoLLi/90XBMEpR1TW/T6c=
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
Subject: [PATCH v4 3/9] mm: Split huge pages on write-notify or COW
Date:   Thu, 20 Feb 2020 13:27:13 +0100
Message-Id: <20200220122719.4302-4-thomas_os@shipmail.org>
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

We currently only do COW and write-notify on the PTE level, so if the
huge_fault() handler returns VM_FAULT_FALLBACK on wp faults,
split the huge pages and page-table entries. Also do this for huge PUDs
if there is no huge_fault() handler and the vma is not anonymous, similar
to how it's done for PMDs.

Note that fs/dax.c does the splitting in the huge_fault() handler, but as
huge_fault() is implemented by modules we need to consider whether to
export the splitting functions for use in the modules or whether to try
to keep calls in the core. Opt for the latter. A follow-up patch can
remove the dax.c split_huge_pmd() if needed.

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
 mm/memory.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 17aadc751e5c..4c49fe963e5c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3880,11 +3880,14 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma))
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	if (vmf->vma->vm_ops->huge_fault) {
+		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 
-	/* COW handled on pte level: split pmd */
-	VM_BUG_ON_VMA(vmf->vma->vm_flags & VM_SHARED, vmf->vma);
+		if (!(ret & VM_FAULT_FALLBACK))
+			return ret;
+	}
+
+	/* COW or write-notify handled on pte level: split pmd. */
 	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
 
 	return VM_FAULT_FALLBACK;
@@ -3897,12 +3900,20 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 
 static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vmf->vma))
-		return VM_FAULT_FALLBACK;
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+		goto split;
+	if (vmf->vma->vm_ops->huge_fault) {
+		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+
+		if (!(ret & VM_FAULT_FALLBACK))
+			return ret;
+	}
+split:
+	/* COW or write-notify not handled on PUD level: split pud.*/
+	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
-- 
2.21.1

