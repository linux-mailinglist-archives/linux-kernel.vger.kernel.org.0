Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017EA1C330
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfENGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 02:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfENGUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:20:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FD3DAD94;
        Tue, 14 May 2019 06:20:40 +0000 (UTC)
Date:   Tue, 14 May 2019 08:20:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190514062039.GB20868@dhcp22.suse.cz>
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz>
 <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
 <20190513214503.GB25356@dhcp22.suse.cz>
 <CAHbLzkpUE2wBp8UjH72ugXjWSfFY5YjV1Ps9t5EM2VSRTUKxRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpUE2wBp8UjH72ugXjWSfFY5YjV1Ps9t5EM2VSRTUKxRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-05-19 21:36:59, Yang Shi wrote:
> On Mon, May 13, 2019 at 2:45 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 13-05-19 14:09:59, Yang Shi wrote:
> > [...]
> > > I think we can just account 512 base pages for nr_scanned for
> > > isolate_lru_pages() to make the counters sane since PGSCAN_KSWAPD/DIRECT
> > > just use it.
> > >
> > > And, sc->nr_scanned should be accounted as 512 base pages too otherwise we
> > > may have nr_scanned < nr_to_reclaim all the time to result in false-negative
> > > for priority raise and something else wrong (e.g. wrong vmpressure).
> >
> > Be careful. nr_scanned is used as a pressure indicator to slab shrinking
> > AFAIR. Maybe this is ok but it really begs for much more explaining
> 
> I don't know why my company mailbox didn't receive this email, so I
> replied with my personal email.
> 
> It is not used to double slab pressure any more since commit
> 9092c71bb724 ("mm: use sc->priority for slab shrink targets"). It uses
> sc->priority to determine the pressure for slab shrinking now.
> 
> So, I think we can just remove that "double slab pressure" code. It is
> not used actually and looks confusing now. Actually, the "double slab
> pressure" does something opposite. The extra inc to sc->nr_scanned
> just prevents from raising sc->priority.

I have to get in sync with the recent changes. I am aware there were
some patches floating around but I didn't get to review them. I was
trying to point out that nr_scanned used to have a side effect to be
careful about. If it doesn't have anymore then this is getting much more
easier of course. Please document everything in the changelog.
-- 
Michal Hocko
SUSE Labs
