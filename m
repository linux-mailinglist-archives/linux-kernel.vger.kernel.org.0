Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51546C2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfGQV7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 17:59:46 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56207 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfGQV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:59:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TX9KWw9_1563400771;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX9KWw9_1563400771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 05:59:38 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/2] mm: thp: fix false negative of shmem vma's THP eligibility
Date:   Thu, 18 Jul 2019 05:59:18 +0800
Message-Id: <1563400758-124759-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563400758-124759-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1563400758-124759-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
vma") introduced THPeligible bit for processes' smaps. But, when checking
the eligibility for shmem vma, __transparent_hugepage_enabled() is
called to override the result from shmem_huge_enabled().  It may result
in the anonymous vma's THP flag override shmem's.  For example, running a
simple test which create THP for shmem, but with anonymous THP disabled,
when reading the process's smaps, it may show:

7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
Size:               4096 kB
...
[snip]
...
ShmemPmdMapped:     4096 kB
...
[snip]
...
THPeligible:    0

And, /proc/meminfo does show THP allocated and PMD mapped too:

ShmemHugePages:     4096 kB
ShmemPmdMapped:     4096 kB

This doesn't make too much sense.  The shmem objects should be treated
separately from anonymous THP.  Calling shmem_huge_enabled() with checking
MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
dax vma check since we already checked if the vma is shmem already.

Also check if vma is suitable for THP by calling
transhuge_vma_suitable().

And minor fix to smaps output format and documentation.

Fixes: 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each vma")
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/filesystems/proc.txt | 4 ++--
 fs/proc/task_mmu.c                 | 3 ++-
 mm/huge_memory.c                   | 9 +++++++--
 mm/shmem.c                         | 3 +++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index fb4735f..99ca040 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -486,8 +486,8 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
 "SwapPss" shows proportional swap share of this mapping. Unlike "Swap", this
 does not take into account swapped out page of underlying shmem objects.
 "Locked" indicates whether the mapping is locked in memory or not.
-"THPeligible" indicates whether the mapping is eligible for THP pages - 1 if
-true, 0 otherwise.
+"THPeligible" indicates whether the mapping is eligible for allocating THP
+pages - 1 if true, 0 otherwise. It just shows the current status.
 
 "VmFlags" field deserves a separate description. This member represents the kernel
 flags associated with the particular virtual memory area in two letter encoded
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 818cedb..731642e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -832,7 +832,8 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, false);
 
-	seq_printf(m, "THPeligible:    %d\n", transparent_hugepage_enabled(vma));
+	seq_printf(m, "THPeligible:		%d\n",
+		   transparent_hugepage_enabled(vma));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 782dd14..1334ede 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -63,10 +63,15 @@
 
 bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
+	/* The addr is used to check if the vma size fits */
+	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
+
+	if (!transhuge_vma_suitable(vma, addr))
+		return false;
 	if (vma_is_anonymous(vma))
 		return __transparent_hugepage_enabled(vma);
-	if (vma_is_shmem(vma) && shmem_huge_enabled(vma))
-		return __transparent_hugepage_enabled(vma);
+	if (vma_is_shmem(vma))
+		return shmem_huge_enabled(vma);
 
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index f4dce9c..64e5d59 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3872,6 +3872,9 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 	loff_t i_size;
 	pgoff_t off;
 
+	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
 	if (shmem_huge == SHMEM_HUGE_DENY)
-- 
1.8.3.1

