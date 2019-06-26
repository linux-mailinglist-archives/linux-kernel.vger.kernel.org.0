Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147C456E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFZQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 12:01:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37619 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:00:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so2338198oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/963AMc32TjFW8pz2sb81LGtvemWumKWmOSWi/w+uo=;
        b=FEqk4AyqvI2SzCotbI6w47r7lIg1pbMai4XViymaBkOSAtj0NfKwJKshzu/N8BPJFi
         PPN0xns9/GQ3UjW0F9OUD+lLQxT0bLvpRO6rEeExsKdp48k3oiJcMS1RfpUHWI3YgQSe
         P3swXsvQ9fmeXBT6oobBozcpVgRGWN23FavhhN4cCEGhqIdsUZ+QWbmxpT1xgQhmYaLI
         wRlJBZOCxG1HxsggNiXJVMbdqx15uDTKnIMPx8OZYBLCprh9CGs/eCgDPe7/TAMtVU5d
         oafpIZj3xnh4RTWYjvBCXah4DbVlLssHna403/2Qrtq8aZqQJ+EBDW0IKrQkvHB1zCgf
         +PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/963AMc32TjFW8pz2sb81LGtvemWumKWmOSWi/w+uo=;
        b=LHzfOs1viAqaHnwjwJ/++wvCjcZat7q8LSAUjkwV3c/XfdD9tSJTIeq5vtwB9oreYv
         b0heo9DuXRrsvR4DNQzxtvNwiWB0bD8acUDL2985aWHN2g2reAHhAX3WsOpXqZvYlc/Z
         zS8xHVxNbd/9NQGGSNKthNzti9bB8g9hLdCYqbDkbWCWVuLo0M+qWl+CspydHvygRvIO
         JEx+l4NDUt0A3m9zDMzsEhKzbYwMJWMd8IU8qTGSclSm417sqRbph/d5mX3MGmLkBbtC
         MXgwBa6mcwmu3pq52sCIGJRCRiGyb1IOxsWcFjdlk/l6D2mPIB7aKHKyngzcnvXtgg3C
         EsCQ==
X-Gm-Message-State: APjAAAVQaSH6sgy7DMGOWFsrdY/nTiPRO1xFJdTDdYj7IuNrRE99MiUl
        Qk22yx/5A9IEvzdW9x5H9DZJ/47/63zWgHAHt3yOKg==
X-Google-Smtp-Source: APXvYqw+HKEk3o1E4qvsumKbcYL8DeGoSSUg6kQouoUdfkWJuiZCSiMJzuF3+UevbQqRwbob+TxTsET5oJi5oxrpxxs=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr2276731oii.0.1561564858765;
 Wed, 26 Jun 2019 09:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-5-hch@lst.de>
In-Reply-To: <20190626122724.13313-5-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jun 2019 09:00:47 -0700
Message-ID: <CAPcyv4gTOf+EWzSGrFrh2GrTZt5HVR=e+xicUKEpiy57px8J+w@mail.gmail.com>
Subject: Re: [PATCH 04/25] mm: remove MEMORY_DEVICE_PUBLIC support
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Ira ]

On Wed, Jun 26, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The code hasn't been used since it was added to the tree, and doesn't
> appear to actually be usable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
[..]
> diff --git a/mm/swap.c b/mm/swap.c
> index 7ede3eddc12a..83107410d29f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -740,17 +740,6 @@ void release_pages(struct page **pages, int nr)
>                 if (is_huge_zero_page(page))
>                         continue;
>
> -               /* Device public page can not be huge page */
> -               if (is_device_public_page(page)) {
> -                       if (locked_pgdat) {
> -                               spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> -                                                      flags);
> -                               locked_pgdat = NULL;
> -                       }
> -                       put_devmap_managed_page(page);
> -                       continue;
> -               }
> -

This collides with Ira's bug fix [1]. The MEMORY_DEVICE_FSDAX case
needs this to be converted to be independent of "public" pages.
Perhaps it should be pulled out of -mm and incorporated in this
series.

[1]: https://lore.kernel.org/lkml/20190605214922.17684-1-ira.weiny@intel.com/
