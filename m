Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD8A2F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfH3FiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 01:38:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfH3FiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:38:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB987ACA0;
        Fri, 30 Aug 2019 05:38:09 +0000 (UTC)
Date:   Fri, 30 Aug 2019 07:38:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     akpm@linux-foundation.org, urezki@gmail.com, guro@fb.com,
        rpenyaev@suse.de, rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: move 'area->pages' after if statement
Message-ID: <20190830053808.GM28313@dhcp22.suse.cz>
References: <20190830035716.GA190684@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830035716.GA190684@LGEARND20B15>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 12:57:16, Austin Kim wrote:
> If !area->pages statement is true where memory allocation fails, 
> area is freed.
> 
> In this case 'area->pages = pages' should not executed.
> So move 'area->pages = pages' after if statement.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/vmalloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b810103..af93ba6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2416,13 +2416,15 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	} else {
>  		pages = kmalloc_node(array_size, nested_gfp, node);
>  	}
> -	area->pages = pages;
> -	if (!area->pages) {
> +
> +	if (!pages) {
>  		remove_vm_area(area->addr);
>  		kfree(area);
>  		return NULL;
>  	}
>  
> +	area->pages = pages;
> +
>  	for (i = 0; i < area->nr_pages; i++) {
>  		struct page *page;
>  
> -- 
> 2.6.2
> 

-- 
Michal Hocko
SUSE Labs
