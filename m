Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD59F67A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfH0W7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 18:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0W7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93D233084244;
        Tue, 27 Aug 2019 22:59:06 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C6825D6B0;
        Tue, 27 Aug 2019 22:58:53 +0000 (UTC)
Date:   Wed, 28 Aug 2019 06:58:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190827225827.GA5263@ming.t460p>
References: <20190827085344.30799-1-ming.lei@redhat.com>
 <20190827085344.30799-2-ming.lei@redhat.com>
 <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 27 Aug 2019 22:59:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:42:02PM +0200, Thomas Gleixner wrote:
> On Tue, 27 Aug 2019, Ming Lei wrote:
> > +/*
> > + * Update average irq interval with the Exponential Weighted Moving
> > + * Average(EWMA)
> > + */
> > +static void irq_update_interval(void)
> > +{
> > +#define IRQ_INTERVAL_EWMA_WEIGHT	128
> > +#define IRQ_INTERVAL_EWMA_PREV_FACTOR	127
> > +#define IRQ_INTERVAL_EWMA_CURR_FACTOR	(IRQ_INTERVAL_EWMA_WEIGHT - \
> > +		IRQ_INTERVAL_EWMA_PREV_FACTOR)
> 
> Please do not stick defines into a function body. That's horrible.

OK.

> 
> > +
> > +	int cpu = raw_smp_processor_id();
> > +	struct irq_interval *inter = per_cpu_ptr(&avg_irq_interval, cpu);
> > +	u64 delta = sched_clock_cpu(cpu) - inter->last_irq_end;
> 
> Why are you doing that raw_smp_processor_id() dance? The call site has
> interrupts and preemption disabled.

OK, will change to __smp_processor_id().

> 
> Also how is that supposed to work when sched_clock is jiffies based?

Good catch, looks ktime_get_ns() is needed.

> 
> > +	inter->avg = (inter->avg * IRQ_INTERVAL_EWMA_PREV_FACTOR +
> > +		delta * IRQ_INTERVAL_EWMA_CURR_FACTOR) /
> > +		IRQ_INTERVAL_EWMA_WEIGHT;
> 
> We definitely are not going to have a 64bit multiplication and division on
> every interrupt. Asided of that this breaks 32bit builds all over the place.

I will convert the above into add/subtract/shift only.

thanks,
Ming
