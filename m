Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5677AB6272
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfIRLsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 07:48:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46931 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfIRLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:48:13 -0400
Received: by mail-io1-f65.google.com with SMTP id d17so15285194ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofTkjvEUSpXrIs73m3lky1N1Didfq1+b+91cMsW/1Rg=;
        b=W6+8ReYiHHVeVlnbV+ueh6udXHFSCEib8D8eNPDlyCH6VFXoehOcoJRBKqKNvR4FEM
         9g8Yy6hdIuR0aAWNZlOKYx7kixD+24v0SCc4385+eO76oCXYWiCs2JC13YTOVoFPb+2U
         gWfU78r/G4aJO0p15MkApXrNA4dRMyazMU6Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofTkjvEUSpXrIs73m3lky1N1Didfq1+b+91cMsW/1Rg=;
        b=VZlobGEzmGtNwjWqZKlOMx9orz6FxGE8zwQksrYZKDJGKSz0k7T/LLZMxq/0UNqltm
         yNuB/hjlaFBXTJeWkC7iiJXqtvsVc2WuLRD8nTcoT7dB/HW4PKfM1yxQnHz0XuwSmZ3L
         P9PAfV+lPt/bpAdJgPG9ehvmZbsoFBwdLYlsoSB7eOaJAGy/c2QnHtjF3q1E23ciMnze
         3PR1g5DJikjGLt1uUvCg3l76CP0seyoCq81Q/+tDACLN5L4kzw+6SUiNixYc1xI0VW1P
         BEvjj0w6X1mi/SSoNJxZOQYF+ezhtdOwUYuYzCeOvUVylm+8soon7gJK+Xxu19oxhGyx
         MQ7w==
X-Gm-Message-State: APjAAAU3mrlFBkJFPuGLv7RVatjAKteBJwMw981EAeOh/KV2v21MafRd
        rn+bR2ix/MtTff+3m0dbtAE/d1GiE1UQw7trik7hDQ==
X-Google-Smtp-Source: APXvYqyw0kfhKySzuyEVmqkEH5tD5giZFYYFb8X7Ox56+XVKPgy+ZTNU1io4zY5oiSdqUq3HrOYM3DiCRNEvay8WMq0=
X-Received: by 2002:a5d:91c8:: with SMTP id k8mr1484342ior.232.1568807292316;
 Wed, 18 Sep 2019 04:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190916004640.b453167d3556c4093af4cf7d@gmail.com>
In-Reply-To: <20190916004640.b453167d3556c4093af4cf7d@gmail.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Wed, 18 Sep 2019 07:47:36 -0400
Message-ID: <CALZtONDROMJoyxgRSG2+xNVs2B0q+vQQOGG09fH0QCSzgRi5CA@mail.gmail.com>
Subject: Re: [PATCH/RFC] zswap: do not map same object twice
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 5:46 PM Vitaly Wool <vitalywool@gmail.com> wrote:
>
> zswap_writeback_entry() maps a handle to read swpentry first, and
> then in the most common case it would map the same handle again.
> This is ok when zbud is the backend since its mapping callback is
> plain and simple, but it slows things down for z3fold.
>
> Since there's hardly a point in unmapping a handle _that_ fast as
> zswap_writeback_entry() does when it reads swpentry, the
> suggestion is to keep the handle mapped till the end.

LGTM

>
> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Reviewed-by: Dan Streetman <ddstreet@ieee.org>

> ---
>  mm/zswap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0e22744a76cb..b35464bc7315 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -856,7 +856,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>         /* extract swpentry from data */
>         zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
>         swpentry = zhdr->swpentry; /* here */
> -       zpool_unmap_handle(pool, handle);
>         tree = zswap_trees[swp_type(swpentry)];
>         offset = swp_offset(swpentry);
>
> @@ -866,6 +865,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>         if (!entry) {
>                 /* entry was invalidated */
>                 spin_unlock(&tree->lock);
> +               zpool_unmap_handle(pool, handle);
>                 return 0;
>         }
>         spin_unlock(&tree->lock);
> @@ -886,15 +886,13 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>         case ZSWAP_SWAPCACHE_NEW: /* page is locked */
>                 /* decompress */
>                 dlen = PAGE_SIZE;
> -               src = (u8 *)zpool_map_handle(entry->pool->zpool, entry->handle,
> -                               ZPOOL_MM_RO) + sizeof(struct zswap_header);
> +               src = (u8 *)zhdr + sizeof(struct zswap_header);
>                 dst = kmap_atomic(page);
>                 tfm = *get_cpu_ptr(entry->pool->tfm);
>                 ret = crypto_comp_decompress(tfm, src, entry->length,
>                                              dst, &dlen);
>                 put_cpu_ptr(entry->pool->tfm);
>                 kunmap_atomic(dst);
> -               zpool_unmap_handle(entry->pool->zpool, entry->handle);
>                 BUG_ON(ret);
>                 BUG_ON(dlen != PAGE_SIZE);
>
> @@ -940,6 +938,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>         spin_unlock(&tree->lock);
>
>  end:
> +       zpool_unmap_handle(pool, handle);
>         return ret;
>  }
>
> --
> 2.17.1
