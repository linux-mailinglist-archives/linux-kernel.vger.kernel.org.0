Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF23F9B45E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436690AbfHWQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 12:17:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36212 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436677AbfHWQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:17:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i1CFw-0005q7-W8; Fri, 23 Aug 2019 18:17:41 +0200
Date:   Fri, 23 Aug 2019 18:17:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190823161740.xhntflxs3vlf3xnu@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
 <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-22 22:23:23 [-0500], Scott Wood wrote:
> On Thu, 2019-08-22 at 09:39 -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > ---
> > > > Another question is whether non-raw spinlocks are intended to create
> > > > an
> > > > RCU read-side critical section due to implicit preempt disable.
> > > 
> > > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > > consolidation?  If not, I don't see why they should do so after that
> > > consolidation in -rt.
> > 
> > May be I am missing something, but I didn't see the connection between
> > consolidation and this patch. AFAICS, this patch is so that
> > rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?
> 
> Before consolidation, RT mapped rcu_read_lock_bh_held() to
> rcu_read_lock_bh() and called rcu_read_lock() from rcu_read_lock_bh().  This
> somehow got lost when rebasing on top of 5.0.

so now rcu_read_lock_bh_held() is untouched and in_softirq() reports 1.
So the problem is that we never hold RCU but report 1 like we do?

Sebastian
