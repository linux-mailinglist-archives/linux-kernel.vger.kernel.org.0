Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B72C17AD48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCERae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 12:30:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38198 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCERae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:30:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id a16so2803700pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vNeh9Pd7A3jC+lAiG1qDL0YXo2Ve7XhmxDKrJcovXSc=;
        b=V9Jf9RHYfTaKoPNwyR/ZqRpbM7++EFV5M3l+Gb/M27xCKeKa5UfNPXd7ILib0b9rj8
         o9F/ruICOhsODIsR0A/Q2YZg92Xq9vGb2p4CcW/m18OrDJuMw93FvtM51DwX9UWV+4EZ
         KNIVHrWBxHtZSlBbLeFKGo9A7LW5zUuFm9oP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vNeh9Pd7A3jC+lAiG1qDL0YXo2Ve7XhmxDKrJcovXSc=;
        b=NlQotB15OuYb8nrKJuRg49KEPZACblYwXJfjmsrteFJpVFMk2pcmbX/CrnfjtWPAGv
         vmwp4VfmoszMauBasxcTzF4gQdUmTjTZa7e2POoT+AEOKxV9vTxcbBxxA9I2QKAi8NFz
         k0IR3/hQ77eiEaH3gEbPcOk1uInnsl+qVfjoaALs1zjO60LvUvUd3tEazsrQV209X3Ua
         XwlR2NTcnmdQpyhvhvDDhcfx/QEfXa/3TTfsegseU++E9tL1khYwVnxz7i1YHgoxA7Ti
         gWHtVlSr5+PX8X4+cqXmFBN7qZKbGCWvpqetfm3gjx3Uiy5WOkiMbbx1MZjJQ+5X2Oq3
         cfEQ==
X-Gm-Message-State: ANhLgQ26T9dT9xH9nAFHSSEW54bznOB9mYAFV03BJGmsm9tsbf/5Z6g+
        0sIlcCI7RIdWB74e9UAOoe/+yA==
X-Google-Smtp-Source: ADFU+vvughyancsaR9TzogY7vXckHLfAnPZ1i0WoVQgLJT88RNnb2tQAJymwgzJlaU0Xk4wC9no7Jw==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr9365462pls.258.1583429432492;
        Thu, 05 Mar 2020 09:30:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o12sm6747925pjs.6.2020.03.05.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:30:31 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:30:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cl@rock-chips.com, heiko@sntech.de, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, akpm@linux-foundation.org, tglx@linutronix.de,
        mpe@ellerman.id.au, surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, luto@amacapital.net, wad@chromium.org,
        mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: Re: [PATCH v1 1/1] sched/fair: do not preempt current task if it is
 going to call schedule()
Message-ID: <202003050929.DD4DB3529@keescook>
References: <20200305081611.29323-1-cl@rock-chips.com>
 <20200305081611.29323-2-cl@rock-chips.com>
 <20200305095803.GW2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305095803.GW2596@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:58:03AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 05, 2020 at 04:16:11PM +0800, cl@rock-chips.com wrote:
> > From: Liang Chen <cl@rock-chips.com>
> > 
> > when we create a kthread with ktrhead_create_on_cpu(),the child thread
> > entry is ktread.c:ktrhead() which will be preempted by the parent after
> > call complete(done) while schedule() is not called yet,then the parent
> > will call wait_task_inactive(child) but the child is still on the runqueue,
> > so the parent will schedule_hrtimeout() for 1 jiffy,it will waste a lot of
> > time,especially on startup.
> > 
> >   parent                             child
> > ktrhead_create_on_cpu()
> >   wait_fo_completion(&done) -----> ktread.c:ktrhead()
> >                              |----- complete(done);--wakeup and preempted by parent
> >  kthread_bind() <------------|  |-> schedule();--dequeue here
> >   wait_task_inactive(child)     |
> >    schedule_hrtimeout(1 jiffy) -|
> > 
> > So we hope the child just wakeup parent but not preempted by parent, and the
> > child is going to call schedule() soon,then the parent will not call
> > schedule_hrtimeout(1 jiffy) as the child is already dequeue.
> > 
> > The same issue for ktrhead_park()&&kthread_parkme().
> > This patch can save 120ms on rk312x startup with CONFIG_HZ=300.
> 
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index b262f47046ca..8a4e4c9cdc22 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
> >  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
> >  			break;
> >  
> > +		set_tsk_going_to_sched(current);
> >  		complete(&self->parked);
> >  		schedule();
> > +		clear_tsk_going_to_sched(current);
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> >  }
> > @@ -245,8 +247,10 @@ static int kthread(void *_create)
> >  	/* OK, tell user we're spawned, wait for stop or wakeup */
> >  	__set_current_state(TASK_UNINTERRUPTIBLE);
> >  	create->result = current;
> > +	set_tsk_going_to_sched(current);
> >  	complete(done);
> >  	schedule();
> > +	clear_tsk_going_to_sched(current);
> >  
> >  	ret = -EINTR;
> >  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
> 
> Were you looking for this? I think it does the same without having
> fallen from the ugly tree...
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index b262f47046ca..62699ff414f4 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;
>  
> +		preempt_disable()
>  		complete(&self->parked);
> -		schedule();
> +		schedule_preempt_disabled();
> +		preempt_enable();
>  	}
>  	__set_current_state(TASK_RUNNING);
>  }
> @@ -245,8 +247,10 @@ static int kthread(void *_create)
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result = current;
> +	preempt_disable()
>  	complete(done);
> -	schedule();
> +	schedule_preempt_disabled();
> +	preempt_enable();
>  
>  	ret = -EINTR;
>  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {

That's much nicer, yes! :) As I said, I don't know much about the
scheduler. ;)

-- 
Kees Cook
