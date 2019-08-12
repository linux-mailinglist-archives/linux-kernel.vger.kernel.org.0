Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588B589797
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfHLHM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:12:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46898 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:12:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so11816860pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3X82VUZxeCBJ2bjbXyC/KyX1TZSvze6F2ZdNq0/QFs=;
        b=gaBcIOATDOxnijuC6bO8XdSIlN9lg5pfhuqgR+rW4QMQiUiHq0n5yORrFOjLFIsa9c
         I10Itx9BcbTvdTWXv95pk1528uewGa7QtKRalvgP4txWpwKXLUq5AHdIoeXJCPvQRBs/
         iIpdfC7SW97qddysNS4N9RLxlAdZLjjbtzGvoYXhg4TTSUlgFNM0ydl13E6qnCyoBRpx
         7uq+LkYF001nKhn9CYm6sqAdCvbGBKaM/hRAHHfArlkULK841jyY1N2eM92H9DL3ZPvC
         5hcOeYGZPYvFeNqj2HtuvtPTgL+mciDrJkQH5/46rKYHJZPs9BcNLwC6DzPduDxOF6Sv
         i/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3X82VUZxeCBJ2bjbXyC/KyX1TZSvze6F2ZdNq0/QFs=;
        b=qxSATejSoNomTDkeCxy5a5pB91VHGCXQKYGeK1ocqOogjJvza/od9EqSYwspKwbtPJ
         JpO25oUwuhzrZUw9X0EAwu8kAoK8qxVrZx/ifRjgZP7O8TXn+Adq7PLzF7BKwedoFc27
         nZaagywC58DwZgKIhsgkd6NUEAlW132iexHD+LePyoJsbunfgzgFYXHh+axctd67lSez
         VsJYUCG69J1y00S+B1RKfypZOPVauGGF5IKDqIMnz+eYS5Vsz6k39xAcgvl38nepktEn
         GgLRtl2dSr6L6BCeC9r9FtXq5jHuMXEnN2h559XidKvqtuCgjKR/APT4JJvwBYZSUpPy
         +iNg==
X-Gm-Message-State: APjAAAXE5Q/ght4C1e9S5FnGm0TsUOZEsaYBSJbtk539rk+siOyL5BPb
        kaYcOAl4EWu83pGnlr/gB2goeTeN84o=
X-Google-Smtp-Source: APXvYqyDz1pee0PV4FPn88xQRzBHBqCu2at3//StAQ7DxuBM3emrDzq3M7IJm0dNt2nQk107Pwp5Iw==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr28764685pgg.171.1565593976680;
        Mon, 12 Aug 2019 00:12:56 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id v6sm9219580pff.78.2019.08.12.00.12.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 00:12:55 -0700 (PDT)
Date:   Mon, 12 Aug 2019 00:12:53 -0700
From:   Michel Lespinasse <walken@google.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] some cleanups related to RB_DECLARE_CALLBACKS_MAX
Message-ID: <CANN689H0bzp_wPXugvStJu=ozWE2zcHaKiQ60bCdyGhcdpy8tg@mail.gmail.com>
References: <20190811184613.20463-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811184613.20463-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 11:46 AM Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> Also i have open question related to validating of the augment tree, i mean
> in case of debugging to check that nodes are maintained correctly. Please
> have a look here: https://lkml.org/lkml/2019/7/29/304
>
> Basically we can add one more function under RB_DECLARE_CALLBACKS_MAX template
> making it public that checks a tree and its augmented nodes. At least i see
> two users where it can be used: vmalloc and lib/rbtree_test.c.

I think it would be sufficient to call RBCOMPUTE(node, true) on every
node and check the return value ?

Something like the following (probably applicable in other files too):

---------------------------------- 8< ------------------------------------

augmented rbtree: use generated compute_max function for debug checks

In debug code, use the generated compute_max function instead of
reimplementing similar functionality in multiple places.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 lib/rbtree_test.c | 15 +-------------
 mm/mmap.c         | 26 +++--------------------
 mm/vmalloc.c      | 53 +++++++----------------------------------------
 3 files changed, 12 insertions(+), 82 deletions(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c7570d3..a5a04e820f77 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -222,20 +222,7 @@ static void check_augmented(int nr_nodes)
 	check(nr_nodes);
 	for (rb = rb_first(&root.rb_root); rb; rb = rb_next(rb)) {
 		struct test_node *node = rb_entry(rb, struct test_node, rb);
-		u32 subtree, max = node->val;
-		if (node->rb.rb_left) {
-			subtree = rb_entry(node->rb.rb_left, struct test_node,
-					   rb)->augmented;
-			if (max < subtree)
-				max = subtree;
-		}
-		if (node->rb.rb_right) {
-			subtree = rb_entry(node->rb.rb_right, struct test_node,
-					   rb)->augmented;
-			if (max < subtree)
-				max = subtree;
-		}
-		WARN_ON_ONCE(node->augmented != max);
+		WARN_ON_ONCE(!augment_callbacks_compute_max(node, true));
 	}
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 24f0772d6afd..d6d23e6c2d10 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -311,24 +311,6 @@ static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_DEBUG_VM_RB
-static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
-{
-	unsigned long max = vma_compute_gap(vma), subtree_gap;
-	if (vma->vm_rb.rb_left) {
-		subtree_gap = rb_entry(vma->vm_rb.rb_left,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max = subtree_gap;
-	}
-	if (vma->vm_rb.rb_right) {
-		subtree_gap = rb_entry(vma->vm_rb.rb_right,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max = subtree_gap;
-	}
-	return max;
-}
-
 static int browse_rb(struct mm_struct *mm)
 {
 	struct rb_root *root = &mm->mm_rb;
@@ -355,10 +337,8 @@ static int browse_rb(struct mm_struct *mm)
 			bug = 1;
 		}
 		spin_lock(&mm->page_table_lock);
-		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma)) {
-			pr_emerg("free gap %lx, correct %lx\n",
-			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma));
+		if (!vma_gap_callbacks_compute_max(vma, true)) {
+			pr_emerg("wrong subtree gap in vma %p\n", vma);
 			bug = 1;
 		}
 		spin_unlock(&mm->page_table_lock);
@@ -385,7 +365,7 @@ static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ignore)
 		struct vm_area_struct *vma;
 		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
 		VM_BUG_ON_VMA(vma != ignore &&
-			vma->rb_subtree_gap != vma_compute_subtree_gap(vma),
+			!vma_gap_callbacks_compute_max(vma, true),
 			vma);
 	}
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f7c61accb0e2..ea23ccaf70fc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -553,48 +553,6 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
 	RB_CLEAR_NODE(&va->rb_node);
 }
 
-#if DEBUG_AUGMENT_PROPAGATE_CHECK
-static void
-augment_tree_propagate_check(struct rb_node *n)
-{
-	struct vmap_area *va;
-	struct rb_node *node;
-	unsigned long size;
-	bool found = false;
-
-	if (n == NULL)
-		return;
-
-	va = rb_entry(n, struct vmap_area, rb_node);
-	size = va->subtree_max_size;
-	node = n;
-
-	while (node) {
-		va = rb_entry(node, struct vmap_area, rb_node);
-
-		if (get_subtree_max_size(node->rb_left) == size) {
-			node = node->rb_left;
-		} else {
-			if (va_size(va) == size) {
-				found = true;
-				break;
-			}
-
-			node = node->rb_right;
-		}
-	}
-
-	if (!found) {
-		va = rb_entry(n, struct vmap_area, rb_node);
-		pr_emerg("tree is corrupted: %lu, %lu\n",
-			va_size(va), va->subtree_max_size);
-	}
-
-	augment_tree_propagate_check(n->rb_left);
-	augment_tree_propagate_check(n->rb_right);
-}
-#endif
-
 /*
  * This function populates subtree_max_size from bottom to upper
  * levels starting from VA point. The propagation must be done
@@ -645,9 +603,14 @@ augment_tree_propagate_from(struct vmap_area *va)
 		node = rb_parent(&va->rb_node);
 	}
 
-#if DEBUG_AUGMENT_PROPAGATE_CHECK
-	augment_tree_propagate_check(free_vmap_area_root.rb_node);
-#endif
+	if (DEBUG_AUGMENT_PROPAGATE_CHECK) {
+		struct vmap_area *va;
+
+		list_for_each_entry(va, &free_vmap_area_list, list) {
+			WARN_ON(!free_vmap_area_rb_augment_cb_compute_max(
+					va, true));
+		}
+	}
 }
 
 static void
-- 
2.23.0.rc1.153.gdeed80330f-goog
