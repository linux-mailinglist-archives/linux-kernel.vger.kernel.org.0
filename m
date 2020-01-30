Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05F14D64D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 07:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgA3F4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 00:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgA3F4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:56:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5052067C;
        Thu, 30 Jan 2020 05:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580363813;
        bh=Pho2pgnIvXzlEFmTkvMPEldeg1wJfFK8dEM29Uqk7CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjhZTFy5BraERTei6q58aYcKcXFMZJNlItkA3AQNLC5RYtYLNyJK7h89n0TEI79c0
         RZupZ+/qyYnDvRpHfxFoxmTYhGIwSfnkoi3rpRvCsV4FYudnai/GkgEsdrakgCfRIs
         KizJn8RHJy73hntL7L1y5DAAy1/15a2DRj7KXOhE=
Date:   Thu, 30 Jan 2020 06:56:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpet: Fix struct_size() in kzalloc()
Message-ID: <20200130055650.GA623220@kroah.com>
References: <202001300450.00U4ocvS083098@www262.sakura.ne.jp>
 <20200130052645.GA833@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130052645.GA833@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 09:26:45PM -0800, Eric Biggers wrote:
> On Thu, Jan 30, 2020 at 01:50:38PM +0900, Tetsuo Handa wrote:
> > Gustavo A. R. Silva wrote:
> > > > Are you sure the allocation size is the same again?  Much like the
> > > > n_hdlc patch was, I think you need to adjust the variable size here.
> > > > Maybe, it's a bit of a pain to figure out at a quick glance, I just want
> > > > to make sure you at least do look at that :)
> > > > 
> > > 
> > > Yep. The allocation thing was already handled almost a year ago by the
> > > following patch, and it didn't require to increase the size at that time:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=401c9bd10beef4b030eb9e34d16b5341dc6c683b
> > > 
> > 
> > Nope. KASAN splat began because allocation size calculation is wrong.
> > 
> > [    8.319936] ==================================================================
> > [    8.319936] BUG: KASAN: slab-out-of-bounds in hpet_alloc+0x41d/0xdf0
> > [    8.319936] Write of size 4 at addr ffff8881e6156928 by task swapper/0/1
> > 
> > [    8.319936] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0+ #248
> > [    8.319936] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
> > [    8.319936] Call Trace:
> > [    8.319936]  dump_stack+0x163/0x1d5
> > [    8.319936]  print_address_description.constprop.6+0x1e8/0x3a0
> > [    8.319936]  ? hpet_alloc+0x41d/0xdf0
> > [    8.319936]  __kasan_report+0x143/0x1a0
> > [    8.319936]  ? hpet_alloc+0x41d/0xdf0
> > [    8.319936]  ? hpet_alloc+0x41d/0xdf0
> > [    8.319936]  kasan_report+0x12/0x20
> > [    8.319936]  __asan_report_store4_noabort+0x17/0x20
> > [    8.319936]  hpet_alloc+0x41d/0xdf0
> > [    8.319936]  hpet_reserve_platform_timers+0x1eb/0x22f
> > [    8.319936]  ? hpet_setup+0xd1/0xd1
> > [    8.319936]  hpet_late_init+0x2f2/0x386
> > [    8.319936]  ? setup_unknown_nmi_panic+0x15/0x15
> > [    8.319936]  ? hpet_enable+0x6fa/0x6fa
> > [    8.319936]  do_one_initcall+0xf6/0x6c0
> > [    8.319936]  ? perf_trace_initcall_level+0x3f0/0x3f0
> > [    8.319936]  ? rcu_read_lock_sched_held+0x9c/0xd0
> > [    8.319936]  ? rcu_read_lock_bh_held+0xb0/0xb0
> > [    8.319936]  ? __kasan_check_write+0x14/0x20
> > [    8.319936]  ? __kasan_check_read+0x11/0x20
> > [    8.319936]  kernel_init_freeable+0x4b0/0x531
> > [    8.319936]  ? rest_init+0x2f0/0x2f0
> > [    8.319936]  kernel_init+0x13/0x180
> > [    8.319936]  ? rest_init+0x2f0/0x2f0
> > [    8.319936]  ret_from_fork+0x24/0x30
> > 
> > [    8.319936] Allocated by task 1:
> > [    8.319936]  save_stack+0x21/0x80
> > [    8.319936]  __kasan_kmalloc.constprop.7+0xab/0xe0
> > [    8.319936]  kasan_kmalloc+0x9/0x10
> > [    8.319936]  __kmalloc+0x17c/0x810
> > [    8.319936]  hpet_alloc+0x1b4/0xdf0
> > [    8.319936]  hpet_reserve_platform_timers+0x1eb/0x22f
> > [    8.319936]  hpet_late_init+0x2f2/0x386
> > [    8.319936]  do_one_initcall+0xf6/0x6c0
> > [    8.319936]  kernel_init_freeable+0x4b0/0x531
> > [    8.319936]  kernel_init+0x13/0x180
> > [    8.319936]  ret_from_fork+0x24/0x30
> > 
> > [    8.319936] Freed by task 0:
> > [    8.319936] (stack is not available)
> > 
> > [    8.319936] The buggy address belongs to the object at ffff8881e6156000
> >                 which belongs to the cache kmalloc-4k of size 4096
> > [    8.319936] The buggy address is located 2344 bytes inside of
> >                 4096-byte region [ffff8881e6156000, ffff8881e6157000)
> > [    8.319936] The buggy address belongs to the page:
> > [    8.319936] page:ffffea0007985580 refcount:1 mapcount:0 mapping:ffff8881f3802000 index:0x0 compound_mapcount: 0
> > [    8.319936] raw: 02fffc0000010200 ffffea0007985408 ffff8881f3801a48 ffff8881f3802000
> > [    8.319936] raw: 0000000000000000 ffff8881e6156000 0000000100000001 0000000000000000
> > [    8.319936] page dumped because: kasan: bad access detected
> > 
> > [    8.319936] Memory state around the buggy address:
> > [    8.320001]  ffff8881e6156800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [    8.320096]  ffff8881e6156880: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> > [    8.320190] >ffff8881e6156900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [    8.320284]                                   ^
> > [    8.320349]  ffff8881e6156980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [    8.320444]  ffff8881e6156a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [    8.320537] ==================================================================
> > [    8.320631] Disabling lock debugging due to kernel taint
> > 
> > We need a patch shown below.
> > 
> > 
> > 
> > >From 2607c3e719bb526e976a88ea8a2f3475688eadb5 Mon Sep 17 00:00:00 2001
> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date: Thu, 30 Jan 2020 13:43:23 +0900
> > Subject: [PATCH] hpet: Fix struct_size() in kzalloc()
> > 
> > Changing "struct hpet_dev hp_dev[1]" to "struct hpet_dev hp_dev[]"
> > reduces structure size by sizeof(struct hpet_dev) bytes. We need to
> > compensate it at struct_size().
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Fixes: 987f028b8637cfa7 ("char: hpet: Use flexible-array member")
> > ---
> >  drivers/char/hpet.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> > index aed2c45f7968..ed3b7dab678d 100644
> > --- a/drivers/char/hpet.c
> > +++ b/drivers/char/hpet.c
> > @@ -855,7 +855,7 @@ int hpet_alloc(struct hpet_data *hdp)
> >  		return 0;
> >  	}
> >  
> > -	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs - 1),
> > +	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs),
> >  			GFP_KERNEL);
> >  
> >  	if (!hpetp)
> > -- 
> 
> Yep, "char: hpet: Use flexible-array member" started causing random boot
> failures on mainline for me.  Tetsuo beat me to sending the fix.
> 
> Only thing I'll add is that GFP_KERNEL can now fit on the previous line.

Gustavo already sent a fix for this, I didn't realize it was causing
boot problems, I'll forward it on to Linus soon.

thanks,

greg k-h
