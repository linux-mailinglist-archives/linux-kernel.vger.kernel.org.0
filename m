Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF78B417
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHMJ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 05:29:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41280 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfHMJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:29:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so71399144lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fAGysT7hqZ7fpkKuFt14uGWUhbRaQKW6bEkju/DQztU=;
        b=F7ZExr/gKphkOMbwzFNWLmCTRAdBlrNKlQyD7+WmTsRhHi+YC6OsQlm/kv9McDMwFJ
         R20dugVH22xMQS1tATtQnipVcUq5+nBQw4VKYvqVVy0lO9RLXadlOBVtdkC+07Hec/kC
         DaAxgaUQr+XJFc1x48p5QOiOp7ImUQcDuXmckL3kz0gh3pOD6TO1exI8vCRFYeNYfwwY
         GuWqop4SZxgOPqPLslr9Tweb22sqb99wojlKzdUtMX+YxWcdjrTcQZNHET4LJMrsBGvV
         Se3PKx/Jb49JIgI0HVFL7j86xEU7J1qzFvi9BsTcEnZwiht5JPWGfREGMG5RwN2l2MFR
         ZNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fAGysT7hqZ7fpkKuFt14uGWUhbRaQKW6bEkju/DQztU=;
        b=HYn3CqRUJls8P2AxxrAE/F6zKGlc87Uh1GTl0KkPvEjsunOuH3x5u2sOLW8WbP4bPO
         NhzsOM+20xooZAklhGpSKB496UWq6yPOVI70IO4C41H2+NTLdJuZsNKLCV+hhLPx6mmF
         MSquKlLj6wSKfmcvvhpb3t2N4b2sPBJEOBo5Vw2y9DjrsPrHEaVO74LMkWIH5pVMSYzq
         x597tVXHDhL4m8qWpi0cTcHFuYaKUM2XaNbzaXPaemcE3IDGaAAP6OUNuIA+09m+ALBS
         C1i5KrB6BBaICdRu1UZqbyWtBsbGkGgvpqf2FJBVKWpI/AQhn/D2Q6bi5kIdgDc5XsMT
         +VVQ==
X-Gm-Message-State: APjAAAWO7gg4IRjvN/c3y2AZ1faIxz81nGm7NfYAEa8awYf4VVmqtoH1
        b4r4itfYGL9KVOpsp8HIfGg=
X-Google-Smtp-Source: APXvYqxYBQM5SCNw2q/2hCRd2Jc3+NStRRPko0hooVWmdJu4/GZCA6opIqvaZS1fQLxMejlgwxnMBw==
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr21147287lfp.80.1565688573302;
        Tue, 13 Aug 2019 02:29:33 -0700 (PDT)
Received: from pc636 ([37.212.214.187])
        by smtp.gmail.com with ESMTPSA id m25sm19522310lfc.83.2019.08.13.02.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 02:29:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 13 Aug 2019 11:29:22 +0200
To:     Michel Lespinasse <walken@google.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] some cleanups related to RB_DECLARE_CALLBACKS_MAX
Message-ID: <20190813092922.udzdjgfj4w6e362c@pc636>
References: <20190811184613.20463-1-urezki@gmail.com>
 <CANN689H0bzp_wPXugvStJu=ozWE2zcHaKiQ60bCdyGhcdpy8tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689H0bzp_wPXugvStJu=ozWE2zcHaKiQ60bCdyGhcdpy8tg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think it would be sufficient to call RBCOMPUTE(node, true) on every
> node and check the return value ?
>
Yes, that is enough for sure. The only way i was thinking about to make it
public, because checking the tree for MAX is generic for every users which
use RB_DECLARE_CALLBACKS_MAX template. Something like:

validate_rb_max_tree() {
    for (nd = rb_first(root); nd; nd = rb_next(nd)) {
	    fooo = rb_entry(nd, struct sometinhf, rb_field);
	    WARN_ON(!*_compute_max(foo, true);	
    }
}

and call this public function under debug code. But i do not have strong
opinion here and it is probably odd. Anyway i am fine with your change.

There is small comment below:

> 
> Something like the following (probably applicable in other files too):
> 
> ---------------------------------- 8< ------------------------------------
> 
> augmented rbtree: use generated compute_max function for debug checks
> 
> In debug code, use the generated compute_max function instead of
> reimplementing similar functionality in multiple places.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>  lib/rbtree_test.c | 15 +-------------
>  mm/mmap.c         | 26 +++--------------------
>  mm/vmalloc.c      | 53 +++++++----------------------------------------
>  3 files changed, 12 insertions(+), 82 deletions(-)
> 
> diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
> index 41ae3c7570d3..a5a04e820f77 100644
> --- a/lib/rbtree_test.c
> +++ b/lib/rbtree_test.c
> @@ -222,20 +222,7 @@ static void check_augmented(int nr_nodes)
>  	check(nr_nodes);
>  	for (rb = rb_first(&root.rb_root); rb; rb = rb_next(rb)) {
>  		struct test_node *node = rb_entry(rb, struct test_node, rb);
> -		u32 subtree, max = node->val;
> -		if (node->rb.rb_left) {
> -			subtree = rb_entry(node->rb.rb_left, struct test_node,
> -					   rb)->augmented;
> -			if (max < subtree)
> -				max = subtree;
> -		}
> -		if (node->rb.rb_right) {
> -			subtree = rb_entry(node->rb.rb_right, struct test_node,
> -					   rb)->augmented;
> -			if (max < subtree)
> -				max = subtree;
> -		}
> -		WARN_ON_ONCE(node->augmented != max);
> +		WARN_ON_ONCE(!augment_callbacks_compute_max(node, true));
>  	}
>  }
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 24f0772d6afd..d6d23e6c2d10 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -311,24 +311,6 @@ static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
>  }
>  
>  #ifdef CONFIG_DEBUG_VM_RB
> -static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
> -{
> -	unsigned long max = vma_compute_gap(vma), subtree_gap;
> -	if (vma->vm_rb.rb_left) {
> -		subtree_gap = rb_entry(vma->vm_rb.rb_left,
> -				struct vm_area_struct, vm_rb)->rb_subtree_gap;
> -		if (subtree_gap > max)
> -			max = subtree_gap;
> -	}
> -	if (vma->vm_rb.rb_right) {
> -		subtree_gap = rb_entry(vma->vm_rb.rb_right,
> -				struct vm_area_struct, vm_rb)->rb_subtree_gap;
> -		if (subtree_gap > max)
> -			max = subtree_gap;
> -	}
> -	return max;
> -}
> -
>  static int browse_rb(struct mm_struct *mm)
>  {
>  	struct rb_root *root = &mm->mm_rb;
> @@ -355,10 +337,8 @@ static int browse_rb(struct mm_struct *mm)
>  			bug = 1;
>  		}
>  		spin_lock(&mm->page_table_lock);
> -		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma)) {
> -			pr_emerg("free gap %lx, correct %lx\n",
> -			       vma->rb_subtree_gap,
> -			       vma_compute_subtree_gap(vma));
> +		if (!vma_gap_callbacks_compute_max(vma, true)) {
> +			pr_emerg("wrong subtree gap in vma %p\n", vma);
>  			bug = 1;
>  		}
>  		spin_unlock(&mm->page_table_lock);
> @@ -385,7 +365,7 @@ static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ignore)
>  		struct vm_area_struct *vma;
>  		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
>  		VM_BUG_ON_VMA(vma != ignore &&
> -			vma->rb_subtree_gap != vma_compute_subtree_gap(vma),
> +			!vma_gap_callbacks_compute_max(vma, true),
>  			vma);
>  	}
>  }
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f7c61accb0e2..ea23ccaf70fc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -553,48 +553,6 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
>  	RB_CLEAR_NODE(&va->rb_node);
>  }
>  
> -#if DEBUG_AUGMENT_PROPAGATE_CHECK
> -static void
> -augment_tree_propagate_check(struct rb_node *n)
> -{
> -	struct vmap_area *va;
> -	struct rb_node *node;
> -	unsigned long size;
> -	bool found = false;
> -
> -	if (n == NULL)
> -		return;
> -
> -	va = rb_entry(n, struct vmap_area, rb_node);
> -	size = va->subtree_max_size;
> -	node = n;
> -
> -	while (node) {
> -		va = rb_entry(node, struct vmap_area, rb_node);
> -
> -		if (get_subtree_max_size(node->rb_left) == size) {
> -			node = node->rb_left;
> -		} else {
> -			if (va_size(va) == size) {
> -				found = true;
> -				break;
> -			}
> -
> -			node = node->rb_right;
> -		}
> -	}
> -
> -	if (!found) {
> -		va = rb_entry(n, struct vmap_area, rb_node);
> -		pr_emerg("tree is corrupted: %lu, %lu\n",
> -			va_size(va), va->subtree_max_size);
> -	}
> -
> -	augment_tree_propagate_check(n->rb_left);
> -	augment_tree_propagate_check(n->rb_right);
> -}
> -#endif
> -
>  /*
>   * This function populates subtree_max_size from bottom to upper
>   * levels starting from VA point. The propagation must be done
> @@ -645,9 +603,14 @@ augment_tree_propagate_from(struct vmap_area *va)
>  		node = rb_parent(&va->rb_node);
>  	}
>  
> -#if DEBUG_AUGMENT_PROPAGATE_CHECK
> -	augment_tree_propagate_check(free_vmap_area_root.rb_node);
> -#endif
> +	if (DEBUG_AUGMENT_PROPAGATE_CHECK) {
> +		struct vmap_area *va;
> +
> +		list_for_each_entry(va, &free_vmap_area_list, list) {
> +			WARN_ON(!free_vmap_area_rb_augment_cb_compute_max(
> +					va, true));
> +		}
> +	}
>  }
>
The object of validating is the tree, therefore it makes sense to go with it,
instead of iterating over the list.

Thank you!

--
Vlad Rezki
