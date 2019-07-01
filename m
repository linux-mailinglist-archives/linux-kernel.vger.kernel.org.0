Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6551178E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEBKqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 06:46:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:46:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hM9Eo-0004r2-UJ; Thu, 02 May 2019 12:46:51 +0200
Date:   Thu, 2 May 2019 12:46:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Provide a pointer to the valid CPU mask
Message-ID: <20190502104650.oi6pjg67z3pifncj@linutronix.de>
References: <20190423142636.14347-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423142636.14347-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-23 16:26:36 [+0200], To linux-kernel@vger.kernel.org wrote:
> In commit 4b53a3412d66 ("sched/core: Remove the tsk_nr_cpus_allowed()
> wrapper") the tsk_nr_cpus_allowed() wrapper was removed. There was not
> much difference in !RT but in RT we used this to implement
> migrate_disable(). Within a migrate_disable() section the CPU mask is
> restricted to single CPU while the "normal" CPU mask remains untouched.
> 
> As an alternative implementation Ingo suggested to use
> 	struct task_struct {
> 		const cpumask_t		*cpus_ptr;
> 		cpumask_t		cpus_mask;
>         };
> with
> 	t->cpus_allowed_ptr = &t->cpus_allowed;
> 
> In -RT we then can switch the cpus_ptr to
> 	t->cpus_allowed_ptr = &cpumask_of(task_cpu(p));
> 
> in a migration disabled region. The rules are simple:
> - Code that 'uses' ->cpus_allowed would use the pointer.
> - Code that 'modifies' ->cpus_allowed would use the direct mask.
> 
> I proposed this patch as a series earlier and it was shutdown due to the
> migrate_disable() bits. It has been said that migrate_disable() should
> only be used with RT and thus not introduced without it.
> I hereby propose only the mask CPU-bits.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

a gentle ping.

Sebastian
