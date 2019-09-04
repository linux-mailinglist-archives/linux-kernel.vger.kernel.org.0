Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF661A84AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfIDNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 09:42:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40190 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:42:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so581830pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oklghVAYMBOMwnSSWwCYcajaz+bMy8hr9iKM1Yg7aak=;
        b=WBZbEbSlW3hA4LPKkYyJzd58HTqckuyI9ruChkezZC6jGsyEyWalm/XID+in4XwAcX
         ushgsDXIys/3Uyob2lacjzvMhD6NTYshvx5ow8YlhokuvapX6Z8eLwn5GE56kIpHJBwM
         zlAbyidngWUPtIg1wV2lD3MndKSRQhmq4kLro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oklghVAYMBOMwnSSWwCYcajaz+bMy8hr9iKM1Yg7aak=;
        b=sX8wG2q4m94rxYwvD0z+iupDWVfgKR0KUGpfBpFq95s0DQffwW686R/8qIh+S0rnDt
         XdBJhpdvOxBO4JSqW9o+QzcGtaByoiskC8rY7hqjFmzfOzSAx+zAWKcbAQ2lRvmTbZse
         FUUj4DtEDIP/0oTImRHsYxIweE/KKQHJ8zwEyobZJ2PyZDOFgOBgAn+ca8IGwimJswYU
         MANcY8TY4LQBGhiJXQta+p5aUcHEUaJkiNSF6KOMQuZS7ePq9q6vhSnEAq8I+LVdZcaN
         yKLoNwbHZuWXIcWfz8mqRIvlLqMcQzZ37DI5kItSd2INYVMB9vHk2MKATNnpplxdJYnf
         kq+A==
X-Gm-Message-State: APjAAAVIiglvupr2JbqROVdhDKyodoRBmqjZOaWTcXgE5/FD+Nld5Rwx
        dQfj3VYajBCzPPMlSBCfA7Qg7A==
X-Google-Smtp-Source: APXvYqxtMLqjgzNXqwP58ru84p45VRpR0RWa4wbrgf8WB/8ClopE5Mr9NERja4e4k0aI89Ih5g/0wQ==
X-Received: by 2002:a62:4d41:: with SMTP id a62mr46382478pfb.155.1567604524993;
        Wed, 04 Sep 2019 06:42:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c2sm11187176pfd.66.2019.09.04.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:42:04 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:42:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>, paulmck@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904134203.GA240514@google.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
 <20190904040039.GB150430@google.com>
 <20190904081919.GA2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904081919.GA2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:19:19AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 04, 2019 at 12:00:39AM -0400, Joel Fernandes wrote:
> > [ Resending since I messed up my last email's headers! ]
> > 
> > On Tue, Sep 03, 2019 at 03:25:59PM +0200, Viktor Rosendahl wrote:
> > > This patch implements the feature that the tracing_max_latency file,
> > > e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> > > notifications through the fsnotify framework when a new latency is
> > > available.
> > > 
> > > One particularly interesting use of this facility is when enabling
> > > threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> > > together with the preempt/irqsoff tracers. This makes it possible to
> > > implement a user space program that can, with equal probability,
> > > obtain traces of latencies that occur immediately after each other in
> > > spite of the fact that the preempt/irqsoff tracers operate in overwrite
> > > mode.
> > 
> > Adding Paul since RCU faces similar situations, i.e. raising softirq risks
> > scheduler deadlock in rcu_read_unlock_special() -- but RCU's solution is to
> > avoid raising the softirq and instead use irq_work.
> 
> Which is right.

Cool.

> > I was wondering, if we can rename __raise_softirq_irqoff() to
> > raise_softirq_irqoff_no_wake() and call that from places where there is risk
> > of scheduler related deadlocks. Then I think this can be used from Viktor's
> > code.  Let us discuss - what would happen if the softirq is raised, but
> > ksoftirqd is not awakened for this latency notification path? Is this really
> > an issue considering the softirq will execute during the next interrupt exit?
> 
> You'd get unbounded latency for processing the softirq and warnings on
> going idle with softirqs pending.

Thanks for sharing that.

> I really don't see why we should/want to be using softirq here.

Sure. makes sense.

thanks,

 - Joel

