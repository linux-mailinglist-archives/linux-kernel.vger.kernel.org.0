Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E469A512
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 03:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbfHWBuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 21:50:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45310 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbfHWBuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:50:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so5258718pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nVpIaULoP5xHhVhqVwCnL2/nr72RjF/GeMw6NFKePik=;
        b=iXWjbHRav/jxO8IDVueGiQsPLqyZ2UBzkvdzUstOgkEklotIMp8PhS8shzzN9Zuwkb
         J/oC2mR2wQoaRxCqzPMdMqWdrZL7QQhbmcpkgNsVVqZcEuBx3ri3ZZ4GQfYVXpZq+Qha
         OhoJWf9g/svDxyaIdNDLhULNDPAdA+aoctMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nVpIaULoP5xHhVhqVwCnL2/nr72RjF/GeMw6NFKePik=;
        b=XbnTrbqEZEldC/GvbLQcxJBmWPeJUBcGk7n9eK7oX09FLZ0E89NnQqjtOeFo8uc+up
         Eub+NcLbgRvTAbDl7z/SdEscQsvEYEKg/aKUCl6c490cuc5latJcvMe9L0CelUPRLlYG
         82YxyVUTfoIxhjgskO39xlVBEeTH17xVCmjJGFyGy5NoM44IDhSIERMXYmyQSWE0I56s
         VbOamSG0b82nYLpbistcKR9B1p+3ySfE8TrDgJA4LTWZ8PeO/7ymW5IETQkwWgXTgdHO
         jgohGdUwO/0hyes1frXELQB3KwnwRjM0c7p86y8aIaOBUqAgHP14GdfGB6rVa0GwSzIr
         IOTQ==
X-Gm-Message-State: APjAAAUS/XXitHUh1EKHWbgVK/WQs8eoUUdm0HD5ALG0pqdEM2xkfQD8
        CNwVTOdCYtA0h0GPhPO1R0xSCQ==
X-Google-Smtp-Source: APXvYqyxkGDu+sSVhIUbPpsJ6PM9e2ZRLfP6B6V0M/cpGZQgPLq13M4w+mRe0UsSMquMVVCLJAOdpg==
X-Received: by 2002:aa7:8f29:: with SMTP id y9mr2491838pfr.27.1566525011711;
        Thu, 22 Aug 2019 18:50:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm688640pfc.70.2019.08.22.18.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 18:50:10 -0700 (PDT)
Date:   Thu, 22 Aug 2019 21:50:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190823015009.GA152050@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
 <20190822152706.GB28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822152706.GB28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 08:27:06AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 22, 2019 at 09:39:55AM -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > > A plain local_bh_disable() is documented as creating an RCU critical
> > > > section, and (at least) rcutorture expects this to be the case.  However,
> > > > in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> > > > preempt_count() directly.  Even if RCU were changed to check
> > > > in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> > > > 
> > > > Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> > > > rcu_read_lock_bh_held() accordingly.
> > > 
> > > Cool!  Some questions and comments below.
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > ---
> > > > Another question is whether non-raw spinlocks are intended to create an
> > > > RCU read-side critical section due to implicit preempt disable.
> > > 
> > > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > > consolidation?  If not, I don't see why they should do so after that
> > > consolidation in -rt.
> > 
> > May be I am missing something, but I didn't see the connection between
> > consolidation and this patch. AFAICS, this patch is so that
> > rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?
> 
> I was interpreting Scott's question (which would be excluded from the
> git commit log) as relating to a possible follow-on patch.
> 
> The question is "how special can non-raw spinlocks be in -rt?".  From what
> I can see, they have been treated as sleeplocks from an RCU viewpoint,
> so maybe that should continue to be the case.  It does deserve some
> thought because in mainline a non-raw spinlock really would block a
> post-consolidation RCU grace period, even in PREEMPT kernels.
> 
> But then again, you cannot preempt a non-raw spinlock in mainline but
> you can in -rt, so extending that exception to RCU is not unreasonable.
> 
> Either way, we do need to make a definite decision and document it.
> If I were forced to make a decision right now, I would follow the old
> behavior, so that only raw spinlocks were guaranteed to block RCU grace
> periods.  But I am not being forced, so let's actually discuss and make
> a conscious decision.  ;-)

I think non-raw spinlocks on -rt should at least do rcu_read_lock() so that
any driver or kernel code that depends on this behavior and works on non-rt
also works on -rt. It also removes the chance a kernel developer may miss
documentation and accidentally forget that their code may break on -rt. I am
curious to see how much this design pattern appears in the kernel
(spin_lock'ed section "intended" as an RCU-reader by code sequences).

Logically speaking, to me anything that disables preemption on non-RT should
do rcu_read_lock() on -rt so that from RCU's perspective, things are working.
But I wonder where we would draw the line and if the bar is to need actual
examples of usage patterns to make a decision..

Any thoughts?

thanks,

 - Joel

