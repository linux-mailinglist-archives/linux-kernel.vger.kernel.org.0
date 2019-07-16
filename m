Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48526AFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfGPTVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 15:21:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38717 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:21:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so20798556qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dazy32K9kj9n+ylitO8+oLTMrnW27hmM0+svC5zAqu4=;
        b=Og3iNMAN/OReC0h8Zy6KNLnRIMxOBh25A2r1f4m6CTZKsj6XHDKSJ9mvbSnGWIPus6
         ZG37/AN4brgULiLHg8PT0/Krbu3rFll1yqhc2WZKm3xRBE7I88zumhf0KqstM/WJbrFa
         DywxLRN2pWPbDmiTflAWaXIgm1AR3pjnnkH4uIzpVWiD7yZApwXE8556U3n/l6bTfwlQ
         NDiZOXz6ZRH348rpQvo/p+9pFFKNcDJE9XA92XlUng1DWlIaw2K34o4tBRtC7nhF47Ic
         VdnDhRv+amjsS/mOOOeo2VG2dwDBdEO33kaWrYok7EHiL2Uqn9c5VxcZtCdSiEJzvckf
         snkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dazy32K9kj9n+ylitO8+oLTMrnW27hmM0+svC5zAqu4=;
        b=rztZiYCb0tVpcfW4UPQINvupCNr68zyCatNTmGJdPDgeyWa3iogjprA3+1LX9bToG4
         m6htoF4lAPDo0QQjVNl54+M/5y1wBxx7PSXpPgxFj6MbqeYtG0tcraFx+ePo5mmk73aH
         nhn8SKJA8AWPXLXAQy31Nj8SX8r5enLpZQ2KL2MpSSMjPEuQMzEQISw8lCRP4w3rqgrM
         eCsYM6LnqYyx2Poac0Re42L9ty3M7aN40CJI2KNo8jPqZeHECUBaQG32rl2YVHFw5vT9
         HNscVvBFZ0WeQIszDZr7tPegPgp+peGBUt7L602sMV19YfKean4VoPoRUyjgeALdtEbR
         aN8A==
X-Gm-Message-State: APjAAAVwgr53/ufOITYTx1yBAzyb/5NZTmSi/VHvfxL8R4XZBFk4bJAs
        pi0vYy1a7HHP1dXvUqY5PyuARw==
X-Google-Smtp-Source: APXvYqwwjj1IWyEWlBQ5HrZSL7JNZQErZe7PN1ZOvQQVX2SRbXq5qo6gxY5lJ5R5eUUQfnTXyJuNPg==
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr24450214qvf.93.1563304879619;
        Tue, 16 Jul 2019 12:21:19 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k25sm7474452qta.78.2019.07.16.12.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 12:21:19 -0700 (PDT)
Message-ID: <1563304877.4610.10.camel@lca.pw>
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
From:   Qian Cai <cai@lca.pw>
To:     Yang Shi <yang.shi@linux.alibaba.com>, catalin.marinas@arm.com,
        mhocko@suse.com, dvyukov@google.com, rientjes@google.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 Jul 2019 15:21:17 -0400
In-Reply-To: <a198d00d-d1f4-0d73-8eb8-6667c0bdac04@linux.alibaba.com>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
         <1563301410.4610.8.camel@lca.pw>
         <a198d00d-d1f4-0d73-8eb8-6667c0bdac04@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 12:01 -0700, Yang Shi wrote:
> 
> On 7/16/19 11:23 AM, Qian Cai wrote:
> > On Wed, 2019-07-17 at 01:50 +0800, Yang Shi wrote:
> > > When running ltp's oom test with kmemleak enabled, the below warning was
> > > triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> > > passed in:
> > > 
> > > WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608
> > > __alloc_pages_nodemask+0x1c31/0x1d50
> > > Modules linked in: loop dax_pmem dax_pmem_core ip_tables x_tables xfs
> > > virtio_net net_failover virtio_blk failover ata_generic virtio_pci
> > > virtio_ring
> > > virtio libata
> > > CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-
> > > g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> > > RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
> > > ...
> > >   kmemleak_alloc+0x4e/0xb0
> > >   kmem_cache_alloc+0x2a7/0x3e0
> > >   ? __kmalloc+0x1d6/0x470
> > >   ? ___might_sleep+0x9c/0x170
> > >   ? mempool_alloc+0x2b0/0x2b0
> > >   mempool_alloc_slab+0x2d/0x40
> > >   mempool_alloc+0x118/0x2b0
> > >   ? __kasan_check_read+0x11/0x20
> > >   ? mempool_resize+0x390/0x390
> > >   ? lock_downgrade+0x3c0/0x3c0
> > >   bio_alloc_bioset+0x19d/0x350
> > >   ? __swap_duplicate+0x161/0x240
> > >   ? bvec_alloc+0x1b0/0x1b0
> > >   ? do_raw_spin_unlock+0xa8/0x140
> > >   ? _raw_spin_unlock+0x27/0x40
> > >   get_swap_bio+0x80/0x230
> > >   ? __x64_sys_madvise+0x50/0x50
> > >   ? end_swap_bio_read+0x310/0x310
> > >   ? __kasan_check_read+0x11/0x20
> > >   ? check_chain_key+0x24e/0x300
> > >   ? bdev_write_page+0x55/0x130
> > >   __swap_writepage+0x5ff/0xb20
> > > 
> > > The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, however kmemleak has
> > > __GFP_NOFAIL set all the time due to commit
> > > d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
> > > with fault injection").  But, it doesn't make any sense to have
> > > __GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM specified at the same time.
> > > 
> > > According to the discussion on the mailing list, the commit should be
> > > reverted for short term solution.  Catalin Marinas would follow up with a
> > > better
> > > solution for longer term.
> > > 
> > > The failure rate of kmemleak metadata allocation may increase in some
> > > circumstances, but this should be expected side effect.
> > 
> > As mentioned in anther thread, the situation for kmemleak under memory
> > pressure
> > has already been unhealthy. I don't feel comfortable to make it even worse
> > by
> > reverting this commit alone. This could potentially make kmemleak kill
> > itself
> > easier and miss some more real memory leak later.
> > 
> > To make it really a short-term solution before the reverting, I think
> > someone
> > needs to follow up with the mempool solution with tunable pool size
> > mentioned
> > in,
> > 
> > https://lore.kernel.org/linux-mm/20190328145917.GC10283@arrakis.emea.arm.com
> > /
> > 
> > I personally not very confident that Catalin will find some time soon to
> > implement embedding kmemleak metadata into the slab. Even he or someone does
> > eventually, it probably need quite some time to test and edge out many of
> > corner
> > cases that kmemleak could have by its natural.
> 
> Thanks for sharing some background. I didn't notice this topic had been 
> discussed. I'm not sure if this revert would make things worse since I'm 
> supposed real memory leak would be detected sooner before oom kicks in, 
> and kmemleak is already broken with __GFP_NOFAIL.

Well, people could inject some memory pressure at the middle of a test run. OOM
does not necessarily mean kmemleak would always be disabled, as it sometimes
could survive if the memory is recovering fast enough.

Thanks to this commit, there are allocation with __GFP_DIRECT_RECLAIM that
succeeded would keep trying with __GFP_NOFAIL for kmemleak tracking object
allocations. Otherwise, one kmemleak object allocation failure would kill the
whole kmemleak.

> 
> It seems everyone agree __GFP_NPFAIL should be removed? Anyway, I would 
> like leave the decision to Catalin.
> 
> > 
> > > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Qian Cai <cai@lca.pw>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > >   mm/kmemleak.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > > index 9dd581d..884a5e3 100644
> > > --- a/mm/kmemleak.c
> > > +++ b/mm/kmemleak.c
> > > @@ -114,7 +114,7 @@
> > >   /* GFP bitmask for kmemleak internal allocations */
> > >   #define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL |
> > > GFP_ATOMIC)) |
> > > \
> > >   				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
> > > -				 __GFP_NOWARN | __GFP_NOFAIL)
> > > +				 __GFP_NOWARN)
> > >   
> > >   /* scanning area inside a memory block */
> > >   struct kmemleak_scan_area {
> 
> 
