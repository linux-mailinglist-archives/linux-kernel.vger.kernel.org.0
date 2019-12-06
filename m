Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87559114D87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 09:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfLFIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 03:24:48 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:50406 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfLFIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:24:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0C2833F26D;
        Fri,  6 Dec 2019 09:24:40 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YkhtrX0c;
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
        with ESMTP id gHg2CEyS_O6z; Fri,  6 Dec 2019 09:24:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1E7FB3F260;
        Fri,  6 Dec 2019 09:24:35 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5C95436248A;
        Fri,  6 Dec 2019 09:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575620675; bh=vaz4Fv+7GImw8+vcszuFMdA6P2YC6/2kJMWKMuBG2ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkhtrX0cdlFY/uXQGbmu6FwDrUf+pkXZee5ibUPmYxgy5YNt6UnC9GobHSO2Vv0Tu
         vx0rm/fpXq9Ulzsv0ZzUlS0n7s4xXoJ26AafBEHiBtDsLi6bgADq0Kn9nJt2q30T06
         e8Jx5Nwta7vsEMfqqRXkNr+fqJIS6sauiGmHEmCo=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 1/2] mm: Add a vmf_insert_mixed_prot() function
Date:   Fri,  6 Dec 2019 09:24:25 +0100
Message-Id: <20191206082426.2958-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206082426.2958-1-thomas_os@shipmail.org>
References: <20191206082426.2958-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The TTM module today uses a hack to be able to set a different page
protection than struct vm_area_struct::vm_page_prot. To be able to do
this properly, add the needed vm functionality as vmf_insert_mixed_prot().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..29575d3c1e47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2548,6 +2548,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
+vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
+			pfn_t pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..b9e7f1d56b1c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1719,9 +1719,9 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 }
 
 static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+		unsigned long addr, pfn_t pfn, pgprot_t pgprot,
+		bool mkwrite)
 {
-	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
 
 	BUG_ON(!vm_mixed_ok(vma, pfn));
@@ -1764,10 +1764,16 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
+				 pfn_t pfn, pgprot_t pgprot)
+{
+	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
+}
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, false);
+	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vmf_insert_mixed);
 
@@ -1779,7 +1785,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, true);
+	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, true);
 }
 EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
 
-- 
2.21.0

