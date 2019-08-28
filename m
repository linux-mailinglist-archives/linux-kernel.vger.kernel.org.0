Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A233A02D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfH1NOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:14:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47186 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfH1NOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:14:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2xmT-00045m-G8; Wed, 28 Aug 2019 15:14:33 +0200
Date:   Wed, 28 Aug 2019 15:14:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190828131433.3gi4debho5zc7hgc@linutronix.de>
References: <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827155306.GF26530@linux.ibm.com>
 <20190828092739.46mrffvzjv6v3de5@linutronix.de>
 <20190828125426.GO26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828125426.GO26530@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-28 05:54:26 [-0700], Paul E. McKenney wrote:
> On Wed, Aug 28, 2019 at 11:27:39AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-08-27 08:53:06 [-0700], Paul E. McKenney wrote:
> > > Am I understanding this correctly?
> > 
> > Everything perfect except that it is not lockdep complaining but the
> > WARN_ON_ONCE() in rcu_note_context_switch().
> 
> This one, right?
> 
> 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
> 
> Another approach would be to change that WARN_ON_ONCE().  This fix might
> be too extreme, as it would suppress other issues:
> 
> 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);
> 
> But maybe what is happening under the covers is that preempt is being
> set when sleeping on a spinlock.  Is that the case?

I would like to keep that check and that is why we have:

|   #if defined(CONFIG_PREEMPT_RT_FULL)
|         sleeping_l = t->sleeping_lock;
|   #endif
|         WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);

in -RT and ->sleeping_lock is that counter that is incremented in
spin_lock(). And the only reason why sleeping_lock_inc() was used in the
patch was to disable _this_ warning.

> 							Thanx, Paul

Sebastian
