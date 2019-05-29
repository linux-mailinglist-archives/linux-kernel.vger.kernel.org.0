Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136192E145
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfE2Pik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 11:38:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbfE2Pij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:38:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3677AC50;
        Wed, 29 May 2019 15:38:38 +0000 (UTC)
Date:   Wed, 29 May 2019 17:38:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix recent_rotated history
Message-ID: <20190529153836.GF18589@dhcp22.suse.cz>
References: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 19:09:02, Kirill Tkhai wrote:
> Johannes pointed that after commit 886cf1901db9
> we lost all zone_reclaim_stat::recent_rotated
> history. This commit fixes that.
> 
> Fixes: 886cf1901db9 "mm: move recent_rotated pages calculation to shrink_inactive_list()"
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

I didn't get to review the original bug series but this one looks
obviously correct.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d9c3e873eca6..1d49329a4d7d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1953,8 +1953,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	if (global_reclaim(sc))
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> -	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
> -	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
> +	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> +	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
>  
>  	move_pages_to_lru(lruvec, &page_list);
>  
> 

-- 
Michal Hocko
SUSE Labs
