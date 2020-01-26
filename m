Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD197149863
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 02:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAZBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 20:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAZBXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:23:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35DE2071E;
        Sun, 26 Jan 2020 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580001834;
        bh=GT9CakDKgzHGUsSd9Pzep51RqWx2T4j5nL8jJpuNXfU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cHMhoBBGZV26DndY6i79l0/oheY4IbhYgCsuqfMECWp+RWh41bvab2aVqy5sh4VP2
         zzY5c7ceHPkAgkzOeJIIw+jRuMUcrqF1H9vWDxzZF26XayhojEOK1n8F6qZrqmiqZb
         iWqsFYhbU643ZDKtlj+M0bfkHQQLNXzrJJ2KrkZc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A43853522863; Sat, 25 Jan 2020 17:23:54 -0800 (PST)
Date:   Sat, 25 Jan 2020 17:23:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com, oleg@redhat.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200126012354.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
 <37A3FF92-0958-46DD-AFB1-CE72000B153F@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A3FF92-0958-46DD-AFB1-CE72000B153F@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 10:41:06PM +0100, Christian Brauner wrote:
> On January 24, 2020 5:59:08 AM GMT+01:00, madhuparnabhowmik10@gmail.com wrote:
> >From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> >This patch fixes the following sparse errors by annotating the
> >sighand_struct with __rcu
> >
> >kernel/fork.c:1511:9: error: incompatible types in comparison
> >expression
> >kernel/exit.c:100:19: error: incompatible types in comparison
> >expression
> >kernel/signal.c:1370:27: error: incompatible types in comparison
> >expression
> >
> >This fix introduces the following sparse error in signal.c due to
> >checking the sighand pointer without rcu primitives:
> >
> >kernel/signal.c:1386:21: error: incompatible types in comparison
> >expression
> >
> >This new sparse error is also fixed in this patch.
> >
> >Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> >---
> > include/linux/sched.h | 2 +-
> > kernel/signal.c       | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/sched.h b/include/linux/sched.h
> >index b511e178a89f..7a351360ad54 100644
> >--- a/include/linux/sched.h
> >+++ b/include/linux/sched.h
> >@@ -918,7 +918,7 @@ struct task_struct {
> > 
> > 	/* Signal handlers: */
> > 	struct signal_struct		*signal;
> >-	struct sighand_struct		*sighand;
> >+	struct sighand_struct __rcu		*sighand;
> > 	sigset_t			blocked;
> > 	sigset_t			real_blocked;
> > 	/* Restored if set_restore_sigmask() was used: */
> >diff --git a/kernel/signal.c b/kernel/signal.c
> >index bcd46f547db3..9ad8dea93dbb 100644
> >--- a/kernel/signal.c
> >+++ b/kernel/signal.c
> >@@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct
> >task_struct *tsk,
> > 		 * must see ->sighand == NULL.
> > 		 */
> > 		spin_lock_irqsave(&sighand->siglock, *flags);
> >-		if (likely(sighand == tsk->sighand))
> >+		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> > 			break;
> > 		spin_unlock_irqrestore(&sighand->siglock, *flags);
> > 	}
> 
> If Paul is happy with this and nobody wants to take it I'll pick this up.

Works for me!

							Thanx, Paul
