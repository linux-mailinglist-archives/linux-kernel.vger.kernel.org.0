Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7316572
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEGONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 10:13:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55644 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfEGONp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:13:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7ADD80D;
        Tue,  7 May 2019 07:13:44 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277933F5C1;
        Tue,  7 May 2019 07:13:42 -0700 (PDT)
Date:   Tue, 7 May 2019 15:13:40 +0100
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
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
Message-ID: <20190507141338.tnp62joujcrxyv5j@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-4-luca.abeni@santannapisa.it>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2019 at 06:48:33 (+0200), Luca Abeni wrote:
> @@ -1591,6 +1626,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>  
>  	rcu_read_lock();
>  	curr = READ_ONCE(rq->curr); /* unlocked access */
> +	het = static_branch_unlikely(&sched_asym_cpucapacity);

Nit: not sure how the generated code looks like but I wonder if this
could potentially make you loose the benefit of the static key ?

Thanks,
Quentin
