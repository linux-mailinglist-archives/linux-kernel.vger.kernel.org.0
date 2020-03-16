Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73E186F09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 16:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgCPPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 11:48:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40976 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbgCPPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:48:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id s11so15657692qks.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XurdrTIrr9xQaIPprYsyVcQx7FmMjZZB/eYQB/VnuIM=;
        b=j9zyO+Pp0APRFZGMmJsa1YYnNX9Rg0QlgRJWqzN6a5ZZFLevRfvcFOaJUfy9GQ4k4Z
         mg0VC/ib0MMNRSy8wSRCmkNOkRssgtdyMqlHSwoiJRZEJiMIwMp0RN4zhtrE6dxQbpwh
         ykMcugAS01a9i/BJ33BTla5Jsktu9Kcg5eiJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XurdrTIrr9xQaIPprYsyVcQx7FmMjZZB/eYQB/VnuIM=;
        b=bYQLDb4TE6fQjZ/Jnx5C5tvH/6thHNMDWp33GsXuvvtgJqj3QLenKfdtkurYjkTBVw
         LPGsRD6n2V2YWCyec9kXKSUoBnyth8epwo251oUeSPR5hYeOQAEphIYYKaaskboxxuYB
         1g+EKjOzK3hcNEZlA1pMTVlUL3bsMRd4nFAsbcYQSauNxek9rC2OiEH4t59v9xEWDVl9
         7jjasnWCk9mR9VL4WSSnCXNuVvmDiucpMYt+GzLhqH/anK9NTzU6a8K8plSwLTmC8oY9
         HnYvULwyWVXSLgKeUY9+/qLzHGRWzf+vX1dya6Y/RrQALSspM0OOLlQFOy41ZwMg6GIc
         hxMA==
X-Gm-Message-State: ANhLgQ3od0R7n/xhPs7SdBcsqYvommeKiG2hR5t+lCpOoespIaA0QyOm
        fLHBG9yU7dQE3QRrB0Xa+ulB2Q==
X-Google-Smtp-Source: ADFU+vuzzXmxnpTUeVbLFafj9YIBVVISf2aXvBqs4CSDGa40AcDcH5WrgiHjtvpfjk3hxJ7wfODm+A==
X-Received: by 2002:a37:987:: with SMTP id 129mr305727qkj.83.1584373731404;
        Mon, 16 Mar 2020 08:48:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c12sm44657qtb.49.2020.03.16.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:48:51 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:48:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/6] rcu: rename __is_kfree_rcu_offset() macro
Message-ID: <20200316154850.GG190951@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315181840.6966-5-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 07:18:38PM +0100, Uladzislau Rezki (Sony) wrote:
> Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset.
> All RCU paths use kvfree() now instead of kfree(), thus
> rename it.

This patch LGTM:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 6 +++---
>  kernel/rcu/tiny.c        | 2 +-
>  kernel/rcu/tree.c        | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index bb270221dbdc..e4961631a44f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -798,16 +798,16 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  
>  /*
>   * Does the specified offset indicate that the corresponding rcu_head
> - * structure can be handled by kfree_rcu()?
> + * structure can be handled by kvfree_rcu()?
>   */
> -#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
> +#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
>  
>  /*
>   * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
>   */
>  #define __kfree_rcu(head, offset) \
>  	do { \
> -		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
> +		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
>  		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
>  	} while (0)
>  
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 3dd8e6e207b0..aa897c3f2e92 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -85,7 +85,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  	unsigned long offset = (unsigned long)head->func;
>  
>  	rcu_lock_acquire(&rcu_callback_map);
> -	if (__is_kfree_rcu_offset(offset)) {
> +	if (__is_kvfree_rcu_offset(offset)) {
>  		trace_rcu_invoke_kvfree_callback("", head, offset);
>  		kvfree((void *)head - offset);
>  		rcu_lock_release(&rcu_callback_map);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index eef75cd210fd..bb9544238396 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2719,7 +2719,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		return; // Enqueued onto ->nocb_bypass, so just leave.
>  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
>  	rcu_segcblist_enqueue(&rdp->cblist, head);
> -	if (__is_kfree_rcu_offset((unsigned long)func))
> +	if (__is_kvfree_rcu_offset((unsigned long)func))
>  		trace_rcu_kvfree_callback(rcu_state.name, head,
>  					 (unsigned long)func,
>  					 rcu_segcblist_n_cbs(&rdp->cblist));
> @@ -2911,7 +2911,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
> +		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
>  			kvfree((void *)head - offset);
>  
>  		rcu_lock_release(&rcu_callback_map);
> -- 
> 2.20.1
> 
