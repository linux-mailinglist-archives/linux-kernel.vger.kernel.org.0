Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371B85D9F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 02:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGCA6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 20:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfGCA6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:58:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E86B218BA;
        Tue,  2 Jul 2019 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562102371;
        bh=Tlj2RrGNaOqOZ+7sngsROh+dPsr/HURv8KYaqPdX2Tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mTmZs1yoM8R9sJY0ieO8eIQJr3f8HYOWvQ3AMF5RJaDSv2pSaZaihzF+/IR3zRzS1
         c1Lo86AgdvNT8xO+Z6NMAKkcwx8Bv9Q2MIOWKOkhIYBQdrBruYLu3rZABrPfWQySrt
         4Gaz5KQ1vRA5wuFWuTaH2vEnRIcEeE+JF2BKSBmI=
Date:   Tue, 2 Jul 2019 14:19:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Henry Burns <henryburns@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before
 __SetPageMovable()
Message-Id: <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org>
In-Reply-To: <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
References: <20190702005122.41036-1-henryburns@google.com>
        <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
        <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 18:16:30 -0700 Henry Burns <henryburns@google.com> wrote:

> Cc: Vitaly Wool <vitalywool@gmail.com>, Vitaly Vul <vitaly.vul@sony.com>

Are these the same person?

> Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
> Date: Mon, 1 Jul 2019 18:16:30 -0700
> 
> On Mon, Jul 1, 2019 at 6:00 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Mon, Jul 1, 2019 at 5:51 PM Henry Burns <henryburns@google.com> wrote:
> > >
> > > __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> > > lock the page. Following zsmalloc.c's example we call trylock_page() and
> > > unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> > > passed in locked, as documentation.

The changelog still doesn't mention that this bug triggers a
VM_BUG_ON_PAGE().  It should do so.  I did this:

: __SetPageMovable() expects its page to be locked, but z3fold.c doesn't
: lock the page.  This triggers the VM_BUG_ON_PAGE(!PageLocked(page), page)
: in __SetPageMovable().
:
: Following zsmalloc.c's example we call trylock_page() and unlock_page(). 
: Also make z3fold_page_migrate() assert that newpage is passed in locked,
: as per the documentation.

I'll add a cc:stable to this fix.

> > > Signed-off-by: Henry Burns <henryburns@google.com>
> > > Suggested-by: Vitaly Wool <vitalywool@gmail.com>
> > > ---
> > >  Changelog since v1:
> > >  - Added an if statement around WARN_ON(trylock_page(page)) to avoid
> > >    unlocking a page locked by a someone else.
> > >
> > >  mm/z3fold.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > > index e174d1549734..6341435b9610 100644
> > > --- a/mm/z3fold.c
> > > +++ b/mm/z3fold.c
> > > @@ -918,7 +918,10 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
> > >                 set_bit(PAGE_HEADLESS, &page->private);
> > >                 goto headless;
> > >         }
> > > -       __SetPageMovable(page, pool->inode->i_mapping);
> > > +       if (!WARN_ON(!trylock_page(page))) {
> > > +               __SetPageMovable(page, pool->inode->i_mapping);
> > > +               unlock_page(page);
> > > +       }
> >
> > Can you please comment why lock_page() is not used here?

Shakeel asked "please comment" (ie, please add a code comment), not
"please comment on".  Subtle ;)

> Since z3fold_alloc can be called in atomic or non atomic context,
> calling lock_page() could trigger a number of
> warnings about might_sleep() being called in atomic context. WARN_ON
> should avoid the problem described
> above as well, and in any weird condition where someone else has the
> page lock, we can avoid calling
> __SetPageMovable().

I think this will suffice:

--- a/mm/z3fold.c~mm-z3foldc-lock-z3fold-page-before-__setpagemovable-fix
+++ a/mm/z3fold.c
@@ -919,6 +919,9 @@ retry:
 		set_bit(PAGE_HEADLESS, &page->private);
 		goto headless;
 	}
+	/*
+	 * z3fold_alloc() can be called from atomic contexts, hence the trylock
+	 */
 	if (!WARN_ON(!trylock_page(page))) {
 		__SetPageMovable(page, pool->inode->i_mapping);
 		unlock_page(page);

However this code would be more effective if z3fold_alloc() were to be
told when it is running in non-atomic context so it can perform a
sleeping lock_page() in that case.  That's an improvement to consider
for later, please.

