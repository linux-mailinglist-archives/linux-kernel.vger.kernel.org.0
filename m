Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38E9151E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEFQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 12:50:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfEFQuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2BB07E43D;
        Mon,  6 May 2019 16:50:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id B47F75EDE4;
        Mon,  6 May 2019 16:50:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  6 May 2019 18:50:19 +0200 (CEST)
Date:   Mon, 6 May 2019 18:50:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, jack@suse.com,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190506165009.GA28959@redhat.com>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
 <20190502114258.GB7323@redhat.com>
 <20190503145059.GC2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503145059.GC2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 06 May 2019 16:50:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03, Peter Zijlstra wrote:
>
> -static void lockdep_sb_freeze_release(struct super_block *sb)
> -{
> -	int level;
> -
> -	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
> -		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> -}
> -
> -/*
> - * Tell lockdep we are holding these locks before we call ->unfreeze_fs(sb).
> - */
> -static void lockdep_sb_freeze_acquire(struct super_block *sb)
> -{
> -	int level;
> -
> -	for (level = 0; level < SB_FREEZE_LEVELS; ++level)
> -		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> +	percpu_down_write_non_owner(sb->s_writers.rw_sem + level-1);
>  }

I'd suggest to not change fs/super.c, keep these helpers, and even not introduce
xxx_write_non_owner().

freeze_super() takes other locks, it calls sync_filesystem(), freeze_fs(), lockdep
should know that this task holds SB_FREEZE_XXX locks for writing.


> @@ -80,14 +83,8 @@ int __percpu_down_read(struct percpu_rw_
>  	 * and reschedule on the preempt_enable() in percpu_down_read().
>  	 */
>  	preempt_enable_no_resched();
> -
> -	/*
> -	 * Avoid lockdep for the down/up_read() we already have them.
> -	 */
> -	__down_read(&sem->rw_sem);
> +	wait_event(sem->waiters, !atomic_read(&sem->block));
>  	this_cpu_inc(*sem->read_count);

Argh, this looks racy :/

Suppose that sem->block == 0 when wait_event() is called, iow the writer released
the lock.

Now suppose that this __percpu_down_read() races with another percpu_down_write().
The new writer can set sem->block == 1 and call readers_active_check() in between,
after wait_event() and before this_cpu_inc(*sem->read_count).

Oleg.

