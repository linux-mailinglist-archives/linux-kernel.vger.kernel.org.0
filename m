Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27847191675
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCXQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbgCXQa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:30:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B1AD2076F;
        Tue, 24 Mar 2020 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585067456;
        bh=zN8a8ff6F93rxfbnXtH/OcB/Pb+dW43Yhgo3Ww7vWQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ri1Mc8OSEm6cogEpBO9hMkaeRhw+6K3o1kbrSlsDZvoC1oDtJ66RRAd2oZcCz9/+7
         ncW1j/AHt+aiuYCn0axZhfZskTLlbffchzCWAGIi8cx/puBhsRiVmJXW7eF3+QT6uz
         2TWkycg6hCS+tNpkoVgHuQyEGoThdUGY6yjTqB7o=
Date:   Tue, 24 Mar 2020 17:30:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 04/21] timers: Use hlist_unhashed() instead of
 open-coding in timer_pending()
Message-ID: <20200324163054.GA2518746@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-5-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:26PM +0000, Will Deacon wrote:
> timer_pending() open-codes a version of hlist_unhashed() to check
> whether or not the 'timer' parameter has been queued in the timer wheel.
> KCSAN detects this as a racy operation and explodes at us:
> 
>   | BUG: KCSAN: data-race in del_timer / detach_if_pending
>   |
>   | write to 0xffff88808697d870 of 8 bytes by task 10 on cpu 0:
>   |  __hlist_del include/linux/list.h:764 [inline]
>   |  detach_timer kernel/time/timer.c:815 [inline]
>   |  detach_if_pending+0xcd/0x2d0 kernel/time/timer.c:832
>   |  try_to_del_timer_sync+0x60/0xb0 kernel/time/timer.c:1226
>   |  del_timer_sync+0x6b/0xa0 kernel/time/timer.c:1365
>   |  schedule_timeout+0x2d2/0x6e0 kernel/time/timer.c:1896
>   |  rcu_gp_fqs_loop+0x37c/0x580 kernel/rcu/tree.c:1639
>   |  rcu_gp_kthread+0x143/0x230 kernel/rcu/tree.c:1799
>   |  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   |  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
>   |
>   | read to 0xffff88808697d870 of 8 bytes by task 12060 on cpu 1:
>   |  del_timer+0x3b/0xb0 kernel/time/timer.c:1198
>   |  sk_stop_timer+0x25/0x60 net/core/sock.c:2845
>   |  inet_csk_clear_xmit_timers+0x69/0xa0 net/ipv4/inet_connection_sock.c:523
>   |  tcp_clear_xmit_timers include/net/tcp.h:606 [inline]
>   |  tcp_v4_destroy_sock+0xa3/0x3f0 net/ipv4/tcp_ipv4.c:2096
>   |  inet_csk_destroy_sock+0xf4/0x250 net/ipv4/inet_connection_sock.c:836
>   |  tcp_close+0x6f3/0x970 net/ipv4/tcp.c:2497
>   |  inet_release+0x86/0x100 net/ipv4/af_inet.c:427
>   |  __sock_release+0x85/0x160 net/socket.c:590
>   |  sock_close+0x24/0x30 net/socket.c:1268
>   |  __fput+0x1e1/0x520 fs/file_table.c:280
>   |  ____fput+0x1f/0x30 fs/file_table.c:313
>   |  task_work_run+0xf6/0x130 kernel/task_work.c:113
>   |  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   |  exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:163
> 
> Replace the explicit 'pprev' pointer comparison in timer_pending() with
> a call to hlist_unhashed() and initialise the 'expires' timer field
> explicitly in do_init_timer() so that the compiler doesn't emit bogus
> 'maybe used uninitialised' warnings now that it cannot reason statically
> about the result of timer_pending().
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
