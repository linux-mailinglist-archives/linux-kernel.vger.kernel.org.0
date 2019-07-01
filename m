Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A33519C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfFXRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 13:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfFXRkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A516B307D85A;
        Mon, 24 Jun 2019 17:40:25 +0000 (UTC)
Received: from ovpn-116-138.phx2.redhat.com (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B749600C0;
        Mon, 24 Jun 2019 17:40:20 +0000 (UTC)
Message-ID: <3deedea922e864ddf6363dc6d0850f42ad33ba50.camel@redhat.com>
Subject: Re: [RFC PATCH RT 3/4] rcu: unlock special: Treat irq and preempt
 disabled the same
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 12:40:19 -0500
In-Reply-To: <20190622191320.GA23577@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-4-swood@redhat.com>
         <20190620211005.GW26519@linux.ibm.com>
         <cf42d8516ac99f69913b1f7a7e8abe578ad27e7f.camel@redhat.com>
         <20190620222505.GB26519@linux.ibm.com>
         <5d24d1243849d9f8f6884348e1ceafcc3b7314fd.camel@redhat.com>
         <20190622002606.GL26519@linux.ibm.com>
         <20190622191320.GA23577@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 24 Jun 2019 17:40:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-22 at 12:13 -0700, Paul E. McKenney wrote:
> On Fri, Jun 21, 2019 at 05:26:06PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 20, 2019 at 06:08:19PM -0500, Scott Wood wrote:
> > > On Thu, 2019-06-20 at 15:25 -0700, Paul E. McKenney wrote:
> > > > On Thu, Jun 20, 2019 at 04:59:30PM -0500, Scott Wood wrote:
> > > > > On Thu, 2019-06-20 at 14:10 -0700, Paul E. McKenney wrote:
> > > > > > On Tue, Jun 18, 2019 at 08:19:07PM -0500, Scott Wood wrote:
> > > > > > > [Note: Just before posting this I noticed that the
> > > > > > > invoke_rcu_core
> > > > > > > stuff
> > > > > > >  is part of the latest RCU pull request, and it has a patch
> > > > > > > that
> > > > > > >  addresses this in a more complicated way that appears to deal
> > > > > > > with
> > > > > > > the
> > > > > > >  bare irq-disabled sequence as well.
> > > > > > 
> > > > > > Far easier to deal with it than to debug the lack of it.  ;-)
> > > > > > 
> > > > > > >  Assuming we need/want to support such sequences, is the
> > > > > > >  invoke_rcu_core() call actually going to result in scheduling
> > > > > > > any
> > > > > > >  sooner?  resched_curr() just does the same setting of
> > > > > > > need_resched
> > > > > > >  when it's the same cpu.
> > > > > > > ]
> > > > > > 
> > > > > > Yes, invoke_rcu_core() can in some cases invoke the scheduler
> > > > > > sooner.
> > > > > > Setting the CPU-local bits might not have effect until the next
> > > > > > interrupt.
> > > > > 
> > > > > Maybe I'm missing something, but I don't see how (in the non-
> > > > > use_softirq
> > > > > case).  It just calls wake_up_process(), which in resched_curr()
> > > > > will
> > > > > set
> > > > > need_resched but not do an IPI-to-self.
> > > > 
> > > > The common non-rt case will be use_softirq.  Or are you referring
> > > > specifically to this block of code in current -rcu?
> > > > 
> > > > 		} else if (exp && irqs_were_disabled && !use_softirq
> > > > &&
> > > > 			   !t-
> > > > >rcu_read_unlock_special.b.deferred_qs) {
> > > > 			// Safe to awaken and we get no help from
> > > > enabling
> > > > 			// irqs, unlike bh/preempt.
> > > > 			invoke_rcu_core();
> > > 
> > > Yes, that one.  If that block is removed the else path should be
> > > sufficient,
> > > now that an IPI-to-self has been added.
> > 
> > I will give it a try and let you know what happens.
> 
> How about the following?

Looks good, thanks.

-Scott


