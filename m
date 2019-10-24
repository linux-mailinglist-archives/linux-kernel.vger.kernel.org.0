Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4EE3244
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501892AbfJXM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 08:26:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfJXMZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:25:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79C7DB259;
        Thu, 24 Oct 2019 12:25:53 +0000 (UTC)
Date:   Thu, 24 Oct 2019 14:25:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Li Xinhai <xinhai.li@outlook.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: allow unmapped hole at head side of mbind range
Message-ID: <20191024122552.GB658@dhcp22.suse.cz>
References: <TY2PR04MB29753892EBAD17D9E8FECBAEE86A0@TY2PR04MB2975.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR04MB29753892EBAD17D9E8FECBAEE86A0@TY2PR04MB2975.apcprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-10-19 07:35:06, Li Xinhai wrote:
> From: Li Xinhai  <xinhai.li@outlook.com>
> 
> mbind_range silently ignore unmapped hole at middle and tail of the 
> specified range, but report EFAULT if hole at head side.
> It is more reasonable to support silently ignore holes at any part of 
> the range, only report EFAULT if the whole range is in hole.

The changelog is a bit cryptic but you are right. find_vma returns the
first vma that ends above the given address. If vm_start > start
then there is still an overlap possible
              [    vma      ]
    [start        end]
and we should mbind [vma->vm_start, end] at least. I haven't checked
whether changing the condition is sufficient for the rest of the code to
work properly. I am pretty sure a test case shouldn't be really hard
to construct and add to the kernel testing machinery.

Btw. when writing a changelog then it is always preferred to describe
user visible effect of the patch. In this case it would be an unexpected
EFAULT on a range that starts before an existing VMA while still
overlapping it. Make sure to note that.

Fixes: 9d8cebd4bcd7 ("mm: fix mbind vma merge problem")
> Signed-off-by: Li Xinhai <xinhai.li@outlook.com>
> ---
> 
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..ae160d9936d9 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -738,7 +738,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
>         unsigned long vmend;
>  
>         vma = find_vma(mm, start);
> -       if (!vma || vma->vm_start > start)
> +       if (!vma || vma->vm_start >= end)
>                 return -EFAULT;
>  
>         prev = vma->vm_prev;
> 

-- 
Michal Hocko
SUSE Labs
