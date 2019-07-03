Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF65CD04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGBJyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 05:54:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38416 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfGBJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:54:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so16226809ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjyKVTfGLIvonwBnPeklb1p3eTYs2YkOVqXlW7TXq5I=;
        b=KDkySTJNPi9xp2C9AbgqC60PF/XlLQ5EkZL2DorhyaDXAZWlT23yYIPfStjb1pELpb
         mCt6Dw0DoiVH9E0SF4LlIrX0Qg/iIO4boobYYGgAwfSUTcsn0iXNwkW0tj6VYZOQyIxJ
         /4JMcJsCj17lggg5m+gtFf24FOocdJjTtV1WH/HxcaH675SYrW59q555fZDLlfk5v1xz
         X/OxWEagVMcjk6FONjuM7VNPBOhVAULnNjBwbn6W7429kkDrpbgwYOw0LUYxZwLDEYen
         UqnqI9mCajyZkBl0t7/k3WXjxkERDDuwlXPAGc6Dp44e4YV59PKX2b9rkuqatb8B1oYO
         dQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjyKVTfGLIvonwBnPeklb1p3eTYs2YkOVqXlW7TXq5I=;
        b=fq4hBjcTWIDj634a0ptkxNZ+7xeFWCwGCNTZrP255icS5fc2aiMwxBeNJaPO6+BYp9
         rKjRZKjAkEreBeoJUJTGT7XdVwBZqrJ1PYQwaTJqWne6JopRxaSrtiSBmHfFYg2LwwE3
         zjHuFlJyYuMv9/PwYARboL++bDMZK5vXCFbo8vE3r79v/qRKYX7eRH8mp66G/+qqEEgW
         j7Ed3p6b7479+o6ovv7SUTDEfqOWOsN9PBZF3dO6PQKAR9amiCYK5rbn3Ihb9t3tvfFl
         zNVlkDIl0bKgcdnHhKjedDVIqxWJj3QO1XYHm2hjs3rgqbeDieBdoKWAW+j4B47hb9yh
         iCCw==
X-Gm-Message-State: APjAAAWQfiWuWUZga/I9SF1bNzo67FT+Ftxxm70QeODW7z2z3Zh0reu/
        XV1DPTG2OD6tHm8HAIVMKwgxWyfE3B/c3Ou3ajg=
X-Google-Smtp-Source: APXvYqzwuDK5paYci+EjBub1RottsQW8Z3v6j5P39yYdQ08dZkdClJyhBoe5GwYmEBPA5Rl/qWZ8LnknbwME5uslAZ4=
X-Received: by 2002:a2e:8ed2:: with SMTP id e18mr16909326ljl.235.1562061244143;
 Tue, 02 Jul 2019 02:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com>
In-Reply-To: <20190702005122.41036-1-henryburns@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Tue, 2 Jul 2019 12:53:51 +0300
Message-ID: <CAMJBoFM0ciL81Tq5ZMRwwGHhxBwJ=2Wf31u=W_74AzmCbLubyA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Henry Burns <henryburns@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 3:51 AM Henry Burns <henryburns@google.com> wrote:
>
> __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> lock the page. Following zsmalloc.c's example we call trylock_page() and
> unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> passed in locked, as documentation.
>
> Signed-off-by: Henry Burns <henryburns@google.com>
> Suggested-by: Vitaly Wool <vitalywool@gmail.com>

Acked-by: Vitaly Wool <vitalywool@gmail.com>

Thanks!

> ---
>  Changelog since v1:
>  - Added an if statement around WARN_ON(trylock_page(page)) to avoid
>    unlocking a page locked by a someone else.
>
>  mm/z3fold.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index e174d1549734..6341435b9610 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -918,7 +918,10 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>                 set_bit(PAGE_HEADLESS, &page->private);
>                 goto headless;
>         }
> -       __SetPageMovable(page, pool->inode->i_mapping);
> +       if (!WARN_ON(!trylock_page(page))) {
> +               __SetPageMovable(page, pool->inode->i_mapping);
> +               unlock_page(page);
> +       }
>         z3fold_page_lock(zhdr);
>
>  found:
> @@ -1325,6 +1328,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>
>         VM_BUG_ON_PAGE(!PageMovable(page), page);
>         VM_BUG_ON_PAGE(!PageIsolated(page), page);
> +       VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
>
>         zhdr = page_address(page);
>         pool = zhdr_to_pool(zhdr);
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
