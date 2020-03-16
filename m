Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761AC186EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgCPPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 11:45:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41105 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgCPPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:45:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id s11so15637781qks.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iPNljTvaNQWCaWWd+vx+ooVAx+tFkyrnFRq/mDa1B3o=;
        b=xASkp0ELycx94keGFplut2ZJepIWff6JG29vLYTzBDCXELBqwOApx/O95qEZIpwLx6
         rV6zcuHnLyKopl/05+nOQOjdSAkzg99WfxRqHERZPd36n1n1rinnnBGhMhZrEwT73txX
         Z1kFlSVIu46eiPzmOBPbOfL7zwI0MmgtRHMlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPNljTvaNQWCaWWd+vx+ooVAx+tFkyrnFRq/mDa1B3o=;
        b=hUdokgsBlGccOAC1OsBR6ib426grzv/t3zmDhvg79Kj9RKe80OsEgBht25gsJAXMfH
         CqsEWn7SALrHl5DvLGwOkR+Q+sc3Up/USRg6OqVE93TDBSevHBQpXzEKQQ3nFHTiR4Mp
         eTyEmJc/UfLYxptHJy7q6IIfvkKZf5z8TqSAdi/nx6dBaq8vl3tr7kFCPWEn7m43WU0d
         rEMEa28VcrH6pOX8nB341QJEuqAzxfHRXjAgWKqGCHoTdSmCOevAlNy3cPYDb1tFHSV1
         XYEQrTupSiX3gX+qNa1FM8ol5SBJA1X1gQyA+Tu0PeNXEltcPHHMtdMROsCR3bhYwevU
         tl8w==
X-Gm-Message-State: ANhLgQ1yemMIhgmcr9CoGpmkkmXfAEbWaZHfmYkU0gkjpXio+xvYBs3h
        Ho0t0a2Wvs9O0oE4P57c4i5hxw==
X-Google-Smtp-Source: ADFU+vsJMfZRY3mlCkPyTW2oKMTrq4Mr9dzfkEoKA2N+q+jThPaXqV1pJCzsoXMgRwiSP12fMLf6bw==
X-Received: by 2002:a05:620a:21ce:: with SMTP id h14mr240002qka.363.1584373540502;
        Mon, 16 Mar 2020 08:45:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z18sm23887qtz.77.2020.03.16.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:45:40 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:45:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 2/6] rcu: introduce kvfree_rcu() interface
Message-ID: <20200316154539.GE190951@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315181840.6966-3-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 07:18:36PM +0100, Uladzislau Rezki (Sony) wrote:
> kvfree_rcu() can deal with an allocated memory that is obtained
> via kvmalloc(). It can return two types of allocated memory or
> "pointers", one can belong to regular SLAB allocator and another
> one can be vmalloc one. It depends on requested size and memory
> pressure.
> 
> Based on that, two streams are split, thus if a pointer belongs
> to vmalloc allocator it is queued to the list, otherwise SLAB
> one is queued into "bulk array" for further processing.
> 
> The main reason of such splitting is:
>     a) to distinguish kmalloc()/vmalloc() ptrs;
>     b) there is no vmalloc_bulk() interface.
> 
> As of now we have list_lru.c user that needs such interface,
> also there will be new comers. Apart of that it is preparation
> to have a head-less variant later.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h |  9 +++++++++
>  kernel/rcu/tiny.c        |  3 ++-
>  kernel/rcu/tree.c        | 17 ++++++++++++-----
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 2be97a83f266..bb270221dbdc 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -845,6 +845,15 @@ do {									\
>  		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
>  } while (0)
>  
> +/**
> + * kvfree_rcu() - kvfree an object after a grace period.
> + * @ptr:	pointer to kvfree
> + * @rhf:	the name of the struct rcu_head within the type of @ptr.
> + *
> + * Same as kfree_rcu(), just simple alias.
> + */
> +#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
> +
>  /*
>   * Place this after a lock-acquisition primitive to guarantee that
>   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index dd572ce7c747..4b99f7b88bee 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpu.h>
>  #include <linux/prefetch.h>
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  
>  #include "rcu.h"
>  
> @@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  	rcu_lock_acquire(&rcu_callback_map);
>  	if (__is_kfree_rcu_offset(offset)) {
>  		trace_rcu_invoke_kfree_callback("", head, offset);
> -		kfree((void *)head - offset);
> +		kvfree((void *)head - offset);
>  		rcu_lock_release(&rcu_callback_map);
>  		return true;
>  	}
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2f4c91a3713a..1c0a73616872 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
>  	}
>  
>  	/*
> -	 * Emergency case only. It can happen under low memory
> -	 * condition when an allocation gets failed, so the "bulk"
> -	 * path can not be temporary maintained.
> +	 * vmalloc() pointers end up here also emergency case. It can

Suggest rephrase for clarity:

nit: We can end up here either with 1) vmalloc() pointers or 2) low on memory
and could not allocate a bulk array.

thanks,

 - Joel


> +	 * happen under low memory condition when an allocation gets
> +	 * failed, so the "bulk" path can not be temporary maintained.
>  	 */
>  	for (; head; head = next) {
>  		unsigned long offset = (unsigned long)head->func;
> @@ -2912,7 +2912,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
>  
>  		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
> -			kfree((void *)head - offset);
> +			kvfree((void *)head - offset);
>  
>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
> @@ -3084,10 +3084,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  
>  	/*
> +	 * We do not queue vmalloc pointers into array,
> +	 * instead they are just queued to the list. We
> +	 * do it because of:
> +	 *    a) to distinguish kmalloc()/vmalloc() ptrs;
> +	 *    b) there is no vmalloc_bulk() interface.
> +	 *
>  	 * Under high memory pressure GFP_NOWAIT can fail,
>  	 * in that case the emergency path is maintained.
>  	 */
> -	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> +	if (is_vmalloc_addr((void *) head - (unsigned long) func) ||
> +			!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
>  		head->func = func;
>  		head->next = krcp->head;
>  		krcp->head = head;
> -- 
> 2.20.1
> 
