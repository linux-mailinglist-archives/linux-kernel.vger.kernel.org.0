Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F179CC9643
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfJCBih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfJCBig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:38:36 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D2B222BE;
        Thu,  3 Oct 2019 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066716;
        bh=DWFzTLVMJ2lb38P7yieK3u1L5vc+qIiH05ds6lWnZzw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RgAdjpzCpZRxcbGDm7spmnQjPhCIxojSHwBTS/Mgs2wRxmqYMF22xm8gUZFZvAjG8
         3PSxnG1UTQ8BCzO8aSSMPN0NG6EtXkOxl/d5k1cDPtEt1eijmhWJj3cqVYwF0cvr+W
         E1qdwEU7o/z4xLN06YUPI1XTQzPKg61Idnibocrw=
Date:   Wed, 2 Oct 2019 18:38:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] NO_HZ fixes for v5.5
Message-ID: <20191003013834.GA12927@paulmck-ThinkPad-P72>
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

This series contains various fixes for NO_HZ and NO_HZ_FULL problems,
including re-enabling the tick during long-term kernel-mode execution.

1.	Add TICK_DEP_BIT_RCU (which allows RCU-specific tick re-enabling),
	courtesy of Frederic Weisbecker.

2.	Export tick start/stop functions for rcutorture.

3.	Force on tick when invoking lots of callbacks.

4.	Force on tick for rcutorture readers and callback flooders.

5.	Provide RCU quiescent state in multi_cpu_stop().

6.	Make CPU-hotplug removal operations enable tick.

7.	Use {READ,WRITE)_ONCE() for multi_cpu_stop() ->state.

8.	Force tick on for nohz_full CPUs not reaching quiescent states.

9.	Force nohz_full tick on upon irq enter instead of exit.

10.	Reset CPU hints when reporting a quiescent state, courtesy of
	Joel Fernandes.

11.	Confine ->core_needs_qs accesses to the corresponding CPU.

12.	Make kernel-mode nohz_full CPUs invoke the RCU core processing.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcutree.h      |    1 
 include/linux/tick.h         |    7 ++
 include/trace/events/timer.h |    3 -
 kernel/rcu/rcutorture.c      |   20 +++++---
 kernel/rcu/tree.c            |  105 ++++++++++++++++++++++++++++++-------------
 kernel/rcu/tree.h            |    1 
 kernel/stop_machine.c        |    7 +-
 kernel/time/tick-sched.c     |   11 ++++
 8 files changed, 114 insertions(+), 41 deletions(-)
