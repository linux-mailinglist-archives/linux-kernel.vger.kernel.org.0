Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C015B24D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfF3XGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 19:06:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34135 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfF3XGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 19:06:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so11578474otk.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bl+8fccvQ+Vw0cb2jDFiMa7kxLSzzNYBzyYR78H/6zs=;
        b=NclGqIATbUTGEGvFGfvyAKJsQ3Wsyo9OEJAJV4eNIIXaQtWTv1qGxGwG65g02Quva7
         p/M3ofz5qKgSpMrd//ezAR7w3QAI/1GuPsVtnm7N0AgVJjM1umhgZ+XoxtR4bcOnjtWA
         kRrh01URyCYf8NBw6Hs539A1pNVWhcK9JfhM+VWY/nlPevY0fk1lcmJi3jN6BTx1EIa7
         L97hbwq1GAMoGw/eUC10KjlA7sENrYhRhrQT+cxc47LKeOW0jtvy093Phu13g7k5Zw9h
         6/j3Ui2uRJ37DSDkBxVukEjHdL6IqYOQPdF1yie7lNtnv+1Xv8FADP6iF8d1+DwqE8Yk
         HSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bl+8fccvQ+Vw0cb2jDFiMa7kxLSzzNYBzyYR78H/6zs=;
        b=nKT3HtnrALOudiQHoyVKqoc+TtB01guA1BxX6Sn8VxrpcYJWNKjcZs7rPP5N+uRE8E
         79aHp2pdvQTjV75C/De119AZMsQAj2MBCgSkyJdnUd6Uok3E5eUUqVyjqLn8f2wVtb2P
         Qt590t7iAsRmb0cL005TqaK92qomHVrcqyY5m+Oe3ne8OLOOxwsqgK8VJIQns6ooPL30
         vOQtGWPV7tqWccgj6ORBNGNBkQy2tVLLBWxUGOAXIddwt0MyhrBLGtVRlg7gx+UOXo0s
         lamOhQRRqABmBTdg8NGCAzrpb6GOKvG6fAHE/4DPDYyFtI+kvuYTEg+bhi5hCJWO3EhQ
         AcQw==
X-Gm-Message-State: APjAAAV7AzwcycrNa/FFj7O1XiyRhGv+Ye0SGhBKC4ocYJ2yVVYyrzAG
        +i211vqfp0eaoI0mbhvxScmxVw==
X-Google-Smtp-Source: APXvYqwsNJqRsUaScDSVFeKcrfnQNXKYf7CsN+IusCoyenNGR11PQ6HvLabLyOiq5tnxR0X7o8uN/A==
X-Received: by 2002:a9d:7a45:: with SMTP id z5mr18205451otm.197.1561936006723;
        Sun, 30 Jun 2019 16:06:46 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n106sm2153839ota.31.2019.06.30.16.06.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Jun 2019 16:06:45 -0700 (PDT)
Date:   Sun, 30 Jun 2019 16:06:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, hch@lst.de, gkohli@codeaurora.org,
        mingo@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
In-Reply-To: <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
Message-ID: <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
References: <1559161526-618-1-git-send-email-cai@lca.pw> <20190530080358.GG2623@hirez.programming.kicks-ass.net> <82e88482-1b53-9423-baad-484312957e48@kernel.dk> <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019, Jens Axboe wrote:
> 
> How about the following plan - if folks are happy with this sched patch,
> we can queue it up for 5.3. Once that is in, I'll kill the block change
> that special cases the polled task wakeup. For 5.2, we go with Oleg's
> patch for the swap case.

I just hit the do_task_dead() kernel BUG at kernel/sched/core.c:3463!
while heavy swapping on 5.2-rc7: it looks like Oleg's patch intended
for 5.2 was not signed off, and got forgotten.

I did hit the do_task_dead() BUG (but not at all easily) on early -rcs
before seeing Oleg's patch, then folded it in and and didn't hit the BUG
again; then just tried again without it, and luckily hit in a few hours.

So I can give it an enthusiastic
Acked-by: Hugh Dickins <hughd@google.com>
because it makes good sense to avoid the get/blk_wake/put overhead on
the asynch path anyway, even if it didn't work around a bug; but only
Half-Tested-by: Hugh Dickins <hughd@google.com>
since I have not been exercising the synchronous path at all.

Hugh, requoting Oleg:

> 
> I don't understand this code at all but I am just curious, can we do
> something like incomplete patch below ?
> 
> Oleg.
> 
> --- x/mm/page_io.c
> +++ x/mm/page_io.c
> @@ -140,8 +140,10 @@ int swap_readpage(struct page *page, bool synchronous)
>  	unlock_page(page);
>  	WRITE_ONCE(bio->bi_private, NULL);
>  	bio_put(bio);
> -	blk_wake_io_task(waiter);
> -	put_task_struct(waiter);
> +	if (waiter) {
> +		blk_wake_io_task(waiter);
> +		put_task_struct(waiter);
> +	}
>  }
>  
>  int generic_swapfile_activate(struct swap_info_struct *sis,
> @@ -398,11 +400,12 @@ int swap_readpage(struct page *page, boo
>  	 * Keep this task valid during swap readpage because the oom killer may
>  	 * attempt to access it in the page fault retry time check.
>  	 */
> -	get_task_struct(current);
> -	bio->bi_private = current;
>  	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -	if (synchronous)
> +	if (synchronous) {
>  		bio->bi_opf |= REQ_HIPRI;
> +		get_task_struct(current);
> +		bio->bi_private = current;
> +	}
>  	count_vm_event(PSWPIN);
>  	bio_get(bio);
>  	qc = submit_bio(bio);
