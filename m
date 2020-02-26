Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A8170659
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBZRmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:42:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:56042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgBZRmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:42:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA889AE85;
        Wed, 26 Feb 2020 17:42:17 +0000 (UTC)
Subject: Re: [PATCH V2 4/4] mm/vma: Replace all remaining open encodings with
 vma_is_anonymous()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
 <1582520593-30704-5-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ec32b449-9c53-fcf6-a14f-63ce26742f2c@suse.cz>
Date:   Wed, 26 Feb 2020 18:42:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582520593-30704-5-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 6:03 AM, Anshuman Khandual wrote:
> This replaces all remaining open encodings with vma_is_anonymous().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz

> ---
>  mm/gup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c8ffe2e61f03..58c8cbfeded6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -146,7 +146,8 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  	 * But we can only make this optimization where a hole would surely
>  	 * be zero-filled if handle_mm_fault() actually did handle it.
>  	 */
> -	if ((flags & FOLL_DUMP) && (!vma->vm_ops || !vma->vm_ops->fault))
> +	if ((flags & FOLL_DUMP) &&
> +			(vma_is_anonymous(vma) || !vma->vm_ops->fault))
>  		return ERR_PTR(-EFAULT);
>  	return NULL;
>  }
> 

