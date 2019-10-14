Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0586D6407
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfJNNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:22:36 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:35916 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbfJNNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:22:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id C75733FAC2;
        Mon, 14 Oct 2019 15:22:17 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=dFjtJ11m;
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
        with ESMTP id nUUmjEQB9-bi; Mon, 14 Oct 2019 15:22:14 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id C7AF53F615;
        Mon, 14 Oct 2019 15:22:12 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 1D38936804E;
        Mon, 14 Oct 2019 15:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571059332; bh=/VtZki6GCsW+3DEzZB0xqCHXTb7savVZuIvitIAE654=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFjtJ11mVBt3zcz894RV4MVRMdH56hMURYx7V41/Rikmp02dKm9HSxu2JaVDMRrPa
         vL2epK1DFdr3O+X7H16Yy6s5YRkk9vJXp7F7v5XBjlWFYuN3J8wdmYFDpWdA7OA7Yj
         XneoqM0pEyFFaBUoVGROS/sc/prNVPjk+Cmwgles=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v6 1/8] mm: Remove BUG_ON mmap_sem not held from xxx_trans_huge_lock()
Date:   Mon, 14 Oct 2019 15:21:57 +0200
Message-Id: <20191014132204.7721-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014132204.7721-1-thomas_os@shipmail.org>
References: <20191014132204.7721-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The caller needs to make sure that the vma is not torn down during the
lock operation and can also use the i_mmap_rwsem for file-backed vmas.
Remove the BUG_ON. We could, as an alternative, add a test that either
vma->vm_mm->mmap_sem or vma->vm_file->f_mapping->i_mmap_rwsem are held.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 include/linux/huge_mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93d5cf0bc716..0b84e13e88e2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -216,7 +216,6 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_mm->mmap_sem), vma);
 	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
@@ -225,7 +224,6 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_mm->mmap_sem), vma);
 	if (pud_trans_huge(*pud) || pud_devmap(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
-- 
2.20.1

