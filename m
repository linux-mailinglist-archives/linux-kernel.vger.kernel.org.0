Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7EFA84AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfIDNou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 09:44:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38281 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfIDNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:44:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so6726840pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W721XQEkMG8bC4j2PepgMeY0jTQOErIpXztyfiJXOs8=;
        b=luGclcN1dcSuuNyjEd4iVSQhaZ7/plNnDTMPxi9rQNhfhWvSUm52SKtinf2rFBYvXv
         WkUY7zrmOKflAgtEFgIlDdwxNSqASf+eYZIMIOZno6R0+F2WyGjFJAgjSZ4QIsynr/s2
         ODnVlH9pQ8nvqktBpgfoOyAIHBEzgNZe6LLo0mlO0LIalIP8unm77acWwKiMIholXtcx
         rd0SUmY8p+MkPEaF4kb8sFqd7nNFprQXHr3npmQIDeaSJ+orCGo3gH4fjy6lV6eRrABT
         5nNtXJDgdAgHI4Yz0CI2RrNJFbyLrMht5vS5C2Qv1NthNoz3ozyI4WZorI/8tpI2Ehs9
         flxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W721XQEkMG8bC4j2PepgMeY0jTQOErIpXztyfiJXOs8=;
        b=DdyfijP4/BLUp6cwPthT33WzfvjdYyUj2N9ZB4ZZZiBrDm0FEkEuiz5rcAY7j1fuH/
         ItmvppydhuvVPzKIo8sHxY5EHNV8TPk4ylm21NBK9JALoNCxoSI+ZL46hXNPwrh1ZoDw
         8AoIV9ecslfzKjQGpS1rChtN92En7xvURPYUyz49rNUsqUMkKXInXvnY/5+UWPCBO/O3
         96wO3nXI5PNACjWRXhmDzmkJalhGrtId4sl8ermFBRNiwWrQ7JhaD7XFgWwM0xtRVlMk
         Oq37oFh8STUL81+4PFMz5t+gIWV/4TRNKb8uRpJ/9KNPMizLU1lP86DY5KfyMHQRZAUs
         ja5w==
X-Gm-Message-State: APjAAAW729G8vwsTVzdj9uxvWUxNwEdBNR2rQDLhUM78iMUOrdRuROkC
        LLTHDc2ZjvIAu3KybQGVYOORhyM7Av6qRADmqlEXXQ==
X-Google-Smtp-Source: APXvYqzCww2lW0PtxSg3odpkkA5VJF/XxD5kKaqrmZ1KDA7CF0CBSRDpFDrvufwyLOctz33+u6vqBpksBAlWIGv+72Q=
X-Received: by 2002:a17:90a:ff08:: with SMTP id ce8mr4950627pjb.123.1567604688325;
 Wed, 04 Sep 2019 06:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Sep 2019 15:44:37 +0200
Message-ID: <CAAeHK+wyvLF8=DdEczHLzNXuP+oC0CEhoPmp_LHSKVNyAiRGLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/kasan: dump alloc/free stack for page allocator
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:51 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> This patch is KASAN report adds the alloc/free stacks for page allocator
> in order to help programmer to see memory corruption caused by page.
>
> By default, KASAN doesn't record alloc/free stack for page allocator.
> It is difficult to fix up page use-after-free issue.
>
> This feature depends on page owner to record the last stack of pages.
> It is very helpful for solving the page use-after-free or out-of-bound.
>
> KASAN report will show the last stack of page, it may be:
> a) If page is in-use state, then it prints alloc stack.
>    It is useful to fix up page out-of-bound issue.
>
> BUG: KASAN: slab-out-of-bounds in kmalloc_pagealloc_oob_right+0x88/0x90
> Write of size 1 at addr ffffffc0d64ea00a by task cat/115
> ...
> Allocation stack of page:
>  prep_new_page+0x1a0/0x1d8
>  get_page_from_freelist+0xd78/0x2748
>  __alloc_pages_nodemask+0x1d4/0x1978
>  kmalloc_order+0x28/0x58
>  kmalloc_order_trace+0x28/0xe0
>  kmalloc_pagealloc_oob_right+0x2c/0x90
>
> b) If page is freed state, then it prints free stack.
>    It is useful to fix up page use-after-free issue.
>
> BUG: KASAN: use-after-free in kmalloc_pagealloc_uaf+0x70/0x80
> Write of size 1 at addr ffffffc0d651c000 by task cat/115
> ...
> Free stack of page:
>  kasan_free_pages+0x68/0x70
>  __free_pages_ok+0x3c0/0x1328
>  __free_pages+0x50/0x78
>  kfree+0x1c4/0x250
>  kmalloc_pagealloc_uaf+0x38/0x80
>
>
> This has been discussed, please refer below link.
> https://bugzilla.kernel.org/show_bug.cgi?id=203967
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> ---
>  lib/Kconfig.kasan | 9 +++++++++
>  mm/kasan/common.c | 6 ++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 4fafba1a923b..ba17f706b5f8 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -135,6 +135,15 @@ config KASAN_S390_4_LEVEL_PAGING
>           to 3TB of RAM with KASan enabled). This options allows to force
>           4-level paging instead.
>
> +config KASAN_DUMP_PAGE
> +       bool "Dump the page last stack information"
> +       depends on KASAN && PAGE_OWNER
> +       help
> +         By default, KASAN doesn't record alloc/free stack for page allocator.
> +         It is difficult to fix up page use-after-free issue.
> +         This feature depends on page owner to record the last stack of page.
> +         It is very helpful for solving the page use-after-free or out-of-bound.

I'm not sure if we need a separate config for this. Is there any
reason to not have this enabled by default?

> +
>  config TEST_KASAN
>         tristate "Module for testing KASAN for bug detection"
>         depends on m && KASAN
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2277b82902d8..2a32474efa74 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -35,6 +35,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/bug.h>
>  #include <linux/uaccess.h>
> +#include <linux/page_owner.h>
>
>  #include "kasan.h"
>  #include "../slab.h"
> @@ -227,6 +228,11 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
>
>  void kasan_free_pages(struct page *page, unsigned int order)
>  {
> +#ifdef CONFIG_KASAN_DUMP_PAGE
> +       gfp_t gfp_flags = GFP_KERNEL;
> +
> +       set_page_owner(page, order, gfp_flags);
> +#endif
>         if (likely(!PageHighMem(page)))
>                 kasan_poison_shadow(page_address(page),
>                                 PAGE_SIZE << order,
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190904065133.20268-1-walter-zh.wu%40mediatek.com.
