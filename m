Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426AE1869DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 12:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgCPLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 07:18:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39144 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgCPLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:18:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id h6so347039wrs.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkzased074+2YtAr5hFJ/daEFNhyLZu+M7n1STZCoBQ=;
        b=PuviygU2AAmP2GYX+19eXOd4AbKmQEvTvBAqVTKc7w9rRAFSTEm0NG5JfeGXiZlN47
         CamCokt1G4OvKPqDvDl3RrUCmiJQgLKim3xrQkFaayVEh4iIWCY14ZRWscp6Uc8gYH/B
         5WuEvcJgYeGcoItq30X3xr98ryw51RZztMC4GWmZX4/hnuBFAG4rIxCq3Q+CuEDJtblB
         vyZJ9K51xs267yZZwCBeCXyq7TOvH/yEfKMtDr8j9VZJMVnvAGttyNQbvXsbb5+t4Lg9
         4lrTcZRMwrfRcrNOmtDT6d844jb4g8Xobe5FBexitdnjw4gbnJrbYm3hhR2UKsEgYRZD
         VpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkzased074+2YtAr5hFJ/daEFNhyLZu+M7n1STZCoBQ=;
        b=dKffKkgRtM3Q7Ba2UkhGRwvc6PTRu163mDN5upiQNmGshazix4KcN8PBn045rzri/m
         bT8UENy6pwJRQ+EldIbidB/lzCliYu1pNY9s9ZaAsdYxnwIBrdK0PN18Z0NQvUVZ6suL
         ScqLHO4CNv7QbckLmjx3ntgPBUzNpWUKgWmLPoxKPLVmLm3X1RlmuTxDvwd/ohV7QMl4
         cc1wW5K2UccKlG7OnoEXlBF5V40IBziYjbEQnGZAWLf1WEqRENtiGahycz1k19+hznKU
         g8GaiP+qjrD5DO7a74n1B7XUYPcKrPsRBfUqPRUwbWL7u7WIJHroyG6UzQ9xHYoyL/Sa
         BpSA==
X-Gm-Message-State: ANhLgQ0KvHrHI3bUCgHuoJrryscjZ78TkwCVTHgrIhJmti8gDtzkX7xs
        cksIxwqXwoPLUcYqYJuqlpl/wJBTDWgvEVl7wngJXfI11kE=
X-Google-Smtp-Source: ADFU+vtLcva0bE/nXI4bTW8PFsxRpyI9ov7T+F6+EGCZKFCf0U1B9Nd91Nf05H+MgIUj46mpauaunKTh4F/HQrzJakE=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr35015005wrj.196.1584357480753;
 Mon, 16 Mar 2020 04:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200316102150.16487-1-bhe@redhat.com>
In-Reply-To: <20200316102150.16487-1-bhe@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 16 Mar 2020 12:17:49 +0100
Message-ID: <CAM9Jb+iow40dCvrC8xoKAv5di2J_TDxvAkzKkHk5a0OXNaq3Yg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/sparse.c: Use kvmalloc/kvfree to alloc/free
 memmap for the classic sparse
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, willy@infradead.org,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This change makes populate_section_memmap()/depopulate_section_memmap
> much simpler.
>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> v3->v4:
>   Split the old v3 into two patches, to carve out the using 'nid'
>   as preferred node to allocate memmap into a separate patch. This
>   is suggested by Michal, and the carving out is put in patch 2.
>
> v2->v3:
>   Remove __GFP_NOWARN and use array_size when calling kvmalloc_node()
>   per Matthew's comments.
> http://lkml.kernel.org/r/20200312141749.GL27711@MiWiFi-R3L-srv
>
>  mm/sparse.c | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index e747a238a860..d01d09cc7d99 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -719,35 +719,14 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>                 unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
> -       struct page *page, *ret;
> -       unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> -
> -       page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
> -       if (page)
> -               goto got_map_page;
> -
> -       ret = vmalloc(memmap_size);
> -       if (ret)
> -               goto got_map_ptr;
> -
> -       return NULL;
> -got_map_page:
> -       ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
> -got_map_ptr:
> -
> -       return ret;
> +       return kvmalloc(array_size(sizeof(struct page),
> +                       PAGES_PER_SECTION), GFP_KERNEL);
>  }
>
>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>                 struct vmem_altmap *altmap)
>  {
> -       struct page *memmap = pfn_to_page(pfn);
> -
> -       if (is_vmalloc_addr(memmap))
> -               vfree(memmap);
> -       else
> -               free_pages((unsigned long)memmap,
> -                          get_order(sizeof(struct page) * PAGES_PER_SECTION));
> +       kvfree(pfn_to_page(pfn));
>  }
>
>  static void free_map_bootmem(struct page *memmap)
> --
> 2.17.2

With David's indentation suggestion:
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
