Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B503CCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfFKNLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:11:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390242AbfFKNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mXp7GfOu1REQRIFlq9C+d+O/GeRzxbASf2pcGXMeKhE=; b=aLUiKbmukQrL/U1LPPsjrJ+0O
        ChvbrLtjGXC9SZMNEwtoYmpcNyyDqle2WwDidzWiQWLzhoa9T32xbRnaVLVfxFK74e+Anw3A5VEjt
        jDaP5+mB0EJ06W8qaX2r7RPVnEuQQJsxzypyMOJBHFk7N4HTy70/y5+3yiPba78ttKqxOqh4dtjgH
        oUEjUgsgyIt1qrKrQejBbhQaIyihLg/BgSbQHlQcMo9ZjWw9bLo6xzQuNA0j35JKGZfVaA1anIUQl
        +1CucbkmJ7uiPq0KleCAQAlstwyoaO3/7siMLbq33B0/vqbIBEiKQKI71xc64Gqipdd5QTm2ulEn3
        7/pygxh+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hagYn-0003q6-H1; Tue, 11 Jun 2019 13:11:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 661F920234FA3; Tue, 11 Jun 2019 15:11:31 +0200 (CEST)
Date:   Tue, 11 Jun 2019 15:11:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 16/19] locking/rwsem: Guard against making count
 negative
Message-ID: <20190611131131.GG3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-17-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-17-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:15PM -0400, Waiman Long wrote:

> +static inline long rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
> +{
> +	long adjustment = -RWSEM_READER_BIAS;
> +
> +	*cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);

I'm thinking we'd actually want add_return_acquire() here.

> +	if (unlikely(*cnt < 0)) {
> +		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> +		adjustment = 0;
> +	}
> +	return adjustment;
> +}

> @@ -1271,9 +1332,10 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
>   */
>  inline void __down_read(struct rw_semaphore *sem)
>  {
> +	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
> +
> +	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
> +		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, adjustment);
>  		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>  	} else {
>  		rwsem_set_reader_owned(sem);
> @@ -1282,9 +1344,11 @@ inline void __down_read(struct rw_semaphore *sem)
>  
>  static inline int __down_read_killable(struct rw_semaphore *sem)
>  {
> +	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
> +
> +	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
> +		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
> +						    adjustment)))
>  			return -EINTR;
>  		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>  	} else {

I'm confused by the need for @tmp; isn't that returning the exact same
state !adjustment is?

Also; half the patch seems to do cnt<0, while the other half (above)
does &READ_FAILED, what gives?
