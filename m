Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBABA30009
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 18:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfE3QPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 12:15:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfE3QPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:15:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so4268823pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QdCnbVnvU3JKpvLwtQ0RZP1XXmjXKTawTWYBTDGInu4=;
        b=iLQl/tzlA9IoLss9iCFQI/uNGICbYiY4oejGcOmvASeKUe1o9NBlHzZdiKIU2xU58Y
         3pKqXYhhLPDvcUMN7eyQqGRC4IryxuvQMWpUXEv8jnvIzDG7kZZg9PxBjkDzEFxg+RQf
         IVDhR19utfM7z+cRwAL4kdXgETyC+JmOUaA4KHKVd+GagQ+bXc+lAzNsMdpe3bzXPDPx
         KDOv/heXOJc5v7KdT7sv1ibco32xt7Ynm8VHLcvCtns9QqQ/Lj7JCkgVMV9pp/OkoWPD
         Zcc+T3tyl96dUAbeOBndyhsXipIkP4D9akQIpA985eo1aayznx92rFD0B7fd/9tZaa6C
         VapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QdCnbVnvU3JKpvLwtQ0RZP1XXmjXKTawTWYBTDGInu4=;
        b=QTTjYXMwuwXfm4zE4i8bo+1wsrrVOWsgPJzR71MXMqrX2IV2KbQFJ5fgsX5mfQKxbR
         oxPjkPoPe8pm0qDHDCVynO1a5fpDeFvrfI6Li32h9AKHVrNxz/XximrsKlpGe848v5Xh
         uMWx1FQ2a6Ip0u0HaLf2xMB3Pl0/7pnKHgfzR+QCOeKSj4fXQd/nudqxa00yv+vAMB0I
         abypmwwP5g9m/U57a0pLnOH8txlXapx9Ft0uFguILWpB0q7vO5fVpnh8OJ+aQaS5NKN3
         BkVqqMTUXvQHe+DBhq0CsXVZc0npNVFkqMxNm5QUZe008J//gm6yslJ/12966KIafVBD
         nnJQ==
X-Gm-Message-State: APjAAAWsjQ3ZQ3X2WSBe438O+QWeWCW0z6Xuh0VbP95wBYnvsaIHVARJ
        Ib1HOOrpkFfCRzIlkp8/SkQmWg==
X-Google-Smtp-Source: APXvYqzdneacRJ3jMe8/a4aYeOWI8YILi6WoYZXJpCLl8ovLvQkhojhfLpNV90VPB11YoHs72pAphw==
X-Received: by 2002:a17:90a:240c:: with SMTP id h12mr4366079pje.12.1559232951269;
        Thu, 30 May 2019 09:15:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7ef9])
        by smtp.gmail.com with ESMTPSA id s42sm7645186pjc.5.2019.05.30.09.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 09:15:50 -0700 (PDT)
Date:   Thu, 30 May 2019 12:15:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix page cache convergence regression
Message-ID: <20190530161548.GA8415@cmpxchg.org>
References: <20190524153148.18481-1-hannes@cmpxchg.org>
 <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524173900.GA11702@cmpxchg.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any objections or feedback on the proposed fix below? This
is kind of a serious regression.

On Fri, May 24, 2019 at 01:39:00PM -0400, Johannes Weiner wrote:
> From 63a0dbc571ff38f7c072c62d6bc28192debe37ac Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 24 May 2019 10:12:46 -0400
> Subject: [PATCH] mm: fix page cache convergence regression
> 
> Since a28334862993 ("page cache: Finish XArray conversion"), on most
> major Linux distributions, the page cache doesn't correctly transition
> when the hot data set is changing, and leaves the new pages thrashing
> indefinitely instead of kicking out the cold ones.
> 
> On a freshly booted, freshly ssh'd into virtual machine with 1G RAM
> running stock Arch Linux:
> 
> [root@ham ~]# ./reclaimtest.sh
> + dd of=workingset-a bs=1M count=0 seek=600
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + ./mincore workingset-a
> 153600/153600 workingset-a
> + dd of=workingset-b bs=1M count=0 seek=600
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 104029/153600 workingset-a
> 120086/153600 workingset-b
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 104029/153600 workingset-a
> 120268/153600 workingset-b
> 
> workingset-b is a 600M file on a 1G host that is otherwise entirely
> idle. No matter how often it's being accessed, it won't get cached.
> 
> While investigating, I noticed that the non-resident information gets
> aggressively reclaimed - /proc/vmstat::workingset_nodereclaim. This is
> a problem because a workingset transition like this relies on the
> non-resident information tracked in the page cache tree of evicted
> file ranges: when the cache faults are refaults of recently evicted
> cache, we challenge the existing active set, and that allows a new
> workingset to establish itself.
> 
> Tracing the shrinker that maintains this memory revealed that all page
> cache tree nodes were allocated to the root cgroup. This is a problem,
> because 1) the shrinker sizes the amount of non-resident information
> it keeps to the size of the cgroup's other memory and 2) on most major
> Linux distributions, only kernel threads live in the root cgroup and
> everything else gets put into services or session groups:
> 
> [root@ham ~]# cat /proc/self/cgroup
> 0::/user.slice/user-0.slice/session-c1.scope
> 
> As a result, we basically maintain no non-resident information for the
> workloads running on the system, thus breaking the caching algorithm.
> 
> Looking through the code, I found the culprit in the above-mentioned
> patch: when switching from the radix tree to xarray, it dropped the
> __GFP_ACCOUNT flag from the tree node allocations - the flag that
> makes sure the allocated memory gets charged to and tracked by the
> cgroup of the calling process - in this case, the one doing the fault.
> 
> To fix this, allow xarray users to specify per-tree flag that makes
> xarray allocate nodes using __GFP_ACCOUNT. Then restore the page cache
> tree annotation to request such cgroup tracking for the cache nodes.
> 
> With this patch applied, the page cache correctly converges on new
> workingsets again after just a few iterations:
> 
> [root@ham ~]# ./reclaimtest.sh
> + dd of=workingset-a bs=1M count=0 seek=600
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + ./mincore workingset-a
> 153600/153600 workingset-a
> + dd of=workingset-b bs=1M count=0 seek=600
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 124607/153600 workingset-a
> 87876/153600 workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 81313/153600 workingset-a
> 133321/153600 workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 63036/153600 workingset-a
> 153600/153600 workingset-b
> 
> Cc: stable@vger.kernel.org # 4.20+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/inode.c             |  2 +-
>  include/linux/xarray.h |  1 +
>  lib/xarray.c           | 12 ++++++++++--
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index e9d18b2c3f91..cd67859dbaf1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -361,7 +361,7 @@ EXPORT_SYMBOL(inc_nlink);
>  
>  static void __address_space_init_once(struct address_space *mapping)
>  {
> -	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ);
> +	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
>  	init_rwsem(&mapping->i_mmap_rwsem);
>  	INIT_LIST_HEAD(&mapping->private_list);
>  	spin_lock_init(&mapping->private_lock);
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 0e01e6129145..5921599b6dc4 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -265,6 +265,7 @@ enum xa_lock_type {
>  #define XA_FLAGS_TRACK_FREE	((__force gfp_t)4U)
>  #define XA_FLAGS_ZERO_BUSY	((__force gfp_t)8U)
>  #define XA_FLAGS_ALLOC_WRAPPED	((__force gfp_t)16U)
> +#define XA_FLAGS_ACCOUNT	((__force gfp_t)32U)
>  #define XA_FLAGS_MARK(mark)	((__force gfp_t)((1U << __GFP_BITS_SHIFT) << \
>  						(__force unsigned)(mark)))
>  
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 6be3acbb861f..446b956c9188 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -298,6 +298,8 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
>  		xas_destroy(xas);
>  		return false;
>  	}
> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> +		gfp |= __GFP_ACCOUNT;
>  	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
>  	if (!xas->xa_alloc)
>  		return false;
> @@ -325,6 +327,8 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
>  		xas_destroy(xas);
>  		return false;
>  	}
> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> +		gfp |= __GFP_ACCOUNT;
>  	if (gfpflags_allow_blocking(gfp)) {
>  		xas_unlock_type(xas, lock_type);
>  		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
> @@ -358,8 +362,12 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
>  	if (node) {
>  		xas->xa_alloc = NULL;
>  	} else {
> -		node = kmem_cache_alloc(radix_tree_node_cachep,
> -					GFP_NOWAIT | __GFP_NOWARN);
> +		gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
> +
> +		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> +			gfp |= __GFP_ACCOUNT;
> +
> +		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
>  		if (!node) {
>  			xas_set_err(xas, -ENOMEM);
>  			return NULL;
> -- 
> 2.21.0
> 
