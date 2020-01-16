Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72EC13D166
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 02:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAPBON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 20:14:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35363 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAPBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:14:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so7605422plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EIPzTGXgt0b2KsdT5+8NfDM27wAq3dacOy5E2SHm7CU=;
        b=hjd60ti0T1XgqLNsXYvCyqGSIJE43kWhZS1um57CKMqBIis1MlILWYu8AOAdecLq3C
         P0STBPZJuprti7qVCJ3o49b+f9HujKHmX6uNxKxtjYgkwjBpN9e0Jfo22KPSQ6NF+uYC
         1LNqZJVE00yJzCmEtQYdKA/xiwkPtvWHvcQ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EIPzTGXgt0b2KsdT5+8NfDM27wAq3dacOy5E2SHm7CU=;
        b=OBGfaMiE74mAW/vM6243jwInAo94WpA1evjN2bnOIWsL2tRQYJPODHpjctQypxUGaQ
         EajevegNg87QIdsaf2b5htczTP6SbE7HP1ceZsrpqEk7VWZI4s6USksBsGr4Zrp60eGD
         t+CZN/oHh7lnZIID4RMI0TBmK4CoKpEFjZqOaWsNt9e/v+YJsEQMK8uV/f55zXmbjQ/l
         NLjX0GPLS3Lb3XZqdKEmTF8yc826eNJOcbZQDrWF4PeeBr8DN5XJxMXLqaJk3L+NNnOH
         +GYekg5Lsdjs4iIWlo4pirCqY6ES1vHwNWKWNMYN2kBBJ9yD5PXZEYaHTNeqWR8GVxJv
         0a4w==
X-Gm-Message-State: APjAAAUAvp6kmQq/5ldCp8RjHp4lBTYnwpcCayK2mEhzCdsWcGo1XpPu
        MqBJoKibQfLAP5ZiPXbR9DCVtw==
X-Google-Smtp-Source: APXvYqxWhvcJDmEfpklxoydZOR/XfGw65Mv8/A7RQGlp2oSNhtVW/9cShBodQGWxaav8eZg9xeSRtQ==
X-Received: by 2002:a17:90a:fb4f:: with SMTP id iq15mr3546521pjb.86.1579137252096;
        Wed, 15 Jan 2020 17:14:12 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v8sm22738914pff.151.2020.01.15.17.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 17:14:11 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:14:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200116011410.GC246464@google.com>
References: <20191231122241.5702-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231122241.5702-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 01:22:41PM +0100, Uladzislau Rezki (Sony) wrote:
> kfree_rcu() logic can be improved further by using kfree_bulk()
> interface along with "basic batching support" introduced earlier.
> 
> The are at least two advantages of using "bulk" interface:
> - in case of large number of kfree_rcu() requests kfree_bulk()
>   reduces the per-object overhead caused by calling kfree()
>   per-object.
> 
> - reduces the number of cache-misses due to "pointer chasing"
>   between objects which can be far spread between each other.
> 
> This approach defines a new kfree_rcu_bulk_data structure that
> stores pointers in an array with a specific size. Number of entries
> in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
> structure to be exactly one page.
> 
> Since it deals with "block-chain" technique there is an extra
> need in dynamic allocation when a new block is required. Memory
> is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
> allows to skip direct reclaim under low memory condition to
> prevent stalling and fails silently under high memory pressure.
> 
> The "emergency path" gets maintained when a system is run out
> of memory. In that case objects are linked into regular list
> and that is it.
> 
> In order to evaluate it, the "rcuperf" was run to analyze how
> much memory is consumed and what is kfree_bulk() throughput.
> 
> Testing on the HiKey-960, arm64, 8xCPUs with below parameters:
> 
> CONFIG_SLAB=y
> kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> 
> 102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
> 89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB
> 
> rcuperf shows approximately ~12% better throughput(Total time)
> in case of using "bulk" interface. The "drain logic" or its RCU
> callback does the work faster that leads to better throughput.

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

(Vlad is going to post a v2 which fixes a debugobjects bug but that should
not have any impact on testing).

thanks,

 - Joel



> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 154 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 130 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 48fba2257748..4ee5c737558b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2754,22 +2754,45 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  #define KFREE_DRAIN_JIFFIES (HZ / 50)
>  #define KFREE_N_BATCHES 2
>  
> +/*
> + * This macro defines how many entries the "records" array
> + * will contain. It is based on the fact that the size of
> + * kfree_rcu_bulk_data structure becomes exactly one page.
> + */
> +#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 2)
> +
> +/**
> + * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
> + * @nr_records: Number of active pointers in the array
> + * @records: Array of the kfree_rcu() pointers
> + * @next: Next bulk object in the block chain
> + */
> +struct kfree_rcu_bulk_data {
> +	unsigned long nr_records;
> +	void *records[KFREE_BULK_MAX_ENTR];
> +	struct kfree_rcu_bulk_data *next;
> +};
> +
>  /**
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
>   * @head_free: List of kfree_rcu() objects waiting for a grace period
> + * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
>   * @krcp: Pointer to @kfree_rcu_cpu structure
>   */
>  
>  struct kfree_rcu_cpu_work {
>  	struct rcu_work rcu_work;
>  	struct rcu_head *head_free;
> +	struct kfree_rcu_bulk_data *bhead_free;
>  	struct kfree_rcu_cpu *krcp;
>  };
>  
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> + * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
> + * @bcached: Keeps at most one object for later reuse when build chain blocks
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> @@ -2783,6 +2806,8 @@ struct kfree_rcu_cpu_work {
>   */
>  struct kfree_rcu_cpu {
>  	struct rcu_head *head;
> +	struct kfree_rcu_bulk_data *bhead;
> +	struct kfree_rcu_bulk_data *bcached;
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	spinlock_t lock;
>  	struct delayed_work monitor_work;
> @@ -2800,6 +2825,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  {
>  	unsigned long flags;
>  	struct rcu_head *head, *next;
> +	struct kfree_rcu_bulk_data *bhead, *bnext;
>  	struct kfree_rcu_cpu *krcp;
>  	struct kfree_rcu_cpu_work *krwp;
>  
> @@ -2809,22 +2835,39 @@ static void kfree_rcu_work(struct work_struct *work)
>  	spin_lock_irqsave(&krcp->lock, flags);
>  	head = krwp->head_free;
>  	krwp->head_free = NULL;
> +	bhead = krwp->bhead_free;
> +	krwp->bhead_free = NULL;
>  	spin_unlock_irqrestore(&krcp->lock, flags);
>  
> -	// List "head" is now private, so traverse locklessly.
> +	/* List "bhead" is now private, so traverse locklessly. */
> +	for (; bhead; bhead = bnext) {
> +		bnext = bhead->next;
> +
> +		rcu_lock_acquire(&rcu_callback_map);
> +		kfree_bulk(bhead->nr_records, bhead->records);
> +		rcu_lock_release(&rcu_callback_map);
> +
> +		if (cmpxchg(&krcp->bcached, NULL, bhead))
> +			free_page((unsigned long) bhead);
> +
> +		cond_resched_tasks_rcu_qs();
> +	}
> +
> +	/*
> +	 * Emergency case only. It can happen under low memory
> +	 * condition when an allocation gets failed, so the "bulk"
> +	 * path can not be temporary maintained.
> +	 */
>  	for (; head; head = next) {
>  		unsigned long offset = (unsigned long)head->func;
>  
>  		next = head->next;
> -		// Potentially optimize with kfree_bulk in future.
>  		debug_rcu_head_unqueue(head);
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
> -			/* Could be optimized with kfree_bulk() in future. */
> +		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
>  			kfree((void *)head - offset);
> -		}
>  
>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
> @@ -2839,26 +2882,45 @@ static void kfree_rcu_work(struct work_struct *work)
>   */
>  static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  {
> +	struct kfree_rcu_cpu_work *krwp;
> +	bool queued = false;
>  	int i;
> -	struct kfree_rcu_cpu_work *krwp = NULL;
>  
>  	lockdep_assert_held(&krcp->lock);
> -	for (i = 0; i < KFREE_N_BATCHES; i++)
> -		if (!krcp->krw_arr[i].head_free) {
> -			krwp = &(krcp->krw_arr[i]);
> -			break;
> -		}
>  
> -	// If a previous RCU batch is in progress, we cannot immediately
> -	// queue another one, so return false to tell caller to retry.
> -	if (!krwp)
> -		return false;
> +	for (i = 0; i < KFREE_N_BATCHES; i++) {
> +		krwp = &(krcp->krw_arr[i]);
>  
> -	krwp->head_free = krcp->head;
> -	krcp->head = NULL;
> -	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
> -	queue_rcu_work(system_wq, &krwp->rcu_work);
> -	return true;
> +		/*
> +		 * Try to detach bhead or head and attach it over any
> +		 * available corresponding free channel. It can be that
> +		 * a previous RCU batch is in progress, it means that
> +		 * immediately to queue another one is not possible so
> +		 * return false to tell caller to retry.
> +		 */
> +		if ((krcp->bhead && !krwp->bhead_free) ||
> +				(krcp->head && !krwp->head_free)) {
> +			if (!krwp->bhead_free) {
> +				krwp->bhead_free = krcp->bhead;
> +				krcp->bhead = NULL;
> +			}
> +
> +			if (!krwp->head_free) {
> +				krwp->head_free = krcp->head;
> +				krcp->head = NULL;
> +			}
> +
> +			/*
> +			 * The work can already be queued. If so, it means that
> +			 * within a short time, second, either head or bhead has
> +			 * been detached as well.
> +			 */
> +			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queued = true;
> +		}
> +	}
> +
> +	return queued;
>  }
>  
>  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> @@ -2895,6 +2957,39 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> +static inline bool
> +kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> +{
> +	struct kfree_rcu_bulk_data *bnode;
> +
> +	if (unlikely(!krcp->initialized))
> +		return false;
> +
> +	lockdep_assert_held(&krcp->lock);
> +
> +	/* Check if a new block is required. */
> +	if (!krcp->bhead ||
> +			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> +		bnode = xchg(&krcp->bcached, NULL);
> +		if (!bnode)
> +			bnode = (struct kfree_rcu_bulk_data *)
> +				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +
> +		/* No cache or an allocation got failed. */
> +		if (unlikely(!bnode))
> +			return false;
> +
> +		/* Initialize the new block. */
> +		bnode->nr_records = 0;
> +		bnode->next = krcp->bhead;
> +		krcp->bhead = bnode;
> +	}
> +
> +	/* Finally insert. */
> +	krcp->bhead->records[krcp->bhead->nr_records++] = ptr;
> +	return true;
> +}
> +
>  /*
>   * Queue a request for lazy invocation of kfree() after a grace period.
>   *
> @@ -2926,9 +3021,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  			  __func__, head);
>  		goto unlock_return;
>  	}
> -	head->func = func;
> -	head->next = krcp->head;
> -	krcp->head = head;
> +
> +	/*
> +	 * Under high memory pressure GFP_NOWAIT can fail,
> +	 * in that case the emergency path is maintained.
> +	 */
> +	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp,
> +			(void *) head - (unsigned long) func))) {
> +		head->func = func;
> +		head->next = krcp->head;
> +		krcp->head = head;
> +	}
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> @@ -3834,8 +3937,11 @@ static void __init kfree_rcu_batch_init(void)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		spin_lock_init(&krcp->lock);
> -		for (i = 0; i < KFREE_N_BATCHES; i++)
> +		for (i = 0; i < KFREE_N_BATCHES; i++) {
> +			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
> +		}
> +
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  		krcp->initialized = true;
>  	}
> -- 
> 2.20.1
> 
