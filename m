Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08B9B748
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391733AbfHWTqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 15:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732627AbfHWTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A5F3C08C33E;
        Fri, 23 Aug 2019 19:46:45 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFACF5C578;
        Fri, 23 Aug 2019 19:46:39 +0000 (UTC)
Message-ID: <40dd3a7e37ed9b3d03c50221dafc7aa137827ce8.camel@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Fri, 23 Aug 2019 14:46:39 -0500
In-Reply-To: <20190823161740.xhntflxs3vlf3xnu@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-2-swood@redhat.com>
         <20190821233358.GU28441@linux.ibm.com> <20190822133955.GA29841@google.com>
         <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
         <20190823161740.xhntflxs3vlf3xnu@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 23 Aug 2019 19:46:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 18:17 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-22 22:23:23 [-0500], Scott Wood wrote:
> > On Thu, 2019-08-22 at 09:39 -0400, Joel Fernandes wrote:
> > > On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > > ---
> > > > > Another question is whether non-raw spinlocks are intended to
> > > > > create
> > > > > an
> > > > > RCU read-side critical section due to implicit preempt disable.
> > > > 
> > > > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > > > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > > > consolidation?  If not, I don't see why they should do so after that
> > > > consolidation in -rt.
> > > 
> > > May be I am missing something, but I didn't see the connection between
> > > consolidation and this patch. AFAICS, this patch is so that
> > > rcu_read_lock_bh_held() works at all on -rt. Did I badly miss
> > > something?
> > 
> > Before consolidation, RT mapped rcu_read_lock_bh_held() to
> > rcu_read_lock_bh() and called rcu_read_lock() from
> > rcu_read_lock_bh().  This
> > somehow got lost when rebasing on top of 5.0.
> 
> so now rcu_read_lock_bh_held() is untouched and in_softirq() reports 1.
> So the problem is that we never hold RCU but report 1 like we do?

Yes.

-Scott


