Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E145E32536
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 23:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFBVs3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jun 2019 17:48:29 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60968 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726715AbfFBVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:48:29 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16768558-1500050 
        for multiple; Sun, 02 Jun 2019 22:47:39 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190307153051.18815-1-willy@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <liu.song.a23@gmail.com>
References: <20190307153051.18815-1-willy@infradead.org>
Message-ID: <155951205528.18214.706102020945306720@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Date:   Sun, 02 Jun 2019 22:47:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (2019-03-07 15:30:51)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 404acdcd0455..aaf88f85d492 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2456,6 +2456,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>                         if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
>                                 shmem_uncharge(head->mapping->host, 1);
>                         put_page(head + i);
> +               } else if (!PageAnon(page)) {
> +                       __xa_store(&head->mapping->i_pages, head[i].index,
> +                                       head + i, 0);

Forgiving the ignorant copy'n'paste, this is required:

+               } else if (PageSwapCache(page)) {
+                       swp_entry_t entry = { .val = page_private(head + i) };
+                       __xa_store(&swap_address_space(entry)->i_pages,
+                                  swp_offset(entry),
+                                  head + i, 0);
                }
        }
 
The locking is definitely wrong.
-Chris
