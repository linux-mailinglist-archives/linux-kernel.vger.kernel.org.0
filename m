Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E58115181
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 14:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLFNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 08:54:36 -0500
Received: from foss.arm.com ([217.140.110.172]:44782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfLFNyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42ED1FB;
        Fri,  6 Dec 2019 05:54:21 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C263F718;
        Fri,  6 Dec 2019 05:54:19 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v16 13/25] mm: pagewalk: Don't lock PTEs for walk_page_range_novma()
Date:   Fri,  6 Dec 2019 13:53:04 +0000
Message-Id: <20191206135316.47703-14-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206135316.47703-1-steven.price@arm.com>
References: <20191206135316.47703-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range_novma() can be used to walk page tables or the kernel or
for firmware. These page tables may contain entries that are not backed
by a struct page and so it isn't (in general) possible to take the PTE
lock for the pte_entry() callback. So update walk_pte_range() to only
take the lock when no_vma==false and add a comment explaining the
difference to walk_page_range_novma().

Signed-off-by: Steven Price <steven.price@arm.com>
---
 mm/pagewalk.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index efa464cf079b..1b9a3ba24c51 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -10,9 +10,10 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *pte;
 	int err = 0;
 	const struct mm_walk_ops *ops = walk->ops;
-	spinlock_t *ptl;
+	spinlock_t *uninitialized_var(ptl);
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	pte = walk->no_vma ? pte_offset_map(pmd, addr) :
+			     pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (;;) {
 		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
@@ -23,7 +24,9 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		pte++;
 	}
 
-	pte_unmap_unlock(pte, ptl);
+	if (!walk->no_vma)
+		spin_unlock(ptl);
+	pte_unmap(pte);
 	return err;
 }
 
@@ -383,6 +386,12 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return err;
 }
 
+/*
+ * Similar to walk_page_range() but can walk any page tables even if they are
+ * not backed by VMAs. Because 'unusual' entries may be walked this function
+ * will also not lock the PTEs for the pte_entry() callback. This is useful for
+ * walking the kernel pages tables or page tables for firmware.
+ */
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  void *private)
-- 
2.20.1

