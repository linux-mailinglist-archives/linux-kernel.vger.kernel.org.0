Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394BF179CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 01:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbgCEAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 19:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388407AbgCEAf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:35:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DC32084E;
        Thu,  5 Mar 2020 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583368527;
        bh=A0B6q9mDysJC9CEiJqkKY3U8/e/cX5VhA8cYED9cPmo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=h+taKVQbSBRSWDF0Q7aHQcp8F8fFOIlDl/Z3rg1xj7YbDd20n3SHfLCV69O/DdsqK
         dq29DR+6uLzamssXGopylboDp98CoKFzxmnzmxSBDK5cEtugT8L8Juycq/LdLB7Aeo
         7Gu0IS5d+B+0oau7p/h3NUMMuq++Sy3htnj+xfMo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D98743522731; Wed,  4 Mar 2020 16:35:26 -0800 (PST)
Date:   Wed, 4 Mar 2020 16:35:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, bigeasy@linutronix.de, tglx@linutronix.de,
        swood@redhat.com, williams@redhat.com, juri.lelli@redhat.com,
        linux-rt-users@vger.kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: RCU use of swait
Message-ID: <20200305003526.GA20601@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

RCU makes considerable use of swait and friends.  The motivation I recall
was around offloaded callbacks, where in the old days the grace-period
kthread might do a wakeup for up to N tasks, where N is the number of
CPUs, all with interrupts disabled.  This has since been reduced to
roughly sqrt(N) tasks, which might well still be too many wakeups to do
with interrupts disabled throughout.

However, the other use cases have at most one waiter to be awakened.

So I am guessing that I could usefully convert all but the rcu_node
structure's ->nocb_gp_wq field from swait to wait.  Particularly the
use cases in SRCU and Tiny RCU.

Or is there some other reason why {S,}RCU needs to use swait that I
am forgetting?

							Thanx, Paul
