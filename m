Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810E8B3DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbfIPPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 11:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbfIPPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:36:57 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5076214D9;
        Mon, 16 Sep 2019 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568648216;
        bh=UVEDiSFb7PbBmSMCLBsQzUaNXwy9lDl9mXB28flFCjM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S4mKDYB5Uh2xN7T2aFOQ7jXK3WPpOjzcYSDbt6MBn8I7/78XOoRqqlJuYaJcQuJmi
         X/LYo+Yujjsn8R8nsn6G/I3EqjRJLXKqadyob5XN+WQ8Y14ygoYuHQYrTU1/a+eeqn
         U4BQjPTMllUR3eXwsbLn6nBPL3WV87gbkfCDkUzA=
Date:   Mon, 16 Sep 2019 08:36:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: locktorture: Do not include rwlock.h directly
Message-ID: <20190916153651.GW30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190916145404.bukcmlliequu77wk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916145404.bukcmlliequu77wk@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 04:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> From: Wolfgang M. Reimer <linuxball@gmail.com>
> 
> Including rwlock.h directly will cause kernel builds to fail
> if CONFIG_PREEMPT_RT is defined. The correct header file
> (rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
> is included by locktorture.c anyway.
> 
> Remove the include of linux/rwlock.h.
> 
> Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Queued for further review and testing, thank you both!

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index c513031cd7e33..9fb042d610d23 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -16,7 +16,6 @@
>  #include <linux/kthread.h>
>  #include <linux/sched/rt.h>
>  #include <linux/spinlock.h>
> -#include <linux/rwlock.h>
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
>  #include <linux/smp.h>
> -- 
> 2.23.0
> 
