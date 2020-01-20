Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A61427C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 11:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 05:02:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:02:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so13798506wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ioDFiDvKcwt4hurak6jw+SNUipK0Ae3bdxG5ilHrI2U=;
        b=RJAQqfKLTlFNMp3Jjux1zsG5Keugwk5SunRh5IVJ4rJXcZlHEco78m88Z5VC3cOj/B
         icxAP8wbMI9LjRQmc2n+2wkLU3tnxYsh5xx/UQiEyrH+aavz1W6T90m9VjPPPbbG6dVq
         Zb4NQQQ5krQ13CeQn7FsDr8pzsQcah52gWNrBEbp9l2BM1xpjvAAFt+GSoh+OBxSr/yh
         3qrnknB4JAnMAsXZOJDymDzmiUTHUhZTjdj/0DAuP287buFQSd1GJ6Y3VK+Gk2dQxFmP
         gnWqApDdP75ZHonTe5oUFsB6W+jKoMOcoKa2QeepkAiCVYKklZIiBjjj7ZE/2nsht4rU
         17qA==
X-Gm-Message-State: APjAAAXWustMSVV+7Wp4d1A+TCksCscywO9SgijYX3aXC+9s7Zwqtekk
        BQcyVBPgPSj7Vcw04KhGUJQ=
X-Google-Smtp-Source: APXvYqyDL0kj1GDISy0/4HaGIqmZD/uMF6LvqvRMSyxb2tlIhjnvC7Z88z3tcRSU1rnjL0IkcIObwA==
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr17925798wmt.22.1579514525086;
        Mon, 20 Jan 2020 02:02:05 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id p7sm2687031wmp.31.2020.01.20.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:02:04 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:02:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 7/8] mm/migrate.c: move page on next iteration
Message-ID: <20200120100203.GR18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-8-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-8-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:35, Wei Yang wrote:
> When page is not successfully queued for migration, we would move pages
> on pagelist immediately. Actually, this could be done in the next
> iteration by telling it we need some help.
> 
> This patch adds a new variable need_move to be an indication. After
> this, we only need to call move_pages_and_store_status() twice.

No! Not another iterator. There are two and this makes the function
quite hard to follow already. We do not want to add a third one.

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/migrate.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index aee5aeb082c4..2a857fec65b6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1610,6 +1610,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  	LIST_HEAD(pagelist);
>  	int start, i;
>  	int err = 0, err1;
> +	int need_move = 0;
>  
>  	migrate_prep();
>  
> @@ -1641,13 +1642,15 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		if (current_node == NUMA_NO_NODE) {
>  			current_node = node;
>  			start = i;
> -		} else if (node != current_node) {
> +		} else if (node != current_node || need_move) {
>  			err = move_pages_and_store_status(mm, current_node,
> -					&pagelist, status, start, i - start);
> +					&pagelist, status, start,
> +					i - start - need_move);
>  			if (err)
>  				goto out;
>  			start = i;
>  			current_node = node;
> +			need_move = 0;
>  		}
>  
>  		/*
> @@ -1662,6 +1665,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			continue;
>  		}
>  
> +		/* Ask next iteration to move us */
> +		need_move = 1;
> +
>  		/*
>  		 * Two possible cases for err here:
>  		 * == 0: page is already on the target node, then store
> @@ -1671,17 +1677,11 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		err = store_status(status, i, err ? : current_node, 1);
>  		if (err)
>  			goto out_flush;
> -
> -		err = move_pages_and_store_status(mm, current_node, &pagelist,
> -				status, start, i - start);
> -		if (err)
> -			goto out;
> -		current_node = NUMA_NO_NODE;
>  	}
>  out_flush:
>  	/* Make sure we do not overwrite the existing error */
>  	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
> -				status, start, i - start);
> +				status, start, i - start - need_move);
>  	if (err >= 0)
>  		err = err1;
>  out:
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
