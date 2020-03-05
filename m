Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC9B17B14B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCEWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:17:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41183 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCEWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:17:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id b5so443238qkh.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KtJH5QV8X5puZW05K9mF0ArNYyR1iSSvlLq7+eFOBlM=;
        b=e2uP7GSoZY3MnBc0ACHvh9M8AmXy5DN+nH3Je6EKcaBWHgvbfybU1DZMwrqHR6Sca3
         u+yQbP30jVphg518OYwRq3A8a655zDHGUankpC/8yJeYsozgeLujAIOw1ug14rM5RYem
         /Xl/xE4i0kmGMJSZUiMtlXYGWaEZMF1CCbONU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KtJH5QV8X5puZW05K9mF0ArNYyR1iSSvlLq7+eFOBlM=;
        b=bEWIur6cuI3HB1nauAfkJqnM8UP3xKfrEN/ovgE+dnxoKNtxx7CvGUXuINM0PlU+ev
         lrF76CMj29y3jzRJe8IdUq463pSZAZMdOldxiEz38A4AUXbbdhoOEZpawh3bPFa8Biyg
         RbUKiuTEVmlHGOJx3NOEAsHnh7Ix+AaTV9Q6+IOy2MjGhQ0giUBGDQ5c8PZEpTWYrhQs
         5CTlOXRm2m7IT/1vWkKTtEFH4yEvG4bD49dnb+twdZAbczQLAnB12XVml1IIlP6D2wmY
         oOHVNfIasXx9agSdp+XDoglrVUNRsmGBWxsvhyybz/zutOZxjj4nERNx8vYTWB6/RwHs
         md/A==
X-Gm-Message-State: ANhLgQ3Swbn3v4+xo8TxvIUX6knVD65jSw3dJrGUJcCY4UFcrQUlgENi
        akfCQT2V8RIp2DE25rpd9mEyGRGdZOE=
X-Google-Smtp-Source: ADFU+vtYq72oP3Tra1ZpNGV4aNQ+yh9RZgeUnjQ/WjvZTsnvVKjbbD3GQhQoaATOByT5hL9V8Y2S5A==
X-Received: by 2002:a05:620a:13ed:: with SMTP id h13mr180689qkl.313.1583446674322;
        Thu, 05 Mar 2020 14:17:54 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d137sm10415771qkc.99.2020.03.05.14.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:17:53 -0800 (PST)
Date:   Thu, 5 Mar 2020 17:17:53 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH linus/master 2/2] rcu/tree: Add a shrinker to prevent OOM
 due to kfree_rcu() batching
Message-ID: <20200305221753.GA66450@google.com>
References: <20200305221323.66051-1-joel@joelfernandes.org>
 <20200305221323.66051-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305221323.66051-2-joel@joelfernandes.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:13:23PM -0500, Joel Fernandes (Google) wrote:
> To reduce grace periods and improve kfree() performance, we have done
> batching recently dramatically bringing down the number of grace periods
> while giving us the ability to use kfree_bulk() for efficient kfree'ing.
> 
> However, this has increased the likelihood of OOM condition under heavy
> kfree_rcu() flood on small memory systems. This patch introduces a
> shrinker which starts grace periods right away if the system is under
> memory pressure due to existence of objects that have still not started
> a grace period.
> 
> With this patch, I do not observe an OOM anymore on a system with 512MB
> RAM and 8 CPUs, with the following rcuperf options:
> 
> rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000
> rcuperf.kfree_rcu_test=1 rcuperf.kfree_mult=2

Paul,
I may have to rebase this patch on top of Vlad's kfree_bulk() work. But let
us discuss patch and I can rebase it and repost it once patch looks Ok to
you. (The kfree_bulk() work should not affect the patch).

thanks,

 - Joel


> 
> NOTE:
> On systems with no memory pressure, the patch has no effect as intended.
> 
> Cc: urezki@gmail.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  kernel/rcu/tree.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d91c9156fab2e..28ec35e15529d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2723,6 +2723,8 @@ struct kfree_rcu_cpu {
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
>  	bool initialized;
> +	// Number of objects for which GP not started
> +	int count;
>  };
>  
>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> @@ -2791,6 +2793,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  
>  	krwp->head_free = krcp->head;
>  	krcp->head = NULL;
> +	krcp->count = 0;
>  	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
>  	queue_rcu_work(system_wq, &krwp->rcu_work);
>  	return true;
> @@ -2864,6 +2867,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	head->func = func;
>  	head->next = krcp->head;
>  	krcp->head = head;
> +	krcp->count++;
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> @@ -2879,6 +2883,58 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
>  
> +static unsigned long
> +kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +	int cpu;
> +	unsigned long flags, count = 0;
> +
> +	/* Snapshot count of all CPUs */
> +	for_each_online_cpu(cpu) {
> +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +
> +		spin_lock_irqsave(&krcp->lock, flags);
> +		count += krcp->count;
> +		spin_unlock_irqrestore(&krcp->lock, flags);
> +	}
> +
> +	return count;
> +}
> +
> +static unsigned long
> +kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +	int cpu, freed = 0;
> +	unsigned long flags;
> +
> +	for_each_online_cpu(cpu) {
> +		int count;
> +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +
> +		count = krcp->count;
> +		spin_lock_irqsave(&krcp->lock, flags);
> +		if (krcp->monitor_todo)
> +			kfree_rcu_drain_unlock(krcp, flags);
> +		else
> +			spin_unlock_irqrestore(&krcp->lock, flags);
> +
> +		sc->nr_to_scan -= count;
> +		freed += count;
> +
> +		if (sc->nr_to_scan <= 0)
> +			break;
> +	}
> +
> +	return freed;
> +}
> +
> +static struct shrinker kfree_rcu_shrinker = {
> +	.count_objects = kfree_rcu_shrink_count,
> +	.scan_objects = kfree_rcu_shrink_scan,
> +	.batch = 0,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>  void __init kfree_rcu_scheduler_running(void)
>  {
>  	int cpu;
> @@ -3774,6 +3830,8 @@ static void __init kfree_rcu_batch_init(void)
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  		krcp->initialized = true;
>  	}
> +	if (register_shrinker(&kfree_rcu_shrinker))
> +		pr_err("Failed to register kfree_rcu() shrinker!\n");
>  }
>  
>  void __init rcu_init(void)
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
