Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32184494
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 08:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfHGGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 02:39:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfHGGjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YjFjhTuT30+WR+0Rz31alBwUHp7i7H4qDnAY2b1b5AI=; b=lkbaa7lYSH9aLDmp/+lta95zh
        cYv/jqthqjDqOT8fXUYm4bNPNrq4LjLu6duEzAr59c4Q1saRdKjHYv5jAPsO+PfbXKgcSoHlWfJ39
        Rmqo6lqvIEC5Egr/Muv2q81fQn4uh44OXRwLrfp3VxeEfEtOOc1+einn9Ek0W4a5SHXoxkmANfoSR
        Rfs2qdAj4xYSMwCRG5vXvq5dgRhD6sg2od0wq3nFWZZHqZKonyo7j210O9TxiD+QMo5QZbXcmulkf
        dv2uo2wVom57gdYdI76kbqD+6evjX+MYPgnUq6CAzlYA/w3YpamFdjf4YXV888k7fABQQNXnpyrBZ
        0VuUHFHYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvFb6-0007II-Js; Wed, 07 Aug 2019 06:38:56 +0000
Date:   Tue, 6 Aug 2019 23:38:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas@shipmail.org>, Dave Airlie <airlied@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: drm pull for v5.3-rc1
Message-ID: <20190807063856.GB6002@infradead.org>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
 <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
 <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
 <CAHk-=wghASUU7QmoibQK7XS09na7rDRrjSrWPwkGz=qLnGp_Xw@mail.gmail.com>
 <20190806073831.GA26668@infradead.org>
 <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:50:42AM -0700, Linus Torvalds wrote:
> 
> In fact, I do note that a lot of the users don't actually use the
> "void *private" argument at all - they just want the walker - and just
> pass in a NULL private pointer. So we have things like this:
> 
> > +       if (walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
> > +                       NULL)) {
> 
> and in a perfect world we'd have arguments with default values so that
> we could skip those entirely for when people just don't need it.
> 
> I'm not a huge fan of C++ because of a lot of the complexity (and some
> really bad decisions), but many of the _syntactic_ things in C++ would
> be nice to use. This one doesn't seem to be one that the gcc people
> have picked up as an extension ;(
> 
> Yes, yes, we could do it with a macro, I guess.
> 
>    #define walk_page_range(mm, start,end, ops, ...) \
>        __walk_page_range(mm, start, end, (NULL , ## __VA_ARGS__))
> 
> but I'm not sure it's worthwhile.

Given that is is just a single argument I'm not to worried.  A simpler
and a more complex variant seems more useful if we can skip a few
arguments IMHO.
