Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742988EE63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfHOOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:38:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43908 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfHOOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:38:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so1960785qkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNrMF/uU1bNfvkdgF74Cua5rMx69GIS6m4JXv8+fHak=;
        b=XnFf3BH105JLrwSSPLnlMStnXLEm7eHDNv2oomajK/Ybv809VU4soaSuvYD1TD7VSI
         MIirezR57bfSFb4WaBjePGwtVqJBvLc8HYIm8CQlxzDgGuFT9drXu/rOQA54w+kVgzaP
         fvAUCocOeA2I5HJKBeDM2pb5hx2cZfivgf3rrjq6F+c0VVywo+/UDfFIOkt02YIk+X9/
         2dVQ6wjna9i0ewdzm0w+BzK471JyIW33cus7Md5bUPLhnitYZ5H0wjbovbgDRhxVXZZU
         pYAtaJjNT0gpe9G55FwQNHSb2Ar2gczUjkeuoQkYNRfnDDTkOQiGfxOzNZ+HLDwMpHQf
         izfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNrMF/uU1bNfvkdgF74Cua5rMx69GIS6m4JXv8+fHak=;
        b=CVbEORPhgRTdG8UOejSkTJ186HfbAZs07/XPQKCk3d4/JgXZ7If7I7FGljNaJAb3+L
         vdJp6crAUlPjCr+7dqLvEC6+xgeMmrjoedxaitZ7ctA8Cu/S/tHL1xUbynluPCDEkziL
         vF20XyGndXGyyeG54lokGGPL7dRAgtaYeRg+Fbua+nb70p/w+J9maT0m6P1DBML/CBM8
         IJsDEJqZLyf0tMYlo9kfE6A09tEgw9JyJ3UlqCBXr9kdWA9IrzVzYQ8HpAtfMjnT8qUo
         yy6wFRoEyNtGv/g2J9omG9qSB5whgArHWbTxBSNpmfPb5sp3ItqKU+DNEc7AaN5P3Xtq
         txXA==
X-Gm-Message-State: APjAAAVK8t9brBsTOM8QV9oLoqkaQtNmBTYwrD5g1WDCWkxS+hw5usn0
        P/6DlC70lru1d4mCY6c3jzK7lQ==
X-Google-Smtp-Source: APXvYqyrLUurfa+j/pK7k5WY8Y78wjqUesLo+WjaUZ5NQgAZCAzL488QQTrcCxHIE4RpT+716qDyEA==
X-Received: by 2002:ae9:e8d6:: with SMTP id a205mr4069811qkg.241.1565879880315;
        Thu, 15 Aug 2019 07:38:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u16sm1430477qkj.107.2019.08.15.07.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 07:37:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyGt5-0005At-Fn; Thu, 15 Aug 2019 11:37:59 -0300
Date:   Thu, 15 Aug 2019 11:37:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815143759.GG21596@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz>
 <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:12:11PM +0200, Daniel Vetter wrote:
> On Thu, Aug 15, 2019 at 3:04 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Aug 15, 2019 at 10:44:29AM +0200, Michal Hocko wrote:
> >
> > > As the oom reaper is the primary guarantee of the oom handling forward
> > > progress it cannot be blocked on anything that might depend on blockable
> > > memory allocations. These are not really easy to track because they
> > > might be indirect - e.g. notifier blocks on a lock which other context
> > > holds while allocating memory or waiting for a flusher that needs memory
> > > to perform its work.
> >
> > But lockdep *does* track all this and fs_reclaim_acquire() was created
> > to solve exactly this problem.
> >
> > fs_reclaim is a lock and it flows through all the usual lockdep
> > schemes like any other lock. Any time the page allocator wants to do
> > something the would deadlock with reclaim it takes the lock.
> >
> > Failure is expressed by a deadlock cycle in the lockdep map, and
> > lockdep can handle arbitary complexity through layers of locks, work
> > queues, threads, etc.
> >
> > What is missing?
> 
> Lockdep doens't seen everything by far. E.g. a wait_event will be
> caught by the annotations here, but not by lockdep. 

Sure, but the wait_event might be OK if its progress isn't contingent
on fs_reclaim, ie triggered from interrupt, so why ban it?

> And since we're talking about mmu notifiers here and gpus/dma engines.
> We have dma_fence_wait, which can wait for any hw/driver in the system
> that takes part in shared/zero-copy buffer processing. Which at least
> on the graphics side is everything. This pulls in enormous amounts of
> deadlock potential that lockdep simply is blind about and will never
> see.

It seems very risky to entagle a notifier widely like that.

It looks pretty sure that notifiers are fs_reclaim, so at a minimum
that wait_event can't be contingent on anything that is doing
GFP_KERNEL or it will deadlock - and blockable doesn't make that sleep
safe.

Avoiding an uncertain wait_event under notifiers would seem to be the
only reasonable design here..

Jason
