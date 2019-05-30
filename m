Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE62E2F76E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfE3GYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 02:24:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3GYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:24:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38A4AACA8;
        Thu, 30 May 2019 06:24:20 +0000 (UTC)
Date:   Thu, 30 May 2019 08:24:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in
 kmalloc_slab()
Message-ID: <20190530062418.GB6703@dhcp22.suse.cz>
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
 <20190529162532.GG18589@dhcp22.suse.cz>
 <CAFbcbMDJB0uNjTa9xwT9npmTdqMJ1Hez3CyeOCjjrLF2W0Wprw@mail.gmail.com>
 <20190529174931.GH18589@dhcp22.suse.cz>
 <CAFbcbMA6XjZqrgHmG70Vm_a34Rn4tKqoMgQkRBXES2r3+ymYwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFbcbMA6XjZqrgHmG70Vm_a34Rn4tKqoMgQkRBXES2r3+ymYwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please do not top-post]

On Thu 30-05-19 13:20:01, Dianzhang Chen wrote:
> It is possible that a CPU mis-predicts the conditional branch, and
> speculatively loads size_index[size_index_elem(size)], even if size >192.
> Although this value will subsequently be discarded,
> but it can not drop all the effects of speculative execution,
> such as the presence or absence of data in caches. Such effects may
> form side-channels which can be
> observed to extract secret information.

I understand the general mechanism of spectre v1. What I was asking for
is an example of where userspace directly controls the allocation size
as this is usually bounded to an in kernel object size. I can see how
and N * sizeof(object) where N is controlled by the userspace could be
the target. But calling that out explicitly would be appreciated.
 
> As for "why this particular path a needs special treatment while other
> size branches are ok",
> i think the other size branches need to treatment as well at first place,
> but in code `index = fls(size - 1)` the function `fls` will make the
> index at specific range,
> so it can not use `kmalloc_caches[kmalloc_type(flags)][index]` to load
> arbitury data.
> But, still it may load some date that it shouldn't, if necessary, i
> think can add array_index_nospec as well.

Please mention that in the changelog as well.
 
> On Thu, May 30, 2019 at 1:49 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 30-05-19 00:39:53, Dianzhang Chen wrote:
> > > It's come from `192+1`.
> > >
> > >
> > > The more code fragment is:
> > >
> > >
> > > if (size <= 192) {
> > >
> > >     if (!size)
> > >
> > >         return ZERO_SIZE_PTR;
> > >
> > >     size = array_index_nospec(size, 193);
> > >
> > >     index = size_index[size_index_elem(size)];
> > >
> > > }
> >
> > OK I see, I could have looked into the code, my bad. But I am still not
> > sure what is the potential exploit scenario and why this particular path
> > a needs special treatment while other size branches are ok. Could you be
> > more specific please?
> > --
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs
