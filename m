Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36BF389F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKGTcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:32:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mQxP0NlH0MuR5NgfBa7ZCQQ8PQRRveWOV37ydOHPvRw=; b=VXy6MZotTpf66qPz/dBlVidRi
        9xFpSlqueLKA1mQXklQszdCmr3x+2uuDXpl9697ql4kmJhqWLBj4h+yeTGiec9tAHurB3gbAZ12TP
        pyjm1XPs0m8QuvgVrKzvRfEBHmabBd5SFYtBJjVGppjmvdxKERSGn+ZT5O6lYBZl/x+t6ItOaOxq5
        XzS/s4gMmj5ygv5KEsPGs25H6VYx7BfHZoMYcPzp9YCIIm6GQHb+5cNbbNRxF46sNTqORSiB3kFsP
        NiWnM3T/VJ1ZCbuxsu199qFIBGB7LgP6uJp9Zbx0WyfDC3rCR3/X34YqcXw6RcPZBXJpICsTn1Cka
        5eJLwEhbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSnVJ-0007Lr-NN; Thu, 07 Nov 2019 19:31:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D198E980E2D; Thu,  7 Nov 2019 20:31:34 +0100 (CET)
Date:   Thu, 7 Nov 2019 20:31:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107193134.GJ3079@worktop.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192753.GA55494@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107192753.GA55494@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 07:27:53PM +0000, Quentin Perret wrote:
> On Thursday 07 Nov 2019 at 19:43:56 (+0100), Peter Zijlstra wrote:
> > But you mean something like:
> > 
> > 	for (class = prev->sched_class; class; class = class->next) {
> > 		if (class->balance(rq, rf))
> > 			break;
> > 	}
> > 
> > 	put_prev_task(rq, prev);
> > 
> > 	for_each_class(class) {
> > 		p = class->pick_next_task(rq);
> > 		if (p)
> > 			return p;
> > 	}
> > 
> > 	BUG();
> > 
> > like?
> 
> Right, something like that, though what I had was basically doing the
> pull from within the pick_next_task_*() functions directly, like we were
> doing before. I'm now seeing how easy it is to get this wrong, and that
> even good-looking code in this area can be broken in very subtle ways,
> so I didn't feel comfortable refactoring again so close to rc7. If you
> feel more confident, I'm more than happy to test a patch implemeting the
> above :)

Thing is, if we revert (and we might have to), we'll have to revert more
than just the one patch due to that other (__pick_migrate_task) borkage
that got reported today.
