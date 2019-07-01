Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB61C845
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfENMN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 08:13:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34753 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:13:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so11929743oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6T7mgXIvnET5l/tpGXLopOXL/eCRoBVjJ8wVdjfvJM=;
        b=gKMZt+rmO48Wd6LixwSFA5uP+tnHbIOOzUMW7+cBpiXeFZOAPzh53vAAif3AgkqbCQ
         1qOovLLoGbwFNYLJHR9YWAxqooTAwxUakSopoiggHN/gyfCHB9iSN5+ffCnzv5xHnSSY
         1HX5wrQvZ28MsrkDdHaV9KzwQSClciBtzVYJV+CzkD0V87c/OW4S9UkgNiWaUm00HP6O
         inW6jQyHzZS5r4rWyYh2cWIY5bhfa2eYUZvyrJwh7jBdJse1t06e3uVksOSgWbViKwtI
         wuadLwR/wSvMZP+RSe9VR5YNWctqW6aqDOo1HpmPgILV98ku9QPoARijDhLUJb+vUJ4R
         ujNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6T7mgXIvnET5l/tpGXLopOXL/eCRoBVjJ8wVdjfvJM=;
        b=hsy3GadyDxQHdP2YDbB054c8+/Wy0AT6lXAj8q1IYiShQ3agYHe4I5WLy3st6urGm0
         yHAC7NH1YCWZzUn9D4FX4oRuRV0nyE3aqeauoKhVUSX0wt4VA99yAxvhOfLQV4s/n1gf
         2TEms1iWddy24LTVTTW7oKuwD6MavFRuKhv3n3ki18Idzlr7F3aAM7Jxy+7rTCeB93ye
         Uz9fPvRhmi6HyfaIwOXtn5x7M+6ndrXJSG2OYtMGv1DsEJycHj+P1k8Z7xMAt/187NEa
         /Z7lwyZSZT/osKc7I8sp47wYw7NZReFh6E8oA7fzVQUDqmkUKb2k9Bm1gCiBXcvTNKLC
         SfBA==
X-Gm-Message-State: APjAAAVFfqgognhaFvqRDXXGpRrE5mXwY+ExLXEJn0K0TWADgiOS93kk
        oiQwmobLPLxiZpYivY6nRTUGKQ==
X-Google-Smtp-Source: APXvYqxt8u10XFlJlrW+Z8Xzk2QlxKIYWgUazpaKKgLWQ5dFhciFxSHt8Xc4H3c7OWeomT6MpjW7Zg==
X-Received: by 2002:aca:fd0c:: with SMTP id b12mr2471522oii.55.1557836033811;
        Tue, 14 May 2019 05:13:53 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:b9a9:ba56:cfab:b3bf])
        by smtp.gmail.com with ESMTPSA id f7sm6912633otb.66.2019.05.14.05.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 05:13:52 -0700 (PDT)
Date:   Tue, 14 May 2019 07:13:50 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, minyard@acm.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514121350.GA6050@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514091219.nesriqe7qplk3476@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:12:19AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-14 10:43:56 [+0200], Peter Zijlstra wrote:
> > Now.. that will fix it, but I think it is also wrong.
> > 
> > The problem being that it violates FIFO, something that might be more
> > important on -RT than elsewhere.
> 
> Wouldn't -RT be more about waking the task with the highest priority
> instead the one that waited the longest?
> 
> > The regular wait API seems confused/inconsistent when it uses
> > autoremove_wake_function and default_wake_function, which doesn't help,
> > but we can easily support this with swait -- the problematic thing is
> > the custom wake functions, we musn't do that.
> > 
> > (also, mingo went and renamed a whole bunch of wait_* crap and didn't do
> > the same to swait_ so now its named all different :/)
> > 
> > Something like the below perhaps.
> 
> This still violates FIFO because a task can do wait_for_completion(),
> not enqueue itself on the list because it noticed a pending wake and
> leave. The list order is preserved, we have that.
> But this a completion list. We have probably multiple worker waiting for
> something to do so all of those should be of equal priority, maybe one
> for each core or so. So it shouldn't matter which one we wake up.
> 
> Corey, would it make any change which waiter is going to be woken up?

In the application that found this, the wake order probably isn't
relevant.

For other applications, I really doubt that very many are using multiple
waiters.  If so, this bug would have been reported sooner, I think.

As you mention, for RT you would want waiter woken by priority and FIFO
within priority.  I don't think POSIX says anything about FIFO within
priority, but that's probably a good idea.  That's no longer a simple
wait queue  The way it is now is probably closer to that than what Peter
suggested, but not really that close.

This is heavily used in drivers and fs code, where it probably doesn't
matter.  I looked through a few users in mm and kernel, and they had
one waiter or were init/shutdown type things where order is not important.

So I'm not sure it's important.

-corey

> 
> Sebastian
