Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B440E19AC5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgDAND4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Apr 2020 09:03:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbgDANDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:03:55 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jJd22-0001Op-G5; Wed, 01 Apr 2020 15:03:46 +0200
Date:   Wed, 1 Apr 2020 15:03:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: Don't double assign worker->sleeping
Message-ID: <20200401130346.e7cdsqgxppa6ohje@linutronix.de>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <CAJhGHyDmw5Fwq5mgb1h=7GBegQKP2HQnPTxcRps-0PvGbC2PWg@mail.gmail.com>
 <CAJhGHyBS9Z=x-X2Bxzbic2sfqj=STqr+K8Tgu1UfYMQDm6MtBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJhGHyBS9Z=x-X2Bxzbic2sfqj=STqr+K8Tgu1UfYMQDm6MtBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-01 11:44:06 [+0800], Lai Jiangshan wrote:
> On Wed, Apr 1, 2020 at 11:22 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > Hello
Hi Lai,

…
> > 2) wq_worker_running() can be interrupted(async-page-faulted in virtual machine)
> > and nr_running would be decreased twice.
> 
> would be *increased* twice
> 
> I just saw the V2 patch, this issue is not listed, but need to be fixed too.

| void wq_worker_running(struct task_struct *task)
| {
|         struct worker *worker = kthread_data(task);
| 
|         if (!worker->sleeping)
|                 return;
|         if (!(worker->flags & WORKER_NOT_RUNNING))
|                 atomic_inc(&worker->pool->nr_running);
*0
|         worker->sleeping = 0;
*1
| }

So an interrupt
- before *0, the preempting caller drop early in wq_worker_sleeping(), only one
  atomic_inc()

- after *1, the preempting task will invoke wq_worker_sleeping() and do
  dec() + inc().

What did I miss here?

Sebastian
