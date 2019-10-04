Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFEECB5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfJDIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 04:16:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfJDIQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:16:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50119AD22;
        Fri,  4 Oct 2019 08:16:13 +0000 (UTC)
Date:   Fri, 4 Oct 2019 10:16:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: remove unused scan_control parameter from
 pageout()
Message-ID: <20191004081612.GB9578@dhcp22.suse.cz>
References: <1570124498-19300-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570124498-19300-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 01:41:38, Yang Shi wrote:
> Since lumpy reclaim was removed in v3.5 scan_control is not used by
> may_write_to_{queue|inode} and pageout() anymore, remove the unused
> parameter.

I haven't really checked whether it was the lumpy reclaim removal but it
is clearly not used these days.

> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/vmscan.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e5d52d6..17489b8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -774,7 +774,7 @@ static inline int is_page_cache_freeable(struct page *page)
>  	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
>  }
>  
> -static int may_write_to_inode(struct inode *inode, struct scan_control *sc)
> +static int may_write_to_inode(struct inode *inode)
>  {
>  	if (current->flags & PF_SWAPWRITE)
>  		return 1;
> @@ -822,8 +822,7 @@ static void handle_write_error(struct address_space *mapping,
>   * pageout is called by shrink_page_list() for each dirty page.
>   * Calls ->writepage().
>   */
> -static pageout_t pageout(struct page *page, struct address_space *mapping,
> -			 struct scan_control *sc)
> +static pageout_t pageout(struct page *page, struct address_space *mapping)
>  {
>  	/*
>  	 * If the page is dirty, only perform writeback if that write
> @@ -859,7 +858,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping,
>  	}
>  	if (mapping->a_ops->writepage == NULL)
>  		return PAGE_ACTIVATE;
> -	if (!may_write_to_inode(mapping->host, sc))
> +	if (!may_write_to_inode(mapping->host))
>  		return PAGE_KEEP;
>  
>  	if (clear_page_dirty_for_io(page)) {
> @@ -1396,7 +1395,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  			 * starts and then write it out here.
>  			 */
>  			try_to_unmap_flush_dirty();
> -			switch (pageout(page, mapping, sc)) {
> +			switch (pageout(page, mapping)) {
>  			case PAGE_KEEP:
>  				goto keep_locked;
>  			case PAGE_ACTIVATE:
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
