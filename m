Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9DF1C78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfKFR16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:27:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfKFR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jLjsMgVY7ccDxi1mEGKcTlH1BIMRO0RyG0VqOslZmpI=; b=TD53viTHZ0O7qsGdsz3mttRMX
        LqHd40IjN0eWEG/fXdTJzkNyr6Sh3fLlDn60h6+NuF9Aw2VQ/kCPEg+wJ2PBFR5r0ouhui5gAtXwN
        OPYE2NsZ353j+c/QSAYBrn3wfv1WY6s7kWYaPAkSZ8DYsnASKZC7Qa+AQshaBignvYlzi4ZiMZfR7
        gk9sYL9u3onJqWabp+/WuTq+/He3xAh4t8A6+duHK26258jZlfhqDfBY3Rto+NXjZkt0NNcvgAOwt
        RAoOWzQ/WhXT3hH0a3WcFwHS283/hWDt2cbj2OSwlQoZWFgjayEHWQYlLWWkv7Joa4eqElPaFkXtj
        PdFKCRvUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSP5n-0003fw-Nm; Wed, 06 Nov 2019 17:27:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C79F300692;
        Wed,  6 Nov 2019 18:26:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9331E2025EDA7; Wed,  6 Nov 2019 18:27:37 +0100 (CET)
Date:   Wed, 6 Nov 2019 18:27:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191106172737.GM5671@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106165437.GX4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:54:37PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 06:51:40PM +0300, Kirill Tkhai wrote:
> > > +#ifdef CONFIG_SMP
> > > +	if (!rq->nr_running) {
> > > +		/*
> > > +		 * Make sure task_on_rq_curr() fails, such that we don't do
> > > +		 * put_prev_task() + set_next_task() on this task again.
> > > +		 */
> > > +		prev->on_cpu = 2;
> > >  		newidle_balance(rq, rf);
> > 
> > Shouldn't we restore prev->on_cpu = 1 after newidle_balance()? Can't prev
> > become pickable again after newidle_balance() releases rq->lock, and we
> > take it again, so this on_cpu == 2 never will be cleared?
> 
> Indeed so.

Oh wait, the way it was written this is not possible. Because
rq->nr_running == 0 and prev->on_cpu > 0 it means the current task is
going to sleep and cannot be woken back up.

But if I move the ->on_cpu=2 thing earlier, as I wrote I'd do, then yes,
we have to set it back to 1. Because in that case we can get here for a
spurious schedule and we'll pick the same task again.


