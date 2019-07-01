Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB516568
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 16:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEGOKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 10:10:55 -0400
Received: from foss.arm.com ([217.140.101.70]:55572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfEGOKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:10:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F48880D;
        Tue,  7 May 2019 07:10:54 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C35FE3F5C1;
        Tue,  7 May 2019 07:10:51 -0700 (PDT)
Date:   Tue, 7 May 2019 15:10:50 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190507141048.d45ia7qfytnfdhqc@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-3-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-3-luca.abeni@santannapisa.it>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2019 at 06:48:32 (+0200), Luca Abeni wrote:
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
>  {
> -	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> +	unsigned long res;
> +
> +	res = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> +
> +	return (res << SCHED_CAPACITY_SHIFT) /
> +	       arch_scale_cpu_capacity(NULL, rq->cpu);

The only user of cpu_bw_dl() is schedutil right ? If yes, we probably
don't want to scale things here -- schedutil already does this I
believe.

Thanks,
Quentin

>  }
>  
>  static inline unsigned long cpu_util_dl(struct rq *rq)
> -- 
> 2.20.1
> 
