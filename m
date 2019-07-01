Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27968252A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfEUOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:49:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34270 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:49:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so29854054eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7IOMcNShzp88plVKB970+NE4F+uWKbqTavdIwV9VTZU=;
        b=K2u0HR8GjjPph9aWDUMgbUTkdaGHORgnlhQ5O+jE9OPB0bYVQnJ1ODz4blADryQtdX
         pa0G0gEFYE0rz9UvMpOgqbe+rbO0ivH/HD50iXsv/+brZ/19ysThpf/RfyS0dqkSUiG2
         Of+EbAXOcS1PLLjYqc3MNnAPJwN2wV4XxglRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7IOMcNShzp88plVKB970+NE4F+uWKbqTavdIwV9VTZU=;
        b=lU/NJ7Q4x4VYWsvTt6Cy1FoWc6xjS+FP/qbeSaMY9vWOQKxYZEz0qM8ftUOP7knR78
         PMhJJ1ndU3+WjJYT+NggSucFxASbBbLrP+p53xdB+giB02itwcsgSn1R8keFrVnQKoSJ
         UCHysHQOzpBuVtP6NLqP+6+8Vr4ge7pXmEKKmCm6tWi0bN2Pm/RgCgV4DSpG5ruaejMz
         tLSi+B/aZzKVFXiyzhvwA08InB1L6MVZHlbOZaxhMcU4pXq1QP1yl8IVGbNQUvjefyfT
         T/58T8tskAEdoqmEeNJWGqJf6U/wfZb/hu2ce0qhTzAjtq33ZoxNL8LGf0PxpMV/PKRf
         jA8Q==
X-Gm-Message-State: APjAAAWP7+RIRi7JBjCyuitFm5EULudhd2ftqzMCGG6nMAc/JOxXQ770
        z+foYdFNoZrU20oFVnRAfEf89w==
X-Google-Smtp-Source: APXvYqytIZu/6anacKvD69vhQKlzZMTSzIMEvW9ZHTiye+AtpdGee4CjEbWTItKCYEIqDaw+ejs+4Q==
X-Received: by 2002:a50:8808:: with SMTP id b8mr54195428edb.202.1558450137617;
        Tue, 21 May 2019 07:48:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t19sm3558423ejq.51.2019.05.21.07.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 07:48:56 -0700 (PDT)
Date:   Tue, 21 May 2019 16:48:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add non_block_start/end()
Message-ID: <20190521144854.GP21222@phenom.ffwll.local>
Mail-Followup-To: Michal Hocko <mhocko@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190521100611.10089-1-daniel.vetter@ffwll.ch>
 <20190521104638.GO32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521104638.GO32329@dhcp22.suse.cz>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:46:38PM +0200, Michal Hocko wrote:
> On Tue 21-05-19 12:06:11, Daniel Vetter wrote:
> > In some special cases we must not block, but there's not a
> > spinlock, preempt-off, irqs-off or similar critical section already
> > that arms the might_sleep() debug checks. Add a non_block_start/end()
> > pair to annotate these.
> > 
> > This will be used in the oom paths of mmu-notifiers, where blocking is
> > not allowed to make sure there's forward progress. Quoting Michal:
> > 
> > "The notifier is called from quite a restricted context - oom_reaper -
> > which shouldn't depend on any locks or sleepable conditionals. The code
> > should be swift as well but we mostly do care about it to make a forward
> > progress. Checking for sleepable context is the best thing we could come
> > up with that would describe these demands at least partially."
> > 
> > Peter also asked whether we want to catch spinlocks on top, but Michal
> > said those are less of a problem because spinlocks can't have an
> > indirect dependency upon the page allocator and hence close the loop
> > with the oom reaper.
> > 
> > Suggested by Michal Hocko.
> > 
> > v2:
> > - Improve commit message (Michal)
> > - Also check in schedule, not just might_sleep (Peter)
> > 
> > v3: It works better when I actually squash in the fixup I had lying
> > around :-/
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: "Christian K�nig" <christian.koenig@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "J�r�me Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Wei Wang <wvw@google.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Christian K�nig <christian.koenig@amd.com> (v1)
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> I like this in general. The implementation looks reasonable to me but I
> didn't check deeply enough to give my R-by or A-by.

Thanks for all your comments. I'll ask Jerome Glisse to look into this, I
think it'd could be useful for all the HMM work too.

And I sent this out without reply-to the patch it's supposed to replace,
will need to do that again so patchwork and 0day pick up the correct
series. Sry about that noise :-/
-Daniel

> 
> > ---
> >  include/linux/kernel.h | 10 +++++++++-
> >  include/linux/sched.h  |  4 ++++
> >  kernel/sched/core.c    | 19 ++++++++++++++-----
> >  3 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 74b1ee9027f5..b5f2c2ff0eab 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -214,7 +214,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> >   * might_sleep - annotation for functions that can sleep
> >   *
> >   * this macro will print a stack trace if it is executed in an atomic
> > - * context (spinlock, irq-handler, ...).
> > + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> > + * not allowed can be annotated with non_block_start() and non_block_end()
> > + * pairs.
> >   *
> >   * This is a useful debugging help to be able to catch problems early and not
> >   * be bitten later when the calling function happens to sleep when it is not
> > @@ -230,6 +232,10 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> >  # define cant_sleep() \
> >  	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
> >  # define sched_annotate_sleep()	(current->task_state_change = 0)
> > +# define non_block_start() \
> > +	do { current->non_block_count++; } while (0)
> > +# define non_block_end() \
> > +	do { WARN_ON(current->non_block_count-- == 0); } while (0)
> >  #else
> >    static inline void ___might_sleep(const char *file, int line,
> >  				   int preempt_offset) { }
> > @@ -238,6 +244,8 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> >  # define might_sleep() do { might_resched(); } while (0)
> >  # define cant_sleep() do { } while (0)
> >  # define sched_annotate_sleep() do { } while (0)
> > +# define non_block_start() do { } while (0)
> > +# define non_block_end() do { } while (0)
> >  #endif
> >  
> >  #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 11837410690f..7f5b293e72df 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -908,6 +908,10 @@ struct task_struct {
> >  	struct mutex_waiter		*blocked_on;
> >  #endif
> >  
> > +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > +	int				non_block_count;
> > +#endif
> > +
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> >  	unsigned int			irq_events;
> >  	unsigned long			hardirq_enable_ip;
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 102dfcf0a29a..ed7755a28465 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3264,13 +3264,22 @@ static noinline void __schedule_bug(struct task_struct *prev)
> >  /*
> >   * Various schedule()-time debugging checks and statistics:
> >   */
> > -static inline void schedule_debug(struct task_struct *prev)
> > +static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >  {
> >  #ifdef CONFIG_SCHED_STACK_END_CHECK
> >  	if (task_stack_end_corrupted(prev))
> >  		panic("corrupted stack end detected inside scheduler\n");
> >  #endif
> >  
> > +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > +	if (!preempt && prev->state && prev->non_block_count) {
> > +		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
> > +			prev->comm, prev->pid, prev->non_block_count);
> > +		dump_stack();
> > +		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> > +	}
> > +#endif
> > +
> >  	if (unlikely(in_atomic_preempt_off())) {
> >  		__schedule_bug(prev);
> >  		preempt_count_set(PREEMPT_DISABLED);
> > @@ -3377,7 +3386,7 @@ static void __sched notrace __schedule(bool preempt)
> >  	rq = cpu_rq(cpu);
> >  	prev = rq->curr;
> >  
> > -	schedule_debug(prev);
> > +	schedule_debug(prev, preempt);
> >  
> >  	if (sched_feat(HRTICK))
> >  		hrtick_clear(rq);
> > @@ -6102,7 +6111,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
> >  	rcu_sleep_check();
> >  
> >  	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
> > -	     !is_idle_task(current)) ||
> > +	     !is_idle_task(current) && !current->non_block_count) ||
> >  	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
> >  	    oops_in_progress)
> >  		return;
> > @@ -6118,8 +6127,8 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
> >  		"BUG: sleeping function called from invalid context at %s:%d\n",
> >  			file, line);
> >  	printk(KERN_ERR
> > -		"in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
> > -			in_atomic(), irqs_disabled(),
> > +		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
> > +			in_atomic(), irqs_disabled(), current->non_block_count,
> >  			current->pid, current->comm);
> >  
> >  	if (task_stack_end_corrupted(current))
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
