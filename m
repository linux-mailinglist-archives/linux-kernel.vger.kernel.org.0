Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF21849AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 15:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCMOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 10:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMOlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:41:49 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC89206E9;
        Fri, 13 Mar 2020 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584110509;
        bh=tkDtSVMV9wG5/KlFdfEzBofOPCCL6QYbGj7vjKcmMzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrpw/AiO9C5nCDYeNyZbkNb0EfKaLKKGWDbpiszZNfRSxxvv/s+cqkWwSlyZXtWgU
         nEMUQNhr0c0t1a3vJiAMICMysNCE4zE6mIk8klsnItE6CqYVkLTfifvZkDz9zc04jm
         /dbf09u3fW0aTfH8FQAq95+nNj7eNVYvwfvUpe10=
Date:   Fri, 13 Mar 2020 15:41:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mutt@paulmck-ThinkPad-P72, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200313144145.GA31604@lenoir>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:16:18AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series provides two variants of Tasks RCU, a rude variant inspired
> by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
> requested by the BPF folks and perhaps also of use for other tracing
> use cases.
> 
> The tracing variant has explicit read-side markers to permit finite grace
> periods even given in-kernel loops in PREEMPT=n builds It also protects
> code in the idle loop, on exception entry/exit paths, and on the various
> CPU-hotplug online/offline code paths, thus having protection properties
> similar to SRCU.  However, unlike SRCU, this variant avoids expensive
> instructions in the read-side primitives, thus having read-side overhead
> similar to that of preemptible RCU.
> 
> There are of course downsides.  The grace-period code can send IPIs to
> CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> It is necessary to scan the full tasklist, much as for Tasks RCU.  There
> is a single callback queue guarded by a single lock, again, much as for
> Tasks RCU.  If needed, these downsides can be at least partially remedied

So what we trade to fix the issues we are having with tracing against extended
grace periods, we lose in CPU isolation. That worries me a bit as tracing can
be thoroughly used with nohz_full and CPU isolation.
