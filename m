Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACE6C284
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 23:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfGQVYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 17:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfGQVYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:24:24 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A3821743
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563398663;
        bh=Ap5TwhmtuWKZyNppq7kyJPabjyvLMUE9Mf8WiDtOxmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zh9lxgNm+6nlUVTZWtDHx+bxjyrLvGvPKR7+3Qj2ZiB7xCtjTgsfuX3LelkkwhWiE
         939QnXVowCyRxqHZvppFJ44+uvHEp72rB58KK16GnDyDwbc9VtGuMz/1hMzWlf286V
         14enB4y9gGoq8PGbGRiqsTA0FC7vu4gonvUFFEPo=
Received: by mail-wr1-f49.google.com with SMTP id x4so26317697wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 14:24:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXwXLR+fq9v3CQ3BQGGnqQlfdW3+Epr9Hdu418qY2kqPeZZBWiU
        +NmJstkHMklOlEX1izDhGfvKI6BIkEsZTiZOik8pdQ==
X-Google-Smtp-Source: APXvYqx3ShJFhqnZ7qsgc9j4qpCUgv2h4GMS3OWkVBQnhodlcAVy+HMbbVlWLrUdOwH/Nrmt/e0c+kr4isRdWypSYYE=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr42310193wrj.47.1563398661732;
 Wed, 17 Jul 2019 14:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190717071439.14261-1-joro@8bytes.org> <20190717071439.14261-4-joro@8bytes.org>
In-Reply-To: <20190717071439.14261-4-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Jul 2019 14:24:09 -0700
X-Gmail-Original-Message-ID: <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
Message-ID: <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 12:14 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> On x86-32 with PTI enabled, parts of the kernel page-tables
> are not shared between processes. This can cause mappings in
> the vmalloc/ioremap area to persist in some page-tables
> after the regions is unmapped and released.
>
> When the region is re-used the processes with the old
> mappings do not fault in the new mappings but still access
> the old ones.
>
> This causes undefined behavior, in reality often data
> corruption, kernel oopses and panics and even spontaneous
> reboots.
>
> Fix this problem by activly syncing unmaps in the
> vmalloc/ioremap area to all page-tables in the system.
>
> References: https://bugzilla.suse.com/show_bug.cgi?id=1118689
> Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4fa8d84599b0..322b11a374fd 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -132,6 +132,8 @@ static void vunmap_page_range(unsigned long addr, unsigned long end)
>                         continue;
>                 vunmap_p4d_range(pgd, addr, next);
>         } while (pgd++, addr = next, addr != end);
> +
> +       vmalloc_sync_all();
>  }

I'm confused.  Shouldn't the code in _vm_unmap_aliases handle this?
As it stands, won't your patch hurt performance on x86_64?  If x86_32
is a special snowflake here, maybe flush_tlb_kernel_range() should
handle this?

Even if your patch is correct, a comment would be nice
