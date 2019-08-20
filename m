Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABF965CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfHTQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfHTQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:02:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D86DA35FE7;
        Tue, 20 Aug 2019 16:02:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id 80BFC6060D;
        Tue, 20 Aug 2019 16:02:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 20 Aug 2019 18:02:41 +0200 (CEST)
Date:   Tue, 20 Aug 2019 18:02:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] userfaultfd_release: always remove uffd flags and clear
 vm_userfaultfd_ctx
Message-ID: <20190820160237.GB4983@redhat.com>
References: <d4583416-5e4a-95e7-a08a-32bf2c9a95fb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4583416-5e4a-95e7-a08a-32bf2c9a95fb@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 20 Aug 2019 16:02:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd_release() should clear vm_flags/vm_userfaultfd_ctx even
if mm->core_state != NULL.

Otherwise a page fault can see userfaultfd_missing() == T and use an
already freed userfaultfd_ctx.

Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Fixes: 04f5866e41fb ("coredump: fix race condition between mmget_not_zero()/get_task_mm() and core dumping")
Cc: stable@vger.kernel.org
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/userfaultfd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ccbdbd6..fe6d804 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -880,6 +880,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
 	unsigned long new_flags;
+	bool still_valid;
 
 	WRITE_ONCE(ctx->released, true);
 
@@ -895,8 +896,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 * taking the mmap_sem for writing.
 	 */
 	down_write(&mm->mmap_sem);
-	if (!mmget_still_valid(mm))
-		goto skip_mm;
+	still_valid = mmget_still_valid(mm);
 	prev = NULL;
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		cond_resched();
@@ -907,19 +907,20 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
-		prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
-				 new_flags, vma->anon_vma,
-				 vma->vm_file, vma->vm_pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX);
-		if (prev)
-			vma = prev;
-		else
-			prev = vma;
+		if (still_valid) {
+			prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
+					 new_flags, vma->anon_vma,
+					 vma->vm_file, vma->vm_pgoff,
+					 vma_policy(vma),
+					 NULL_VM_UFFD_CTX);
+			if (prev)
+				vma = prev;
+			else
+				prev = vma;
+		}
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
-skip_mm:
 	up_write(&mm->mmap_sem);
 	mmput(mm);
 wakeup:
-- 
2.5.0


