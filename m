Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6468611517A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLFNyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 08:54:21 -0500
Received: from foss.arm.com ([217.140.110.172]:44718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLFNyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B786113E;
        Fri,  6 Dec 2019 05:54:16 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE61C3F718;
        Fri,  6 Dec 2019 05:54:13 -0800 (PST)
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
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v16 11/25] mm: pagewalk: Add p4d_entry() and pgd_entry()
Date:   Fri,  6 Dec 2019 13:53:02 +0000
Message-Id: <20191206135316.47703-12-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206135316.47703-1-steven.price@arm.com>
References: <20191206135316.47703-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
no users. We're about to add users so reintroduce them, along with
p4d_entry() as we now have 5 levels of tables.

Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
PUD-sized transparent hugepages") already re-added pud_entry() but with
different semantics to the other callbacks. Since there have never
been upstream users of this, revert the semantics back to match the
other callbacks. This means pud_entry() is called for all entries, not
just transparent huge pages.

Tested-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/linux/pagewalk.h | 19 +++++++++++++------
 mm/pagewalk.c            | 27 ++++++++++++++++-----------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 6ec82e92c87f..06790f23957f 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -8,15 +8,15 @@ struct mm_walk;
 
 /**
  * mm_walk_ops - callbacks for walk_page_range
- * @pud_entry:		if set, called for each non-empty PUD (2nd-level) entry
- *			this handler should only handle pud_trans_huge() puds.
- *			the pmd_entry or pte_entry callbacks will be used for
- *			regular PUDs.
- * @pmd_entry:		if set, called for each non-empty PMD (3rd-level) entry
+ * @pgd_entry:		if set, called for each non-empty PGD (top-level) entry
+ * @p4d_entry:		if set, called for each non-empty P4D entry
+ * @pud_entry:		if set, called for each non-empty PUD entry
+ * @pmd_entry:		if set, called for each non-empty PMD entry
  *			this handler is required to be able to handle
  *			pmd_trans_huge() pmds.  They may simply choose to
  *			split_huge_page() instead of handling it explicitly.
- * @pte_entry:		if set, called for each non-empty PTE (4th-level) entry
+ * @pte_entry:		if set, called for each non-empty PTE (lowest-level)
+ *			entry
  * @pte_hole:		if set, called for each hole at all levels
  * @hugetlb_entry:	if set, called for each hugetlb entry
  * @test_walk:		caller specific callback function to determine whether
@@ -27,8 +27,15 @@ struct mm_walk;
  * @pre_vma:            if set, called before starting walk on a non-null vma.
  * @post_vma:           if set, called after a walk on a non-null vma, provided
  *                      that @pre_vma and the vma walk succeeded.
+ *
+ * p?d_entry callbacks are called even if those levels are folded on a
+ * particular architecture/configuration.
  */
 struct mm_walk_ops {
+	int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
+			 unsigned long next, struct mm_walk *walk);
+	int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
+			 unsigned long next, struct mm_walk *walk);
 	int (*pud_entry)(pud_t *pud, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index ea0b9e606ad1..c089786e7a7f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -94,15 +94,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		}
 
 		if (ops->pud_entry) {
-			spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
-
-			if (ptl) {
-				err = ops->pud_entry(pud, addr, next, walk);
-				spin_unlock(ptl);
-				if (err)
-					break;
-				continue;
-			}
+			err = ops->pud_entry(pud, addr, next, walk);
+			if (err)
+				break;
 		}
 
 		split_huge_pud(walk->vma, pud, addr);
@@ -136,7 +130,12 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 				break;
 			continue;
 		}
-		if (ops->pmd_entry || ops->pte_entry)
+		if (ops->p4d_entry) {
+			err = ops->p4d_entry(p4d, addr, next, walk);
+			if (err)
+				break;
+		}
+		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
 			break;
@@ -163,7 +162,13 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 				break;
 			continue;
 		}
-		if (ops->pmd_entry || ops->pte_entry)
+		if (ops->pgd_entry) {
+			err = ops->pgd_entry(pgd, addr, next, walk);
+			if (err)
+				break;
+		}
+		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
+		    ops->pte_entry)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
 			break;
-- 
2.20.1

