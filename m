Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D037582
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfFFNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 09:42:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41208 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfFFNmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:42:43 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hYsfB-000705-Ue; Thu, 06 Jun 2019 21:42:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hYsf3-0007Q1-NW; Thu, 06 Jun 2019 21:42:33 +0800
Date:   Thu, 6 Jun 2019 21:42:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH RFC tip/core/rcu] Restore barrier() to rcu_read_lock()
 and rcu_read_unlock()
Message-ID: <20190606134233.saqa3insjv75xu6o@gondor.apana.org.au>
References: <20190606131933.GA12576@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606131933.GA12576@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 06:19:33AM -0700, Paul E. McKenney wrote:
> Commit bb73c52bad36 ("rcu: Don't disable preemption for Tiny and Tree
> RCU readers") removed the barrier() calls from rcu_read_lock() and
> rcu_write_lock() in CONFIG_PREEMPT=n&&CONFIG_PREEMPT_COUNT=n kernels.
> Within RCU, this commit was OK, but it failed to account for things like
> get_user() that can pagefault and that can be reordered by the compiler.
> Lack of the barrier() calls in rcu_read_lock() and rcu_read_unlock()
> can cause these page faults to migrate into RCU read-side critical
> sections, which in CONFIG_PREEMPT=n kernels could result in too-short
> grace periods and arbitrary misbehavior.  Please see commit 386afc91144b
> ("spinlocks and preemption points need to be at least compiler barriers")
> for more details.
> 
> This commit therefore restores the barrier() call to both rcu_read_lock()
> and rcu_read_unlock().  It also removes them from places in the RCU update
> machinery that used to need compensatory barrier() calls, effectively
> reverting commit bb73c52bad36 ("rcu: Don't disable preemption for Tiny
> and Tree RCU readers").
> 
> Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

Paul, Linus has already commited his patch:

commit 66be4e66a7f422128748e3c3ef6ee72b20a6197b
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jun 3 13:26:20 2019 -0700

    rcu: locking and unlocking need to always be at least barriers

So you'll need to rebase this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
