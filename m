Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE417ED68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 01:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgCJAs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 20:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgCJAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:48:55 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F192146E;
        Tue, 10 Mar 2020 00:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583801335;
        bh=MyWY5amDJAzJzdzhFcv6Tu9m3xmj/uJuETu5vTpbu1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m2SM3CNeB9AYYwMegS2jCzUUGfrXy4qy+7yHmzpz470bfnGsfowU9w1uN04i1PjNS
         NPr39yPhzzG/w7UlNxW5oRW4PH5Ukm7/+fUWgOqN8Rk6XTj+mzCpMcXBWHGnfsyjvT
         JWHDqz5vyedqi0m4W3YIlVS5G458CGUYD97ld12Y=
Date:   Mon, 9 Mar 2020 17:48:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] mm/swap_slots.c: don't reset the cache slot after use
Message-Id: <20200309174854.b6b8c7f019c3dde048c28f94@linux-foundation.org>
In-Reply-To: <20200309090940.34130-1-richard.weiyang@linux.alibaba.com>
References: <20200309090940.34130-1-richard.weiyang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Mar 2020 17:09:40 +0800 Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> Currently we would clear the cache slot if it is used. While this is not
> necessary, since this entry would not be used until refilled.
> 
> Leave it untouched and assigned the value directly to entry which makes
> the code little more neat.
> 
> Also this patch merges the else and if, since this is the only case we
> refill and repeat swap cache.

cc Tim, who can hopefully remember how this code works ;)

> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -309,7 +309,7 @@ int free_swap_slot(swp_entry_t entry)
>  
>  swp_entry_t get_swap_page(struct page *page)
>  {
> -	swp_entry_t entry, *pentry;
> +	swp_entry_t entry;
>  	struct swap_slots_cache *cache;
>  
>  	entry.val = 0;
> @@ -336,13 +336,10 @@ swp_entry_t get_swap_page(struct page *page)
>  		if (cache->slots) {
>  repeat:
>  			if (cache->nr) {
> -				pentry = &cache->slots[cache->cur++];
> -				entry = *pentry;
> -				pentry->val = 0;
> +				entry = cache->slots[cache->cur++];
>  				cache->nr--;
> -			} else {
> -				if (refill_swap_slots_cache(cache))
> -					goto repeat;
> +			} else if (refill_swap_slots_cache(cache)) {
> +				goto repeat;
>  			}
>  		}
>  		mutex_unlock(&cache->alloc_lock);
> -- 
> 2.20.1 (Apple Git-117)
