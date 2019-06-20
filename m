Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0184DD24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 00:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFTV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 17:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFTV7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B0AFBB00;
        Thu, 20 Jun 2019 21:59:36 +0000 (UTC)
Received: from ovpn-117-83.phx2.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1D1860477;
        Thu, 20 Jun 2019 21:59:30 +0000 (UTC)
Message-ID: <cf42d8516ac99f69913b1f7a7e8abe578ad27e7f.camel@redhat.com>
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
Date:   Thu, 20 Jun 2019 16:59:30 -0500
In-Reply-To: <20190620211005.GW26519@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-4-swood@redhat.com>
         <20190620211005.GW26519@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 20 Jun 2019 21:59:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 14:10 -0700, Paul E. McKenney wrote:
> On Tue, Jun 18, 2019 at 08:19:07PM -0500, Scott Wood wrote:
> > [Note: Just before posting this I noticed that the invoke_rcu_core stuff
> >  is part of the latest RCU pull request, and it has a patch that
> >  addresses this in a more complicated way that appears to deal with the
> >  bare irq-disabled sequence as well.
> 
> Far easier to deal with it than to debug the lack of it.  ;-)
> 
> >  Assuming we need/want to support such sequences, is the
> >  invoke_rcu_core() call actually going to result in scheduling any
> >  sooner?  resched_curr() just does the same setting of need_resched
> >  when it's the same cpu.
> > ]
> 
> Yes, invoke_rcu_core() can in some cases invoke the scheduler sooner.
> Setting the CPU-local bits might not have effect until the next interrupt.

Maybe I'm missing something, but I don't see how (in the non-use_softirq
case).  It just calls wake_up_process(), which in resched_curr() will set
need_resched but not do an IPI-to-self.

-Scott


