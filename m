Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BF1179E94
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 05:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgCEEZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 23:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEEZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:25:41 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF702073B;
        Thu,  5 Mar 2020 04:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583382340;
        bh=WZjQCTkf8uRUWaIOBbpLwjySe/6G1sEj2Z+vxOKRr9A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tW3MUexwEc0MlHeHCOIaECvT8QRiUww+6GXde+GuzAtu0PuJm4awXkFvUog+4IOl+
         slVeG/r4uhIs6UHPL8B8eByG56KVfMITBGmaP9fO7kesTFM4PpSiyypU6plYUYo5Yj
         9kR4o8qaFACqkYjf02LWhP9h/Aoe2YK3QLnrvAAY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 92E8735227C6; Wed,  4 Mar 2020 20:25:40 -0800 (PST)
Date:   Wed, 4 Mar 2020 20:25:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305042540.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
 <20200304225226.6d631baa@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304225226.6d631baa@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:52:26PM -0500, Steven Rostedt wrote:
> On Wed, 4 Mar 2020 16:50:49 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Hello!
> > 
> > Suppose that I need to extract diagnostics information from a blocked
> > task, but that I absolutely cannot tolerate this task awakening in the
> > midst of this extraction process.  Is the following code the right way
> > to make this work given a task "t"?
> > 
> > 	raw_spin_lock_irq(&t->pi_lock);
> > 	if (t->on_rq) {
> > 		/* Task no longer blocked, so ignore it. */
> > 	} else {
> > 		/* Extract consistent diagnostic information. */
> > 	}
> > 	raw_spin_unlock_irq(&t->pi_lock);
> > 
> > It looks like all the wakeup paths acquire ->pi_lock, but I figured I
> > should actually ask...
> 
> IIUC, the rtmutex code uses pi_lock to tinker with the task while it is
> blocked (not woken). But the on_rq test may not be correct. It appears
> that can change without holding the task's pi_lock. I'm looking at the
> ttwu_do_activate() code which modifies the t->on_rq without holding the
> pi_lock. Seems you may need to check the p->state as well. See the
> comment in try_to_wake_up() about testing on_rq vs the state.

Thank you, Steve!

							Thanx, Paul
