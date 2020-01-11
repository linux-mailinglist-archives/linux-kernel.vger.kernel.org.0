Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0657137A70
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 01:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgAKAD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 19:03:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35176 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgAKAD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:03:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so3893890lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0dV0HpLb0SFVmBzU2FxcT9u699TRcir0XtuMO7iJ5Rk=;
        b=jLj7968mfYKL2VYZr0TuLfiNgEm5+DSR9KdJ7zlbQDt/OA7icoEp8yEMnyLppqBrue
         3NcMP+/XLLUMQj7Tk8Ede7FOYr8o9bc2tL4Wqsl08zcoZFkqXB9vNlaQS9kd6XhnhAYa
         uLKfVHKK3ZcR0lMjU2IQbPTpuHVY+C0O4ylgpVM9nFwKVM/+4xnm7yYBzpTkvlEvVwwg
         Cf7J2R+hdmjc9S5e5ra4dZ3oIn7TmzBc8WMZPbgzzMJUBj6BCtwcvkOa0AxYMorFQVPh
         sk5+IEgmkdM4y1F3gxQqL1rQvdHZrj0kRrSzdfoHeqNk6/HSxWPpfmUzTrJK2rwYZtM/
         SzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dV0HpLb0SFVmBzU2FxcT9u699TRcir0XtuMO7iJ5Rk=;
        b=paeube+yqPotDmv5+mmwkxactX2JoCY/mr6qhdnpKVKv+RI9/PNEOcKQT7tohJZXpd
         TypELdJBYVLsWbgShXZ70fvpWagAe/84g183bGn/7Hw0SfVihvMlMc0KYQWgvaqH4yZW
         SqYrn/VJRfvys+jCKlH3EswTOQAsOciw1BfM8MkKYsPQNi81iFMbnV/fFSwYFHscHw9s
         vjEHiHsSJvn8m72X0dniyFVc26fr70z9iRXBhQ3jnkrgdBLICbREJ7Eykkc5O+PIrnfU
         /lMTLRwZ7u8DEcZh5ryAVpgKFWRPG39+Tw+YLyOMQNhsRiJOMvQNKBBtOw1P5qwRrXLp
         OMnQ==
X-Gm-Message-State: APjAAAXFFu/BDomu/EaCj+lJGnWY47R11uxMB2t5dxb1eqF9kjLIgv6n
        J8HJpzIpx2ucJb4JXKPcSsWjbg==
X-Google-Smtp-Source: APXvYqzxnwFlKBQ+HuZ0Ajaxu7sWb5whqIl3y01j830CNxhgfR+kjdu4tsCtYI+F/Uo0FrIyKKggQw==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr4091674lji.135.1578701033705;
        Fri, 10 Jan 2020 16:03:53 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n23sm1791373lfa.41.2020.01.10.16.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 16:03:53 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B1C2010144E; Sat, 11 Jan 2020 03:03:52 +0300 (+03)
Date:   Sat, 11 Jan 2020 03:03:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200111000352.efy6krudecpshezh@box>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109143054.13203-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
> 
> For example, the potential race would be:
> 
>     CPU1                      CPU2
>     mem_cgroup_move_account   split_huge_page_to_list
>       !list_empty
>                                 lock
>                                 !list_empty
>                                 list_del
>                                 unlock
>       lock
>       # !list_empty might not hold anymore
>       list_del_init
>       unlock

I don't think this particular race is possible. Both parties take page
lock before messing with deferred queue, but anytway:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> 
> When this sequence happens, the list_del_init() in
> mem_cgroup_move_account() would crash if CONFIG_DEBUG_LIST since the
> page is already been removed by list_del in split_huge_page_to_list().
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: David Rientjes <rientjes@google.com>
> 
> ---
> v2:
>   * move check on compound outside suggested by Alexander
>   * an example of the race condition, suggested by Michal
> ---
>  mm/memcontrol.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bc01423277c5..1492eefe4f3c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5368,10 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>  	}
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (compound && !list_empty(page_deferred_list(page))) {
> +	if (compound) {
>  		spin_lock(&from->deferred_split_queue.split_queue_lock);
> -		list_del_init(page_deferred_list(page));
> -		from->deferred_split_queue.split_queue_len--;
> +		if (!list_empty(page_deferred_list(page))) {
> +			list_del_init(page_deferred_list(page));
> +			from->deferred_split_queue.split_queue_len--;
> +		}
>  		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  	}
>  #endif
> @@ -5385,11 +5387,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	page->mem_cgroup = to;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (compound && list_empty(page_deferred_list(page))) {
> +	if (compound) {
>  		spin_lock(&to->deferred_split_queue.split_queue_lock);
> -		list_add_tail(page_deferred_list(page),
> -			      &to->deferred_split_queue.split_queue);
> -		to->deferred_split_queue.split_queue_len++;
> +		if (list_empty(page_deferred_list(page))) {
> +			list_add_tail(page_deferred_list(page),
> +				      &to->deferred_split_queue.split_queue);
> +			to->deferred_split_queue.split_queue_len++;
> +		}
>  		spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  	}
>  #endif
> -- 
> 2.17.1
> 
> 

-- 
 Kirill A. Shutemov
