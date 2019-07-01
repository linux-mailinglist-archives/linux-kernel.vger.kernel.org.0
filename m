Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94524ED33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfFUQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:38:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55381 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:38:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1heMYP-000124-OW; Fri, 21 Jun 2019 18:38:21 +0200
Date:   Fri, 21 Jun 2019 18:38:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Message-ID: <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-5-swood@redhat.com>
 <20190620211826.GX26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620211826.GX26519@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-20 14:18:26 [-0700], Paul E. McKenney wrote:
> > Example #1:
> > 
> > 1. preempt_disable()
> > 2. local_bh_disable()
> > 3. preempt_enable()
> > 4. local_bh_enable()
> > 
> > Example #2:
> > 
> > 1. rcu_read_lock()
> > 2. local_irq_disable()
> > 3. rcu_read_unlock()
> > 4. local_irq_enable()
> > 
> > Example #3:
> > 
> > 1. preempt_disable()
> > 2. local_irq_disable()
> > 3. preempt_enable()
> > 4. local_irq_enable()
> 
> OK for -rt, but as long as people can code those sequences without getting
> their wrists slapped, RCU needs to deal with it.  So I cannot accept
> this in mainline at the current time.  Yes, I will know when it is safe
> to accept it when rcutorture's virtual wrist gets slapped in mainline.

All three examples are not symmetrical so if people use this mainline
then they should get their wrists slapped. Since RT trips over each one
of those I try to get rid of them if I notice something like that.

In example #3 you would lose a scheduling event if TIF_NEED_RESCHED gets
set between step 1 and 2 (as local schedule requirement) because the
preempt_enable() would trigger schedule() which does not happen due to
IRQ-off.

Sebastian
