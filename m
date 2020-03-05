Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4572179E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 04:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEDw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 22:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEDw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:52:29 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E172051A;
        Thu,  5 Mar 2020 03:52:27 +0000 (UTC)
Date:   Wed, 4 Mar 2020 22:52:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200304225226.6d631baa@oasis.local.home>
In-Reply-To: <20200305005049.GA21120@paulmck-ThinkPad-P72>
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 16:50:49 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Hello!
> 
> Suppose that I need to extract diagnostics information from a blocked
> task, but that I absolutely cannot tolerate this task awakening in the
> midst of this extraction process.  Is the following code the right way
> to make this work given a task "t"?
> 
> 	raw_spin_lock_irq(&t->pi_lock);
> 	if (t->on_rq) {
> 		/* Task no longer blocked, so ignore it. */
> 	} else {
> 		/* Extract consistent diagnostic information. */
> 	}
> 	raw_spin_unlock_irq(&t->pi_lock);
> 
> It looks like all the wakeup paths acquire ->pi_lock, but I figured I
> should actually ask...

IIUC, the rtmutex code uses pi_lock to tinker with the task while it is
blocked (not woken). But the on_rq test may not be correct. It appears
that can change without holding the task's pi_lock. I'm looking at the
ttwu_do_activate() code which modifies the t->on_rq without holding the
pi_lock. Seems you may need to check the p->state as well. See the
comment in try_to_wake_up() about testing on_rq vs the state.

-- Steve

