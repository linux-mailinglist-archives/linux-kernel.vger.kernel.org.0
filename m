Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37C710273B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfKSOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 09:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfKSOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:46:42 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D69222D1;
        Tue, 19 Nov 2019 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574174802;
        bh=2hYwDaOAC8NJb3N2Uev+UDnLERgikC64fkVnnqY/s2s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sSzNxTMgU/Tfp2rAj7lKTlJxa7Y4Ut+tXUhN5bX7QTk6wm1SJWkS/4XEogasqw0za
         Ac1QKEe8AWfik5lzqBogpXEIZukQ0u1HrMKpkcolk6eDq4OGHXG40rCUrNtEw/K9S1
         mN7Cbch+YmYiI4T55eS671CACC5MwOQ8AgE03as8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 95A2A3520B06; Tue, 19 Nov 2019 06:46:41 -0800 (PST)
Date:   Tue, 19 Nov 2019 06:46:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191119144641.GV2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
 <20191119092149.06fd8f87@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119092149.06fd8f87@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 09:21:49AM -0500, Steven Rostedt wrote:
> On Tue, 19 Nov 2019 09:46:40 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On !RT a locked spinlock_t and rwlock_t disables preemption which
> > implies a RCU read section. There is code that relies on that behaviour.
> > 
> > Add an explicit RCU read section on RT while a sleeping lock (a lock
> > which would disables preemption on !RT) acquired.
> 
> I know that there was some work to merge the RCU flavors of
> rcu_read_lock and rcu_read_lock_sched, I'm assuming this depends on
> that behavior. That is, a synchronize_rcu() will wait for all CPUs to
> schedule and all grace periods to finish, which means that those using

s/grace periods/RCU readers/, but yes.

> rcu_read_lock() and those using all CPUs to schedule can be
> interchangeable. That is, on !RT, it's likely that rcu_read_lock()
> waiters will end up waiting for all CPUs to schedule, and on RT, this
> makes it where those waiting for all CPUs to schedule, will also wait
> for all rcu_read_lock()s grace periods to finish. If that's the case,
> then this change is fine. But it depends on that being the case, which
> it wasn't in older kernels, and we need to be careful about backporting
> this.

Right in one.  Backporting across the RCU flavor consolidation change
must be done with care.

							Thanx, Paul
