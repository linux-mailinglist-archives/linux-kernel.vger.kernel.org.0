Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86C2C1FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 13:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfI3L2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 07:28:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfI3L2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:28:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7A39AEAE;
        Mon, 30 Sep 2019 11:28:17 +0000 (UTC)
Date:   Mon, 30 Sep 2019 13:28:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20190930112817.GC15942@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 28-09-19 13:59:26, Linus Torvalds wrote:
> On Fri, Sep 27, 2019 at 12:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > -       page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> > +       if (!order)
> > +               page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> >         if (page)
> >                 goto got_pg;
> >
> > The whole point of handling this in the page allocator directly is to
> > have a unified solutions rather than have each specific caller invent
> > its own way to achieve higher locality.
> 
> The above just looks hacky.

It is and it was meant to help move on when debugging rather than a
final solution.
 
> Why would order-0 be special?

Ideally it wouldn't be but the current implementation makes it special.
Why? Because the whole concept of low wmark fast path attempt is based
on kswapd balancing for a high watermark providing some space. Kcompactd
doesn't have any notion like that. And I believe that a large part of
the problem really is there. If I am wrong here then I would appreciate
to be corrected.

If __GFP_THISNODE allows for a better THP utilization on a local node
then the problem points at kcompactd not being pro-active enough. And
that was the first diff aiming at.

I also claim that this is not a THP specific problem. You are right
that lower orders are less likely to hit the problem because the memory
is usually not fragmented that heavily but fundamentally the over eager
fallback in the fast path is still there. And that is the reason for me
to pushback against __GFP_THIS_NODE && fallback allocation opencoded
outside of the allocator. The allocator knows the context can compact
so why should we require the caller to be doing that?

Do not get me wrong, but we have a quite a long history of fine tuning
for THP by adding kludges here and there and they usually turnout to
break something else. I really want to get to understand the underlying
problem and base a solution on it rather than "__GFP_THISNODE can cause
overreclaim so pick up a break out condition and hope for the best".
-- 
Michal Hocko
SUSE Labs
