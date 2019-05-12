Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC6D1ACB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfELPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 11:07:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfELPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:07:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66B913086275;
        Sun, 12 May 2019 15:07:28 +0000 (UTC)
Received: from redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84A3860C47;
        Sun, 12 May 2019 15:07:26 +0000 (UTC)
Date:   Sun, 12 May 2019 11:07:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call
 hmm_range_unregister()
Message-ID: <20190512150724.GA4238@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-5-rcampbell@nvidia.com>
 <CAFqt6zbhLQuw2N5-=Nma-vHz1BkWjviOttRsPXmde8U1Oocz0Q@mail.gmail.com>
 <fa2078fd-3ec7-5503-94d7-c4d1a766029a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2078fd-3ec7-5503-94d7-c4d1a766029a@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 12 May 2019 15:07:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:12:14AM -0700, Ralph Campbell wrote:
> 
> On 5/7/19 6:15 AM, Souptick Joarder wrote:
> > On Tue, May 7, 2019 at 5:00 AM <rcampbell@nvidia.com> wrote:
> > > 
> > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > The helper function hmm_vma_fault() calls hmm_range_register() but is
> > > missing a call to hmm_range_unregister() in one of the error paths.
> > > This leads to a reference count leak and ultimately a memory leak on
> > > struct hmm.
> > > 
> > > Always call hmm_range_unregister() if hmm_range_register() succeeded.
> > 
> > How about * Call hmm_range_unregister() in error path if
> > hmm_range_register() succeeded* ?
> 
> Sure, sounds good.
> I'll include that in v2.

NAK for the patch see below why

> 
> > > 
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >   include/linux/hmm.h | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > > index 35a429621e1e..fa0671d67269 100644
> > > --- a/include/linux/hmm.h
> > > +++ b/include/linux/hmm.h
> > > @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> > >                  return (int)ret;
> > > 
> > >          if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> > > +               hmm_range_unregister(range);
> > >                  /*
> > >                   * The mmap_sem was taken by driver we release it here and
> > >                   * returns -EAGAIN which correspond to mmap_sem have been
> > > @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> > > 
> > >          ret = hmm_range_fault(range, block);
> > >          if (ret <= 0) {
> > > +               hmm_range_unregister(range);
> > 
> > what is the reason to moved it up ?
> 
> I moved it up because the normal calling pattern is:
>     down_read(&mm->mmap_sem)
>     hmm_vma_fault()
>         hmm_range_register()
>         hmm_range_fault()
>         hmm_range_unregister()
>     up_read(&mm->mmap_sem)
> 
> I don't think it is a bug to unlock mmap_sem and then unregister,
> it is just more consistent nesting.

So this is not the usage pattern with HMM usage pattern is:

hmm_range_register()
hmm_range_fault()
hmm_range_unregister()

The hmm_vma_fault() is gonne so this patch here break thing.

See https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.2-v3


