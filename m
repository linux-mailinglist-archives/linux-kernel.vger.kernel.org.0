Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1513994
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 13:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEDLyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 07:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbfEDLyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C168AC4A;
        Sat,  4 May 2019 11:54:48 +0000 (UTC)
Date:   Sat, 4 May 2019 07:54:46 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory.c: Make __thp_get_unmapped_area static
Message-ID: <20190504115446.GP29835@dhcp22.suse.cz>
References: <20190504102353.GA22525@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504102353.GA22525@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-05-19 15:53:54, Bharath Vedartham wrote:
> __thp_get_unmapped_area is only used in mm/huge_memory.c. Make it
> static.

Makes sense. Looks like an omission.

> Tested by building and booting the kernel.

Testing by git grep __thp_get_unmapped_area would give you a better
picture. Build test migh not hit paths that are config specific and
static aspect of a functions should not have any functionality related
side effects AFAICS.
 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 165ea46..75fe2b7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -509,7 +509,7 @@ void prep_transhuge_page(struct page *page)
>  	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
>  }
>  
> -unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
> +static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
>  		loff_t off, unsigned long flags, unsigned long size)
>  {
>  	unsigned long addr;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
