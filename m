Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADC6A1966
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfH2LzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 07:55:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2LzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6C+YEpbQ+waKyTLvUFM30EjlYR6OQ3V9fS2IPIYVcZ8=; b=LmksJQcAughQww7l67qvJ+/Wj
        IOK/JVbNb6jkDTD5bY4yF15Fm6JRtltuVZxG+gXSwS78yHBGt2UTJ9XXJET2Hiut/IpIsb1EDBltP
        dmUwPbum4RXe1zrqCun7DRWku4oGQlfdDDmKrCZFxpZz01H5QdTD2HRiuCELwHtloHiBCN2FH9uhS
        W29srtx1aTU1Qy8y6BFOf6ZAxzHd5j/9F/vYpwZ5NSgDYnE0hCMFZSUvNiyDzuy/aSKOEQrsYE3DH
        7eOsbmwYKZZoxzYy/CcBqR0W0QfF6cqwQJ+AqLvZL9lKRhpJFS2gpp1fG1wXn8wwkvwHaHryBfKl2
        RZwXSrCdA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3J0z-0007OA-IZ; Thu, 29 Aug 2019 11:54:57 +0000
Date:   Thu, 29 Aug 2019 04:54:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhigang lu <luzhigang001@gmail.com>
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tonnylu@tencent.com,
        hzhongzhang@tencent.com, knightzhang@tencent.com
Subject: Re: [PATCH] mm/hugetlb: avoid looping to the same hugepage if !pages
 and !vmas
Message-ID: <20190829115457.GC6590@bombadil.infradead.org>
References: <CABNBeK+6C9ToJcjhGBJQm5dDaddA0USOoRFmRckZ27PhLGUfQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABNBeK+6C9ToJcjhGBJQm5dDaddA0USOoRFmRckZ27PhLGUfQg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 07:37:22PM +0800, zhigang lu wrote:
> This change greatly decrease the time of mmaping a file in hugetlbfs.
> With MAP_POPULATE flag, it takes about 50 milliseconds to mmap a
> existing 128GB file in hugetlbfs. With this change, it takes less
> then 1 millisecond.

You're going to need to find a new way of sending patches; this patch is
mangled by your mail system.

> @@ -4391,6 +4391,17 @@ long follow_hugetlb_page(struct mm_struct *mm,
> struct vm_area_struct *vma,
>   break;
>   }
>   }
> +
> + if (!pages && !vmas && !pfn_offset &&
> +     (vaddr + huge_page_size(h) < vma->vm_end) &&
> +     (remainder >= pages_per_huge_page(h))) {
> + vaddr += huge_page_size(h);
> + remainder -= pages_per_huge_page(h);
> + i += pages_per_huge_page(h);
> + spin_unlock(ptl);
> + continue;
> + }

The concept seems good to me.  The description above could do with some
better explanation though.
