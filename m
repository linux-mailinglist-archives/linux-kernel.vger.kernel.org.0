Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63F190B74
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgCXKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 06:51:36 -0400
Received: from foss.arm.com ([217.140.110.172]:60588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgCXKvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:51:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24C4230E;
        Tue, 24 Mar 2020 03:51:35 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E6B23F792;
        Tue, 24 Mar 2020 03:51:34 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:51:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: lockdep warning in sys_swapon
Message-ID: <20200324105130.vdihr6kvbzcfrbda@e107158-lin>
References: <20200323151725.gayvs5g6h5adwqkd@e107158-lin.cambridge.arm.com>
 <20200323153045.s7ag3lrvfe2cpiiw@e107158-lin.cambridge.arm.com>
 <20200323140615.75e3c7481f4c6aeb94c95ba9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323140615.75e3c7481f4c6aeb94c95ba9@linux-foundation.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 14:06, Andrew Morton wrote:
> On Mon, 23 Mar 2020 15:30:45 +0000 Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > On 03/23/20 15:17, Qais Yousef wrote:
> > > Hi
> > > 
> > > I hit the following 2 warnings when running with LOCKDEP=y on arm64 platform
> > > (juno-r2), running on v5.6-rc6
> > > 
> > > The 1st one is when I execute `swapon -a`. The 2nd one happens at boot. I have
> > > /dev/sda2 as my swap in /etc/fstab
> > > 
> > > Note that I either hit 1 OR 2, but didn't hit both warnings at the same time,
> > > yet at least.
> > > 
> > > /dev/sda2 is a usb flash drive, in case it matters somehow.
> > 
> > By the way, I noticed that in claim_swapfile() if we fail we don't release the
> > lock. Shouldn't we release the lock here?
> > 
> > I tried with that FWIW, but it had no effect on the warnings.
> > 
> 
> I'll be sending the below into Linus this week.
> 
> I was hoping to hear from Darrick/Christoph (?) but it looks like the
> right thing to do.  Are you able to test it?
> 
> I think I'll add a cc:stable to this one.
> 
> 
> 
> From: Naohiro Aota <naohiro.aota@wdc.com>
> Subject: mm/swapfile.c: move inode_lock out of claim_swapfile
> 
> claim_swapfile() currently keeps the inode locked when it is successful,
> or the file is already swapfile (with -EBUSY).  And, on the other error
> cases, it does not lock the inode.
> 
> This inconsistency of the lock state and return value is quite confusing
> and actually causing a bad unlock balance as below in the "bad_swap"
> section of __do_sys_swapon().
> 
> This commit fixes this issue by moving the inode_lock() and IS_SWAPFILE
> check out of claim_swapfile().  The inode is unlocked in
> "bad_swap_unlock_inode" section, so that the inode is ensured to be
> unlocked at "bad_swap".  Thus, error handling codes after the locking now
> jumps to "bad_swap_unlock_inode" instead of "bad_swap".
> 
>     =====================================
>     WARNING: bad unlock balance detected!
>     5.5.0-rc7+ #176 Not tainted
>     -------------------------------------
>     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
>     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
>     but there are no more locks to release!
> 
>     other info that might help us debug this:
>     no locks held by swapon/4294.
> 
>     stack backtrace:
>     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
>     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
>     Call Trace:
>      dump_stack+0xa1/0xea
>      ? __do_sys_swapon+0x94b/0x3550
>      print_unlock_imbalance_bug.cold+0x114/0x123
>      ? __do_sys_swapon+0x94b/0x3550
>      lock_release+0x562/0xed0
>      ? kvfree+0x31/0x40
>      ? lock_downgrade+0x770/0x770
>      ? kvfree+0x31/0x40
>      ? rcu_read_lock_sched_held+0xa1/0xd0
>      ? rcu_read_lock_bh_held+0xb0/0xb0
>      up_write+0x2d/0x490
>      ? kfree+0x293/0x2f0
>      __do_sys_swapon+0x94b/0x3550
>      ? putname+0xb0/0xf0
>      ? kmem_cache_free+0x2e7/0x370
>      ? do_sys_open+0x184/0x3e0
>      ? generic_max_swapfile_size+0x40/0x40
>      ? do_syscall_64+0x27/0x4b0
>      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>      ? lockdep_hardirqs_on+0x38c/0x590
>      __x64_sys_swapon+0x54/0x80
>      do_syscall_64+0xa4/0x4b0
>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     RIP: 0033:0x7f15da0a0dc7
> 
> Link: http://lkml.kernel.org/r/20200206090132.154869-1-naohiro.aota@wdc.com
> Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

With this patch applied I can no longer reproduce the problem.

Tested-by: Qais Youef <qais.yousef@arm.com>

Thanks!

--
Qais Yousef

> 
>  mm/swapfile.c |   41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> --- a/mm/swapfile.c~mm-swap-move-inode_lock-out-of-claim_swapfile
> +++ a/mm/swapfile.c
> @@ -2899,10 +2899,6 @@ static int claim_swapfile(struct swap_in
>  		p->bdev = inode->i_sb->s_bdev;
>  	}
>  
> -	inode_lock(inode);
> -	if (IS_SWAPFILE(inode))
> -		return -EBUSY;
> -
>  	return 0;
>  }
>  
> @@ -3157,36 +3153,41 @@ SYSCALL_DEFINE2(swapon, const char __use
>  	mapping = swap_file->f_mapping;
>  	inode = mapping->host;
>  
> -	/* will take i_rwsem; */
>  	error = claim_swapfile(p, inode);
>  	if (unlikely(error))
>  		goto bad_swap;
>  
> +	inode_lock(inode);
> +	if (IS_SWAPFILE(inode)) {
> +		error = -EBUSY;
> +		goto bad_swap_unlock_inode;
> +	}
> +
>  	/*
>  	 * Read the swap header.
>  	 */
>  	if (!mapping->a_ops->readpage) {
>  		error = -EINVAL;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  	page = read_mapping_page(mapping, 0, swap_file);
>  	if (IS_ERR(page)) {
>  		error = PTR_ERR(page);
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  	swap_header = kmap(page);
>  
>  	maxpages = read_swap_header(p, swap_header, inode);
>  	if (unlikely(!maxpages)) {
>  		error = -EINVAL;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	/* OK, set up the swap map and apply the bad block list */
>  	swap_map = vzalloc(maxpages);
>  	if (!swap_map) {
>  		error = -ENOMEM;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
> @@ -3211,7 +3212,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>  					GFP_KERNEL);
>  		if (!cluster_info) {
>  			error = -ENOMEM;
> -			goto bad_swap;
> +			goto bad_swap_unlock_inode;
>  		}
>  
>  		for (ci = 0; ci < nr_cluster; ci++)
> @@ -3220,7 +3221,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>  		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
>  		if (!p->percpu_cluster) {
>  			error = -ENOMEM;
> -			goto bad_swap;
> +			goto bad_swap_unlock_inode;
>  		}
>  		for_each_possible_cpu(cpu) {
>  			struct percpu_cluster *cluster;
> @@ -3234,13 +3235,13 @@ SYSCALL_DEFINE2(swapon, const char __use
>  
>  	error = swap_cgroup_swapon(p->type, maxpages);
>  	if (error)
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  
>  	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
>  		cluster_info, maxpages, &span);
>  	if (unlikely(nr_extents < 0)) {
>  		error = nr_extents;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  	/* frontswap enabled? set up bit-per-page map for frontswap */
>  	if (IS_ENABLED(CONFIG_FRONTSWAP))
> @@ -3280,7 +3281,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>  
>  	error = init_swap_address_space(p->type, maxpages);
>  	if (error)
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  
>  	/*
>  	 * Flush any pending IO and dirty mappings before we start using this
> @@ -3290,7 +3291,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>  	error = inode_drain_writes(inode);
>  	if (error) {
>  		inode->i_flags &= ~S_SWAPFILE;
> -		goto bad_swap;
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	mutex_lock(&swapon_mutex);
> @@ -3315,6 +3316,8 @@ SYSCALL_DEFINE2(swapon, const char __use
>  
>  	error = 0;
>  	goto out;
> +bad_swap_unlock_inode:
> +	inode_unlock(inode);
>  bad_swap:
>  	free_percpu(p->percpu_cluster);
>  	p->percpu_cluster = NULL;
> @@ -3322,6 +3325,7 @@ bad_swap:
>  		set_blocksize(p->bdev, p->old_block_size);
>  		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>  	}
> +	inode = NULL;
>  	destroy_swap_extents(p);
>  	swap_cgroup_swapoff(p->type);
>  	spin_lock(&swap_lock);
> @@ -3333,13 +3337,8 @@ bad_swap:
>  	kvfree(frontswap_map);
>  	if (inced_nr_rotate_swap)
>  		atomic_dec(&nr_rotate_swap);
> -	if (swap_file) {
> -		if (inode) {
> -			inode_unlock(inode);
> -			inode = NULL;
> -		}
> +	if (swap_file)
>  		filp_close(swap_file, NULL);
> -	}
>  out:
>  	if (page && !IS_ERR(page)) {
>  		kunmap(page);
> _
> 
