Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1867041
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfGLNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 09:40:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33950 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfGLNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:40:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so4344040pfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OMgju0w2PM5gayEE0w1vUuk92goZhVVWaxsCGErqD5k=;
        b=inOaNhNWdhCY0qpdYSA52yf2J7QrWJUNlU7Wkes6VGtLleWrejJ8/pilpFVRQ7I2CE
         LwPRX1NxHRKudYm/FdduMHQhgaXdZqnczBcB7kVrkwR3idEb2DDdLNYqMVQ+wBE2vfiA
         Xsic8WM3p5GWUcXYIRdjQ/NCrX6TSNWJQhXB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OMgju0w2PM5gayEE0w1vUuk92goZhVVWaxsCGErqD5k=;
        b=CoV1J860wq8dcypjeoXuNuPcnY7EK+I+EVUUel//e7eMdBt3uerLgJZRIU+jrEbo8W
         bfCYdNlUmPlxKktsZvyKy4/4NQsQXUDM/YGOUE91rHPoPZPuHAw2twmKspga9WcKK6bS
         ylU2g19dV1RucW3ULqdFvgzLeTul7jSNbp0UlkO/R5Y/snJ5DvSxbk62rfXHk/7Nmkon
         7lVWjS1hu6W6HUt31AuvptwJ2PWAO3lm8JJGNYQsvDoPlo2sbwDuPosw9JlLXFEaSvzY
         J2rreAD8p6lKwrLhRJx3+T+A76YxXqsb6vTdZn7knnwVnmuWMqC0m+nphzvQMUjBMpcd
         M05g==
X-Gm-Message-State: APjAAAWbf1FHfOeOEuXFRIoGc1S/T4DDZuz9Ic1fC10nCzzY6HB+0uy0
        HdJaaDBHZLgMlSn0jDTGfNM=
X-Google-Smtp-Source: APXvYqyM8NziRaZJVuWM1fRQ4RnyWa7EcTM2Of5+auAvT11F+IQb/PtEtjyKh2l7JoD64MgoiG57kw==
X-Received: by 2002:a65:5888:: with SMTP id d8mr10750820pgu.124.1562938853708;
        Fri, 12 Jul 2019 06:40:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q36sm7829989pgl.23.2019.07.12.06.40.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 06:40:52 -0700 (PDT)
Date:   Fri, 12 Jul 2019 09:40:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712134051.GD92297@google.com>
References: <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712130105.GL26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712130105.GL26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 06:01:05AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > On Thu, Jul 11, 2019 at 12:48:18PM -0400, Joel Fernandes wrote:
> > > On Thu, Jul 11, 2019 at 08:02:15AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jul 11, 2019 at 09:08:49AM -0400, Joel Fernandes wrote:
> > > > > On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Jul 10, 2019 at 10:20:25AM +0900, Byungchul Park wrote:
> > > > > > > On Tue, Jul 09, 2019 at 05:41:02AM -0700, Paul E. McKenney wrote:
> > > > > > > > > Hi Paul,
> > > > > > > > > 
> > > > > > > > > IMHO, as much as we want to tune the time for fqs to be initiated, we
> > > > > > > > > can also want to tune the time for the help from scheduler to start.
> > > > > > > > > I thought only difference between them is a level of urgency. I might be
> > > > > > > > > wrong. It would be appreciated if you let me know if I miss something.
> > > > > > > > 
> > > > > > > > Hello, Byungchul,
> > > > > > > > 
> > > > > > > > I understand that one hypothetically might want to tune this at runtime,
> > > > > > > > but have you had need to tune this at runtime on a real production
> > > > > > > > workload?  If so, what problem was happening that caused you to want to
> > > > > > > > do this tuning?
> > > > > > > 
> > > > > > > Not actually.
> > > > > > > 
> > > > > > > > > And it's ok even if the patch is turned down based on your criteria. :)
> > > > > > > > 
> > > > > > > > If there is a real need, something needs to be provided to meet that
> > > > > > > > need.  But in the absence of a real need, past experience has shown
> > > > > > > > that speculative tuning knobs usually do more harm than good.  ;-)
> > > > > > > 
> > > > > > > It makes sense, "A speculative tuning knobs do more harm than good".
> > > > > > > 
> > > > > > > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > > > > > > but jiffies_till_sched_qs until we need it.
> > > > > > > 
> > > > > > > However,
> > > > > > > 
> > > > > > > (1) In case that jiffies_till_sched_qs is tunnable:
> > > > > > > 
> > > > > > > 	We might need all of jiffies_till_{first,next}_qs,
> > > > > > > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > > > > > > 	jiffies_to_sched_qs can be affected by any of them. So we
> > > > > > > 	should be able to read each value at any time.
> > > > > > > 
> > > > > > > (2) In case that jiffies_till_sched_qs is not tunnable:
> > > > > > > 
> > > > > > > 	I think we don't have to keep the jiffies_till_sched_qs any
> > > > > > > 	longer since that's only for setting jiffies_to_sched_qs at
> > > > > > > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > > > > > > 	It's meaningless to keep all of tree variables.
> > > > > > > 
> > > > > > > The simpler and less knobs that we really need we have, the better.
> > > > > > > 
> > > > > > > what do you think about it?
> > > > > > > 
> > > > > > > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > > > > > > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > > > > > > think jiffies_till_sched_qs is a much better name for the purpose. I
> > > > > > > will resend it with a commit msg after knowing your opinion on it.
> > > > > > 
> > > > > > I will give you a definite "maybe".
> > > > > > 
> > > > > > Here are the two reasons for changing RCU's embarrassingly large array
> > > > > > of tuning parameters:
> > > > > > 
> > > > > > 1.	They are causing a problem in production.  This would represent a
> > > > > > 	bug that clearly must be fixed.  As you say, this change is not
> > > > > > 	in this category.
> > > > > > 
> > > > > > 2.	The change simplifies either RCU's code or the process of tuning
> > > > > > 	RCU, but without degrading RCU's ability to run everywhere and
> > > > > > 	without removing debugging tools.
> > > > > > 
> > > > > > The change below clearly simplifies things by removing a few lines of
> > > > > > code, and it does not change RCU's default self-configuration.  But are
> > > > > > we sure about the debugging aspect?  (Please keep in mind that many more
> > > > > > sites are willing to change boot parameters than are willing to patch
> > > > > > their kernels.)
> > > > > > 
> > > > > > What do you think?
> > > > > 
> > > > > Just to add that independent of whether the runtime tunable make sense or
> > > > > not, may be it is still worth correcting the 0444 to be 0644 to be a separate
> > > > > patch?
> > > > 
> > > > You lost me on this one.  Doesn't changing from 0444 to 0644 make it be
> > > > a runtime tunable?
> > > 
> > > I was going by our earlier discussion that the parameter is still writable at
> > > boot time. You mentioned something like the following:
> > > ---
> > > In Byungchul's defense, the current module_param() permissions are
> > > 0444, which really is read-only.  Although I do agree that they can
> > > be written at boot, one could use this same line of reasoning to argue
> > > that const variables can be written at compile time (or, for on-stack
> > > const variables, at function-invocation time).  But we still call them
> > > "const".
> > > ---
> > > 
> > > Sorry if I got confused. You are right that we could leave it as read-only.
> > > 
> > > > > > Finally, I urge you to join with Joel Fernandes and go through these
> > > > > > grace-period-duration tuning parameters. �Once you guys get your heads
> > > > > > completely around all of them and how they interact across the different
> > > > > > possible RCU configurations, I bet that the two of you will have excellent
> > > > > > ideas for improvement.
> > > > >
> > > > > Yes, I am quite happy to join forces. Byungchul, let me know what about this
> > > > > or other things you had in mind. I have some other RCU topics too I am trying
> > > > > to get my head around and planning to work on more patches.
> > > > >
> > > > > Paul, in case you had any other specific tunables or experiments in mind, let
> > > > > me know. I am quite happy to try out new experiments and learn something
> > > > > based on tuning something.
> > > >
> > > > These would be the tunables controlling how quickly RCU takes its
> > > > various actions to encourage the current grace period to end quickly.
> > > > I would be happy to give you the exact list if you wish, but most of
> > > > them have appeared in this thread.
> > > >
> > > > The experiments should be designed to work out whether the current
> > > > default settings have configurations where they act badly. �This might
> > > > also come up with advice for people attempting hand-tuning, or proposed
> > > > parameter-checking code to avoid bad combinations.
> > > >
> > > > For one example, setting the RCU CPU stall timeout too low will definitely
> > > > cause some unwanted splats. �(Yes, one could argue that other things in
> > > > the kernel should change to allow this value to decrease, but things
> > > > like latency tracer and friends are probably more useful and important.)
> > > 
> > > Ok, thank you for the hints. 
> > 
> > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > period ever is recorded in rcu_state.gp_max. However it is not read from
> > anywhere.
> > 
> > Any idea why it was added but not used?
> 
> If I remember correclty, it used to be used in debugfs prints.  It is
> useful for working out how low you can decrease rcutorture.stall_cpu to
> without getting RCU CPU stall warnings.  A rather infrequent need,
> given that the mainline default has been adjusted only once.

Got it.

> > I am interested in dumping this value just for fun, and seeing what I get.
> > 
> > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > look like.
> 
> That might be worthwhile.

Thanks. I am thinking also it will help see whether something else like GP
thread priority or other configuration could be causing long GP times that is
otherwise not possible to see without a counter.

I will work out with Byungchul and come up with something.

Cheers,

 - Joel





