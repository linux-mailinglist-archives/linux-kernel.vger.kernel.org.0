Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774F3B4FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfIQOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 10:08:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfIQOIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:08:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCD684E8AC;
        Tue, 17 Sep 2019 14:08:48 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EDC460606;
        Tue, 17 Sep 2019 14:08:45 +0000 (UTC)
Message-ID: <aae7d8cfa23485127e7c404d5fe8bdf8a70627c8.camel@redhat.com>
Subject: Re: [PATCH RT v3 4/5] rcu: Disable use_softirq on PREEMPT_RT
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 17 Sep 2019 09:08:45 -0500
In-Reply-To: <20190911165729.11178-5-swood@redhat.com>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-5-swood@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 17 Sep 2019 14:08:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-11 at 17:57 +0100, Scott Wood wrote:
>  kernel/rcu/tree.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fc8b00c61b32..ee0a5ec2c30f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -98,9 +98,14 @@ struct rcu_state rcu_state = {
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
>  static bool dump_tree;
>  module_param(dump_tree, bool, 0444);
> -/* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
> -static bool use_softirq = 1;
> +/*
> + * By default, use RCU_SOFTIRQ instead of rcuc kthreads.
> + * But, avoid RCU_SOFTIRQ on PREEMPT_RT due to pi/rq deadlocks.
> + */
> +static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> +#ifdef CONFIG_PREEMPT_RT_FULL
>  module_param(use_softirq, bool, 0444);
> +#endif

Ugh, that should be s/ifdef/ifndef/

-Scott


