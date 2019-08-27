Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6422D9EFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfH0QGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 12:06:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37749 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfH0QGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:06:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id bj8so12008180plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1L35nAsSCuH9O7ksDDdD2gjCKxQPbQrMSvK9pHg5hLg=;
        b=xbJ3LuWXwg3Nq02nn3AbHTU8VpTOZaJrBe1s/K+wwywtZ//0Ww372OwQEHTOSDkOau
         b7RZBBOJ1Yu3BM3pCc/YmFO479ZR0A1oNwpQ9pocN4sv+4RMNpue5t/iXM3I6Gf/ZWoa
         iEvU0kcH1H93WoH9os8MK16JA2+RRpTrapdcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1L35nAsSCuH9O7ksDDdD2gjCKxQPbQrMSvK9pHg5hLg=;
        b=j+WVvdLde5hSF9dKuwgHXUsJSBACVs2QWg58YGpjD2bAaPar6EK6ZNga/rOrSzPWbM
         2uwvgN72Ho1wb46Fbw8jiqui3XKr5IY1ITEDYzS/5v0jxgo0V7IdHwh+yzU2aC6Kwq96
         wL59jJ0waOctPPI4MZrS05kYwnBv/sfSzsPB+kFTBNYAbp5pLrohP724KllGOiABaHw4
         tPoOXgJPFbob7X0GNiqdFg0dbuISav/o6mV1laZsceePfxFSBaoAfbgo2ezt31VpQd8/
         /Ygva5uZHHxXQ45gDOGd/gv4jlYb4P/+PGOXpNxGtD+oHN6Jei712dHVbvj9omlGduGJ
         BG1g==
X-Gm-Message-State: APjAAAWNUyCj+saR2sGztj2brXUFXNFd3Kw9KOx4/ZMNi8JHiyqO/hKB
        B5e4Vu5JHGyNsC1xfAAoRsJ7Ug==
X-Google-Smtp-Source: APXvYqyaGmwKpA/k2W0bQmgxlBgAXYTJvuTo9aOtY8wLvfxOIFa1djzD+hu7oJ/bQ7x4GWt8LdNDvw==
X-Received: by 2002:a17:902:f30e:: with SMTP id gb14mr25331225plb.32.1566921981880;
        Tue, 27 Aug 2019 09:06:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y10sm3143262pjp.27.2019.08.27.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:06:21 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:06:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190827160619.GA55873@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827130853.GB132568@google.com>
 <20190827155813.GG26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827155813.GG26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:58:13AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 27, 2019 at 09:08:53AM -0400, Joel Fernandes wrote:
> > On Tue, Aug 27, 2019 at 11:23:33AM +0200, Sebastian Andrzej Siewior wrote:
> > [snip]
> > > > However, if this was instead an rcu_read_lock() critical section within
> > > > a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> > > > RCU would consider that critical section to be preempted.  This means
> > > > that any RCU grace period that is blocked by this RCU read-side critical
> > > > section would remain blocked until stop_one_cpu() resumed, returned,
> > > > and so on until the matching rcu_read_unlock() was reached.  In other
> > > > words, RCU would consider that RCU read-side critical section to span
> > > > the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().
> > > 
> > > Isn't that my example from above and what we do in RT? My understanding
> > > is that this is the reason why we need BOOST on RT otherwise the RCU
> > > critical section could remain blocked for some time.
> > 
> > Not just for boost, it is needed to block the grace period itself on
> > PREEMPT=y. On PREEMPT=y, if rcu_note_context_switch() happens in middle of a
> > rcu_read_lock() reader section, then the task is added to a blocked list
> > (rcu_preempt_ctxt_queue). Then just after that, the CPU reports a QS state
> > (rcu_qs()) as you can see in the PREEMPT=y implementation of
> > rcu_note_context_switch(). Even though the CPU has reported a QS, the grace
> > period will not end because the preempted (or block as could be in -rt) task
> > is still blocking the grace period. This is fundamental to the function of
> > Preemptible-RCU where there is the concept of tasks blocking a grace period,
> > not just CPUs.
> > 
> > I think what Paul is trying to explain AIUI (Paul please let me know if I
> > missed something):
> > 
> > (1) Anyone calling rcu_note_context_switch() and expecting it to respect
> > RCU-readers that are readers as a result of interrupt disabled regions, have
> > incorrect expectations. So calling rcu_note_context_switch() has to be done
> > carefully.
> > 
> > (2) Disabling interrupts is "generally" implied as an RCU-sched flavor
> > reader. However, invoking rcu_note_context_switch() from a disabled interrupt
> > region is *required* for rcu_note_context_switch() to work correctly.
> > 
> > (3) On PREEMPT=y kernels, invoking rcu_note_context_switch() from an
> > interrupt disabled region does not mean that that the task will be added to a
> > blocked list (unless it is also in an RCU-preempt reader) so
> > rcu_note_context_switch() may immediately report a quiescent state and
> > nothing blockings the grace period.
> > So callers of rcu_note_context_switch() must be aware of this behavior.
> > 
> > (4) On PREEMPT=n, unlike PREEMPT=y, there is no blocked list handling and so
> > nothing will block the grace period once rcu_note_context_switch() is called.
> > So any path calling rcu_note_context_switch() on a PREEMPT=n kernel, in the
> > middle of something that is expected to be an RCU reader would be really bad
> > from an RCU view point.
> > 
> > Probably, we should add this all to documentation somewhere.
> 
> I think that Sebastian understands this and was using the example of RCU
> priority boosting to confirm his understanding.  But documentation would
> be good.  Extremely difficult to keep current, but good.  I believe that
> the requirements document does cover this.

Oh ok, got it. Sorry about the noise then!

(In a way, I was just thinking out loud since this is a slightly confusing
 topic :-P and an archive link to this discussion serves a great purpose in
 my notes :-D :-)).

thanks!

 - Joel

