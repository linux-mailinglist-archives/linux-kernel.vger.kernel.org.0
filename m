Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFEB161C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 00:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfILWJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 18:09:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35169 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfILWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:09:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so7450756plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e1NxeIc8kdbb1mtpMHLFI7ESi2lNJyG1ruAa5EmaZJI=;
        b=W/5NCKT5I0KAKwvDWMakHiNM3E2P2jPhKQFcWA+DTfZmRgSQFOnwamoRDtGHE33Hic
         K6PiVIEBtnBXT8+rpGTlyjxYYuQpJFgdLPwuJFKdz/1qr+b9f/G9m4D/Mmh8UAZhU5WW
         qFfI81VKGdvvCdnf80fEBZGdfr2L/iTKni4CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1NxeIc8kdbb1mtpMHLFI7ESi2lNJyG1ruAa5EmaZJI=;
        b=dRpxZhtT1CIDNUQ/et6grUR8z28mh2of9Le9BVKyv0CpwwPA/Xw6rL0tzRopTHsdua
         vC1nARkc1gAnfXZ8ZC34/xkcwBWrGlKrjZ39MuXeniZFUyZSZ2QKrewrGMs/EkmxLY/5
         cpbRb/1DB9DwNGje84txtUrnH+RhYF2DMFee5CX7uoiYEIAWTBZmhmhqZfaKYy6UMuh4
         ppsgZPDAw3gEqTjxq4FZ+ILRbXbeEb6kINXI60jT0oJR+NBWESX6K6T0GC1tgQXt4OQh
         jLdQrhynGY+UpsDPX+fwuJUiHD1b2I+xdjjhOAOURWYsy8krkSMQbEWYMDOZL2lCjp4p
         APfw==
X-Gm-Message-State: APjAAAWBkaquQvI8uwokfKKxC2YKcedEjIBbE88W0k3KeewqAlRyyJii
        TG90Bxj8GY9VObnj9JrSGT/rUQ==
X-Google-Smtp-Source: APXvYqymEWxw8JW732tbtAlQJU1m3Y+4Qy5o7vaXWkDd5px6WpRvlu/Jz3J7LJ2MAKYYTNR8raF03g==
X-Received: by 2002:a17:902:fe91:: with SMTP id x17mr1255401plm.106.1568326182396;
        Thu, 12 Sep 2019 15:09:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm41501297pfq.121.2019.09.12.15.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:09:41 -0700 (PDT)
Date:   Thu, 12 Sep 2019 18:09:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 1/5] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190912220940.GB150506@google.com>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-2-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911165729.11178-2-swood@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 05:57:25PM +0100, Scott Wood wrote:
> A plain local_bh_disable() is documented as creating an RCU critical
> section, and (at least) rcutorture expects this to be the case.  However,
> in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> preempt_count() directly.  Even if RCU were changed to check
> in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> 
> Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> rcu_read_lock_bh_held() accordingly.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
> v3: Remove change to rcu_read_lock_bh_held(), and move debug portions
> of rcu_read_[un]lock_bh() to separate functions
> ---
>  include/linux/rcupdate.h | 40 ++++++++++++++++++++++++++++++++--------
>  kernel/softirq.c         | 12 +++++++++---
>  2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 388ace315f32..9ce7c5006a5e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -600,6 +600,36 @@ static inline void rcu_read_unlock(void)
>  	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +/*
> + * On RT, local_bh_disable() calls rcu_read_lock() -- no need to
> + * track it twice.
> + */
> +static inline void rcu_bh_lock_acquire(void)
> +{
> +}
> +
> +static inline void rcu_bh_lock_release(void)
> +{
> +}
> +#else
> +static inline void rcu_bh_lock_acquire(void)
> +{
> +	__acquire(RCU_BH);
> +	rcu_lock_acquire(&rcu_bh_lock_map);
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> +			 "rcu_read_lock_bh() used illegally while idle");
> +}
> +
> +static inline void rcu_bh_lock_release(void)
> +{
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> +			 "rcu_read_unlock_bh() used illegally while idle");
> +	rcu_lock_release(&rcu_bh_lock_map);
> +	__release(RCU_BH);
> +}
> +#endif
> +
>  /**
>   * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
>   *
> @@ -615,10 +645,7 @@ static inline void rcu_read_unlock(void)
>  static inline void rcu_read_lock_bh(void)
>  {
>  	local_bh_disable();
> -	__acquire(RCU_BH);
> -	rcu_lock_acquire(&rcu_bh_lock_map);
> -	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> -			 "rcu_read_lock_bh() used illegally while idle");
> +	rcu_bh_lock_acquire();
>  }
>  
>  /*
> @@ -628,10 +655,7 @@ static inline void rcu_read_lock_bh(void)
>   */
>  static inline void rcu_read_unlock_bh(void)
>  {
> -	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> -			 "rcu_read_unlock_bh() used illegally while idle");
> -	rcu_lock_release(&rcu_bh_lock_map);
> -	__release(RCU_BH);
> +	rcu_bh_lock_release();
>  	local_bh_enable();
>  }
>  
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index d16d080a74f7..6080c9328df1 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -115,8 +115,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>  	long soft_cnt;
>  
>  	WARN_ON_ONCE(in_irq());
> -	if (!in_atomic())
> +	if (!in_atomic()) {
>  		local_lock(bh_lock);
> +		rcu_read_lock();
> +	}
>  	soft_cnt = this_cpu_inc_return(softirq_counter);
>  	WARN_ON_ONCE(soft_cnt == 0);
>  	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
> @@ -151,8 +153,10 @@ void _local_bh_enable(void)
>  #endif
>  
>  	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
> -	if (!in_atomic())
> +	if (!in_atomic()) {
> +		rcu_read_unlock();
>  		local_unlock(bh_lock);
> +	}
>  }
>  
>  void _local_bh_enable_rt(void)
> @@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	WARN_ON_ONCE(count < 0);
>  	local_irq_enable();
>  
> -	if (!in_atomic())
> +	if (!in_atomic()) {
> +		rcu_read_unlock();
>  		local_unlock(bh_lock);
> +	}
>  
>  	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
>  	preempt_check_resched();
> -- 
> 1.8.3.1
> 
