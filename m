Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D541637EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBSABv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 19:01:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39200 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBSABs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:01:48 -0500
Received: by mail-qk1-f195.google.com with SMTP id a141so11534755qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZncEIyYi8WuUORtwhrTXqb5H8wAtob9Qk+8uAaIjx1I=;
        b=M4Jm/WVIOOrdqqA9r3dqNIkZ65s5JPx/OaYA/Z1C9ZmIbbyR1IAgkVtXwFEpy7YOr8
         EDVyq0AWtnB/yInsz1kCPJeBIOx7GDOKgLBdM8XwY2k2e40ALUw3/F4Gc7KHG9HmzA/s
         /SRNBeyRSUYejg2W9qPrnqTqNz/yzVhBbP+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZncEIyYi8WuUORtwhrTXqb5H8wAtob9Qk+8uAaIjx1I=;
        b=KxTvU4+ROJ7XkNi6KfJV3TswIGoyx/KxyrEVJ/6qlreYFLXJjXtRm5S18UDIf9UqMw
         q6QS3jrnJS5YDRbnFB30I/7knBM0E9i2m/+1iIYFAYQf6GFp3FhcmuU+ysBNb+8NZVSM
         XX8o/Lm/tqSlU7CXm1VXva/8qsUm9ImNjod+SS3tSu0q5KjWSofPaPW+NpGYjAwWsGzY
         W808KIU6GfOD8HTGbHV0r/MazlBiz94NhK8LL/Wd0J+iWf+zj/3MGyj3xIkfdk7Um5Bc
         RUSZgpKzX+6TS99TVyBR5KPeSLBk7ZVU4juavhd4aJJ4me0MeUl0/2yNidDVbIRzo0oJ
         Ouig==
X-Gm-Message-State: APjAAAV3Reug3FW0gpM7z904Uiqh06F7ryd6c8s8MytdVbYrdGvWh5rP
        xpz7WK5TYrfWgpAT0OWEkMkp3g==
X-Google-Smtp-Source: APXvYqw5t12g1wrtXskMvVyIqVO0btZ865Lf7DT68CyUl5rJs5IExjWAcjNd1r2JD94XwKTu2thuLQ==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr21209557qkg.101.1582070506240;
        Tue, 18 Feb 2020 16:01:46 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y28sm142559qkj.44.2020.02.18.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:01:45 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:01:44 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200219000144.GA26663@google.com>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
 <20200218202226.GJ2935@paulmck-ThinkPad-P72>
 <20200218174503.3d4e4750@gandalf.local.home>
 <20200218225455.GN2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218225455.GN2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:54:55PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 18, 2020 at 05:45:03PM -0500, Steven Rostedt wrote:
> > On Tue, 18 Feb 2020 12:22:26 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> > > > On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:  
> > > > > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:  
> > > >   
> > > > > > I just took offence at the Changelog wording. It seems to suggest there
> > > > > > actually is a problem, there is not.  
> > > > > 
> > > > > Quoting the changelog: "Not appropriate for backporting due to failure
> > > > > being unlikely."  
> > > > 
> > > > That implies there is failure, however unlikely.
> > > > 
> > > > In this particular case there is absolutely no failure, except perhaps
> > > > in KCSAN. This patch is a pure annotation such that KCSAN can understand
> > > > the code.
> > > > 
> > > > Like said, I don't object to the actual patch, but I do think it is
> > > > important to call out false negatives or to describe the actual problem
> > > > found.  
> > > 
> > > I don't feel at all comfortable declaring that there is absolutely
> > > no possibility of failure.
> > 
> > Perhaps wording it like so:
> > 
> > "There's know known issue with the current code, but the *_ONCE()
> > annotations here makes KCSAN happy, allowing us to focus on KCSAN
> > warnings that can help bring about known issues in other code that we
> > can fix, without being distracted by KCSAN warnings that we do not see
> > a problem with."
> > 
> > ?
> 
> That sounds more like something I might put in rcutodo.html as a statement
> of the RCU approach to KCSAN reports.
> 
> But switching to a different situation (for variety, if nothing else),
> what about the commit shown below?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 35bc02b04a041f32470ae6d959c549bcce8483db
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Feb 18 13:41:02 2020 -0800
> 
>     rcutorture: Mark data-race potential for rcu_barrier() test statistics
>     
>     The n_barrier_successes, n_barrier_attempts, and
>     n_rcu_torture_barrier_error variables are updated (without access
>     markings) by the main rcu_barrier() test kthread, and accessed (also
>     without access markings) by the rcu_torture_stats() kthread.  This of
>     course can result in KCSAN complaints.
>     
>     Because the accesses are in diagnostic prints, this commit uses
>     data_race() to excuse the diagnostic prints from the data race.  If this
>     were to ever cause bogus statistics prints (for example, due to store
>     tearing), any misleading information would be disambiguated by the
>     presence or absence of an rcutorture splat.
>     
>     This data race was reported by KCSAN.  Not appropriate for backporting
>     due to failure being unlikely and due to the mild consequences of the
>     failure, namely a confusing rcutorture console message.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 5453bd5..b3301f3 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1444,9 +1444,9 @@ rcu_torture_stats_print(void)
>  		atomic_long_read(&n_rcu_torture_timers));
>  	torture_onoff_stats();
>  	pr_cont("barrier: %ld/%ld:%ld\n",
> -		n_barrier_successes,
> -		n_barrier_attempts,
> -		n_rcu_torture_barrier_error);
> +		data_race(n_barrier_successes),
> +		data_race(n_barrier_attempts),
> +		data_race(n_rcu_torture_barrier_error));

Would it be not worth just fixing the data-race within rcutorture itself?

thanks,

 - Joel

