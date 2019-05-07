Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496971674B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEGQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:00:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfEGQAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:00:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9B9374;
        Tue,  7 May 2019 09:00:43 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDD653F5AF;
        Tue,  7 May 2019 09:00:40 -0700 (PDT)
Date:   Tue, 7 May 2019 17:00:38 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
Message-ID: <20190507160038.GF19434@e105550-lin.cambridge.arm.com>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
 <20190507141338.tnp62joujcrxyv5j@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507141338.tnp62joujcrxyv5j@queper01-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 03:13:40PM +0100, Quentin Perret wrote:
> On Monday 06 May 2019 at 06:48:33 (+0200), Luca Abeni wrote:
> > @@ -1591,6 +1626,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
> >  
> >  	rcu_read_lock();
> >  	curr = READ_ONCE(rq->curr); /* unlocked access */
> > +	het = static_branch_unlikely(&sched_asym_cpucapacity);
> 
> Nit: not sure how the generated code looks like but I wonder if this
> could potentially make you loose the benefit of the static key ?

I have to take the blame for this bit :-)

I would be surprised the static_key gives us anything here, but that is 
actually not the point here. It is purely to know whether we have to be 
capacity aware or not. I don't think we are in a critical path and the
variable providing the necessary condition just happened to be a
static_key.

We might be able to make better use of it if we refactor the code a bit.

Morten
